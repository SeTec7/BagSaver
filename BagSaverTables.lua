--[[

	Hand-coded data tables for use in BagSaver

--]]


-- Globals
BagSaverTables = {}

-- Useful snippet to get the ids and names for all subtypes
--for _, subClassID in pairs(C_AuctionHouse.GetAuctionItemSubClasses(LE_ITEM_CLASS_WEAPON)) do
--    print(subClassID, (GetItemSubClassInfo(LE_ITEM_CLASS_WEAPON, subClassID)))
--end

function BagSaverTables.ItemIsWeapon(item)
	if item.classID == LE_ITEM_CLASS_WEAPON then
		if item.subClassID == FISHINGPOLE then
			return false
		else
			return true
		end
	end
	return false
end

function BagSaverTables.ItemIsArmor(item)
	if item.classID == LE_ITEM_CLASS_ARMOR then
		return true
	end
	return false
end

function BagSaverTables.ItemIsRangedWeapon(item)
	if BagSaverTables.ItemIsWeapon(item) then
		if item.subClassID == LE_ITEM_WEAPON_BOWS or
			item.subClassID == LE_ITEM_WEAPON_CROSSBOW or
			item.subClassID == LE_ITEM_WEAPON_GUNS or
			item.subClassID == LE_ITEM_WEAPON_THROWN then
			--print(item.name .. " is ranged weapon " .. item.classID .. " " .. item.subClassID)
			return true
		end
	end
	--print(item.name .. "is not ranged " .. item.classID .. " " .. item.subClassID)
	return false
end

-- Functions for data tables
function BagSaverTables.DumpEquipmentTable()
	for className, localizedClassName in pairs(LOCALIZED_CLASS_NAMES_MALE) do
		print(className)
		for itemClassID,v in pairs(BagSaverTables["UnusableEquipment"][className]) do
			print(" " .. GetItemClassInfo(itemClassID))
			for itemSubClassID,v in pairs(BagSaverTables["UnusableEquipment"][className][itemClassID]) do
				print("  " .. GetItemSubClassInfo(itemClassID, itemSubClassID),v)
			end
		end
	end
end

function BagSaverTables.DumpNonPrimaryArmorTable()
	for className, localizedClassName in pairs(LOCALIZED_CLASS_NAMES_MALE) do
		print(className)
		print(" Always:")
		for armorSubClassID,v in pairs(BagSaverTables["NonPrimaryArmor"][className]) do
			print("  " .. GetItemSubClassInfo(LE_ITEM_CLASS_ARMOR, armorSubClassID))
		end
	end
end

function BagSaverTables.DumpCraftingToolsTable()
	for id, name in pairs(BagSaverTables["CraftingTools"]) do
		print(id, name)
	end
end

function BagSaverTables.DumpFishingToolsTable()
	for id, name in pairs(BagSaverTables["FishingTools"]) do
		print(id, name)
	end
end

function BagSaverTables.DumpMiscTable()
	for id, name in pairs(BagSaverTables["Miscellaneous"]) do
		print(id, name)
	end
end

-- Table definitions

--UnusuableEquipment - Lists what gear is unusable for each class
local UnusableEquipment = {}
BagSaverTables["UnusableEquipment"] = UnusableEquipment

--Initialize our table structure for each class
--UnusableEquipment["CLASS"] = {}
--UnusableEquipment["CLASS"][LE_ITEM_CLASS_WEAPON] = {}
--UnusableEquipment["CLASS"][LE_ITEM_CLASS_ARMOR] = {}
for className, localizedClassName in pairs(LOCALIZED_CLASS_NAMES_MALE) do
	UnusableEquipment[className] = {}
	UnusableEquipment[className][LE_ITEM_CLASS_WEAPON] = {}
	UnusableEquipment[className][LE_ITEM_CLASS_ARMOR] = {}
end

