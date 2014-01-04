--[[

	Hand-coded data tables for use in BagSaver

--]]


-- Globals
BagSaverTables = {}

--Define local vars with localized name of each weapon and armor type
local WEAPON,ARMOR,CONTAINER,CONSUMABLE,GLYPH,TRADEGOODS,RECIPE,GEM,MISCELLANEOUS,QUEST,PET = GetAuctionItemClasses()
local ONEHANDAXES,TWOHANDAXES,BOWS,GUNS,ONEHANDMACES,TWOHANDMACES,POLEARMS,ONEHANDSWORDS,TWOHANDSWORDS,STAVES,FISTWEAPONS,WEAPONMISC,DAGGERS,THROWN,CROSSBOWS,WANDS,FISHINGPOLES = GetAuctionItemSubClasses(1)
local ARMORMISC,CLOTH,LEATHER,MAIL,PLATE,COSMETIC,SHIELDS = GetAuctionItemSubClasses(2)
--print("Item Classes: ")
--print(GetAuctionItemClasses())
--print(WEAPON,ARMOR,CONTAINER,CONSUMABLE,GLYPH,TRADEGOODS,RECIPE,GEM,MISCELLANEOUS,QUEST,PET)
--print("Item Subclasses 1: ")
--print(GetAuctionItemSubClasses(1))
--print(ONEHANDAXES,TWOHANDAXES,BOWS,GUNS,ONEHANDMACES,TWOHANDMACES,POLEARMS,ONEHANDSWORDS,TWOHANDSWORDS,STAVES,FISTWEAPONS,WEAPONMISC,DAGGERS,THROWN,CROSSBOWS,WANDS,FISHINGPOLES)
--print("Item Subclasses 2: ")
--print(GetAuctionItemSubClasses(2))
--print(ARMORMISC,CLOTH,LEATHER,MAIL,PLATE,COSMETIC,SHIELDS)

function BagSaverTables.ItemIsWeapon(item)
	if item.class == WEAPON then
		if item.subclass == FISHINGPOLE then
			return false
		else
			return true
		end
	end
	return false
end

function BagSaverTables.ItemIsArmor(item)
	if item.class == ARMOR then
		return true
	end
	return false
end

function BagSaverTables.ItemIsRangedWeapon(item)
	if BagSaverTables.ItemIsWeapon(item) then
		if item.subClass == BOWS or
			item.subClass == CROSSBOWS or
			item.subClass == GUNS or
			item.subClass == THROWN then
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
			if (armorType ~= "Post40") then
				print("  " .. armorType)
			end
		end
		print(" Post level 40:")
		for armorType,v in pairs(BagSaverTables["NonPrimaryArmor"][className]["Post40"]) do
			if (armorType ~= "Post40") then
				print("  " .. armorType)
			end
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
--UnusableEquipment["CLASS"][WEAPON] = {}
--UnusableEquipment["CLASS"][ARMOR] = {}
for className, localizedClassName in pairs(LOCALIZED_CLASS_NAMES_MALE) do
	UnusableEquipment[className] = {}
	UnusableEquipment[className][WEAPON] = {}
	UnusableEquipment[className][ARMOR] = {}
end

--Reference for all equipment and armor types
--[[
UnusableEquipment["CLASS"][WEAPON][BOWS] = 1
UnusableEquipment["CLASS"][WEAPON][CROSSBOWS] = 1
UnusableEquipment["CLASS"][WEAPON][DAGGERS] = 1
UnusableEquipment["CLASS"][WEAPON][FISTWEAPONS] = 1
UnusableEquipment["CLASS"][WEAPON][GUNS] = 1
UnusableEquipment["CLASS"][WEAPON][ONEHANDAXES] = 1
UnusableEquipment["CLASS"][WEAPON][ONEHANDMACES] = 1
UnusableEquipment["CLASS"][WEAPON][ONEHANDSWORDS] = 1
UnusableEquipment["CLASS"][WEAPON][POLEARMS] = 1
UnusableEquipment["CLASS"][WEAPON][STAVES] = 1
UnusableEquipment["CLASS"][WEAPON][THROWN] = 1
UnusableEquipment["CLASS"][WEAPON][TWOHANDAXES] = 1
UnusableEquipment["CLASS"][WEAPON][TWOHANDMACES] = 1
UnusableEquipment["CLASS"][WEAPON][TWOHANDSWORDS] = 1
UnusableEquipment["CLASS"][WEAPON][WANDS] = 1
UnusableEquipment["CLASS"][ARMOR][CLOTH] = 1
UnusableEquipment["CLASS"][ARMOR][LEATHER] = 1
UnusableEquipment["CLASS"][ARMOR][MAIL] = 1
UnusableEquipment["CLASS"][ARMOR][PLATE] = 1
UnusableEquipment["CLASS"][ARMOR][SHIELDS] = 1
--]]

