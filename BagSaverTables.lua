--[[

	Hand-coded data tables for use in BagSaver

--]]


-- Globals
BagSaverTables = {}

-- Useful snippet to get the ids and names for all subtypes
--for _, subClassID in pairs(C_AuctionHouse.GetAuctionItemSubClasses(Enum.ItemClass.Weapon)) do
--    print(subClassID, (GetItemSubClassInfo(Enum.ItemClass.Weapon, subClassID)))
--end

function BagSaverTables.ItemIsWeapon(item)
	if item.classID == Enum.ItemClass.Weapon then
		if item.subClassID == FISHINGPOLE then
			return false
		else
			return true
		end
	end
	return false
end

function BagSaverTables.ItemIsArmor(item)
	if item.classID == Enum.ItemClass.Armor then
		return true
	end
	return false
end

function BagSaverTables.ItemIsRangedWeapon(item)
	if BagSaverTables.ItemIsWeapon(item) then
		if item.subClassID == Enum.ItemWeaponSubclass.Bows or
			item.subClassID == Enum.ItemWeaponSubclass.Crossbow or
			item.subClassID == Enum.ItemWeaponSubclass.Guns or
			item.subClassID == Enum.ItemWeaponSubclass.Thrown then
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
			print("  " .. GetItemSubClassInfo(Enum.ItemClass.Armor, armorSubClassID))
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
--UnusableEquipment["CLASS"][Enum.ItemClass.Weapon] = {}
--UnusableEquipment["CLASS"][Enum.ItemClass.Armor] = {}
for className, localizedClassName in pairs(LOCALIZED_CLASS_NAMES_MALE) do
	UnusableEquipment[className] = {}
	UnusableEquipment[className][Enum.ItemClass.Weapon] = {}
	UnusableEquipment[className][Enum.ItemClass.Armor] = {}
end

--Reference for all equipment and armor types
--[[
UnusableEquipment["CLASS"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Bows] = 1
UnusableEquipment["CLASS"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Crossbow] = 1
UnusableEquipment["CLASS"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Dagger] = 1
UnusableEquipment["CLASS"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Unarmed] = 1
UnusableEquipment["CLASS"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Guns] = 1
UnusableEquipment["CLASS"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Axe1H] = 1
UnusableEquipment["CLASS"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Mace1H] = 1
UnusableEquipment["CLASS"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Sword1H] = 1
UnusableEquipment["CLASS"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Polearm] = 1
UnusableEquipment["CLASS"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Staff] = 1
UnusableEquipment["CLASS"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Thrown] = 1
UnusableEquipment["CLASS"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Axe2H] = 1
UnusableEquipment["CLASS"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Mace2H] = 1
UnusableEquipment["CLASS"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Sword2H] = 1
UnusableEquipment["CLASS"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Wand] = 1
UnusableEquipment["CLASS"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Warglaive] = 1
UnusableEquipment["CLASS"][Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Cloth] = 1
UnusableEquipment["CLASS"][Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Leather] = 1
UnusableEquipment["CLASS"][Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Mail] = 1
UnusableEquipment["CLASS"][Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Plate] = 1
UnusableEquipment["CLASS"][Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Shield] = 1
--]]

UnusableEquipment["DEATHKNIGHT"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Bows] = 1
UnusableEquipment["DEATHKNIGHT"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Crossbow] = 1
UnusableEquipment["DEATHKNIGHT"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Dagger] = 1
UnusableEquipment["DEATHKNIGHT"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Unarmed] = 1
UnusableEquipment["DEATHKNIGHT"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Guns] = 1
UnusableEquipment["DEATHKNIGHT"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Staff] = 1
UnusableEquipment["DEATHKNIGHT"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Thrown] = 1
UnusableEquipment["DEATHKNIGHT"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Wand] = 1
UnusableEquipment["DEATHKNIGHT"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Warglaive] = 1
UnusableEquipment["DEATHKNIGHT"][Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Shield] = 1

