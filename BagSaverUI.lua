--[[

	UI element creation/tracking for BagSaver

--]]


--[[ Globals --]]
BagSaverUI = {}

--[[ Main addon frame creation and main local vars ]]--
local DisposableItemFrames = {}
BagSaverUI["DisposableItemFrames"] = DisposableItemFrames

--[[ Config UI --]]
function BagSaverUI.CreateConfigMenu()
	local configPanel = CreateFrame("Frame", "BagSaverConfigFrame", UIParent)
	configPanel.name = "BagSaver"
	configPanel.okay = function (self) return end
	configPanel.cancel = function (self) return end

	local addonName, addonTitle, addonNotes = GetAddOnInfo('BagSaver')
	local configPanelTitle = configPanel:CreateFontString(nil, 'ARTWORK', 'GameFontNormalLarge')
	configPanelTitle:SetPoint('TOPLEFT', 16, -16)
	configPanelTitle:SetText(addonTitle)

	local configPanelDesc = configPanel:CreateFontString(nil, 'ARTWORK', 'GameFontHighlightSmall')
	configPanelDesc:SetHeight(32)
	configPanelDesc:SetPoint('TOPLEFT', configPanelTitle, 'BOTTOMLEFT', 0, -8)
	configPanelDesc:SetPoint('RIGHT', configPanel, -32, 0)
	configPanelDesc:SetNonSpaceWrap(true)
	configPanelDesc:SetJustifyH('LEFT')
	configPanelDesc:SetJustifyV('TOP')
	configPanelDesc:SetText(addonNotes)

	local autoSellConfigPanel = CreateFrame("Frame", "BagSaverAutoSellConfigFrame", configPanel)
	autoSellConfigPanel.name = "Auto-Sell Options"
	autoSellConfigPanel.parent = "BagSaver"
	autoSellConfigPanel.okay = function (self) return end
	autoSellConfigPanel.cancel = function (self) return end

	local autoSellConfigPanelTitle = autoSellConfigPanel:CreateFontString(nil, 'ARTWORK', 'GameFontNormalLarge')
	autoSellConfigPanelTitle:SetPoint('TOPLEFT', 16, -16)
	autoSellConfigPanelTitle:SetText(autoSellConfigPanel.name)

	local autoSellConfigPanelDesc = autoSellConfigPanel:CreateFontString(nil, 'ARTWORK', 'GameFontHighlightSmall')
	autoSellConfigPanelDesc:SetHeight(32)
	autoSellConfigPanelDesc:SetPoint('TOPLEFT', autoSellConfigPanelTitle, 'BOTTOMLEFT', 0, -8)
	autoSellConfigPanelDesc:SetPoint('RIGHT', autoSellConfigPanel, -32, 0)
	autoSellConfigPanelDesc:SetNonSpaceWrap(true)
	autoSellConfigPanelDesc:SetJustifyH('LEFT')
	autoSellConfigPanelDesc:SetJustifyV('TOP')
	autoSellConfigPanelDesc:SetText("These options allow you to control BagSaver's auto-selling features")

	local discardConfigPanel = CreateFrame("Frame", "BagSaverDiscardConfigFrame", configPanel)
	discardConfigPanel.name = "Discard Options"
	discardConfigPanel.parent = "BagSaver"
	discardConfigPanel.okay = function (self) return end
	discardConfigPanel.cancel = function (self) return end

	local discardConfigPanelTitle = discardConfigPanel:CreateFontString(nil, 'ARTWORK', 'GameFontNormalLarge')
	discardConfigPanelTitle:SetPoint('TOPLEFT', 16, -16)
	discardConfigPanelTitle:SetText(discardConfigPanel.name)

	local discardConfigPanelDesc = discardConfigPanel:CreateFontString(nil, 'ARTWORK', 'GameFontHighlightSmall')
	discardConfigPanelDesc:SetHeight(32)
	discardConfigPanelDesc:SetPoint('TOPLEFT', discardConfigPanelTitle, 'BOTTOMLEFT', 0, -8)
	discardConfigPanelDesc:SetPoint('RIGHT', discardConfigPanel, -32, 0)
	discardConfigPanelDesc:SetNonSpaceWrap(true)
	discardConfigPanelDesc:SetJustifyH('LEFT')
	discardConfigPanelDesc:SetJustifyV('TOP')
	discardConfigPanelDesc:SetText("These options allow you to control what BagSaver will offer you to discard when your bags are full")

	local autoSell = BagSaverUI.CreateCheckButton("Auto-Sell", autoSellConfigPanel,"Enable automatic selling of \"junk\" to vendors", "autoSell", 'InterfaceOptionsCheckButtonTemplate')
	autoSell:SetPoint('TOPLEFT', 10, -75)

	local autoSellPrompt = BagSaverUI.CreateCheckButton("Prompt before Auto-Sell", autoSellConfigPanel,"Prompt before automatically selling anything to a vendor", "autoSellPrompt", 'InterfaceOptionsSmallCheckButtonTemplate')
	autoSellPrompt:SetPoint('TOPLEFT', 150, -75)
	BagSaverUI.SetupDependentControl(autoSell,autoSellPrompt)

	local autoSellGrayItems = BagSaverUI.CreateCheckButton("Gray Items", autoSellConfigPanel,"Consider gray items to be junk", "autoSellGrayItems", 'InterfaceOptionsCheckButtonTemplate')
	autoSellGrayItems:SetPoint('TOPLEFT', 20, -100)
	BagSaverUI.SetupDependentControl(autoSell,autoSellGrayItems)

	local autoSellUnusableBoundItems = BagSaverUI.CreateCheckButton("Unusable Soulbound Items", autoSellConfigPanel,"Consider Soulbound items that you could *never* equip to be junk", "autoSellUnusableBoundItems", 'InterfaceOptionsCheckButtonTemplate')
	autoSellUnusableBoundItems:SetPoint('TOPLEFT', 20, -125)
	BagSaverUI.SetupDependentControl(autoSell,autoSellUnusableBoundItems)

	local autoSellNonPrimaryBoundArmor = BagSaverUI.CreateCheckButton("Non-Primary Soulbound Armor", autoSellConfigPanel,"Consider soulbound armor below your primary type (cloth, leather, mail, plate) to be junk", "autoSellNonPrimaryBoundArmor", 'InterfaceOptionsCheckButtonTemplate')
	autoSellNonPrimaryBoundArmor:SetPoint('TOPLEFT', 20, -150)
	BagSaverUI.SetupDependentControl(autoSell,autoSellNonPrimaryBoundArmor)

	local autoSellUselessForClass = BagSaverUI.CreateCheckButton("Soulbound Useless Items", autoSellConfigPanel,"Consider soulbound items your class can't really use (melee weapons for Hunters, ranged weapons for Warriors/Rogues) to be junk", "autoSellUselessForClass", 'InterfaceOptionsCheckButtonTemplate')
	autoSellUselessForClass:SetPoint('TOPLEFT', 20, -175)
	BagSaverUI.SetupDependentControl(autoSell,autoSellUselessForClass)

	local findDisposableItems = BagSaverUI.CreateCheckButton("Find Discardable Items", discardConfigPanel,"Find items to let you discard when your bags are full", "findDisposableItems", 'InterfaceOptionsCheckButtonTemplate')
	findDisposableItems:SetPoint('TOPLEFT', 10, -75)

	local exemptCraftingToolsFromDiscard = BagSaverUI.CreateCheckButton("Ignore Crafting Tools", discardConfigPanel,"Ignore tools used by a tradeskill", "exemptCraftingToolsFromDiscard", 'InterfaceOptionsCheckButtonTemplate')
	exemptCraftingToolsFromDiscard:SetPoint('TOPLEFT', 20, -100)
	BagSaverUI.SetupDependentControl(findDisposableItems,exemptCraftingToolsFromDiscard)

	local exemptFishingToolsFromDiscard = BagSaverUI.CreateCheckButton("Ignore Fishing Tools", discardConfigPanel,"Ignore fishing baubles, lures, etc.", "exemptFishingToolsFromDiscard", 'InterfaceOptionsCheckButtonTemplate')
	exemptFishingToolsFromDiscard:SetPoint('TOPLEFT', 20, -125)
	BagSaverUI.SetupDependentControl(findDisposableItems,exemptFishingToolsFromDiscard)

	InterfaceOptions_AddCategory(configPanel)
	InterfaceOptions_AddCategory(autoSellConfigPanel)
	InterfaceOptions_AddCategory(discardConfigPanel)
