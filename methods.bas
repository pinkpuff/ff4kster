'Game objects
#include once "types/gameobjects/methods/elementgrid.bas"
#include once "types/gameobjects/methods/equipchart.bas"
#include once "types/gameobjects/methods/spell.bas"
#include once "types/gameobjects/methods/spellset.bas"
#include once "types/gameobjects/methods/weapon.bas"
#include once "types/gameobjects/methods/armor.bas"
#include once "types/gameobjects/methods/medicine.bas"
#include once "types/gameobjects/methods/tool.bas"
#include once "types/gameobjects/methods/shop.bas"
#include once "types/gameobjects/methods/job.bas"
#include once "types/gameobjects/methods/character.bas"
#include once "types/gameobjects/methods/menucommand.bas"
#include once "types/gameobjects/methods/actor.bas"
#include once "types/gameobjects/methods/event.bas"
#include once "types/gameobjects/methods/eventcall.bas"
#include once "types/gameobjects/methods/trigger.bas"
#include once "types/gameobjects/methods/npc.bas"
#include once "types/gameobjects/methods/placement.bas"
#include once "types/gameobjects/methods/placementgroup.bas"
#include once "types/gameobjects/methods/mapgrid.bas"
#include once "types/gameobjects/methods/map.bas"
#include once "types/gameobjects/methods/itemdropgroup.bas"
#include once "types/gameobjects/methods/monsterstatgroup.bas"
#include once "types/gameobjects/methods/monsterspeedgroup.bas"
#include once "types/gameobjects/methods/aicondition.bas"
#include once "types/gameobjects/methods/aiscriptentry.bas"
#include once "types/gameobjects/methods/specialsize.bas"
#include once "types/gameobjects/methods/monster.bas"
#include once "types/gameobjects/methods/formation.bas"
#include once "types/gameobjects/methods/autobattle.bas"
#include once "types/gameobjects/methods/solobattle.bas"
#include once "types/gameobjects/methods/tileset.bas"

'GUI elements
#include once "types/gui/methods/bluemenu.bas"
#include once "types/gui/methods/bluetextinput.bas"
#include once "types/gui/methods/bluenumberinput.bas"
#include once "types/gui/methods/bluemessageinput.bas"
#include once "types/gui/methods/gridmenu.bas"

'Menus used in editors
#include once "types/menus/general/methods/flagmenu.bas"
#include once "types/menus/general/methods/elementmenu.bas"
#include once "types/menus/general/methods/statmenu.bas"
#include once "types/menus/general/methods/equipmenu.bas"
#include once "types/menus/general/methods/racemenu.bas"
#include once "types/menus/general/methods/eventcallmenu.bas"

#include once "types/menus/spell/methods/spelleffectmenu.bas"
#include once "types/menus/spell/methods/spellvisualmenu.bas"

#include once "types/menus/spellset/methods/spellsetstartingmenu.bas"
#include once "types/menus/spellset/methods/spellsetlearningmenu.bas"

#include once "types/menus/weapon/methods/weaponanimationmenu.bas"
#include once "types/menus/weapon/methods/castsmenu.bas"
#include once "types/menus/weapon/methods/weaponpropertiesmenu.bas"
#include once "types/menus/weapon/methods/weaponinfomenu.bas"

#include once "types/menus/armor/methods/armorinfomenu.bas"
#include once "types/menus/medicine/methods/medicineinfomenu.bas"
#include once "types/menus/tool/methods/toolinfomenu.bas"
#include once "types/menus/command/methods/commandparametersmenu.bas"

#include once "types/menus/job/methods/spelllinkmenu.bas"

#include once "types/menus/character/methods/characterlevelupmenu.bas"
#include once "types/menus/character/methods/characterstartingmenu.bas"
#include once "types/menus/character/methods/statupmenu.bas"
#include once "types/menus/character/methods/after70menu.bas"

#include once "types/menus/actor/methods/commandmenu.bas"
#include once "types/menus/actor/methods/equipmentmenu.bas"
#include once "types/menus/actor/methods/shadowdatamenu.bas"

#include once "types/menus/event/methods/scriptentrymenu.bas"
#include once "types/menus/event/methods/eventmenu.bas"

#include once "types/menus/trigger/methods/triggerinfomenu.bas"

#include once "types/menus/monster/methods/aimenu.bas"
#include once "types/menus/monster/methods/monsterinfomenu.bas"
#include once "types/menus/monster/methods/monsterstatsmenu.bas"
#include once "types/menus/monster/methods/monsterdropmenu.bas"
#include once "types/menus/monster/methods/monstergfxmenu.bas"

#include once "types/menus/formation/methods/formationinfomenu.bas"

#include once "types/menus/encounter/methods/encountermenu.bas"

#include once "types/menus/map/methods/mapeditormenu.bas"