--Reference for all equipment and armor types
--[[
UnusableEquipment["CLASS"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_BOWS] = 1
UnusableEquipment["CLASS"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_CROSSBOW] = 1
UnusableEquipment["CLASS"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_DAGGER] = 1
UnusableEquipment["CLASS"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_UNARMED] = 1
UnusableEquipment["CLASS"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_GUNS] = 1
UnusableEquipment["CLASS"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_AXE1H] = 1
UnusableEquipment["CLASS"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_MACE1H] = 1
UnusableEquipment["CLASS"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_SWORD1H] = 1
UnusableEquipment["CLASS"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_POLEARM] = 1
UnusableEquipment["CLASS"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_STAFF] = 1
UnusableEquipment["CLASS"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_THROWN] = 1
UnusableEquipment["CLASS"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_AXE2H] = 1
UnusableEquipment["CLASS"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_MACE2H] = 1
UnusableEquipment["CLASS"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_SWORD2H] = 1
UnusableEquipment["CLASS"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_WAND] = 1
UnusableEquipment["CLASS"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_WARGLAIVE] = 1
UnusableEquipment["CLASS"][LE_ITEM_CLASS_ARMOR][LE_ITEM_ARMOR_CLOTH] = 1
UnusableEquipment["CLASS"][LE_ITEM_CLASS_ARMOR][LE_ITEM_ARMOR_LEATHER] = 1
UnusableEquipment["CLASS"][LE_ITEM_CLASS_ARMOR][LE_ITEM_ARMOR_MAIL] = 1
UnusableEquipment["CLASS"][LE_ITEM_CLASS_ARMOR][LE_ITEM_ARMOR_PLATE] = 1
UnusableEquipment["CLASS"][LE_ITEM_CLASS_ARMOR][LE_ITEM_ARMOR_SHIELD] = 1
--]]

UnusableEquipment["DEATHKNIGHT"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_BOWS] = 1
UnusableEquipment["DEATHKNIGHT"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_CROSSBOW] = 1
UnusableEquipment["DEATHKNIGHT"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_DAGGER] = 1
UnusableEquipment["DEATHKNIGHT"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_UNARMED] = 1
UnusableEquipment["DEATHKNIGHT"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_GUNS] = 1
UnusableEquipment["DEATHKNIGHT"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_STAFF] = 1
UnusableEquipment["DEATHKNIGHT"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_THROWN] = 1
UnusableEquipment["DEATHKNIGHT"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_WAND] = 1
UnusableEquipment["DEATHKNIGHT"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_WARGLAIVE] = 1
UnusableEquipment["DEATHKNIGHT"][LE_ITEM_CLASS_ARMOR][LE_ITEM_ARMOR_SHIELD] = 1

UnusableEquipment["DEMONHUNTER"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_BOWS] = 1
UnusableEquipment["DEMONHUNTER"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_CROSSBOW] = 1
UnusableEquipment["DEMONHUNTER"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_GUNS] = 1
UnusableEquipment["DEMONHUNTER"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_POLEARM] = 1
UnusableEquipment["DEMONHUNTER"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_STAFF] = 1
UnusableEquipment["DEMONHUNTER"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_THROWN] = 1
UnusableEquipment["DEMONHUNTER"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_AXE2H] = 1
UnusableEquipment["DEMONHUNTER"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_MACE2H] = 1
UnusableEquipment["DEMONHUNTER"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_SWORD2H] = 1
UnusableEquipment["DEMONHUNTER"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_WAND] = 1
UnusableEquipment["DEMONHUNTER"][LE_ITEM_CLASS_ARMOR][LE_ITEM_ARMOR_MAIL] = 1
UnusableEquipment["DEMONHUNTER"][LE_ITEM_CLASS_ARMOR][LE_ITEM_ARMOR_PLATE] = 1
UnusableEquipment["DEMONHUNTER"][LE_ITEM_CLASS_ARMOR][LE_ITEM_ARMOR_SHIELD] = 1

UnusableEquipment["DRUID"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_BOWS] = 1
UnusableEquipment["DRUID"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_CROSSBOW] = 1
UnusableEquipment["DRUID"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_GUNS] = 1
UnusableEquipment["DRUID"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_AXE1H] = 1
UnusableEquipment["DRUID"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_SWORD1H] = 1
UnusableEquipment["DRUID"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_THROWN] = 1
UnusableEquipment["DRUID"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_AXE2H] = 1
UnusableEquipment["DRUID"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_SWORD2H] = 1
UnusableEquipment["DRUID"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_WAND] = 1
UnusableEquipment["DRUID"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_WARGLAIVE] = 1
UnusableEquipment["DRUID"][LE_ITEM_CLASS_ARMOR][LE_ITEM_ARMOR_MAIL] = 1
UnusableEquipment["DRUID"][LE_ITEM_CLASS_ARMOR][LE_ITEM_ARMOR_PLATE] = 1
UnusableEquipment["DRUID"][LE_ITEM_CLASS_ARMOR][LE_ITEM_ARMOR_SHIELD] = 1