UnusableEquipment["DEMONHUNTER"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Bows] = 1
UnusableEquipment["DEMONHUNTER"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Crossbow] = 1
UnusableEquipment["DEMONHUNTER"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Guns] = 1
UnusableEquipment["DEMONHUNTER"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Polearm] = 1
UnusableEquipment["DEMONHUNTER"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Staff] = 1
UnusableEquipment["DEMONHUNTER"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Thrown] = 1
UnusableEquipment["DEMONHUNTER"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Axe2H] = 1
UnusableEquipment["DEMONHUNTER"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Mace2H] = 1
UnusableEquipment["DEMONHUNTER"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Sword2H] = 1
UnusableEquipment["DEMONHUNTER"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Wand] = 1
UnusableEquipment["DEMONHUNTER"][Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Mail] = 1
UnusableEquipment["DEMONHUNTER"][Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Plate] = 1
UnusableEquipment["DEMONHUNTER"][Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Shield] = 1

UnusableEquipment["DRUID"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Bows] = 1
UnusableEquipment["DRUID"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Crossbow] = 1
UnusableEquipment["DRUID"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Guns] = 1
UnusableEquipment["DRUID"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Axe1H] = 1
UnusableEquipment["DRUID"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Sword1H] = 1
UnusableEquipment["DRUID"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Thrown] = 1
UnusableEquipment["DRUID"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Axe2H] = 1
UnusableEquipment["DRUID"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Sword2H] = 1
UnusableEquipment["DRUID"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Wand] = 1
UnusableEquipment["DRUID"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Warglaive] = 1
UnusableEquipment["DRUID"][Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Mail] = 1
UnusableEquipment["DRUID"][Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Plate] = 1
UnusableEquipment["DRUID"][Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Shield] = 1

UnusableEquipment["EVOKER"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Bows] = 1
UnusableEquipment["EVOKER"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Crossbow] = 1
UnusableEquipment["EVOKER"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Guns] = 1
UnusableEquipment["EVOKER"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Polearm] = 1
UnusableEquipment["EVOKER"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Thrown] = 1
UnusableEquipment["EVOKER"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Wand] = 1
UnusableEquipment["EVOKER"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Warglaive] = 1
UnusableEquipment["EVOKER"][Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Plate] = 1
UnusableEquipment["EVOKER"][Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Shield] = 1

UnusableEquipment["HUNTER"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Mace1H] = 1
UnusableEquipment["HUNTER"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Mace2H] = 1
UnusableEquipment["HUNTER"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Wand] = 1
UnusableEquipment["HUNTER"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Warglaive] = 1
UnusableEquipment["HUNTER"][Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Plate] = 1
UnusableEquipment["HUNTER"][Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Shield] = 1

UnusableEquipment["MAGE"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Bows] = 1
UnusableEquipment["MAGE"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Crossbow] = 1
UnusableEquipment["MAGE"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Unarmed] = 1
UnusableEquipment["MAGE"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Guns] = 1
UnusableEquipment["MAGE"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Axe1H] = 1
UnusableEquipment["MAGE"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Mace1H] = 1
UnusableEquipment["MAGE"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Polearm] = 1
UnusableEquipment["MAGE"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Thrown] = 1
UnusableEquipment["MAGE"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Axe2H] = 1
UnusableEquipment["MAGE"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Mace2H] = 1
UnusableEquipment["MAGE"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Sword2H] = 1
UnusableEquipment["MAGE"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Warglaive] = 1
UnusableEquipment["MAGE"][Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Leather] = 1
UnusableEquipment["MAGE"][Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Mail] = 1
UnusableEquipment["MAGE"][Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Plate] = 1
UnusableEquipment["MAGE"][Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Shield] = 1

