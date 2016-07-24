--[[

	BagSaver addon. 
	Primary functions are auto-selling unwanted items
	to a vendor, finding the least valuable item in 
	your bags to discard and more.
	Author: OneWingedAngel

--]]


--[[ Globals --]]
BagSaverConfig = {}
--Namespace for addon functions
BagSaver = {}

--[[ Main addon frame creation and main local vars ]]--
local BagSaverFrame = CreateFrame("Frame", "BagSaverFrame", UIParent)

local ScanningTooltip = CreateFrame( "GameTooltip", "ScanningTooltipFrame" )
ScanningTooltip:SetOwner( WorldFrame, "ANCHOR_NONE" )
ScanningTooltip:AddFontStrings(
	ScanningTooltip:CreateFontString( "$parentTextLeft1", nil, "GameTooltipText" ),
	ScanningTooltip:CreateFontString( "$parentTextRight1", nil, "GameTooltipText" ) )

local DefaultConfig = {}
local RegisteredEvents = {}
BagSaverFrame:SetScript("OnEvent", function (self, event, ...) if (RegisteredEvents[event]) then return RegisteredEvents[event](self, event, ...) end end)

--[[ Event Handlers --]]

function RegisteredEvents:ADDON_LOADED(event, addon, ...)
	if (addon == "BagSaver") then
		SLASH_BAGSAVER1, SLASH_BAGSAVER2 = '/bagsaver', '/bs'
		SlashCmdList["BAGSAVER"] = function (msg, editbox)
			BagSaver.SlashCmdHandler(msg, editbox)	
		end

		--Use metatable to implement defaults, see http://www.lua.org/pil/13.4.1.html
		setmetatable(BagSaverConfig, {__index = DefaultConfig})

		BagSaverUI.CreateConfigMenu()
		--print("BagSaver " .. GetAddOnMetadata("BagSaver","Version") .. " Loaded. Type /bs for usage")
	end
end

function RegisteredEvents:MERCHANT_SHOW()
	if BagSaver.GetConfigValue("autoSell") then
		local itemsToSell, numItemsToSell = BagSaver.BagSearch(BagSaver.IsJunkItem)

		if numItemsToSell ~= 0 then
			if BagSaver.GetConfigValue("autoSellPrompt") then
				BagSaver.PromptToSellItemsToVendor(itemsToSell)
			else
				BagSaver.SellItemsToVendor(itemsToSell)
			end
		end
	end
end

function RegisteredEvents:UI_ERROR_MESSAGE(event,message)
	--print("UI ERROR MESSAGE caught, message is " .. message)
	if message == INVENTORY_FULL then
		if BagSaver.GetConfigValue("findDisposableItems") then
			if BagSaver.IsDisposableItemFrameShown() == false then
				local disposableItems, numDisposableItems = BagSaver.BagSearch(BagSaver.IsDisposableItem)
				BagSaver.ShowDisposableItems(disposableItems, numDisposableItems)
			else
				--print("DisposableItems frame already shown, skipping")
			end
		end
	end
end

function RegisteredEvents:BAG_UPDATE(event,bagId)
	if BagSaver.IsDisposableItemFrameShown() and BagSaver.GetNumFreeBagSlots() > 0 then
		for i,frame in pairs(BagSaverUI["DisposableItemFrames"]) do
			frame:Hide()
		end
	end
end

for k, v in pairs(RegisteredEvents) do
	BagSaverFrame:RegisterEvent(k)
end