UnusableEquipment["HUNTER"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_MACE1H] = 1
UnusableEquipment["HUNTER"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_MACE2H] = 1
UnusableEquipment["HUNTER"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_WAND] = 1
UnusableEquipment["HUNTER"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_WARGLAIVE] = 1
UnusableEquipment["HUNTER"][LE_ITEM_CLASS_ARMOR][LE_ITEM_ARMOR_PLATE] = 1
UnusableEquipment["HUNTER"][LE_ITEM_CLASS_ARMOR][LE_ITEM_ARMOR_SHIELD] = 1

UnusableEquipment["MAGE"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_BOWS] = 1
UnusableEquipment["MAGE"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_CROSSBOW] = 1
UnusableEquipment["MAGE"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_UNARMED] = 1
UnusableEquipment["MAGE"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_GUNS] = 1
UnusableEquipment["MAGE"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_AXE1H] = 1
UnusableEquipment["MAGE"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_MACE1H] = 1
UnusableEquipment["MAGE"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_POLEARM] = 1
UnusableEquipment["MAGE"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_THROWN] = 1
UnusableEquipment["MAGE"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_AXE2H] = 1
UnusableEquipment["MAGE"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_MACE2H] = 1
UnusableEquipment["MAGE"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_SWORD2H] = 1
UnusableEquipment["MAGE"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_WARGLAIVE] = 1
UnusableEquipment["MAGE"][LE_ITEM_CLASS_ARMOR][LE_ITEM_ARMOR_LEATHER] = 1
UnusableEquipment["MAGE"][LE_ITEM_CLASS_ARMOR][LE_ITEM_ARMOR_MAIL] = 1
UnusableEquipment["MAGE"][LE_ITEM_CLASS_ARMOR][LE_ITEM_ARMOR_PLATE] = 1
UnusableEquipment["MAGE"][LE_ITEM_CLASS_ARMOR][LE_ITEM_ARMOR_SHIELD] = 1

UnusableEquipment["MONK"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_BOWS] = 1
UnusableEquipment["MONK"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_CROSSBOW] = 1
UnusableEquipment["MONK"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_DAGGER] = 1
UnusableEquipment["MONK"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_GUNS] = 1
UnusableEquipment["MONK"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_THROWN] = 1
UnusableEquipment["MONK"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_AXE2H] = 1
UnusableEquipment["MONK"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_MACE2H] = 1
UnusableEquipment["MONK"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_SWORD2H] = 1
UnusableEquipment["MONK"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_WAND] = 1
UnusableEquipment["MONK"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_WARGLAIVE] = 1
UnusableEquipment["MONK"][LE_ITEM_CLASS_ARMOR][LE_ITEM_ARMOR_MAIL] = 1
UnusableEquipment["MONK"][LE_ITEM_CLASS_ARMOR][LE_ITEM_ARMOR_PLATE] = 1
UnusableEquipment["MONK"][LE_ITEM_CLASS_ARMOR][LE_ITEM_ARMOR_SHIELD] = 1

UnusableEquipment["PALADIN"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_BOWS] = 1
UnusableEquipment["PALADIN"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_CROSSBOW] = 1
UnusableEquipment["PALADIN"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_DAGGER] = 1
UnusableEquipment["PALADIN"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_UNARMED] = 1
UnusableEquipment["PALADIN"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_GUNS] = 1
UnusableEquipment["PALADIN"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_STAFF] = 1
UnusableEquipment["PALADIN"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_THROWN] = 1
UnusableEquipment["PALADIN"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_WAND] = 1
UnusableEquipment["PALADIN"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_WARGLAIVE] = 1

UnusableEquipment["PRIEST"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_BOWS] = 1
UnusableEquipment["PRIEST"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_CROSSBOW] = 1
UnusableEquipment["PRIEST"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_UNARMED] = 1
UnusableEquipment["PRIEST"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_GUNS] = 1
UnusableEquipment["PRIEST"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_AXE1H] = 1
UnusableEquipment["PRIEST"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_SWORD1H] = 1
UnusableEquipment["PRIEST"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_POLEARM] = 1
UnusableEquipment["PRIEST"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_THROWN] = 1
UnusableEquipment["PRIEST"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_AXE2H] = 1
UnusableEquipment["PRIEST"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_MACE2H] = 1
UnusableEquipment["PRIEST"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_SWORD2H] = 1
UnusableEquipment["PRIEST"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_WARGLAIVE] = 1
UnusableEquipment["PRIEST"][LE_ITEM_CLASS_ARMOR][LE_ITEM_ARMOR_LEATHER] = 1
UnusableEquipment["PRIEST"][LE_ITEM_CLASS_ARMOR][LE_ITEM_ARMOR_MAIL] = 1
UnusableEquipment["PRIEST"][LE_ITEM_CLASS_ARMOR][LE_ITEM_ARMOR_PLATE] = 1
UnusableEquipment["PRIEST"][LE_ITEM_CLASS_ARMOR][LE_ITEM_ARMOR_SHIELD] = 1

