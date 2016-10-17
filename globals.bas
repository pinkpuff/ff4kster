dim shared ff4rom as String
dim shared font(&hFF) as Any ptr
dim shared asc2ff4 as String
dim shared warning as Boolean
dim shared unheadered as Boolean
dim shared ifpatch as Boolean
dim shared system_path as String

'dim shared sprite(255, 7, 7) as UByte
dim shared warp_overlay as Any ptr
dim shared trigger_overlay as Any ptr
dim shared chest_overlay as Any ptr
dim shared passage_overlay as Any ptr

dim shared race_names as List
dim shared element_names as List
dim shared palette_names as List

dim shared swing_names as List
dim shared slash_names as List
dim shared weapon_sprite_names as List
dim shared weapon_property_names as List

dim shared shop_names as List
dim shared character_labels as List

dim shared spell_effects as List
dim shared targets as List
dim shared sound_effects as List
dim shared spell_sprites as List
dim shared effect_names as List
dim shared sequence_names as List

dim shared actor_names as List
dim shared spellset_names as List
dim shared event_names as List
dim shared flag_names as List

dim shared total_triggers as Integer

dim shared map_names as List
dim shared map_labels as List

dim shared song_names as List
dim shared vfx as List
dim shared formation_names as List
dim shared character_names as List

dim shared npc_sprite_names as List
dim shared npc_names as List

dim shared tileset_names as List
dim shared battlebg_names as List

dim shared monstergfxnames as Dictionary
dim shared monstersizenames as List

dim shared pose_names as List
dim shared stance_names as List

dim shared dialogues_bank1 as List
dim shared dialogues_bank3 as List
dim shared dialogues_battle as List
dim shared dialogues_alerts as List
dim shared dialogues_status as List

dim shared item_names as List 'combines weapons, armors, medicines, and tools
dim shared item_descriptions as List

'Objects with fixed quantities
dim shared elementgrids(total_element_grids) as ElementGrid
dim shared equipcharts(total_equip_charts) as EquipChart
dim shared spells(total_spells) as Spell
dim shared weapons(total_weapons) as Weapon
dim shared armors(total_armors) as Armor
dim shared medicines(total_medicines) as Medicine
dim shared tools(total_tools) as Tool
dim shared shops(total_shops) as Shop
dim shared jobs(total_jobs) as Job
dim shared characters(total_characters) as Character
dim shared menucommands(total_commands) as MenuCommand
dim shared actors(total_actors) as Actor
dim shared events(total_events) as Event
dim shared npcs(total_npcs) as NPC
dim shared placement_groups(total_maps) as PlacementGroup
dim shared maps(total_maps) as Map
dim shared item_drops(total_item_drops) as ItemDropGroup
dim shared stat_groups(total_stat_groups) as MonsterStatGroup
dim shared speed_groups(total_speed_groups) as MonsterSpeedGroup
dim shared monsters(total_monsters) as Monster
dim shared conditionhp(total_condition_hps) as UInteger
dim shared aigroupconditions(total_ai_groups) as String
dim shared aigroupscripts(total_ai_groups) as String
dim shared conditionsets(total_condition_sets) as String
dim shared conditions(total_conditions) as AICondition
dim shared scripts(total_scripts) as List
dim shared special_sizes(total_special_sizes) as SpecialSize
dim shared formations(total_formations) as Formation
dim shared encounters(total_encounters, 8) as UByte
dim shared encounter_tables(total_encounter_tables) as UByte
dim shared autobattles(total_autobattles) as AutoBattle
dim shared solobattles(total_solobattles) as SoloBattle
dim shared spritesheets(total_spritesheets) as SpriteSheet
dim shared tilesets(total_tilesets) as Tileset
dim shared mapgrids(total_maps) as MapGrid

'Objects with variable quantities
dim shared spellsets as List
dim shared eventcalls as List

'Item ranges
dim shared white_end as UByte
dim shared summon_start as UByte
dim shared summon_end as UByte
dim shared oob_start as UByte
dim shared oob_end as UByte
dim shared twohanded_start as UByte
dim shared bow_start as UByte
dim shared arrow_start as UByte
dim shared arrow_end as UByte
dim shared shield_start as UByte
dim shared head_start as UByte
dim shared body_start as UByte
dim shared arms_start as UByte
dim shared arms_end as UByte
dim shared descriptions_start as UByte
dim shared descriptions_end as UByte
dim shared keyitem_start as UByte
dim shared keyitem_special1 as UByte
dim shared keyitem_special2 as UByte
dim shared restricted_command1 as UByte
dim shared restricted_command2 as UByte
dim shared restricted_command3 as UByte
dim shared command1_end as UByte
dim shared command2_start as UByte
dim shared command2_end as UByte
dim shared command3_start as UByte
dim shared command3_end as UByte

'Graphic data
dim shared map_palettes(32, 8, 8) as UInteger
dim shared monster_palettes(total_monster_palettes, 7) as UInteger

'Odds and ends
dim shared jobchange_actor as UByte
dim shared jobchange_job as UByte
dim shared solobattle_actor as UByte
dim shared special_spellset_actor as UByte
dim shared black_spellset_name as String
dim shared white_spellset_name as String
dim shared call_spellset_name as String
dim shared special_spellset_name as String
dim shared total_player_spells as UByte