UnusableEquipment["DEATHKNIGHT"][WEAPON][BOWS] = 1
UnusableEquipment["DEATHKNIGHT"][WEAPON][CROSSBOWS] = 1
UnusableEquipment["DEATHKNIGHT"][WEAPON][DAGGERS] = 1
UnusableEquipment["DEATHKNIGHT"][WEAPON][FISTWEAPONS] = 1
UnusableEquipment["DEATHKNIGHT"][WEAPON][GUNS] = 1
UnusableEquipment["DEATHKNIGHT"][WEAPON][STAVES] = 1
UnusableEquipment["DEATHKNIGHT"][WEAPON][THROWN] = 1
UnusableEquipment["DEATHKNIGHT"][WEAPON][WANDS] = 1
UnusableEquipment["DEATHKNIGHT"][ARMOR][SHIELDS] = 1

UnusableEquipment["DRUID"][WEAPON][BOWS] = 1
UnusableEquipment["DRUID"][WEAPON][CROSSBOWS] = 1
UnusableEquipment["DRUID"][WEAPON][GUNS] = 1
UnusableEquipment["DRUID"][WEAPON][ONEHANDAXES] = 1
UnusableEquipment["DRUID"][WEAPON][ONEHANDSWORDS] = 1
UnusableEquipment["DRUID"][WEAPON][THROWN] = 1
UnusableEquipment["DRUID"][WEAPON][TWOHANDAXES] = 1
UnusableEquipment["DRUID"][WEAPON][TWOHANDSWORDS] = 1
UnusableEquipment["DRUID"][WEAPON][WANDS] = 1
UnusableEquipment["DRUID"][ARMOR][MAIL] = 1
UnusableEquipment["DRUID"][ARMOR][PLATE] = 1
UnusableEquipment["DRUID"][ARMOR][SHIELDS] = 1

UnusableEquipment["HUNTER"][WEAPON][ONEHANDMACES] = 1
UnusableEquipment["HUNTER"][WEAPON][TWOHANDMACES] = 1
UnusableEquipment["HUNTER"][WEAPON][WANDS] = 1
UnusableEquipment["HUNTER"][ARMOR][PLATE] = 1
UnusableEquipment["HUNTER"][ARMOR][SHIELDS] = 1

UnusableEquipment["MAGE"][WEAPON][BOWS] = 1
UnusableEquipment["MAGE"][WEAPON][CROSSBOWS] = 1
UnusableEquipment["MAGE"][WEAPON][FISTWEAPONS] = 1
UnusableEquipment["MAGE"][WEAPON][GUNS] = 1
UnusableEquipment["MAGE"][WEAPON][ONEHANDAXES] = 1
UnusableEquipment["MAGE"][WEAPON][ONEHANDMACES] = 1
UnusableEquipment["MAGE"][WEAPON][POLEARMS] = 1
UnusableEquipment["MAGE"][WEAPON][THROWN] = 1
UnusableEquipment["MAGE"][WEAPON][TWOHANDAXES] = 1
UnusableEquipment["MAGE"][WEAPON][TWOHANDMACES] = 1
UnusableEquipment["MAGE"][WEAPON][TWOHANDSWORDS] = 1
UnusableEquipment["MAGE"][ARMOR][LEATHER] = 1
UnusableEquipment["MAGE"][ARMOR][MAIL] = 1
UnusableEquipment["MAGE"][ARMOR][PLATE] = 1
UnusableEquipment["MAGE"][ARMOR][SHIELDS] = 1

