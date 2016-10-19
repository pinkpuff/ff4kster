== FF4kster v0.8 ==

IMPORTANT NOTES
---------------

* This editor has only been confirmed to work with roms of FF2US v1.1.
  Usage of this editor with other roms is at your own risk. I may
  eventually add compatibility for other versions in future releases.
  
* This editor is not designed to "play nice" with other editors, patches,
  or external modifications to your rom besides graphics editing. If you
  are able to use other editors or patches or make other changes by means
  other than FF4kster and it happens to be compatible, that's great; but
  if they cause FF4kster to no longer work or to mess up or to mess your
  rom up, too bad; you were warned.
  
* Always back up your rom before making any modifications of any kind
  with this or anything else, especially if you are planning any kind
  of large-scale changes. This editor is currently in active production
  and bugs, big and small, slip by from time to time. Thus, it is useful
  and prudent to always have a "stable" version of your rom to fall back
  on in case it gets horribly messed up.
  
* There are some areas of memory to which this editor allows you to add or
  append data. Some of these have built-in safeguards preventing you from
  adding in more data than there is room for in the rom. However, others
  do not (yet). Thus, be careful when adding in extra data, since if you
  add too much and it doesn't check for room, the new data will simply
  bleed into whatever comes after it in the rom, possibly breaking your
  game in a way that may be difficult to repair.

ABOUT
-----
The goal of this project is to create an all-in-one comprehensive rom
editor / hacking tool for FF4 (technically FF2us, but for the sake of
convenience and brevity I will henceforth refer to it as FF4).

This editor tends to use config files rather than hard-coded strings for as
many labels as possible. This includes things like element names, status
names, shop names, map names, etc., basically whatever things you need names
or descriptions for that can't be read from the ROM directly (things like
character names and job names will be read directly from the ROM you're
editing and the labels will display as such). Thus, if you change DKnight in
the ROM to DarkKn or something, then all the labels for that job will show
DarkKn rather than DKnight. Likewise, if you decide you want to have a
different elemental scheme, then instead of having to remember "ok whenever I
see 'fire' in the editor that means 'water'", you can just go into the config
file and overwrite the string "fire" with "water", and the editor will display
"water" for you.

In addition, this editor attempts to incorporate as much graphic data from the
ROM as possible. For example, it currently reads the menu and font graphics
from the ROM you're editing. This has a couple of advantages. First of all, if
you changed the font/windows in your hack, the editor will look like that as
well, so it adds to the look/feel/atmosphere. Secondly, if you changed some of
the symbols to something else (like, let's say you took out the Whip weapons
and added in, say, the Book weapons from FF3, so you changed the whip font
symbol to look like the book symbol), then those changes will appear in the
editor (so instead of having to remember "ok whenever I see a whip symbol that
means book", you would just see the book symbol you put in there). Ideally
though, I'd like it to also display things like, the weapon graphic for the
weapon you're editing, with the correct palette (as opposed to the text
description it has there right now). Likewise, the monster graphics and so on.


INSTALLATION INSTRUCTIONS
-------------------------

* Download the zip file
* Unzip it into a folder of your choice