end

function BagSaverUI.CreateDisposableItemFrame(numItems)
	local DisposableItemFrame = CreateFrame("Frame","DisposableItemFrame"..numItems,UIParent)
	tinsert(UISpecialFrames,DisposableItemFrame:GetName())
	DisposableItemFrame:SetBackdrop({bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", tile = true, tileSize = 32, edgeSize = 32, insets = { left = 11, right = 12, top = 12, bottom = 11 } } );
	DisposableItemFrame:SetPoint("TOP",0,-133)
	DisposableItemFrame:SetWidth(320)
	DisposableItemFrame:SetHeight(70 + (37 * numItems))
	DisposableItemFrame:SetFrameStrata("DIALOG")
	local DisposableItemsText = DisposableItemFrame:CreateFontString(DisposableItemFrame:GetName().."Text", 'ARTWORK', 'GameFontNormal')
	DisposableItemsText:SetPoint('TOP', 0, -16)
	DisposableItemsText:SetWidth(275)
	DisposableItemsText:SetJustifyH("CENTER")
	DisposableItemsText:SetText("These are your least valuable stacks.\nClick and discard one to make room.")
	local DisposableItemCloseButton = CreateFrame("Button","DisposableItemsCloseButton",DisposableItemFrame,"UIPanelCloseButton")
	DisposableItemCloseButton:SetPoint("TOPRIGHT",0,0)
	DisposableItemFrame.itemButtons = {}
	for i=1,numItems do
		local itemButton = BagSaverUI.CreateItemButton("DisposableItemButton"..numItems.."-"..i,DisposableItemFrame)
		itemButton:SetPoint("TOP",DisposableItemsText:GetName(),"BOTTOM",-90,-10-(37*(i-1)))
		tinsert(DisposableItemFrame.itemButtons,itemButton)
	end

	return DisposableItemFrame
end

function BagSaverUI.CreateCheckButton(name, parent, tooltipText, configKey, template)
	local button = CreateFrame('CheckButton', parent:GetName() .. name, parent, template)
	getglobal(button:GetName() .. 'Text'):SetText(name)
	button:SetChecked(BagSaver.GetConfigValue(configKey))
	button:SetScript('OnClick', function(self)
		if self:GetChecked() then
			BagSaver.SetConfigValue(configKey, true)
		else 
			BagSaver.SetConfigValue(configKey, false)
		end
		if ( self.dependentControls ) then
			if ( self:GetChecked() ) then
				for _, control in pairs(self.dependentControls) do
					control:Enable()
				end
			else
				for _, control in pairs(self.dependentControls) do
					control:Disable()
				end
			end
		end
	end)
	button:SetScript('OnEnter', function(self)
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetText(tooltipText, nil, nil, nil, 1, 1)
		GameTooltip:Show() end)
	button:SetScript('OnLeave', function(self) GameTooltip:Hide() end)

	return button
end

function BagSaverUI.CreateItemButton(name, parent, item)
	local itemButton = CreateFrame("Button",name,parent,"ItemButtonTemplate")
	local itemTexture = itemButton:CreateTexture(itemButton:GetName().."Texture","ARTWORK")
	itemTexture:SetTexture("Interface\\QuestFrame\\UI-QuestItemNameFrame")
	itemTexture:SetWidth(140)
	itemTexture:SetHeight(62)
	itemTexture:SetPoint("LEFT",30,0)
	local itemFont = itemButton:CreateFontString(itemButton:GetName().."Text","ARTWORK","GameFontNormal")
	itemFont:SetWidth(103)
	itemFont:SetHeight(38)
	itemFont:SetJustifyH("LEFT")
	itemFont:SetPoint("LEFT",itemButton:GetName(),"RIGHT",8,0)
	local itemExtraFont = itemButton:CreateFontString(itemButton:GetName().."ExtraText","ARTWORK","GameFontNormal")
	itemExtraFont:SetWidth(100)
	itemExtraFont:SetHeight(38)
	itemExtraFont:SetJustifyH("LEFT")
	itemExtraFont:SetPoint("LEFT",itemFont:GetName(),"RIGHT",12,0)

	itemButton:Show()
	itemButton:SetHeight(37)
	itemButton:SetWidth(37)

	return itemButton
end

function BagSaverUI.SetItemButtonInfo(itemButton, item)
	if ( item and type(item) == "table" ) then
		_G[itemButton:GetName()].link = item.link
		_G[itemButton:GetName().."IconTexture"]:SetTexture(item.texture);
		local nameText = _G[itemButton:GetName().."Text"];
		nameText:SetTextColor(unpack(ITEM_QUALITY_COLORS[item.quality] or {1, 1, 1, 1}));
		nameText:SetText(item.name);
		local nameExtraText = _G[itemButton:GetName().."ExtraText"];
		nameExtraText:SetTextColor(unpack({1, 1, 1, 1}));
		nameExtraText:SetText("Total Value:\n " .. BagSaver.GetMoneyString(item.count * item.value));
		if ( item.count and item.count > 1 ) then
			_G[itemButton:GetName().."Count"]:SetText(item.count);
			_G[itemButton:GetName().."Count"]:Show();
		else
			_G[itemButton:GetName().."Count"]:Hide();
		end

		itemButton:SetScript("OnEnter", function(self) if ( self.link ) then GameTooltip:SetOwner(self, "ANCHOR_RIGHT") GameTooltip:SetHyperlink(self.link) end end)
		itemButton:SetScript("OnLeave", function(self) GameTooltip:Hide() end)
		itemButton:SetScript("OnClick", function(self,button,down) 
						if GetContainerItemLink(item.bag,item.slot) == item.link then 
							PickupContainerItem(item.bag, item.slot) 
						else 
							print("Inventory has changed, tried to use wrong item!") 
							itemButton:GetParent():Hide() 
						end 
						end )
	end
end

function BagSaverUI.SetupDependentControl (dependency, control)
	if ( not dependency ) then
		return
	end
	
	assert(control)
	
	dependency.dependentControls = dependency.dependentControls or {}
	tinsert(dependency.dependentControls, control)

	if ( control.type ~= CONTROLTYPE_DROPDOWN ) then
		control.Disable = function (self) getmetatable(self).__index.Disable(self) _G[self:GetName().."Text"]:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b) end
		control.Enable = function (self) getmetatable(self).__index.Enable(self) _G[self:GetName().."Text"]:SetTextColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b) end
		if dependency:GetChecked() then
			control:Enable()
		else
			control:Disable()
		end
	else
		control.Disable = function (self) UIDropDownMenu_DisableDropDown(self) end
		control.Enable = function (self) UIDropDownMenu_EnableDropDown(self) end
	end

end