--[[ Addon functions --]]
function BagSaver.SellItemsToVendor(items)
	local totalProfit = 0
	for itemQuality=0,7 do
		for i,item in pairs(items[itemQuality]) do
			--Check to make sure the items haven't moved since we looked
			local newTexture, newCount, newLocked, newQuality, newReadable, newLootable, newItemLink = GetContainerItemInfo(item["bag"], item["slot"]) 
			if (item["link"] == newItemLink) then
				if item["count"] == 1 then
					print("BagSaver auto-selling: " .. newItemLink .. " for: " .. BagSaver.GetMoneyString(item.value))
					totalProfit = totalProfit + item.value
				else
					print("BagSaver auto-selling: " .. newCount .. "x " .. newItemLink .. " for: " .. BagSaver.GetMoneyString(item.value * item.count))
					totalProfit = totalProfit + (item.value * item.count)
				end
				UseContainerItem(item["bag"],item["slot"])
			else
				print(item["link"] .. " has moved! Not attempting to sell")
			end
		end
	end
	print("Total profit from BagSaver auto-sell: " .. BagSaver.GetMoneyString(totalProfit))
end

function BagSaver.PromptToSellItemsToVendor(items)
	local itemLinks = {}
	local totalSellValue = 0;
	for itemQuality=0,7 do
		for i,item in pairs(items[itemQuality]) do
			if item["count"] == 1 then
				table.insert(itemLinks,item["link"] .. " for: " .. BagSaver.GetMoneyString(item.value))
				totalSellValue = totalSellValue + item.value
			else
				table.insert(itemLinks,item["count"] .. "x " .. item["link"] .. " for: " .. BagSaver.GetMoneyString(item.value * item.count))
				totalSellValue = totalSellValue + (item.value * item.count)
			end
		end
	end

	local dialogText = "Sell the following items?\n"
	StaticPopupDialogs["BAGSAVER_AUTOSELL_PROMPT"] = {
		text = dialogText .. table.concat(itemLinks, "\n") .. "\n Total: " .. BagSaver.GetMoneyString(totalSellValue),
		button1 = "Yes",
		button2 = "No",
		OnAccept = function() BagSaver.SellItemsToVendor(items) end,
		timeout = 0,
		whileDead = 1,
		hideOnEscape = 1,
		showAlert = 1
	}
	StaticPopup_Show("BAGSAVER_AUTOSELL_PROMPT")
end

function BagSaver.ShowDisposableItems(items, numItems)
	if BagSaverUI["DisposableItemFrames"][numItems] == nil then
		BagSaverUI["DisposableItemFrames"][numItems] = BagSaverUI.CreateDisposableItemFrame(numItems)
	end
	local itemFrame = BagSaverUI["DisposableItemFrames"][numItems]
	local itemsToDisplay = {}

	for quality=0,7 do
		if #items[quality] > 0 then
			for i,item in ipairs(items[quality]) do
				tinsert(itemsToDisplay,item)
			end
		end
	end
	for i,item in ipairs(itemsToDisplay) do
		BagSaverUI.SetItemButtonInfo(itemFrame.itemButtons[i],item)
	end
	itemFrame:Show()
end

function BagSaver.BagSearch(addFoundItem)
	local itemsFound = {}
	for itemQuality=0,7 do
		itemsFound[itemQuality] = {}
	end
	local numItemsFound = 0
	for bag = 0,NUM_BAG_SLOTS do
		for slot = 1,GetContainerNumSlots(bag) do
			local id = GetContainerItemID(bag,slot)
			if id then --We're not looking at an empty slot
				currentItem = BagSaver.BuildItemTable(bag,slot,id)
				if addFoundItem(currentItem, itemsFound) then
					numItemsFound = numItemsFound + 1
				end
			end
		end
	end
	return itemsFound, numItemsFound
end