CONTROLS
--------

  Always:

    ESC:   Cancel / go back a menu
    Enter: Confirm

  In menus:

    Arrows:      Move among menu options
    End:         Jump to bottom option
    Home:        Jump to top option
    Page Up:     Move up one section
    Page Down:   Move down one section
    Slash (/):   Toggle "indexed mode" (puts an index in front of each option)
    Tab:         Alternate between component windows of a "composite" menu (such as
                  element/status or "can equip" menus)
    Shift-Enter: Highlight the current entry; pressing Enter on another
                  entry will then swap the two instead of confirming (only
                  certain menus can do this)

  In numeric inputs:

    Up:        +1
    Down:      -1
    Page Up:   +10
    Page Down: -10
    Home:      Minimum value
    End:       Maximum value
    Backspace: Divide current number by 10, rounding down (effectively erases
                last digit)
    0-9 keys:  Multiply the current number by 10 and add the typed digit
                (effectively allows you to type out numbers)
    
    NOTE - Some things look like numeric inputs but are actually menus (prices
           for example, as you can't just put any arbitrary number as a price)

  In text inputs:

    Letters:   Letters
    Numbers:   Numbers
    Unerscore: Elipsis (three dots "..." as a single symbol)
    Symbols:   If the symbol corresponds to a symbol in the FF4 font (such as
                a dash or colon), that symbol; otherwise a "?"
    Insert:    Insert a special symbol from the FF4 font that doesn't have a
                corresponding ascii symbol (e.g. weapon icons, magic orbs,
                etc); the first one will appear and you can cycle through them
                using the arrows (enter to confirm)
    Backspace: Delete last letter/symbol


USAGE INSTRUCTIONS
------------------

Whenever you run the program, you must first specify the location of an FF4
rom. This is done by navigating to the desired file using the keyboard. 
If there is a rom you edit often, it may be convenient to copy it
into the same folder as FF4kster.

Assuming that nothing goes wrong and the rom loads correctly, you will then
be presented with a menu of different editors for different types of game
objects. You can use those to view and/or change the various game components,
then when you are satisfied with the changes, navigate back to the main menu
and select "Save ROM". When you are done using the program, select "Quit"
from the main menu.

If something did go wrong, the usual result is that you will be presented
with a black screen that seems to be doing nothing for a long time. If this
happens, the only solution to my knowledge is to halt the task using
whatever means your operating system provides for doing so.

FF4kster uses a wide array of config files to help you keep track of
changes that the editor cannot detect directly from the rom itself. To
modify these, simply navigate into the "config" folder and load up the
corresponding .dat file in a text editor. From there the format should
be obvious, but in most cases it is simply the index of the item in
question followed by the label of the item (keep it lined up vertically
with the others and use spaces, not tabs). You can change or delete
existing items, or add new ones (for the lists that aren't already 
complete).

The following is a breakdown of the different kinds of objects that this
editor can modify, some relevant details about how the game stores or
inteprets them, and how to use the corresponding component of the editor:


SPELLS
------

A "spell" in this context refers not only to the player spells (the black and
white spells, the summons, ninja, and twin magic) but also to monster
techniques (big bang, black hole, "counter", explode, etc).

The "sprites", "sequence", and "effect" parameters affect the graphics
and animation used by the spell. For now, these are merely text descriptions,
and not all combinations will work together the way one might expect. For
now it will have to remain a case of trial and error.

In addition, there are certain spells which have hard-coded components
(particularly the summons). Thus, if you change one of these with the editor,
the result may or may not be quite what you were expecting.

Even though monster techniques are considered the same kind of object, there
are parameters in other menus that expect a spell that is not a monster
technique, so often the menu provided in those situations will only list the
player spells.

The elemental/status properties of spells refer to a chart of combinations of
elements and statuses. You can edit which entry in the chart the spell is
associated with, and/or you can change what combination of elements and
statuses a particular entry in the chart is associated with. Keep in mind
when you do this that any other spells or items with that element/status
index will likewise be affected. Note also that for "status healing" effects,
the statuses that are lit up are the ones that the effect DOES NOT remove.
The darkened/disabled statuses are the ones it will remove.


SPELL SETS
----------

Each spell set has associated with it a set of starting spells and a set of
learned spells. The starting spells are simply a list of spells, but the
learned spells have both a spell and a level at which it is learned.

If you mix spell "colors" (black, white, summon, etc) of learned spells in the
same spell set, it may not work the way you're expecting. Each character can
have up to three separate spell sets. If they learn a white spell, then it
will go into the spell set associated with their "white" magic set regardless
of which set was associated with the learning of that spell. Deciding which
spells are which color is not done by the presence or absence of the
corresponding orb symbol in the name of the spell, but rather by the index of
the spell in the spell list (e.g. the first 24 spells are white no matter
what their names are; this range can also be altered in the Features Editor).
There is a patch available on romhacking.net that modifies the game code to
instead read the name of the spell and only consider spells whose names
start with the white orb symbol to be white for the purposes of assigning
them to spell sets.


FEATURES
--------
The game applies certain properties to a range of item indexes rather than
on an item-by-item basis. Some examples would be, which items are considered
weapons, which are armors, which armors can be equipped in which slot,
which weapons are two-handed, which items can be used in battle, or outside
of battle, etc.

To change a range, select the item in the "from" column and change it to the
item you wish to be the first item with that property, then select the item
in the "to" column and change it to the item you wish to be the last item
with that property.

In addition to the ranges, the game expects there to be two other items with
"key item" status. These are listed below the regular key item range, and
although there is one in the "from" column and one in the "to" column, these
do not define a range, they are simply two individual items that will have
key item status in addition to the items in the key item range.


WEAPONS
-------

When editing who can equip a weapon, there is a chart of different
combinations of jobs. Each weapon has associated with it an entry in this
chart. You can change which chart entry a given weapon is associated with,
and/or you can change the combination of jobs that a particular chart entry
is associated with. If you do this, remember that it will affect all items
with that equip index.

When editing stat bonuses, you can set which stats will get a bonus and which
will get a penalty. Then you can select from a chart of possible
bonus/penalty pairs.


ARMOR
-----

The armor fields are more or less the same as the weapons, but with fewer
properties to edit. Which armors go in which equip slots (Head, Body, etc)
can be changed in the Features Editor.


MEDICINES
---------

Medicines are the name I've given to items that cannot be equipped but can be
used in battle for some kind of effect.


TOOLS
-----

Tools are the name I've given to items that can neither be equipped nor used
in battle. They only have a use on the menu screen, if indeed they have a use
at all. Some are only plot items such as the package given to you by King
Baron.


SHOPS
-----

Here you can edit the contents of the game's shops. The names of the shops
are not stored in the rom, but there is a config file which you can use to
change the names of the shops for your own conveneince.

There is no limitation on the types of items that can appear in a shop. Any
shop can have any combination of items. The only limitation is that there is
a maximum of eight different items that can be for sale in the same shop.


JOBS
----

Here you can edit the names of the jobs and which spell sets they are
associated with. Chaning the name of a job here will change its name in all
the menus in the other editor components.

Characters can have different spell sets in battle and out of battle if
desired, and the names of the spell colors (black, white, call) can be
changed as well. Changing the name of a spell color will change it for
all characters, and will not change the name of the corresponding menu
command in battle.


CHARACTERS
----------

A character basically consists of a set of starting data and a set of levelup
data. It is also associated with an inital "actor". An actor is what you
might intuitively think of as a character in the game; it has a name, battle
menu, starting equipment, and a link back to its associated character (the
starting stats and levelups).

The levelups from the character's starting level to level 70 each consist of
a set of stats which will increase, the amount by which they will each
increase, a Max HP bonus, a Max MP bonus, and an increase in the amount of
experience the character needs to advance to the next level (henceforth
referred to as TNL).

After level 70, the character's HP, MP, and TNL bonuses will be identical to
those of their final levelup. Their stat bonuses, instead of being fixed,
will be randomly selected from a group of eight stat bonus combinations, each
of which has a set of stats to increase and an amount by which to increase
them.


COMMANDS
--------

You can change the name of any command, but you can only change the
parameters of certain commands. The more that gets discovered and posted
about the locations of various features of the commands, the more I will be
able to expand this component of the editor.


ACTORS
------

An actor has a list of battle commands. It also has a list of starting
equipment. It is possible to assign items to actors' starting equipment that
they would not normally be able to equip, but if you do this, they will not
be able to put it back on if they take it off.

In addition to your regular party of five members that you are familiar with,
there is also something known as a "shadow party", also with a capacity of
five members, where people that leave your party but will be returning go when
they leave. When an actor is added to your party, it can either be loaded
from a particular character's starting data, or it can load current data from
a particular slot in the shadow party.

Likewise, when an actor is removed from your party, it can discard its
character data completely, or it can save it in a particular shadow slot, to
be loaded later by another actor.

Each actor also has a link to a set of levelups associated with a character.
You can change what character a given actor levels up as, but be careful
when changing this, because if there are any characters whose levelup data
is not linked to by any actor when you save the rom, that levelup data will
be gone and will not be recoverable by the editor the next time the rom is
loaded.

There is a certain actor (default = Edge) whose "black" spell set outside
of battle will have the text "Black" replaced with another string of text
(default = "Ninja"). The actor this applies to can be changed, as well as
the string of text that will replace it.


MESSAGES
--------
There are several banks of messages in the rom. Bank 1 is quite large and
contains most of the plot messages. Bank 3 is considerably smaller and
contains most of the rest of the plot dialogue. Bank 2 is divided among
the various locations in the game. Each location has an associated set
of messages which its NPCs and sometimes certain events can utilize. The
battle messages are called during in-battle events, and the battle alerts
are more generic messages that could come up in any battle. You can also
change the display of status effect names during battle.

When editing messages from Banks 1, 2, or 3, there is a large text editing
window you can use to enter or edit the text. However, the underlying text
represented in the box is not always identical to how it is displayed in the
preview on the side; several special codes are used to get certain kinds of
symbols or other effects:

  Certain letter pairs: The text encoding always uses dual-character 
                        encoding whenever possible. Thus if you type "th" it
                        will not result in a 't' followed by an 'h' in the
                        rom but rather the single-byte code for the letter
                        pair 'th'. This shouldn't affect your normal typing
                        in any way; you can just type normal letters the way
                        you expect them to appear and the editor will covert
                        it automatically.

  End of line: Even if you press enter to go down to the next line in the
               text input box, that will not create a new line character in
               the text encoding. To do this, use the slash character '/'.

  Names: If you simply type out a name like "Cecil" or "Yang" then if the
         player changes that character's name, the dialogue will not be
         affected in your message. If you want to refer to a character's name,
         use "/name##" where the # symbols are replaced with the digits 
         comprising the name index you're looking for (so for "Cecil" you
         would type "/name00" or for "Yang", "/name06"). In the "insert menu"
         you can select "Name" to bring up a list of names. Selecting one will
         also insert the code for that name into the text (though you can
         still type it out manually if you prefer). The previews in the
         message editor (but not the previews in other editors, such as the
         event editor) will pad the name out to six letters using spaces.
         This is to assist with spacing and alignment for the situation where
         the player renamed the character, and its name may be longer than
         you were expecting when you were composing the message.

  Songs: There is a special character reserved in the text ecoding for causing
         the game to change to a different track of music when it displays the
         dialogue. To achieve this effect in the multiline text input, type
         "/song##" with the # symbols replaced with the digits for the index
         of the song you wish to play. As with names, the "insert menu"
         contains an option which will bring up a list of the songs in the
         game that you can choose one from and it will insert the appropriate
         code into the text for you.

  Delay: You can cause the game to ignore user input for a certain amount of
         time to prevent them from prematurely advancing the text (you can see
         this effect in messages such as "Karate Man Yang joined!" or "Cecil 
         became a Paladin!"). To insert wait time, type "/wait###", replacing
         the # symbols with a number representing the amount of time you wish
         to force the user to wait.

  Unknown codes: There are some characters that exist in the font but their
                 use is currently unknown (Hex codes 0A to 20). In the
                 unlikely event that you wish to type one of these characters,
                 type "/chr##", replacing the # symbols with the decimal
                 representation of the index of the symbol you want (so, a
                 number between 10 and 32).

  Slash: Since many of these codes use the slash symbol '/', if you need the
         text to have an actual slash character in there, this can be achieved
         by typing "/slash". So for example if you want your message to say
         "4/10" then you would type "4/slash10"
         
All of these codes can by typed manually, but most of them can also be 
accessed via a sub menu which appears when you press INSERT while editing.


EVENTS
------

This component allows you to edit the scripts for particular events (but not
when or how they are initiated; that is handled by the trigger editor and
npc editor). First, select an event. Then your cursor will move to the script
and you will be able to scroll through and read it, or edit it. To remove a
particular item from the script, move your cursor to it and press the DELETE
key. To insert a new item into the script, press the INSERT key; it will move
the script from the point of the cursor down and insert a new blank script
item that you can then edit. To edit a script item, move your cursor to it
and press the ENTER key.

If the script contains a conditional "yes/no" entry, there will be an extra
script box handling the "no" scenario. You can toggle between editing these
scripts with the TAB key.

In addition, you can completely clear out an entire script by pressing the
BACKSPACE key. Be careful with this feature though, as there is no "undo"
button, so once you've cleared it, the only way to get it back is to close
the program completely and re-load the rom. If you already saved it with
the event cleared out, you're out of luck; you'll just have to restore from
a backup if you made one.

There is only a certain amount of space in the rom set aside for event
scripts. Currently, the editor does not check the amount of space taken up by
events after you have edited them, so it is possible that if you add too much
information without deleting enough, that saving the rom could cause the
event data to overstep its bounds and bleed into another kind of data. In a
future version I will add safeguards to prevent this scenario, but for now,
just be careful and be sure to backup your rom before saving.


TRIGGERS
--------

Each map has a list of triggers associated with it. In the editor, first
select a map, then you can edit the triggers associated with it. You can edit
a particular trigger with ENTER, or you can use INSERT and DELETE to add or
remove triggers, respectively.

There are three types of triggers:

* Treasures: A treasure will add its contents to your inventory when you
             investigate it (e.g. chests, pots, etc).

* Teleporters: A teleporter will transport you to a different location when
               you step on it (e.g. stairs, doors, etc).

* Events: An event trigger will cause an event to occur when you step on it.
          Depending on the status of various plot flags, different events may
          be launced by the same trigger at different points in the game. In
          addition, each trigger may or may not be associated with a list of
          "bank 2" messages (messages associated with particular maps) which
          are accessed by specific events (default config file calls them
          "show first message", "show second message", "show third message").
          In the editor, use the TAB key to alternate between editing event
          calls, flag settings, and messages. When editing event calls, you
          can use the INSERT and DELETE keys to add or remove event calls
          respectively.

Note that if you wish to put a trigger somewhere, the map tile at that
trigger's coordinates must be one that can launch that kind of trigger.

Like the event editor, the trigger editor does not verify whether or not you
have added too much data, and if you have, it will overwrite something else in
the rom when you save it. Thus, be careful about adding too many extra
triggers, and always backup your rom.


NPCS
----

NPCs are other characters or miscellaneous interactable objects associated
with a particular map.

As with the trigger editor, first select a map, then you can edit the NPC
placements for that map. You can add or remove placements with INSERT or
DELETE, and you can edit them with ENTER.

Unlike the event and trigger editors, the NPC editor DOES check whether there
is room to spare before allowing you to add a new NPC placement. Thus, it is
safe from bleeding into other data when you save.


TILESETS
--------

Tilesets are the collections of tiles that maps are composed of. Besides
their graphics, these tiles have various properties which affect their
behavior in some way (e.g. damages party when stepped on, can encounter
random battles, do you walk under or over it, etc).

To edit a tile, simply select a tileset in the menu at the left, and press
ENTER. You will then be able to select a tile and press ENTER again to edit
its properties. The properties are all basic YES/NO flags which can be
toggled with ENTER. When done editing, press ESC.

While selecting a tileset, you can change the current color palette index
by pressing TAB. This will allow you to change which of the game's preset
color combinations for maps the editor will preview the tileset with. This
can be useful for getting a gist of what a map will look like before 
committing to a certain color palette in the Map Info editor, but also
the default palette index 0 has a lot of black and thus some tiles from
other tilesets are not visible under this palette.


MAP INFO
--------

Each map has a set of properties that define certain features about it.

Simply select the map whose properties you would like to edit, then navigate
the appropriate menus. Sometimes the "NPC Index" of a map is different from the
map index itself. In such a situation, the NPC placements for that map in the
NPC editor will appear on a different map (the map specified by the NPC Index;
if the map has the "underground" flag set, then add 256 to find the actual map).


MAPS
----

Each map consists of a grid of 32x32 map tiles. Highlighting a map will
display a preview of its tileset on the left and a 16x16 tile section of
the map itself in the middle. Pressing Enter will switch to map editing
mode, where the following controls apply:

  TAB: Switch between the map editor and the tile selector.
  
  ARROWS: Move the cursor.
  
The following controls only apply to the map editor itself, not the tile
selector:

  SHIFT + ARROWS: Expand the cursor to highlight a rectangular section
                  instead of just a single tile.
                  
  HOME: Scroll to the top left corner of the map.
  
  END: Scroll to the bottom left corner of the map.
  
  PAGE UP: Scroll to the top right corner of the map.
  
  PAGE DOWN: Scroll to the bottom right corner of the map.
  
  ENTER: Fill the highlighted tile or section with the currently selected
         tile.
         
  SPACE: Flood fill with the currently selected tile, starting at the
         highlighted tile.
         
  BACKSPACE: Change the selected tile to the highlighted one (much like
             the "dropper" feature of many image editors).

Note that certain maps share the same tile arrangements. This can be viewed
and modified in the "Map Info" editor, under the label "Grid Index". If two
maps share a grid index, editing one will cause the same changes in the other.

In addition, some maps do not contain tile data. These cannot be edited;
The editor will simply display a blank box with the message "No data".
With certain exceptions (mainly the overworld maps), you can press ENTER
on such a map to assign it some map data. Likewise, if you press BACKSPACE
in the map selection menu while a map with data is selected, you will be
presented with the option to remove its data (this will also remove the
data for any other maps with that grid index).

The map editor will display at the bottom the current (x, y) coordinates
of the cursor within the map. This can be useful for cross-referencing
with the locations of other things such as triggers and npcs. It also
displays the amount of space remaining for map data in total. If this
number is displayed in red, it means there is more map data to store than
room to store it in the rom, so you must delete or simplify some maps to
reduce it down before saving; otherwise, you will get a "Map Data Overflow"
error and the data will not be saved. This number is not updated as you
edit; it is only updated when you go back to the map selection menu.


MONSTERS
--------

Monsters have some properties that are stored in unusual ways that require a
little explanation.

* Combat stats: Physical attack, physical defense, and magic defense all take
                their values from a list of possible stat combinations. Each
                entry in the list contains a multiplier, a base, and a
                percentage. When editing one of the monster's combat stats,
                first select a stat combination from the list, then you will
                be given the opportunity to change the values in that list
                entry. If you do change them, they will likewise change for
                anything that uses that entry. All three stats use the same
                list. Speed also uses a list, but it is a different list
                from the others, and each entry only contains two numbers:
                a lower bound, and an upper bound.
                
* Item drops: Each monster has associated with it a number which represents an
              index in the list of item drop tables. You can edit which index
              item drop table corresponds to the monster, and you can also edit
              the details of the table associated with that index. Note however
              that changing the table for an index will affect all monsters
              that have that item drop table index.
              
* Flags: There are certain kinds of data which some monsters have and others do
         not. You can change which "extra bits" of information a given monster
         has by setting or unsetting the flags in the "flags menu". If you wish
         to edit the details of the extra data in question, select the 
         appropriate flag and press TAB (will only work if the flag is set).

* AIs: There is a list of AIs which monsters can use. Each monster has associated
       with it a number indicating the index in the list of the AI that it uses.
       The AI editor allows you to change not only this index, but also the 
       details of the associated AI. The AI editor consists of five components
       which can be navigated between by pressing TAB:
       
       * AI index: This allows you to edit which index AI you wish the monster
                   to use. Monsters that appear on the moon use a different list
                   so this index will refer to a different AI for those monsters
                   than it will for a monster anywhere else.
       
       * Condition set list: This is the tall, thin menu on the left side and it
                             indicates the list of condition sets the AI checks
                             to see which script to execute. You can change the
                             set index with ENTER, you can add a new set with
                             INSERT, or you can remove any set except the last
                             with DELETE.
       
       * Condition set: This is the set of conditions that must all be true in
                        order for the corresponding script to be executed.
                        Pressing ENTER on a condition will allow you to pick a
                        different one from a list, then when you pick it, you
                        will be prompted to change its parameters. If you do,
                        they will also be changed for all references to that
                        condition. You can add extra conditions with INSERT and
                        remove them with DELETE. You cannot delete a condition
                        if to do so would leave you with an empty list.
                        
       * Script index: This is the index of the script that corresponds to the
                       currently selected condition set.
                       
       * Script: This is the list of executable commands that the monster will
                 carry out if the conditions are met. You can change an entry
                 with ENTER, add additional lines with INSERT, and delete lines
                 with DELETE.
                 
Monsters that appear in certain lunar maps use a different set of scripts
than monsters in the other areas. For the most part, the monster editor
displays this correctly, however there is a known bug where some lunar
monsters (particularly the lunar bosses) are displaying "regular" scripts
instead of lunar ones. A fix for this is being worked on.


FORMATIONS
----------

A formation is a battle with a particular group of monsters. There are
256 "regular" formations and an additional 256 "underground/moon"
encounters. Events that reference a particular monster formation only
allow an index up to 256; on "regular" maps this will be the index
specified, but on "underground/moon" maps it will be that index + 256.
Since there is no way for an event to "know" the nature of the map the
player is on when it executes, the formation display in the event editor
previews both formations.


ENCOUNTERS
----------

An encounter table is a set of eight formations that a particular map 
randomizes between when a random battle is initiated on that map. The
eight slots each have different probabilities associated with them that
indicate the chance that a given random battle will select that 
formation.

Upper-world maps can only select from among "regular" formations while
underground or lunar maps can only select from among "underground/moon"
formations.

In addition to the regular "inner" maps, there are encounter tables for
different sections of the overworld maps (earth, underground, moon).
Each section is a 32x32 tile region of the respective map.

Changing the details of a particular table will change it for all maps 
that use that encounter table index.


AUTOBATTLES
-----------

Autobattles are scripted battle sequences where the game takes control
of the characters without allowing the player to input commands.

Each autobattle has a formation which it applies to (whenever that 
formation is encountered, the autobattle script will take over), as well
as a script to execute.

When editing the script, use Enter to change a script entry, Insert to
add one at the current cursor position, or Delete to remove the currently
selected entry.

Some autobattles have two scripts: one each for two different actors.
Which ones have two and which have one seem to be hard-coded and thus
cannot be changed at the moment.


SOLOBATTLES
-----------

There are some battles which hide certain actors, or hide all but
certain actors.

Each solobattle has a formation which it is associated with, as well as
an actor. Whenever this formation is encountered, it will hide all actors
except the one specified, unless the one specified is the "Non-solo"
actor. In that case, only that actor will be hidden, and the rest will be
visible/playable as normal.


ACKNOWLEDGEMENTS
----------------

Many thanks to everyone on the Slick Productions forum for posting their
research and discoveries about the internal workings of the game (without
which this project would not have been possible), as well as for helping me
test and debug the editor. I would also like to particularly thank those
that have made active contributions toward this end.

Known contributors, sources, and/or testers include but are not limited to
the following (as much as I don't like naming names, I feel these people
deserve specific mention):

avalanche
avaquizzer
Bond697
chillyfeez
Deathlike2
Displacer
Dragonsbrethren
Edea
Entroper
Grimoire LD
JCE3000GT
LordGaramonde
Paladin
Phoenix
vivify93
Vehek
Yousei
Zozma
Zyrthofar
...and whoever wrote the "Tower of Bab-Il Docs"

VERSION HISTORY
---------------
* 0.8
    - Added safeguard to prevent overflow in:
       - triggers
       - map data
    - Added special size editor to monster editor
    - Added palette preview to monster editor
    - Cleaned up event editor
       - Sub-menus now expand while selecting item
       - Preview map moved to top and no longer disappears
       - Underground formations and NPCs now preview correctly
    - Added "party dead / flag check event instructions" patch
       compatibility
    - Solobattle and trigger editors now preview formation details
    - Added components to actor editor
       - Which character job changes upon return and to what job
    - Added "6-letter spells" feature to feature editor
    - Formation editor can now toggle rewards, and whether the fanfare
       is played after a battle with "no change" music
    - Fixed bug in map background display
    - Map editor now previews available space for map data
    - Added "Extra 1" and "Extra 2" jobs
       - They can have equips and in-battle spell sets but not in-menu
    - Added loading information display to initial rom load routine
    - Glitch worlds can be made into real worlds and vice versa

* 0.7
    - Added safeguard to prevent overflow in:
       - events
       - all text areas
       - learned spells
    - Added Tileset Editor
    - Tiles now read from rom rather than from image files
    - Animated tiles now animate
    - Map editor previews map backgrounds
    - Cleaned up several monster editor glitches

* 0.6
    - Fixed underground NPCs being named as above-ground counterparts
    - Fixed bug with starting level when changing actor level links
    - Cover can now be indexed by job rather than actor
    - Added targeting type to command editor (only affects cursor for some)
    - Map treasure indexes now calculated correctly
    - Added item description editing
    - Fixed descriptions of spell codes 00-30 & 31-5E in monster AIs
    - Jobs can now have separate spell sets in and out of battle 
    - Added solobattle editor
    - Added many parameters to commands
    - Added encounter rates to map info editor
    - Added a file selector instead of typing the rom filename
    - Fixed bug causing end of Bank 2 to be read incorrectly
    - Bank 2 messages can now be added or deleted
    - Many indexes can now be swapped (shift-enter, enter)
    - Included mystery flag in spell editor
    - Map editor now displays coordinates of cursor
    - Corrected message and npc placement references in event editor
    - Fixed error in "You" placement movement descriptions
    - Event editor now previews bank 2 (you can change/set the map)
    - Event editor now previews placement names
    - Added visual effects config file
    - Spell color names (black/white/call) can now be changed
    - "Special" set name (Ninja) can now be renamed/reassigned
    
* 0.5
    - Added parameters to several commands
    - Added spells usable outside of battle to features editor
    - Changed actor names are now correct in battle
    - Added config file for spell graphic "sequences" and "effects"
    - Fixed encounter range for trapped chests
    - Added auto-battle script editor
    - Added map editor
    - Capped Max MP levelup gains to prevent bleeding into TNL gains
    - Fixed error with actor levelup links causing distorted levelup data

* 0.4
    - Fixed bug causing bows to be better in dominant hand
    - Changed name of "Item Range" editor to "Features" editor
    - Added white spell range to features editor
    - Added bow and arrow ranges to features editor
    - Added equip slot ranges to features editor
    - Fixed window alignment error in map info editor
    - Added config file for battle backgrounds
    - Removed extra junk name from map names
    - Fixed bug causing game to freeze when changing characters with R
    - Fixed bug causing warp/exit to be disabled for all maps
    - Added "warpable" flag to Map Info editor
    - Added "exitable" flag to Map Info editor
    - Fixed bug causing Golbez to fail to appear in scripted battle
    - Added Monster editor
    - Added Formation editor
    - Added Encounter editor
    - Added editing of Cover details to command editor

* 0.3
    - Added Page Up / Page Down functionality to menus
    - Added index toggle function to menus
    - Added safeguard to prevent saving if Bank 1 text overflows
    - Fixed a minor bug with interpreting the "/slash" code in message input
    - Fixed bug with character experience cap
    - Added Map Info editor
    - Added Item Ranges editor, including two-handedness and key item status

* 0.2
    - Fixed bugs with saving of NPCs
    - Fixed navigation errors with event calls / npc speeches
    - Added insert/delete functionality to event call / npc speech message parameters
    - Improved message preview display
    - Added previews for bank 2 messages in event call / npc speech parameters
    - Fixed bug causing underground NPCs to be previewed as upperworld counterparts
    - Fixed a minor mistake in reading spell sets
    - Fixed bug relating to saving equip indexes
    - Fixed bug relating to editing element indexes
    - Added config file for NPC sprites
    - Added config file for NPC names
    - Added message editor
    - Added support for unheadered v1.1 roms