UnusableEquipment["MONK"][WEAPON][BOWS] = 1
UnusableEquipment["MONK"][WEAPON][CROSSBOWS] = 1
UnusableEquipment["MONK"][WEAPON][DAGGERS] = 1
UnusableEquipment["MONK"][WEAPON][GUNS] = 1
UnusableEquipment["MONK"][WEAPON][THROWN] = 1
UnusableEquipment["MONK"][WEAPON][TWOHANDAXES] = 1
UnusableEquipment["MONK"][WEAPON][TWOHANDMACES] = 1
UnusableEquipment["MONK"][WEAPON][TWOHANDSWORDS] = 1
UnusableEquipment["MONK"][WEAPON][WANDS] = 1
UnusableEquipment["MONK"][ARMOR][MAIL] = 1
UnusableEquipment["MONK"][ARMOR][PLATE] = 1
UnusableEquipment["MONK"][ARMOR][SHIELDS] = 1

UnusableEquipment["PALADIN"][WEAPON][BOWS] = 1
UnusableEquipment["PALADIN"][WEAPON][CROSSBOWS] = 1
UnusableEquipment["PALADIN"][WEAPON][DAGGERS] = 1
UnusableEquipment["PALADIN"][WEAPON][FISTWEAPONS] = 1
UnusableEquipment["PALADIN"][WEAPON][GUNS] = 1
UnusableEquipment["PALADIN"][WEAPON][STAVES] = 1
UnusableEquipment["PALADIN"][WEAPON][THROWN] = 1
UnusableEquipment["PALADIN"][WEAPON][WANDS] = 1

UnusableEquipment["PRIEST"][WEAPON][BOWS] = 1
UnusableEquipment["PRIEST"][WEAPON][CROSSBOWS] = 1
UnusableEquipment["PRIEST"][WEAPON][FISTWEAPONS] = 1
UnusableEquipment["PRIEST"][WEAPON][GUNS] = 1
UnusableEquipment["PRIEST"][WEAPON][ONEHANDAXES] = 1
UnusableEquipment["PRIEST"][WEAPON][ONEHANDSWORDS] = 1
UnusableEquipment["PRIEST"][WEAPON][POLEARMS] = 1
UnusableEquipment["PRIEST"][WEAPON][THROWN] = 1
UnusableEquipment["PRIEST"][WEAPON][TWOHANDAXES] = 1
UnusableEquipment["PRIEST"][WEAPON][TWOHANDMACES] = 1
UnusableEquipment["PRIEST"][WEAPON][TWOHANDSWORDS] = 1
UnusableEquipment["PRIEST"][ARMOR][LEATHER] = 1
UnusableEquipment["PRIEST"][ARMOR][MAIL] = 1
UnusableEquipment["PRIEST"][ARMOR][PLATE] = 1
UnusableEquipment["PRIEST"][ARMOR][SHIELDS] = 1

UnusableEquipment["ROGUE"][WEAPON][BOWS] = 1
UnusableEquipment["ROGUE"][WEAPON][CROSSBOWS] = 1
UnusableEquipment["ROGUE"][WEAPON][GUNS] = 1
UnusableEquipment["ROGUE"][WEAPON][POLEARMS] = 1
UnusableEquipment["ROGUE"][WEAPON][THROWN] = 1
UnusableEquipment["ROGUE"][WEAPON][STAVES] = 1
UnusableEquipment["ROGUE"][WEAPON][TWOHANDAXES] = 1
UnusableEquipment["ROGUE"][WEAPON][TWOHANDMACES] = 1
UnusableEquipment["ROGUE"][WEAPON][TWOHANDSWORDS] = 1
UnusableEquipment["ROGUE"][WEAPON][WANDS] = 1
UnusableEquipment["ROGUE"][ARMOR][MAIL] = 1
UnusableEquipment["ROGUE"][ARMOR][PLATE] = 1
UnusableEquipment["ROGUE"][ARMOR][SHIELDS] = 1