function BagSaver.IsJunkItem(item, itemTable)
	local playerClassLocal, playerClass = UnitClass("player")
	local playerLevel = UnitLevel("player")
	if item.value > 0 then --We don't care about items we can't sell
		if (BagSaver.GetConfigValue("autoSellGrayItems")) then
			if item.quality == 0 then
				tinsert(itemTable[item.quality],item)				
				return true
			end
		end
		if BagSaver.GetConfigValue("autoSellUnusableBoundItems") then
			if item.isSoulbound then
				if BagSaver.ItemIsExcludedFromUnusableBound(item) then --Handle special cases and manual exclusions
					return false
				end
				if (BagSaverTables["UnusableEquipment"][playerClass][item.class] ~= nil and 
					BagSaverTables["UnusableEquipment"][playerClass][item.class][item.subClass] ~= nil) then --item is soulbound and could never be equipped by the player's class
					tinsert(itemTable[item.quality],item)
					--print("Selling item because it's unusable and bound: ")
					--BagSaver.DumpItem(item)
					return true
				end
			end
		end
		if BagSaver.GetConfigValue("autoSellNonPrimaryBoundArmor") then
			if item.isSoulbound then
				if BagSaver.ItemIsExcludedFromNonPrimaryBound(item) then --Handle special cases and manual exclusions
					return false
				end
				if BagSaverTables.ItemIsArmor(item) and BagSaverTables["NonPrimaryArmor"][playerClass][item.subClass] ~= nil then --item is of an armor type below the primary type of the player's class
					tinsert(itemTable[item.quality],item)
                    --print("Selling item because it's below primary type: ")
                    --BagSaver.DumpItem(item)
					return true
				end
			end
		end
		if BagSaver.GetConfigValue("autoSellUselessForClass") then
			if item.isSoulbound and BagSaver.ItemIsUselessForClass(item) then
				tinsert(itemTable[item.quality],item)
                --print("Selling item because it's useless for class: ")
                --BagSaver.DumpItem(item)
				return true
			end
		end
	end
	return false
end

function BagSaver.ItemIsExcludedFromUnusableBound(item)
	if BagSaver.ItemIsMiscellaneousExcluded(item) then --Miscellaneous items that should not be auto-sold
		return true
	end
	if BagSaver.ItemRequiresEngineering(item) then --Soulbound items that require engineering should not be sold
		return true
	end
	if BagSaver.ItemRequiresFishing(item) then --Soulbound items that require fishing should not be sold
		return true
	end
	if BagSaverTables["FishingTools"][item.id] then --Fishing Items that do not "require fishing"
		return true
	end
end

function BagSaver.ItemIsExcludedFromNonPrimaryBound(item)
	if item.equipSlot == "INVTYPE_CLOAK" then --Cloaks are all considered to be cloth, so they would be considered non-prmary for most classes
		return true
	end
	if BagSaver.ItemIsMiscellaneousExcluded(item) then --Miscellaneous items that should not be auto-sold
		return true
	end
	if BagSaver.ItemRequiresEngineering(item) then --Soulbound items that require engineering should not be sold
		return true
	end
	if BagSaver.ItemRequiresFishing(item) then --Soulbound items that require fishing should not be sold
		return true
	end
	if BagSaverTables["FishingTools"][item.id] then --Fishing Items that do not "require fishing"
		return true
	end
end

function BagSaver.IsDisposableItem(item, itemTable)
	if item.value > 0 then --Items with no value are usually quest items, conjured, etc.
		if BagSaver.IsItemExcludedFromDisposal(item) then --Handle special cases and exclusions
			return false
		end
		
		if item.quality == 0 or item.quality == 1 then --Only check on gray and white items
			if #itemTable[item.quality] == 0 then --if this is our first item with value
				tinsert(itemTable[item.quality],item)				
				return true
			else 
				if item.value * item.count < itemTable[item.quality][1]["value"] * itemTable[item.quality][1]["count"] then --if current item value is less than stored item value
					itemTable[item.quality][1] = item
				end
			end
		end
	end
	return false
end

function BagSaver.IsItemExcludedFromDisposal(item)
	if BagSaver.ItemIsMiscellaneousExcluded(item) then
		--print("Ignoring item because it's manually ignored: ")
		--BagSaver.DumpItem(item)
		return true
	end
	if BagSaver.GetConfigValue("exemptCraftingToolsFromDiscard") and BagSaver.ItemIsCraftingTool(item) then
		--print("Ignoring item because it's a crafting tool: ")
		--BagSaver.DumpItem(item)
		return true
	end
	if BagSaver.GetConfigValue("exemptFishingToolsFromDiscard") and BagSaver.ItemIsFishingTool(item) then
		--print("Ignoring item because it's a fishing tool: ")
		--BagSaver.DumpItem(item)
		return true
	end