UnusableEquipment["ROGUE"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_BOWS] = 1
UnusableEquipment["ROGUE"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_CROSSBOW] = 1
UnusableEquipment["ROGUE"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_GUNS] = 1
UnusableEquipment["ROGUE"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_POLEARM] = 1
UnusableEquipment["ROGUE"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_THROWN] = 1
UnusableEquipment["ROGUE"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_STAFF] = 1
UnusableEquipment["ROGUE"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_AXE2H] = 1
UnusableEquipment["ROGUE"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_MACE2H] = 1
UnusableEquipment["ROGUE"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_SWORD2H] = 1
UnusableEquipment["ROGUE"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_WAND] = 1
UnusableEquipment["ROGUE"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_WARGLAIVE] = 1
UnusableEquipment["ROGUE"][LE_ITEM_CLASS_ARMOR][LE_ITEM_ARMOR_MAIL] = 1
UnusableEquipment["ROGUE"][LE_ITEM_CLASS_ARMOR][LE_ITEM_ARMOR_PLATE] = 1
UnusableEquipment["ROGUE"][LE_ITEM_CLASS_ARMOR][LE_ITEM_ARMOR_SHIELD] = 1

UnusableEquipment["SHAMAN"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_BOWS] = 1
UnusableEquipment["SHAMAN"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_CROSSBOW] = 1
UnusableEquipment["SHAMAN"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_GUNS] = 1
UnusableEquipment["SHAMAN"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_SWORD1H] = 1
UnusableEquipment["SHAMAN"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_POLEARM] = 1
UnusableEquipment["SHAMAN"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_THROWN] = 1
UnusableEquipment["SHAMAN"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_SWORD2H] = 1
UnusableEquipment["SHAMAN"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_WAND] = 1
UnusableEquipment["SHAMAN"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_WARGLAIVE] = 1
UnusableEquipment["SHAMAN"][LE_ITEM_CLASS_ARMOR][LE_ITEM_ARMOR_PLATE] = 1

UnusableEquipment["WARLOCK"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_BOWS] = 1
UnusableEquipment["WARLOCK"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_CROSSBOW] = 1
UnusableEquipment["WARLOCK"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_UNARMED] = 1
UnusableEquipment["WARLOCK"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_GUNS] = 1
UnusableEquipment["WARLOCK"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_AXE1H] = 1
UnusableEquipment["WARLOCK"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_MACE1H] = 1
UnusableEquipment["WARLOCK"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_POLEARM] = 1
UnusableEquipment["WARLOCK"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_THROWN] = 1
UnusableEquipment["WARLOCK"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_AXE2H] = 1
UnusableEquipment["WARLOCK"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_MACE2H] = 1
UnusableEquipment["WARLOCK"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_SWORD2H] = 1
UnusableEquipment["WARLOCK"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_WARGLAIVE] = 1
UnusableEquipment["WARLOCK"][LE_ITEM_CLASS_ARMOR][LE_ITEM_ARMOR_LEATHER] = 1
UnusableEquipment["WARLOCK"][LE_ITEM_CLASS_ARMOR][LE_ITEM_ARMOR_MAIL] = 1
UnusableEquipment["WARLOCK"][LE_ITEM_CLASS_ARMOR][LE_ITEM_ARMOR_PLATE] = 1
UnusableEquipment["WARLOCK"][LE_ITEM_CLASS_ARMOR][LE_ITEM_ARMOR_SHIELD] = 1

UnusableEquipment["WARRIOR"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_BOWS] = 1
UnusableEquipment["WARRIOR"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_CROSSBOW] = 1
UnusableEquipment["WARRIOR"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_GUNS] = 1
UnusableEquipment["WARRIOR"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_THROWN] = 1
UnusableEquipment["WARRIOR"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_WAND] = 1
UnusableEquipment["WARRIOR"][LE_ITEM_CLASS_WEAPON][LE_ITEM_WEAPON_WARGLAIVE] = 1