UnusableEquipment["MONK"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Bows] = 1
UnusableEquipment["MONK"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Crossbow] = 1
UnusableEquipment["MONK"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Dagger] = 1
UnusableEquipment["MONK"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Guns] = 1
UnusableEquipment["MONK"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Thrown] = 1
UnusableEquipment["MONK"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Axe2H] = 1
UnusableEquipment["MONK"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Mace2H] = 1
UnusableEquipment["MONK"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Sword2H] = 1
UnusableEquipment["MONK"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Wand] = 1
UnusableEquipment["MONK"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Warglaive] = 1
UnusableEquipment["MONK"][Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Mail] = 1
UnusableEquipment["MONK"][Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Plate] = 1
UnusableEquipment["MONK"][Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Shield] = 1

UnusableEquipment["PALADIN"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Bows] = 1
UnusableEquipment["PALADIN"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Crossbow] = 1
UnusableEquipment["PALADIN"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Dagger] = 1
UnusableEquipment["PALADIN"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Unarmed] = 1
UnusableEquipment["PALADIN"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Guns] = 1
UnusableEquipment["PALADIN"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Staff] = 1
UnusableEquipment["PALADIN"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Thrown] = 1
UnusableEquipment["PALADIN"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Wand] = 1
UnusableEquipment["PALADIN"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Warglaive] = 1

UnusableEquipment["PRIEST"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Bows] = 1
UnusableEquipment["PRIEST"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Crossbow] = 1
UnusableEquipment["PRIEST"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Unarmed] = 1
UnusableEquipment["PRIEST"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Guns] = 1
UnusableEquipment["PRIEST"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Axe1H] = 1
UnusableEquipment["PRIEST"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Sword1H] = 1
UnusableEquipment["PRIEST"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Polearm] = 1
UnusableEquipment["PRIEST"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Thrown] = 1
UnusableEquipment["PRIEST"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Axe2H] = 1
UnusableEquipment["PRIEST"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Mace2H] = 1
UnusableEquipment["PRIEST"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Sword2H] = 1
UnusableEquipment["PRIEST"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Warglaive] = 1
UnusableEquipment["PRIEST"][Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Leather] = 1
UnusableEquipment["PRIEST"][Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Mail] = 1
UnusableEquipment["PRIEST"][Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Plate] = 1
UnusableEquipment["PRIEST"][Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Shield] = 1

UnusableEquipment["ROGUE"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Bows] = 1
UnusableEquipment["ROGUE"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Crossbow] = 1
UnusableEquipment["ROGUE"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Guns] = 1
UnusableEquipment["ROGUE"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Polearm] = 1
UnusableEquipment["ROGUE"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Thrown] = 1
UnusableEquipment["ROGUE"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Staff] = 1
UnusableEquipment["ROGUE"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Axe2H] = 1
UnusableEquipment["ROGUE"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Mace2H] = 1
UnusableEquipment["ROGUE"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Sword2H] = 1
UnusableEquipment["ROGUE"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Wand] = 1
UnusableEquipment["ROGUE"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Warglaive] = 1
UnusableEquipment["ROGUE"][Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Mail] = 1
UnusableEquipment["ROGUE"][Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Plate] = 1
UnusableEquipment["ROGUE"][Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Shield] = 1

UnusableEquipment["SHAMAN"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Bows] = 1
UnusableEquipment["SHAMAN"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Crossbow] = 1
UnusableEquipment["SHAMAN"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Guns] = 1
UnusableEquipment["SHAMAN"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Sword1H] = 1
UnusableEquipment["SHAMAN"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Polearm] = 1
UnusableEquipment["SHAMAN"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Thrown] = 1
UnusableEquipment["SHAMAN"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Sword2H] = 1
UnusableEquipment["SHAMAN"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Wand] = 1
UnusableEquipment["SHAMAN"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Warglaive] = 1
UnusableEquipment["SHAMAN"][Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Plate] = 1

