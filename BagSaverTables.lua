--[[

	Hand-coded data tables for use in BagSaver

--]]


-- Globals
BagSaverTables = {}

--Define local vars with localized name of each weapon and armor type
local WEAPON_CLASS_ID = 2
local ARMOR_CLASS_ID = 4

local WEAPON_CLASS = GetItemClassInfo(WEAPON_CLASS_ID)
local ARMOR_CLASS = GetItemClassInfo(ARMOR_CLASS_ID)

local ONEHANDAXES_CLASS_ID,
		TWOHANDAXES_CLASS_ID,
		BOWS_CLASS_ID,
		GUNS_CLASS_ID,
		ONEHANDMACES_CLASS_ID,
		TWOHANDMACES_CLASS_ID,
		POLEARMS_CLASS_ID,
		ONEHANDSWORDS_CLASS_ID,
		TWOHANDSWORDS_CLASS_ID,
		WARGLAIVES_CLASS_ID,
		STAVES_CLASS_ID,
		FISTWEAPONS_CLASS_ID,
		WEAPONMISC_CLASS_ID,
		DAGGERS_CLASS_ID,
		THROWN_CLASS_ID,
		CROSSBOWS_CLASS_ID,
		WANDS_CLASS_ID,
		FISHINGPOLES_CLASS_ID = GetAuctionItemSubClasses(WEAPON_CLASS_ID)

local ONEHANDAXES_SUBCLASS = GetItemSubClassInfo(WEAPON_CLASS_ID,ONEHANDAXES_CLASS_ID)
local TWOHANDAXES_SUBCLASS = GetItemSubClassInfo(WEAPON_CLASS_ID,TWOHANDAXES_CLASS_ID)
local BOWS_SUBCLASS = GetItemSubClassInfo(WEAPON_CLASS_ID,BOWS_CLASS_ID)
local GUNS_SUBCLASS = GetItemSubClassInfo(WEAPON_CLASS_ID,GUNS_CLASS_ID)
local ONEHANDMACES_SUBCLASS = GetItemSubClassInfo(WEAPON_CLASS_ID,ONEHANDMACES_CLASS_ID)
local TWOHANDMACES_SUBCLASS = GetItemSubClassInfo(WEAPON_CLASS_ID,TWOHANDMACES_CLASS_ID)
local POLEARMS_SUBCLASS = GetItemSubClassInfo(WEAPON_CLASS_ID,POLEARMS_CLASS_ID)
local ONEHANDSWORDS_SUBCLASS = GetItemSubClassInfo(WEAPON_CLASS_ID,ONEHANDSWORDS_CLASS_ID)
local TWOHANDSWORDS_SUBCLASS = GetItemSubClassInfo(WEAPON_CLASS_ID,TWOHANDSWORDS_CLASS_ID)
local WARGLAIVES_SUBCLASS = GetItemSubClassInfo(WEAPON_CLASS_ID,WARGLAIVES_CLASS_ID)
local STAVES_SUBCLASS = GetItemSubClassInfo(WEAPON_CLASS_ID,STAVES_CLASS_ID)
local FISTWEAPONS_SUBCLASS = GetItemSubClassInfo(WEAPON_CLASS_ID,FISTWEAPONS_CLASS_ID)
local WEAPONMISC_SUBCLASS = GetItemSubClassInfo(WEAPON_CLASS_ID,WEAPONMISC_CLASS_ID)
local DAGGERS_SUBCLASS = GetItemSubClassInfo(WEAPON_CLASS_ID,DAGGERS_CLASS_ID)
local THROWN_SUBCLASS = GetItemSubClassInfo(WEAPON_CLASS_ID,THROWN_CLASS_ID)
local CROSSBOWS_SUBCLASS = GetItemSubClassInfo(WEAPON_CLASS_ID,CROSSBOWS_CLASS_ID)
local WANDS_SUBCLASS = GetItemSubClassInfo(WEAPON_CLASS_ID,WANDS_CLASS_ID)
local FISHINGPOLES_SUBCLASS = GetItemSubClassInfo(WEAPON_CLASS_ID,FISHINGPOLES_CLASS_ID)
		
local ARMORMISC_CLASS_ID,
		CLOTH_CLASS_ID,
		LEATHER_CLASS_ID,
		MAIL_CLASS_ID,
		PLATE_CLASS_ID,
		COSMETIC_CLASS_ID,
		SHIELDS_CLASS_ID = GetAuctionItemSubClasses(ARMOR_CLASS_ID)

