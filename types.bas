'Game objects
#include once "types/gameobjects/elementgrid.bas"
#include once "types/gameobjects/equipchart.bas"
#include once "types/gameobjects/spell.bas"
#include once "types/gameobjects/spellset.bas"
#include once "types/gameobjects/weapon.bas"
#include once "types/gameobjects/armor.bas"
#include once "types/gameobjects/medicine.bas"
#include once "types/gameobjects/tool.bas"
#include once "types/gameobjects/shop.bas"
#include once "types/gameobjects/statlevelup.bas"
#include once "types/gameobjects/levelupbonus.bas"
#include once "types/gameobjects/job.bas"
#include once "types/gameobjects/character.bas"
#include once "types/gameobjects/menucommand.bas"
#include once "types/gameobjects/actor.bas"
#include once "types/gameobjects/event.bas"
#include once "types/gameobjects/eventcall.bas"
#include once "types/gameobjects/trigger.bas"
#include once "types/gameobjects/npc.bas"
#include once "types/gameobjects/placement.bas"
#include once "types/gameobjects/placementgroup.bas"
#include once "types/gameobjects/mapgrid.bas"
#include once "types/gameobjects/map.bas"
#include once "types/gameobjects/itemdropgroup.bas"
#include once "types/gameobjects/monsterstatgroup.bas"
#include once "types/gameobjects/monsterspeedgroup.bas"
#include once "types/gameobjects/aicondition.bas"
#include once "types/gameobjects/aiscriptentry.bas"
#include once "types/gameobjects/specialsize.bas"
#include once "types/gameobjects/monster.bas"
#include once "types/gameobjects/formation.bas"
#include once "types/gameobjects/autobattle.bas"
#include once "types/gameobjects/solobattle.bas"
#include once "types/gameobjects/tileset.bas"

'GUI elements
#include once "types/gui/bluemenu.bas"
#include once "types/gui/bluetextinput.bas"
#include once "types/gui/bluenumberinput.bas"
#include once "types/gui/bluemessageinput.bas"
#include once "types/gui/gridmenu.bas"

'Menus used in editors
#include once "types/menus/general/flagmenu.bas"
#include once "types/menus/general/elementmenu.bas"
#include once "types/menus/general/statmenu.bas"
#include once "types/menus/general/equipmenu.bas"
#include once "types/menus/general/racemenu.bas"
#include once "types/menus/general/eventcallmenu.bas"

#include once "types/menus/spell/spelleffectmenu.bas"
#include once "types/menus/spell/spellvisualmenu.bas"

#include once "types/menus/spellset/spellsetstartingmenu.bas"
#include once "types/menus/spellset/spellsetlearningmenu.bas"

#include once "types/menus/weapon/weaponanimationmenu.bas"
#include once "types/menus/weapon/castsmenu.bas"
#include once "types/menus/weapon/weaponpropertiesmenu.bas"
#include once "types/menus/weapon/weaponinfomenu.bas"

#include once "types/menus/armor/armorinfomenu.bas"
#include once "types/menus/medicine/medicineinfomenu.bas"
#include once "types/menus/tool/toolinfomenu.bas"
#include once "types/menus/command/commandparametersmenu.bas"

#include once "types/menus/job/spelllinkmenu.bas"

#include once "types/menus/character/characterlevelupmenu.bas"
#include once "types/menus/character/characterstartingmenu.bas"
#include once "types/menus/character/statupmenu.bas"
#include once "types/menus/character/after70menu.bas"

#include once "types/menus/actor/commandmenu.bas"
#include once "types/menus/actor/equipmentmenu.bas"
#include once "types/menus/actor/shadowdatamenu.bas"

#include once "types/menus/event/scriptentrymenu.bas"
#include once "types/menus/event/eventmenu.bas"

#include once "types/menus/trigger/triggerinfomenu.bas"

#include once "types/menus/monster/aimenu.bas"
#include once "types/menus/monster/monsterinfomenu.bas"
#include once "types/menus/monster/monsterstatsmenu.bas"
#include once "types/menus/monster/monsterdropmenu.bas"
#include once "types/menus/monster/monstergfxmenu.bas"

#include once "types/menus/formation/formationinfomenu.bas"

#include once "types/menus/encounter/encountermenu.bas"

#include once "types/menus/map/mapeditormenu.bas"