--NonPrimaryArmor - Lists what armor types are non-primary for each class
local NonPrimaryArmor = {}
BagSaverTables["NonPrimaryArmor"] = NonPrimaryArmor

--Initialize our table structure
--NonPrimaryArmor["CLASS"] = {}
for className, localizedClassName in pairs(LOCALIZED_CLASS_NAMES_MALE) do
	NonPrimaryArmor[className] = {}
end
NonPrimaryArmor["DEATHKNIGHT"][LE_ITEM_ARMOR_CLOTH] = 1
NonPrimaryArmor["DEATHKNIGHT"][LE_ITEM_ARMOR_LEATHER] = 1
NonPrimaryArmor["DEATHKNIGHT"][LE_ITEM_ARMOR_MAIL] = 1

NonPrimaryArmor["DEMONHUNTER"][LE_ITEM_ARMOR_CLOTH] = 1

NonPrimaryArmor["DRUID"][LE_ITEM_ARMOR_CLOTH] = 1

NonPrimaryArmor["HUNTER"][LE_ITEM_ARMOR_CLOTH] = 1
NonPrimaryArmor["HUNTER"][LE_ITEM_ARMOR_LEATHER] = 1

NonPrimaryArmor["MONK"][LE_ITEM_ARMOR_CLOTH] = 1

NonPrimaryArmor["PALADIN"][LE_ITEM_ARMOR_CLOTH] = 1
NonPrimaryArmor["PALADIN"][LE_ITEM_ARMOR_LEATHER] = 1
NonPrimaryArmor["PALADIN"][LE_ITEM_ARMOR_MAIL] = 1

NonPrimaryArmor["ROGUE"][LE_ITEM_ARMOR_CLOTH] = 1

NonPrimaryArmor["SHAMAN"][LE_ITEM_ARMOR_CLOTH] = 1
NonPrimaryArmor["SHAMAN"][LE_ITEM_ARMOR_LEATHER] = 1

NonPrimaryArmor["WARRIOR"][LE_ITEM_ARMOR_CLOTH] = 1
NonPrimaryArmor["WARRIOR"][LE_ITEM_ARMOR_LEATHER] = 1
NonPrimaryArmor["WARRIOR"][LE_ITEM_ARMOR_MAIL] = 1

--List of tools used in tradeskills
local CraftingTools = {}
BagSaverTables["CraftingTools"] = CraftingTools
CraftingTools[6219] = "Arclight Spanner"
CraftingTools[5956] = "Blacksmith Hammer"
CraftingTools[40893] = "Bladed Pickaxe"
CraftingTools[40772] = "Gnomish Army Knife"
CraftingTools[10498] = "Gyromatic Micro-Adjuster"
CraftingTools[40892] = "Hammer Pick"
CraftingTools[2901] = "Mining Pick"
CraftingTools[22462] = "Runed Adamantite Rod"
CraftingTools[16207] = "Runed Arcanite Rod"
CraftingTools[6218] = "Runed Copper Rod"
CraftingTools[22463] = "Runed Eternium Rod"
CraftingTools[22461] = "Runed Fel Iron Rod"
CraftingTools[11130] = "Runed Golden Rod"
CraftingTools[6339] = "Runed Silver Rod"
CraftingTools[44452] = "Runed Titanium Rod"
CraftingTools[11145] = "Runed Truesilver Rod"
CraftingTools[7005] = "Skinning Knife"
CraftingTools[39505] = "Virtuoso Inking Set"
CraftingTools[116913] = "Peon's Mining Pick"

local FishingTools = {}
BagSaverTables["FishingTools"] = FishingTools
FishingTools[6811] = "Aquadynamic Fish Lens"
FishingTools[6530] = "Nightcrawlers"
FishingTools[6533] = "Aquadynamic Fish Attractor"
FishingTools[6532] = "Bright Baubles"
FishingTools[7307] = "Flesh Eating Worm"
FishingTools[33820] = "Weather-Beaten Fishing Hat"
FishingTools[34861] = "Sharpened Fish Hook"
FishingTools[46006] = "Glow Worm"

local Miscellaneous = {}
BagSaverTables["Miscellaneous"] = Miscellaneous
Miscellaneous[50741] = "Vile Fumigator's Mask"
Miscellaneous[116913] = "Peon's Mining Pick"
Miscellaneous[116916] = "Gorepetal's Gentle Grasp"