local ARMORMISC_SUBCLASS = GetItemSubClassInfo(ARMOR_CLASS_ID, ARMORMISC_CLASS_ID)
local CLOTH_SUBCLASS = GetItemSubClassInfo(ARMOR_CLASS_ID, CLOTH_CLASS_ID)
local LEATHER_SUBCLASS = GetItemSubClassInfo(ARMOR_CLASS_ID, LEATHER_CLASS_ID)
local MAIL_SUBCLASS = GetItemSubClassInfo(ARMOR_CLASS_ID, MAIL_CLASS_ID)
local PLATE_SUBCLASS = GetItemSubClassInfo(ARMOR_CLASS_ID, PLATE_CLASS_ID)
local COSMETIC_SUBCLASS = GetItemSubClassInfo(ARMOR_CLASS_ID, COSMETIC_CLASS_ID)
local SHIELDS_SUBCLASS = GetItemSubClassInfo(ARMOR_CLASS_ID, SHIELDS_CLASS_ID)

--print("Item Classes: ")
--print(WEAPON_CLASS,ARMOR_CLASS)

--print("Weapon subclasses: ")
--local concat_string = ""
--for k,v in pairs({GetAuctionItemSubClasses(WEAPON_CLASS_ID)}) do
--	class = GetItemSubClassInfo(WEAPON_CLASS_ID, v)
--	concat_string =  concat_string .. class .. " "
--end
--print(concat_string)
--print(ONEHANDAXES_SUBCLASS,TWOHANDAXES_SUBCLASS,BOWS_SUBCLASS,GUNS_SUBCLASS,ONEHANDMACES_SUBCLASS,TWOHANDMACES_SUBCLASS,POLEARMS_SUBCLASS,ONEHANDSWORDS_SUBCLASS,TWOHANDSWORDS_SUBCLASS,WARGLAIVES_SUBCLASS,STAVES_SUBCLASS,FISTWEAPONS_SUBCLASS,WEAPONMISC_SUBCLASS,DAGGERS_SUBCLASS,THROWN_SUBCLASS,CROSSBOWS_SUBCLASS,WANDS_SUBCLASS,FISHINGPOLES_SUBCLASS)

--print("Armor subclasses: ")
--concat_string = ""
--for k,v in pairs({GetAuctionItemSubClasses(ARMOR_CLASS_ID)}) do
--	class = GetItemSubClassInfo(ARMOR_CLASS_ID, v)
--	concat_string =  concat_string .. class .. " "
--end
--print(concat_string)
--print(ARMORMISC_SUBCLASS,CLOTH_SUBCLASS,LEATHER_SUBCLASS,MAIL_SUBCLASS,PLATE_SUBCLASS,COSMETIC_SUBCLASS,SHIELDS_SUBCLASS)

function BagSaverTables.ItemIsWeapon(item)
	if item.class == WEAPON_CLASS then
		if item.subclass == FISHINGPOLE then
			return false
		else
			return true
		end
	end
	return false
end

function BagSaverTables.ItemIsArmor(item)
	if item.class == ARMOR_CLASS then
		return true
	end
	return false
end

function BagSaverTables.ItemIsRangedWeapon(item)
	if BagSaverTables.ItemIsWeapon(item) then
		if item.subClass == BOWS_SUBCLASS or
			item.subClass == CROSSBOWS_SUBCLASS or
			item.subClass == GUNS_SUBCLASS or
			item.subClass == THROWN_SUBCLASS then
			--print(item.name .. " is ranged weapon " .. item.class .. " " .. item.subClass)
			return true
		end
	end
	--print(item.name .. "is not ranged " .. item.class .. " " .. item.subClass)
	return false
end

-- Functions for data tables
function BagSaverTables.DumpEquipmentTable()
	for className, localizedClassName in pairs(LOCALIZED_CLASS_NAMES_MALE) do
		print(className)
		for itemType,v in pairs(BagSaverTables["UnusableEquipment"][className]) do
			print(" " .. itemType)
			for itemSubType,v in pairs(BagSaverTables["UnusableEquipment"][className][itemType]) do
				print("  " .. itemSubType,v)
			end
		end
	end
end

function BagSaverTables.DumpNonPrimaryArmorTable()
	for className, localizedClassName in pairs(LOCALIZED_CLASS_NAMES_MALE) do
		print(className)
		print(" Always:")
		for armorType,v in pairs(BagSaverTables["NonPrimaryArmor"][className]) do
			print("  " .. armorType)
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