end

function BagSaver.BuildItemTable(bag,slot,id)
	local texture, count, locked, _, readable, lootable, link = GetContainerItemInfo(bag,slot)
	local name, _, quality, iLevel, reqLevel, class, subClass, maxStack, equipSlot, _, value = GetItemInfo(id)
	local itemTable = { id = id,
				bag = bag, 
				slot = slot, 
				value = value, 
				count = count, 
				texture = texture, 
				name = name, 
				link = link, 
				quality = quality, 
				color = { GetItemQualityColor(quality) }, 
				class = class, 
				subClass = subClass, 
				equipSlot = equipSlot }

	itemTable.isSoulbound = BagSaver.ItemIsSoulbound(itemTable)

	return itemTable
end

function BagSaver.ItemIsSoulbound(item)
	ScanningTooltip:ClearLines()
	ScanningTooltip:SetBagItem(item.bag,item.slot)

	local i = 1
	local text = nil
	while (getglobal("ScanningTooltipFrameTextLeft" .. i) ~= nil) do
		if (getglobal("ScanningTooltipFrameTextLeft" .. i):GetText() == ITEM_SOULBOUND) then
			return true
		end
		i = i + 1
	end
	return false
end

function BagSaver.ItemRequiresEngineering(item)
	ScanningTooltip:ClearLines()
	ScanningTooltip:SetBagItem(item.bag,item.slot)

	for i=1,select("#", ScanningTooltip:GetRegions()) do
		local region = select(i,ScanningTooltip:GetRegions())
		if (region:GetObjectType() == "FontString" and region:GetText() ~= nil) then
			if (string.find(region:GetText(), UNIT_SKINNABLE_BOLTS)) then --For some reason, this is the global that contains the localized string "Requires Engineering" 
				return true
			end
		end
	end

	return false
end

function BagSaver.ItemRequiresFishing(item)
	ScanningTooltip:ClearLines()
	ScanningTooltip:SetBagItem(item.bag,item.slot)

	local requiresFishingString = ENCHANT_CONDITION_REQUIRES..PROFESSIONS_FISHING --ENCHANT_CONDITION_REQUIRES = "Requires ", PROFESSIONS_FISHING = "Fishing", localized
	for i=1,select("#", ScanningTooltip:GetRegions()) do
		local region = select(i,ScanningTooltip:GetRegions())
		if (region:GetObjectType() == "FontString" and region:GetText() ~= nil) then
			if (string.find(region:GetText(), requiresFishingString)) then
				return true
			end
		end
	end

	return false
end

function BagSaver.ItemIsMiscellaneousExcluded(item)
	return BagSaverTables["Miscellaneous"][item.id] ~= nil
end

function BagSaver.ItemIsCraftingTool(item)
	return BagSaverTables["CraftingTools"][item.id] ~= nil
end

function BagSaver.ItemIsFishingTool(item)
	return BagSaverTables["FishingTools"][item.id] ~= nil
end

function BagSaver.ItemIsUselessForClass(item)
	local playerClassLocal, playerClass = UnitClass("player")
	if playerClass == "HUNTER" then
		if BagSaverTables.ItemIsWeapon(item) and not BagSaverTables.ItemIsRangedWeapon(item) then
			return true
		else
			return false
		end
	else
		if BagSaverTables.ItemIsRangedWeapon(item) then
			return true
		else
			return false
		end
	end
end

function BagSaver.GetNumFreeBagSlots()
	local totalFreeSlots = 0
	for bag = 0,NUM_BAG_SLOTS do
		local freeSlots, bagType = GetContainerNumFreeSlots(bag)
		if bagType == 0 then
			totalFreeSlots = totalFreeSlots + freeSlots
		end
	end
	return totalFreeSlots
end