UnusableEquipment["WARLOCK"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Bows] = 1
UnusableEquipment["WARLOCK"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Crossbow] = 1
UnusableEquipment["WARLOCK"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Unarmed] = 1
UnusableEquipment["WARLOCK"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Guns] = 1
UnusableEquipment["WARLOCK"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Axe1H] = 1
UnusableEquipment["WARLOCK"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Mace1H] = 1
UnusableEquipment["WARLOCK"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Polearm] = 1
UnusableEquipment["WARLOCK"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Thrown] = 1
UnusableEquipment["WARLOCK"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Axe2H] = 1
UnusableEquipment["WARLOCK"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Mace2H] = 1
UnusableEquipment["WARLOCK"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Sword2H] = 1
UnusableEquipment["WARLOCK"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Warglaive] = 1
UnusableEquipment["WARLOCK"][Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Leather] = 1
UnusableEquipment["WARLOCK"][Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Mail] = 1
UnusableEquipment["WARLOCK"][Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Plate] = 1
UnusableEquipment["WARLOCK"][Enum.ItemClass.Armor][Enum.ItemArmorSubclass.Shield] = 1

UnusableEquipment["WARRIOR"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Bows] = 1
UnusableEquipment["WARRIOR"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Crossbow] = 1
UnusableEquipment["WARRIOR"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Guns] = 1
UnusableEquipment["WARRIOR"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Thrown] = 1
UnusableEquipment["WARRIOR"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Wand] = 1
UnusableEquipment["WARRIOR"][Enum.ItemClass.Weapon][Enum.ItemWeaponSubclass.Warglaive] = 1

--NonPrimaryArmor - Lists what armor types are non-primary for each class
local NonPrimaryArmor = {}
BagSaverTables["NonPrimaryArmor"] = NonPrimaryArmor

--Initialize our table structure
--NonPrimaryArmor["CLASS"] = {}
for className, localizedClassName in pairs(LOCALIZED_CLASS_NAMES_MALE) do
	NonPrimaryArmor[className] = {}
end
NonPrimaryArmor["DEATHKNIGHT"][Enum.ItemArmorSubclass.Cloth] = 1
NonPrimaryArmor["DEATHKNIGHT"][Enum.ItemArmorSubclass.Leather] = 1
NonPrimaryArmor["DEATHKNIGHT"][Enum.ItemArmorSubclass.Mail] = 1

NonPrimaryArmor["DEMONHUNTER"][Enum.ItemArmorSubclass.Cloth] = 1

NonPrimaryArmor["DRUID"][Enum.ItemArmorSubclass.Cloth] = 1

NonPrimaryArmor["EVOKER"][Enum.ItemArmorSubclass.Cloth] = 1
NonPrimaryArmor["EVOKER"][Enum.ItemArmorSubclass.Leather] = 1

NonPrimaryArmor["HUNTER"][Enum.ItemArmorSubclass.Cloth] = 1
NonPrimaryArmor["HUNTER"][Enum.ItemArmorSubclass.Leather] = 1

NonPrimaryArmor["MONK"][Enum.ItemArmorSubclass.Cloth] = 1

NonPrimaryArmor["PALADIN"][Enum.ItemArmorSubclass.Cloth] = 1
NonPrimaryArmor["PALADIN"][Enum.ItemArmorSubclass.Leather] = 1
NonPrimaryArmor["PALADIN"][Enum.ItemArmorSubclass.Mail] = 1

NonPrimaryArmor["ROGUE"][Enum.ItemArmorSubclass.Cloth] = 1

NonPrimaryArmor["SHAMAN"][Enum.ItemArmorSubclass.Cloth] = 1
NonPrimaryArmor["SHAMAN"][Enum.ItemArmorSubclass.Leather] = 1

NonPrimaryArmor["WARRIOR"][Enum.ItemArmorSubclass.Cloth] = 1
NonPrimaryArmor["WARRIOR"][Enum.ItemArmorSubclass.Leather] = 1
NonPrimaryArmor["WARRIOR"][Enum.ItemArmorSubclass.Mail] = 1

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