-- Table definitions

--UnusuableEquipment - Lists what gear is unusable for each class
local UnusableEquipment = {}
BagSaverTables["UnusableEquipment"] = UnusableEquipment

--Initialize our table structure for each class
--UnusableEquipment["CLASS"] = {}
--UnusableEquipment["CLASS"][WEAPON_CLASS] = {}
--UnusableEquipment["CLASS"][ARMOR_CLASS] = {}
for className, localizedClassName in pairs(LOCALIZED_CLASS_NAMES_MALE) do
	UnusableEquipment[className] = {}
	UnusableEquipment[className][WEAPON_CLASS] = {}
	UnusableEquipment[className][ARMOR_CLASS] = {}
end

--Reference for all equipment and armor types
--[[
UnusableEquipment["CLASS"][WEAPON_CLASS][BOWS_SUBCLASS] = 1
UnusableEquipment["CLASS"][WEAPON_CLASS][CROSSBOWS_SUBCLASS] = 1
UnusableEquipment["CLASS"][WEAPON_CLASS][DAGGERS_SUBCLASS] = 1
UnusableEquipment["CLASS"][WEAPON_CLASS][FISTWEAPONS_SUBCLASS] = 1
UnusableEquipment["CLASS"][WEAPON_CLASS][GUNS_SUBCLASS] = 1
UnusableEquipment["CLASS"][WEAPON_CLASS][ONEHANDAXES_SUBCLASS] = 1
UnusableEquipment["CLASS"][WEAPON_CLASS][ONEHANDMACES_SUBCLASS] = 1
UnusableEquipment["CLASS"][WEAPON_CLASS][ONEHANDSWORDS_SUBCLASS] = 1
UnusableEquipment["CLASS"][WEAPON_CLASS][POLEARMS_SUBCLASS] = 1
UnusableEquipment["CLASS"][WEAPON_CLASS][STAVES_SUBCLASS] = 1
UnusableEquipment["CLASS"][WEAPON_CLASS][THROWN_SUBCLASS] = 1
UnusableEquipment["CLASS"][WEAPON_CLASS][TWOHANDAXES_SUBCLASS] = 1
UnusableEquipment["CLASS"][WEAPON_CLASS][TWOHANDMACES_SUBCLASS] = 1
UnusableEquipment["CLASS"][WEAPON_CLASS][TWOHANDSWORDS_SUBCLASS] = 1
UnusableEquipment["CLASS"][WEAPON_CLASS][WANDS_SUBCLASS] = 1
UnusableEquipment["CLASS"][WEAPON_CLASS][WARGLAIVES_SUBCLASS] = 1
UnusableEquipment["CLASS"][ARMOR_CLASS][CLOTH_SUBCLASS] = 1
UnusableEquipment["CLASS"][ARMOR_CLASS][LEATHER_SUBCLASS] = 1
UnusableEquipment["CLASS"][ARMOR_CLASS][MAIL_SUBCLASS] = 1
UnusableEquipment["CLASS"][ARMOR_CLASS][PLATE_SUBCLASS] = 1
UnusableEquipment["CLASS"][ARMOR_CLASS][SHIELDS_SUBCLASS] = 1
--]]

UnusableEquipment["DEATHKNIGHT"][WEAPON_CLASS][BOWS_SUBCLASS] = 1
UnusableEquipment["DEATHKNIGHT"][WEAPON_CLASS][CROSSBOWS_SUBCLASS] = 1
UnusableEquipment["DEATHKNIGHT"][WEAPON_CLASS][DAGGERS_SUBCLASS] = 1
UnusableEquipment["DEATHKNIGHT"][WEAPON_CLASS][FISTWEAPONS_SUBCLASS] = 1
UnusableEquipment["DEATHKNIGHT"][WEAPON_CLASS][GUNS_SUBCLASS] = 1
UnusableEquipment["DEATHKNIGHT"][WEAPON_CLASS][STAVES_SUBCLASS] = 1
UnusableEquipment["DEATHKNIGHT"][WEAPON_CLASS][THROWN_SUBCLASS] = 1
UnusableEquipment["DEATHKNIGHT"][WEAPON_CLASS][WANDS_SUBCLASS] = 1
UnusableEquipment["DEATHKNIGHT"][WEAPON_CLASS][WARGLAIVES_SUBCLASS] = 1
UnusableEquipment["DEATHKNIGHT"][ARMOR_CLASS][SHIELDS_SUBCLASS] = 1