function BagSaver.IsDisposableItemFrameShown()
	for i,frame in pairs(BagSaverUI["DisposableItemFrames"]) do
		if frame:IsShown() then
			return true
		end
	end

	return false
end

function BagSaver.SlashCmdHandler(msg, editbox)
	--print("command is " .. msg .. "\n")
	if (string.lower(msg) == "config") then
		InterfaceOptionsFrame_OpenToCategory("BagSaver")
	elseif (string.lower(msg) == "dumpconfig") then
		print("With defaults")
		for k,v in pairs(DefaultConfig) do
			print(k,BagSaver.GetConfigValue(k))
		end
		print("Direct table")
		for k,v in pairs(BagSaverConfig) do
			print(k,v)
		end
	elseif (string.lower(msg) == "dumpequip") then
		BagSaverTables.DumpEquipmentTable()
	elseif (string.lower(msg) == "dumparmor") then
		BagSaverTables.DumpNonPrimaryArmorTable()
	elseif (string.lower(msg) == "dumpcraft") then
		BagSaverTables.DumpCraftingToolsTable()
	elseif (string.lower(msg) == "dumpfish") then
		BagSaverTables.DumpFishingToolsTable()
	elseif (string.lower(msg) == "reset") then
		BagSaver.SetConfigToDefaults()
	elseif (string.lower(msg) == "perf") then
		BagSaver.PrintPerformanceData()
	else
		BagSaver.ShowHelp()
	end
end

function BagSaver.ShowHelp()
	print("Slash commands (/bagsaver or /bs):")
	print(" /bs config: Open addon config menu (also found in Addon tab in Blizzard's Interface menu)")
	print(" /bs reset:  Resets your config to defaults")
end

function BagSaver.PrintPerformanceData()
	UpdateAddOnMemoryUsage()
	local mem = GetAddOnMemoryUsage("BagSaver")
	print("BagSaver is currently using " .. mem .. " kbytes of memory")
	--collectgarbage(collect)
	--UpdateAddOnMemoryUsage()
	--local mem = GetAddOnMemoryUsage("BagSaver")
	--print("BagSaver is currently using " .. mem .. " kbytes of memory after garbage collection")

end

function BagSaver.DumpItem(item)
	for k,v in pairs(item) do
		print(k,v)
	end
end

--[[ Configuration methods --]]
function BagSaver.GetConfigValue(key)
	return BagSaverConfig[key]
end

function BagSaver.SetConfigValue(key, value)
	if (DefaultConfig[key] == value) then
		BagSaverConfig[key] = nil
	else 
		BagSaverConfig[key] = value
	end
end

function BagSaver.SetConfigToDefaults()
	print("Resetting config to defaults")
	BagSaverConfig = {}
	setmetatable(BagSaverConfig, {__index = DefaultConfig})
end

function BagSaver.GetMoneyString(money)
	local gold = floor(money / 10000)
	local silver = floor((money - gold * 10000) / 100)
	local copper = mod(money, 100)
	if gold > 0 then
		return format(GOLD_AMOUNT_TEXTURE.." "..SILVER_AMOUNT_TEXTURE.." "..COPPER_AMOUNT_TEXTURE, gold, 0, 0, silver, 0, 0, copper, 0, 0)
	elseif silver > 0 then
		return format(SILVER_AMOUNT_TEXTURE.." "..COPPER_AMOUNT_TEXTURE, silver, 0, 0, copper, 0, 0)
	else
		return format(COPPER_AMOUNT_TEXTURE, copper, 0, 0)
	end
end

--[[ "Global" Vars --]]

DefaultConfig = {
	autoSell = true,
	autoSellPrompt = true,
	autoSellGrayItems = true,
	autoSellUnusableBoundItems = false,
	autoSellNonPrimaryBoundArmor = false,
	autoSellUselessForClass = false,
	findDisposableItems = true,
	exemptCraftingToolsFromDiscard = true,
	exemptFishingToolsFromDiscard = false,
}