UnusableEquipment["SHAMAN"][WEAPON][BOWS] = 1
UnusableEquipment["SHAMAN"][WEAPON][CROSSBOWS] = 1
UnusableEquipment["SHAMAN"][WEAPON][GUNS] = 1
UnusableEquipment["SHAMAN"][WEAPON][ONEHANDSWORDS] = 1
UnusableEquipment["SHAMAN"][WEAPON][POLEARMS] = 1
UnusableEquipment["SHAMAN"][WEAPON][THROWN] = 1
UnusableEquipment["SHAMAN"][WEAPON][TWOHANDSWORDS] = 1
UnusableEquipment["SHAMAN"][WEAPON][WANDS] = 1
UnusableEquipment["SHAMAN"][ARMOR][PLATE] = 1

UnusableEquipment["WARLOCK"][WEAPON][BOWS] = 1
UnusableEquipment["WARLOCK"][WEAPON][CROSSBOWS] = 1
UnusableEquipment["WARLOCK"][WEAPON][FISTWEAPONS] = 1
UnusableEquipment["WARLOCK"][WEAPON][GUNS] = 1
UnusableEquipment["WARLOCK"][WEAPON][ONEHANDAXES] = 1
UnusableEquipment["WARLOCK"][WEAPON][ONEHANDMACES] = 1
UnusableEquipment["WARLOCK"][WEAPON][POLEARMS] = 1
UnusableEquipment["WARLOCK"][WEAPON][THROWN] = 1
UnusableEquipment["WARLOCK"][WEAPON][TWOHANDAXES] = 1
UnusableEquipment["WARLOCK"][WEAPON][TWOHANDMACES] = 1
UnusableEquipment["WARLOCK"][WEAPON][TWOHANDSWORDS] = 1
UnusableEquipment["WARLOCK"][ARMOR][LEATHER] = 1
UnusableEquipment["WARLOCK"][ARMOR][MAIL] = 1
UnusableEquipment["WARLOCK"][ARMOR][PLATE] = 1
UnusableEquipment["WARLOCK"][ARMOR][SHIELDS] = 1

UnusableEquipment["WARRIOR"][WEAPON][BOWS] = 1
UnusableEquipment["WARRIOR"][WEAPON][CROSSBOWS] = 1
UnusableEquipment["WARRIOR"][WEAPON][GUNS] = 1
UnusableEquipment["WARRIOR"][WEAPON][THROWN] = 1
UnusableEquipment["WARRIOR"][WEAPON][WANDS] = 1

--NonPrimaryArmor - Lists what armor types are non-primary for each class
local NonPrimaryArmor = {}
BagSaverTables["NonPrimaryArmor"] = NonPrimaryArmor

--Initialize our table structure
--NonPrimaryArmor["CLASS"] = {}
--NonPrimaryArmor["CLASS"]["Post40"] = {}
for className, localizedClassName in pairs(LOCALIZED_CLASS_NAMES_MALE) do
	NonPrimaryArmor[className] = {}
	NonPrimaryArmor[className]["Post40"] = {}
end
NonPrimaryArmor["DEATHKNIGHT"][CLOTH] = 1
NonPrimaryArmor["DEATHKNIGHT"][LEATHER] = 1
NonPrimaryArmor["DEATHKNIGHT"][MAIL] = 1

NonPrimaryArmor["DRUID"][CLOTH] = 1

NonPrimaryArmor["HUNTER"][CLOTH] = 1
NonPrimaryArmor["HUNTER"]["Post40"][LEATHER] = 1

NonPrimaryArmor["MONK"][CLOTH] = 1

NonPrimaryArmor["PALADIN"][CLOTH] = 1
NonPrimaryArmor["PALADIN"][LEATHER] = 1
NonPrimaryArmor["PALADIN"]["Post40"][MAIL] = 1

NonPrimaryArmor["ROGUE"][CLOTH] = 1

NonPrimaryArmor["SHAMAN"][CLOTH] = 1
NonPrimaryArmor["SHAMAN"]["Post40"][LEATHER] = 1

NonPrimaryArmor["WARRIOR"][CLOTH] = 1
NonPrimaryArmor["WARRIOR"][LEATHER] = 1
NonPrimaryArmor["WARRIOR"]["Post40"][MAIL] = 1

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