UnusableEquipment["DEMONHUNTER"][WEAPON_CLASS][BOWS_SUBCLASS] = 1
UnusableEquipment["DEMONHUNTER"][WEAPON_CLASS][CROSSBOWS_SUBCLASS] = 1
UnusableEquipment["DEMONHUNTER"][WEAPON_CLASS][GUNS_SUBCLASS] = 1
UnusableEquipment["DEMONHUNTER"][WEAPON_CLASS][POLEARMS_SUBCLASS] = 1
UnusableEquipment["DEMONHUNTER"][WEAPON_CLASS][STAVES_SUBCLASS] = 1
UnusableEquipment["DEMONHUNTER"][WEAPON_CLASS][THROWN_SUBCLASS] = 1
UnusableEquipment["DEMONHUNTER"][WEAPON_CLASS][TWOHANDAXES_SUBCLASS] = 1
UnusableEquipment["DEMONHUNTER"][WEAPON_CLASS][TWOHANDMACES_SUBCLASS] = 1
UnusableEquipment["DEMONHUNTER"][WEAPON_CLASS][TWOHANDSWORDS_SUBCLASS] = 1
UnusableEquipment["DEMONHUNTER"][WEAPON_CLASS][WANDS_SUBCLASS] = 1
UnusableEquipment["DEMONHUNTER"][ARMOR_CLASS][MAIL_SUBCLASS] = 1
UnusableEquipment["DEMONHUNTER"][ARMOR_CLASS][PLATE_SUBCLASS] = 1
UnusableEquipment["DEMONHUNTER"][ARMOR_CLASS][SHIELDS_SUBCLASS] = 1

UnusableEquipment["DRUID"][WEAPON_CLASS][BOWS_SUBCLASS] = 1
UnusableEquipment["DRUID"][WEAPON_CLASS][CROSSBOWS_SUBCLASS] = 1
UnusableEquipment["DRUID"][WEAPON_CLASS][GUNS_SUBCLASS] = 1
UnusableEquipment["DRUID"][WEAPON_CLASS][ONEHANDAXES_SUBCLASS] = 1
UnusableEquipment["DRUID"][WEAPON_CLASS][ONEHANDSWORDS_SUBCLASS] = 1
UnusableEquipment["DRUID"][WEAPON_CLASS][THROWN_SUBCLASS] = 1
UnusableEquipment["DRUID"][WEAPON_CLASS][TWOHANDAXES_SUBCLASS] = 1
UnusableEquipment["DRUID"][WEAPON_CLASS][TWOHANDSWORDS_SUBCLASS] = 1
UnusableEquipment["DRUID"][WEAPON_CLASS][WANDS_SUBCLASS] = 1
UnusableEquipment["DRUID"][WEAPON_CLASS][WARGLAIVES_SUBCLASS] = 1
UnusableEquipment["DRUID"][ARMOR_CLASS][MAIL_SUBCLASS] = 1
UnusableEquipment["DRUID"][ARMOR_CLASS][PLATE_SUBCLASS] = 1
UnusableEquipment["DRUID"][ARMOR_CLASS][SHIELDS_SUBCLASS] = 1

UnusableEquipment["HUNTER"][WEAPON_CLASS][ONEHANDMACES_SUBCLASS] = 1
UnusableEquipment["HUNTER"][WEAPON_CLASS][TWOHANDMACES_SUBCLASS] = 1
UnusableEquipment["HUNTER"][WEAPON_CLASS][WANDS_SUBCLASS] = 1
UnusableEquipment["HUNTER"][WEAPON_CLASS][WARGLAIVES_SUBCLASS] = 1
UnusableEquipment["HUNTER"][ARMOR_CLASS][PLATE_SUBCLASS] = 1
UnusableEquipment["HUNTER"][ARMOR_CLASS][SHIELDS_SUBCLASS] = 1

