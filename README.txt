BagSaver will help you keep your bags as clean as possible.
I wrote this addon after having enough of my bags being full as I'm levelling/doing dailies/instancing. The goal of the addon will be to keep your bag slots clear of things you don't want, and assist you when your bag does somehow become full in finding the optimal (read: least valuable) item to discard to make room for something better.

All suggestions and feature requests are welcome!

Current features are:
Automated selling of gray items whenever a vendor window is opened
Automated selling of soulbound items that could not ever be equipped (i.e. quest reward staff taken by a Rogue to sell)
Automated selling of soulbound armor that is below your primary armor type (cloth, leather, mail, plate)
Finding the least valuable stack in your inventory for you when your bags are full and need a slot for new loot. 

Future features are:
Integration with economy addons for computing item value

Slash commands (/bagsaver or /bs):
/bs config:	Open addon config menu (also found in Addon tab in Blizzard's Interface menu)
/bs reset:	Resets your config to defaults


ChangeLog:
0.10.02a
--------------------------------
Fixed Polearm detection for Hunters

0.10.02
--------------------------------
Evoker support added
UI code updates for 10.0.2
Updated TOC for 10.0.2

0.10.0
--------------------------------
UI code updates for 10.0
Updated TOC for 10.0

0.9.1
--------------------------------
Fix Hunters trying to sell Legion Survival weapon
Updated TOC for 9.1

0.9.0
--------------------------------
Updated TOC for 9.0

0.8.3
--------------------------------
Updated TOC for 8.3
Refactored some code to account for AuctionHouse API changes

0.8.0
--------------------------------
Updated TOC for 8.0

0.7.0
--------------------------------
Added Demon Hunters and Warglaives to class/equipment tracking
Updated list of non-optimal equipment for classes that no longer change armor type at level 40
Updated TOC for 7.0.3

0.6.8.1
--------------------------------
Removed possible nil object from error line

0.6.8
--------------------------------
Added Gorepetal's Gentle Grasp to list of items to ignore for auto-sell
Updated TOC for 6.2.3


0.6.7
--------------------------------
Added Peon's Mining Pick to list of items to ignore for auto-sell, and made that functionality apply to unusable bound items
Updated TOC for 6.1.0

0.6.6
--------------------------------
Added list of miscellaneous items to ignore for auto-sell, only current entry is Vile Fumigator's Mask
Updated TOC for 6.0

0.6.5
--------------------------------
Bug fixed: BagSaver could try to auto-sell items that weren't armor because they were below your best armor type


0.6.4
--------------------------------
Update TOC for 5.4

0.6.3
--------------------------------
Update TOC for 5.3

0.6.2
--------------------------------
Fixed BagSaver mis-identifying shields

0.6.1
--------------------------------
Updated TOC for 5.2

0.6.0
--------------------------------
Fixed issue with detecting if items are soulbound

0.5.9
--------------------------------
Updated TOC for 5.1

0.5.8.1
--------------------------------
Fishing Poles are no longer considered weapons - fixes auto-selling of soulbound fishing poles for Hunters with the auto-sell Soulbound Useless Items option enabled

0.5.8
--------------------------------
Made BagSaver aware of the Monk class

0.5.7
--------------------------------
Updated option to sell useless items to only consider soulbound items.

0.5.6
--------------------------------
Updated addon for 5.0.4
Hunters now consider all non-ranged weapons to be unusable, and eligible for auto-sell if auto-sell unusable soulbound items option is enabled.
Rogues and Warriors now consider all ranged weapons to be unusable, and eligible for auto-sell if auto-sell unusable soulbound items option is enabled.
Relics are considered unusable by all classes (not really relevant since all Relics are now gray)
Added new option to sell useless items (i.e. weapons you can equip, but not use, like melee weapons for Hunters and ranged weapons for Warrior/Rogues).

0.5.5
--------------------------------
Updated TOC to 4.3

0.5.4
--------------------------------
Updated TOC to 4.2

0.5.3
--------------------------------
Updated TOC to 4.1
Included fishing items that do not "require" fishing to auto-sell exemption

0.5.2
--------------------------------
Updated Unusable Equipment table for Relics for 4.0.6


0.5.1
--------------------------------
Updated Unusable Equipment table for Relics replacing Librams/Idols/Sigils/Totems

0.5
--------------------------------
Updated TOC for 4.0
Added exclusion list for finding discardable items - you can now exempt crafting tools from being considered for discard!
Added exclusion of items that require engineering from auto-sell if you tell BagSaver to sell items below your best armor type
Redesigned options menu slightly
Refactored code for easier maintenance

0.4.1
--------------------------------
Updated TOC for 3.3
Added display of total value of sold items after auto-sell

0.4
--------------------------------
Final release of 0.4b2

0.4b2
--------------------------------
There were potential bugs with how BagSaver displayed the least valuable items in your inventory. These bugs have been fixed.
Least valuable item windows will now close when a slot opens up in your inventory.

0.4b
--------------------------------
New feature: BagSaver can now sell soulbound armor that is below your primary armor type (cloth, leather, mail, plate), off by default
Revision of least valuable stack feature: Now will only show you least valuable gray and white stack
BagSaver now displays the value of any item it sells or shows to you
Minor code refactoring/cleanup

0.3.1
--------------------------------
Improved implementation of Least Valuable stack feature:
Now shows three least valuable items
Does not use inflexible frame tech =)

0.3
--------------------------------
Initial implementation of finding the least valuable stack in your inventory for you to discard when your bags are full

0.2
--------------------------------
Proper release of previous betas
Made config UI a little more swizzy - dependent option checkboxes will disable themselves when their dependant option is disabled

0.2b2
--------------------------------
Weapon type identification was slightly off for daggers, wands, fishing poles, etc. This has been fixed.
Addon incorrectly thought Hunters can use wands. This has been fixed.

0.2b1
--------------------------------
Items are now listed and sold in order of rarity, from least rare (gray) to most rare. This will make it easier to buy back something of value that you didn't mean to sell.

0.2b
--------------------------------
Implemented the ability to consider soulbound items you could never use as junk for auto-selling
Refactored original code
Made inventory searching ignore items with no sell cost

0.1
--------------------------------
Initial release
Supports auto-sell of gray items to vendor
Basic config menu implemented