UnusableEquipment["MAGE"][WEAPON_CLASS][BOWS_SUBCLASS] = 1
UnusableEquipment["MAGE"][WEAPON_CLASS][CROSSBOWS_SUBCLASS] = 1
UnusableEquipment["MAGE"][WEAPON_CLASS][FISTWEAPONS_SUBCLASS] = 1
UnusableEquipment["MAGE"][WEAPON_CLASS][GUNS_SUBCLASS] = 1
UnusableEquipment["MAGE"][WEAPON_CLASS][ONEHANDAXES_SUBCLASS] = 1
UnusableEquipment["MAGE"][WEAPON_CLASS][ONEHANDMACES_SUBCLASS] = 1
UnusableEquipment["MAGE"][WEAPON_CLASS][POLEARMS_SUBCLASS] = 1
UnusableEquipment["MAGE"][WEAPON_CLASS][THROWN_SUBCLASS] = 1
UnusableEquipment["MAGE"][WEAPON_CLASS][TWOHANDAXES_SUBCLASS] = 1
UnusableEquipment["MAGE"][WEAPON_CLASS][TWOHANDMACES_SUBCLASS] = 1
UnusableEquipment["MAGE"][WEAPON_CLASS][TWOHANDSWORDS_SUBCLASS] = 1
UnusableEquipment["MAGE"][WEAPON_CLASS][WARGLAIVES_SUBCLASS] = 1
UnusableEquipment["MAGE"][ARMOR_CLASS][LEATHER_SUBCLASS] = 1
UnusableEquipment["MAGE"][ARMOR_CLASS][MAIL_SUBCLASS] = 1
UnusableEquipment["MAGE"][ARMOR_CLASS][PLATE_SUBCLASS] = 1
UnusableEquipment["MAGE"][ARMOR_CLASS][SHIELDS_SUBCLASS] = 1

UnusableEquipment["MONK"][WEAPON_CLASS][BOWS_SUBCLASS] = 1
UnusableEquipment["MONK"][WEAPON_CLASS][CROSSBOWS_SUBCLASS] = 1
UnusableEquipment["MONK"][WEAPON_CLASS][DAGGERS_SUBCLASS] = 1
UnusableEquipment["MONK"][WEAPON_CLASS][GUNS_SUBCLASS] = 1
UnusableEquipment["MONK"][WEAPON_CLASS][THROWN_SUBCLASS] = 1
UnusableEquipment["MONK"][WEAPON_CLASS][TWOHANDAXES_SUBCLASS] = 1
UnusableEquipment["MONK"][WEAPON_CLASS][TWOHANDMACES_SUBCLASS] = 1
UnusableEquipment["MONK"][WEAPON_CLASS][TWOHANDSWORDS_SUBCLASS] = 1
UnusableEquipment["MONK"][WEAPON_CLASS][WANDS_SUBCLASS] = 1
UnusableEquipment["MONK"][WEAPON_CLASS][WARGLAIVES_SUBCLASS] = 1
UnusableEquipment["MONK"][ARMOR_CLASS][MAIL_SUBCLASS] = 1
UnusableEquipment["MONK"][ARMOR_CLASS][PLATE_SUBCLASS] = 1
UnusableEquipment["MONK"][ARMOR_CLASS][SHIELDS_SUBCLASS] = 1

UnusableEquipment["PALADIN"][WEAPON_CLASS][BOWS_SUBCLASS] = 1
UnusableEquipment["PALADIN"][WEAPON_CLASS][CROSSBOWS_SUBCLASS] = 1
UnusableEquipment["PALADIN"][WEAPON_CLASS][DAGGERS_SUBCLASS] = 1
UnusableEquipment["PALADIN"][WEAPON_CLASS][FISTWEAPONS_SUBCLASS] = 1
UnusableEquipment["PALADIN"][WEAPON_CLASS][GUNS_SUBCLASS] = 1
UnusableEquipment["PALADIN"][WEAPON_CLASS][STAVES_SUBCLASS] = 1
UnusableEquipment["PALADIN"][WEAPON_CLASS][THROWN_SUBCLASS] = 1
UnusableEquipment["PALADIN"][WEAPON_CLASS][WANDS_SUBCLASS] = 1
UnusableEquipment["PALADIN"][WEAPON_CLASS][WARGLAIVES_SUBCLASS] = 1

UnusableEquipment["PRIEST"][WEAPON_CLASS][BOWS_SUBCLASS] = 1
UnusableEquipment["PRIEST"][WEAPON_CLASS][CROSSBOWS_SUBCLASS] = 1
UnusableEquipment["PRIEST"][WEAPON_CLASS][FISTWEAPONS_SUBCLASS] = 1
UnusableEquipment["PRIEST"][WEAPON_CLASS][GUNS_SUBCLASS] = 1
UnusableEquipment["PRIEST"][WEAPON_CLASS][ONEHANDAXES_SUBCLASS] = 1
UnusableEquipment["PRIEST"][WEAPON_CLASS][ONEHANDSWORDS_SUBCLASS] = 1
UnusableEquipment["PRIEST"][WEAPON_CLASS][POLEARMS_SUBCLASS] = 1
UnusableEquipment["PRIEST"][WEAPON_CLASS][THROWN_SUBCLASS] = 1
UnusableEquipment["PRIEST"][WEAPON_CLASS][TWOHANDAXES_SUBCLASS] = 1
UnusableEquipment["PRIEST"][WEAPON_CLASS][TWOHANDMACES_SUBCLASS] = 1
UnusableEquipment["PRIEST"][WEAPON_CLASS][TWOHANDSWORDS_SUBCLASS] = 1
UnusableEquipment["PRIEST"][WEAPON_CLASS][WARGLAIVES_SUBCLASS] = 1
UnusableEquipment["PRIEST"][ARMOR_CLASS][LEATHER_SUBCLASS] = 1
UnusableEquipment["PRIEST"][ARMOR_CLASS][MAIL_SUBCLASS] = 1
UnusableEquipment["PRIEST"][ARMOR_CLASS][PLATE_SUBCLASS] = 1
UnusableEquipment["PRIEST"][ARMOR_CLASS][SHIELDS_SUBCLASS] = 1

UnusableEquipment["ROGUE"][WEAPON_CLASS][BOWS_SUBCLASS] = 1
UnusableEquipment["ROGUE"][WEAPON_CLASS][CROSSBOWS_SUBCLASS] = 1
UnusableEquipment["ROGUE"][WEAPON_CLASS][GUNS_SUBCLASS] = 1
UnusableEquipment["ROGUE"][WEAPON_CLASS][POLEARMS_SUBCLASS] = 1
UnusableEquipment["ROGUE"][WEAPON_CLASS][THROWN_SUBCLASS] = 1
UnusableEquipment["ROGUE"][WEAPON_CLASS][STAVES_SUBCLASS] = 1
UnusableEquipment["ROGUE"][WEAPON_CLASS][TWOHANDAXES_SUBCLASS] = 1
UnusableEquipment["ROGUE"][WEAPON_CLASS][TWOHANDMACES_SUBCLASS] = 1
UnusableEquipment["ROGUE"][WEAPON_CLASS][TWOHANDSWORDS_SUBCLASS] = 1
UnusableEquipment["ROGUE"][WEAPON_CLASS][WANDS_SUBCLASS] = 1
UnusableEquipment["ROGUE"][WEAPON_CLASS][WARGLAIVES_SUBCLASS] = 1
UnusableEquipment["ROGUE"][ARMOR_CLASS][MAIL_SUBCLASS] = 1
UnusableEquipment["ROGUE"][ARMOR_CLASS][PLATE_SUBCLASS] = 1
UnusableEquipment["ROGUE"][ARMOR_CLASS][SHIELDS_SUBCLASS] = 1

UnusableEquipment["SHAMAN"][WEAPON_CLASS][BOWS_SUBCLASS] = 1
UnusableEquipment["SHAMAN"][WEAPON_CLASS][CROSSBOWS_SUBCLASS] = 1
UnusableEquipment["SHAMAN"][WEAPON_CLASS][GUNS_SUBCLASS] = 1
UnusableEquipment["SHAMAN"][WEAPON_CLASS][ONEHANDSWORDS_SUBCLASS] = 1
UnusableEquipment["SHAMAN"][WEAPON_CLASS][POLEARMS_SUBCLASS] = 1
UnusableEquipment["SHAMAN"][WEAPON_CLASS][THROWN_SUBCLASS] = 1
UnusableEquipment["SHAMAN"][WEAPON_CLASS][TWOHANDSWORDS_SUBCLASS] = 1
UnusableEquipment["SHAMAN"][WEAPON_CLASS][WANDS_SUBCLASS] = 1
UnusableEquipment["SHAMAN"][WEAPON_CLASS][WARGLAIVES_SUBCLASS] = 1
UnusableEquipment["SHAMAN"][ARMOR_CLASS][PLATE_SUBCLASS] = 1

UnusableEquipment["WARLOCK"][WEAPON_CLASS][BOWS_SUBCLASS] = 1
UnusableEquipment["WARLOCK"][WEAPON_CLASS][CROSSBOWS_SUBCLASS] = 1
UnusableEquipment["WARLOCK"][WEAPON_CLASS][FISTWEAPONS_SUBCLASS] = 1
UnusableEquipment["WARLOCK"][WEAPON_CLASS][GUNS_SUBCLASS] = 1
UnusableEquipment["WARLOCK"][WEAPON_CLASS][ONEHANDAXES_SUBCLASS] = 1
UnusableEquipment["WARLOCK"][WEAPON_CLASS][ONEHANDMACES_SUBCLASS] = 1
UnusableEquipment["WARLOCK"][WEAPON_CLASS][POLEARMS_SUBCLASS] = 1
UnusableEquipment["WARLOCK"][WEAPON_CLASS][THROWN_SUBCLASS] = 1
UnusableEquipment["WARLOCK"][WEAPON_CLASS][TWOHANDAXES_SUBCLASS] = 1
UnusableEquipment["WARLOCK"][WEAPON_CLASS][TWOHANDMACES_SUBCLASS] = 1
UnusableEquipment["WARLOCK"][WEAPON_CLASS][TWOHANDSWORDS_SUBCLASS] = 1
UnusableEquipment["WARLOCK"][WEAPON_CLASS][WARGLAIVES_SUBCLASS] = 1
UnusableEquipment["WARLOCK"][ARMOR_CLASS][LEATHER_SUBCLASS] = 1
UnusableEquipment["WARLOCK"][ARMOR_CLASS][MAIL_SUBCLASS] = 1
UnusableEquipment["WARLOCK"][ARMOR_CLASS][PLATE_SUBCLASS] = 1
UnusableEquipment["WARLOCK"][ARMOR_CLASS][SHIELDS_SUBCLASS] = 1

UnusableEquipment["WARRIOR"][WEAPON_CLASS][BOWS_SUBCLASS] = 1
UnusableEquipment["WARRIOR"][WEAPON_CLASS][CROSSBOWS_SUBCLASS] = 1
UnusableEquipment["WARRIOR"][WEAPON_CLASS][GUNS_SUBCLASS] = 1
UnusableEquipment["WARRIOR"][WEAPON_CLASS][THROWN_SUBCLASS] = 1
UnusableEquipment["WARRIOR"][WEAPON_CLASS][WANDS_SUBCLASS] = 1
UnusableEquipment["WARRIOR"][WEAPON_CLASS][WARGLAIVES_SUBCLASS] = 1

--NonPrimaryArmor - Lists what armor types are non-primary for each class
local NonPrimaryArmor = {}
BagSaverTables["NonPrimaryArmor"] = NonPrimaryArmor

--Initialize our table structure
--NonPrimaryArmor["CLASS"] = {}
for className, localizedClassName in pairs(LOCALIZED_CLASS_NAMES_MALE) do
	NonPrimaryArmor[className] = {}
end
NonPrimaryArmor["DEATHKNIGHT"][CLOTH_SUBCLASS] = 1
NonPrimaryArmor["DEATHKNIGHT"][LEATHER_SUBCLASS] = 1
NonPrimaryArmor["DEATHKNIGHT"][MAIL_SUBCLASS] = 1

NonPrimaryArmor["DEMONHUNTER"][CLOTH_SUBCLASS] = 1

NonPrimaryArmor["DRUID"][CLOTH_SUBCLASS] = 1

NonPrimaryArmor["HUNTER"][CLOTH_SUBCLASS] = 1
NonPrimaryArmor["HUNTER"][LEATHER_SUBCLASS] = 1

NonPrimaryArmor["MONK"][CLOTH_SUBCLASS] = 1

NonPrimaryArmor["PALADIN"][CLOTH_SUBCLASS] = 1
NonPrimaryArmor["PALADIN"][LEATHER_SUBCLASS] = 1
NonPrimaryArmor["PALADIN"][MAIL_SUBCLASS] = 1

NonPrimaryArmor["ROGUE"][CLOTH_SUBCLASS] = 1

NonPrimaryArmor["SHAMAN"][CLOTH_SUBCLASS] = 1
NonPrimaryArmor["SHAMAN"][LEATHER_SUBCLASS] = 1

NonPrimaryArmor["WARRIOR"][CLOTH_SUBCLASS] = 1
NonPrimaryArmor["WARRIOR"][LEATHER_SUBCLASS] = 1
NonPrimaryArmor["WARRIOR"][MAIL_SUBCLASS] = 1

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
