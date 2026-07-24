MORTAL SHELL MOD - ULTIMATE ENHANCEMENT SUITE
==============================================
Complete gameplay enhancement with a full in-game GUI, cheats, unlocks,
and quality-of-life improvements for Mortal Shell.


OVERVIEW
========
MortalShellMod is a comprehensive UE4SS-based modification for Mortal Shell,
featuring a full ImGui interface directly inside the UE4SS debug panel.
No more memorizing hotkeys or console commands — everything is accessible
through an organized, scrollable GUI with live status indicators.

Highlights:
  * Full in-game GUI panel with live toggle status dashboard
  * Mods automatically re-apply ~4 seconds after you respawn — no manual
    re-enabling needed after death
  * Walk speed is adjustable via slider (1x-10x) before toggling
  * All features also available as console commands and optional hotkeys

Timed with renewed interest ahead of Mortal Shell 2. Perfect for veterans
wanting to experience the game differently, newcomers needing assistance,
or anyone wanting to explore all content without the grind.


INSTALLATION
============

REQUIREMENTS:
  * UE4SS experimental-latest (zDev build)
    Download: https://github.com/UE4SS-RE/RE-UE4SS/releases
  * Mortal Shell (Steam / Epic Games / GOG)

NOTE: This mod requires the experimental/zDev UE4SS build.
Stable releases will not work due to ABI differences.

STEPS:
  1. Install UE4SS
     - Download the latest UE4SS experimental/zDev release
     - Extract to:
       ..\Mortal Shell\Dungeonhaven\Binaries\Win64\

  2. Install MortalShellMod
     - Download and extract mod files
     - Place the MortalShellMod folder in:
       ..\Win64\ue4ss\Mods\MortalShellMod\

     Final layout should look like:
       Win64\
         ue4ss\
           Mods\
             MortalShellMod\
               dlls\
                 main.dll
               Scripts\
                 main.lua
                 cheat_utils.lua
                 weapon_mod.lua
                 Utils.lua
               readme.txt

  3. Enable the mod
     - Open: ..\Win64\ue4ss\Mods\mods.txt
     - Add the line:  MortalShellMod : 1

  4. Launch the game
     - Open the UE4SS debug panel (INSERT key by default)
     - Click the "Mortal Shell Mod" tab
     - All features are accessible from there


GUI OVERVIEW
============
The mod adds a single scrollable "Mortal Shell Mod" tab to the UE4SS panel.

  Status Bar (always visible)
    Walk Fast: OFF  |  Super Stamina: OFF  |  Super Stone: OFF
    Enhanced Parry: OFF  |  God Mode: OFF  |  All Mods: OFF

  [ One-Time Actions ]
    Stone Form No Cooldown   — removes cooldown for this area
    Max Resolve              — sets resolve to 1,000,000 with no drain
    Max Out Inventory        — fills all stackable items to max
    Unlock All Shells        — unlocks all shells
    Max Out Bolts            — fills Large Bolt stack to 999
    Super Ballistazooka      — removes all reload/equip animations permanently

  [ Toggle Features ]
    Walk Speed Slider (1x–10x, default 2x)
    Toggle Walk Fast         — applies speed modifier in a continuous loop
    Toggle Super Stamina     — zero stamina cost
    Toggle Super Stone Form  — 1,000,000 duration super stone form
    Toggle Enhanced Parry    — 1000% enhanced parry chance
    Toggle God Mode          — engine-level invulnerability

  [ Advanced Features ]
    Toggle All Mods (F7)                — fires everything at once (see warnings)
    Always Allow Fast Travel            — anti-softlock for ornate mask
    Unlock All Player Funcs             — shells, weapons, ripostes, ballistazooka
    Exploit Inventory                   — zero-cost upgrades + infinite currency
    Open All Fast Travels               — unlocks all fast travel locations
    Max All Familiarity                 — reveals full item descriptions instantly
    Add All Consumables                 — adds every consumable to inventory
    Unlock All Item Entries             — reveals full codex / item encyclopedia
    Unlock All Tutorials                — marks all tutorials as seen

  [ Combat & Enemies ]
    Enemy control, farming, and world settings.

    Toggles:
      Toggle One Hit Kill      — any enemy that spawns is instantly hit for
                                 near-fatal damage; also nukes all currently
                                 loaded enemies when enabled. Persists through
                                 death until toggled off.
      Toggle Fog               — full effects unknown. A visible fog briefly
                                 covers the screen, and some enemies spawn
                                 multiple times (once per press of Toggle Fog).
                                 An internal on/off appears to happen and state
                                 resets somewhere — unconfirmed.

    Actions:
      Hit All Spawned Enemies  — instantly hits every currently loaded enemy for
                                 near-fatal damage. One-shot; pair with One Hit
                                 Kill to auto-clear new spawns.
      Spawn More Enemies       — respawns nearby enemy spawners; good for farming
                                 or testing.
      Enable Passive Tar & Glimpses — every enemy that spawns drops Tar and
                                 Glimpses to you automatically. One-time enable;
                                 stays active for the session.

  [ Weapons ]
    Summon any of the 6 weapons instantly, bypassing weapon racks

  [ Keybinds ]
    Enable Player Keybinds, Enable Weapon Keybinds
    + Full key reference


AUTO RE-ENABLE AFTER DEATH
===========================
When you die and respawn, the mod detects the new player object and
automatically re-fires all mods that were active — approximately 4 seconds
after the player spawns. This means you don't need to manually re-enable
anything after dying.

If Toggle All Mods (F7) was active, the full suite re-enables.
Individual toggles (god mode, walk fast, etc.) re-enable separately
if they were on independently.

Stone Form cooldown cannot be re-applied this way — it resets on area load.


HOTKEYS (opt-in)
================
Hotkeys are NOT active by default.
Enable via the Keybinds section in the GUI, or run:
  enable_mortal_shell_mod_keybinds   (player keys)
  enable_weapon_mod_keybinds         (weapon keys)

Player hotkeys:
  F1          -- Remove stone form cooldown (one-time)
  F2          -- Toggle super stone form
  F3          -- Toggle walk fast (uses current slider value, default 2x)
  F4          -- Toggle unlimited stamina
  F5          -- Max resolve (one-time)
  F6          -- Toggle enhanced parry (1000%)
  F7          -- Toggle all mods at once (see warnings)
  F8          -- Toggle god mode
  F9          -- Max out all inventory items
  PAGE_UP     -- Show current mod status in console
  NUM_LOCK    -- Unlock all shells
  PAGE_DOWN   -- Exploit inventory (zero-cost upgrades + infinite currency)
  HOME        -- Always allow fast travel (anti-softlock)
  BACKSPACE   -- Unlock all player functions

Weapon hotkeys:
  3           -- Max out bolts
  4           -- Super ballistazooka
  5           -- Hallowed Sword
  6           -- Smoldering Mace
  7           -- Hammer and Chisel
  8           -- Martyr's Blade
  9           -- Axatana Twin Blades
  0           -- Axatana Axe


CONSOLE COMMANDS
================
Open the console with F10, then type any command below.

  mortal_shell_mod                               -- List all commands

  --- COMBAT ---
  stone_form_no_cooldown                         -- Remove stone form cooldown
  toggle_super_stone_form_max                    -- Toggle super stone form
  toggle_super_stamina                           -- Toggle zero stamina cost
  max_resolve                                    -- Max resolve, no drain
  toggle_enhanced_parry_chance                   -- Toggle enhanced parry (1000%)
  toggle_god_mode                                -- Toggle invulnerability

  --- MOVEMENT ---
  toggle_walk_fast                               -- Toggle walk speed (GUI slider value)

  --- INVENTORY & PROGRESSION ---
  max_out_inventory                              -- Max all stackable items
  unlock_all_shells                              -- Unlock all shells
  unlock_all_player_funcs                        -- Unlock shells, weapons, ripostes,
                                                 --   abilities, and ballistazooka
  exploit_inventory                              -- Zero-cost upgrades + infinite currency
  enable_all_fast_travels                        -- Unlock all fast travel locations
  always_allow_fast_travel                       -- Always allow ornate mask usage
  max_all_familiarity                            -- Reveal full descriptions for all items
  add_all_consumables                            -- Add every consumable to inventory
  unlock_all_item_entries                        -- Reveal full item codex
  unlock_all_tutorials                           -- Mark all tutorials as seen

  --- WEAPONS ---
  max_out_bolts                                  -- Fill large bolt stack to max
  super_b                                        -- Super ballistazooka mode
  summon_weapon <0-5>                            -- Summon weapon by ID:
                                                 --   0=Hallowed Sword  1=Smoldering Mace
                                                 --   2=Hammer & Chisel 3=Martyr's Blade
                                                 --   4=Axatana (twin)  5=Axatana (axe)

  --- COMBAT & ENEMIES ---
  one_hit_kill                                   -- Toggle: instantly hit all loaded and
                                                 --   newly spawned enemies for near-fatal
                                                 --   damage (persists through death)
  hit_enemies                                    -- Hit all currently loaded enemies once
  more_enemies                                   -- Respawn nearby enemy spawners (farming)
  passive_tar                                    -- Newly spawned enemies auto-drop
                                                 --   tar and glimpses
  toggle_fog                                     -- Toggle fog (effects unconfirmed)

  --- UTILITY ---
  toggle_mods                                    -- Toggle all core mods at once
  show_status                                    -- Print toggle states to console


IMPORTANT WARNINGS
==================

PERMANENT EFFECTS (until area transition):
  * Stone Form Cooldown (F1 / stone_form_no_cooldown)
    Once removed, stays removed until you load a new area.
    This is the only effect that cannot be re-applied automatically on respawn.

TOGGLE ALL MODS / F7:
  Chains together: stone_form_no_cooldown, toggle_walk_fast, toggle_super_stamina,
  max_resolve, toggle_enhanced_parry_chance, always_allow_fast_travel, god mode,
  super ballistazooka, and max bolts.
  Stone cooldown persists until area transition — all other effects re-enable on respawn.

GOD MODE NOTE:
  Managed by UE4's built-in CheatManager, not mod state directly.
  The status indicator tracks intent; the engine manages the actual effect.


TROUBLESHOOTING
===============

Mod not loading?
  - Verify mods.txt has "MortalShellMod : 1" (exact spelling)
  - Confirm UE4SS files are in the Win64 folder
  - Requires experimental/zDev UE4SS — stable releases will not work

GUI tab not appearing?
  - Make sure both dlls/main.dll and the Scripts folder are present
  - Check the UE4SS console for error messages on startup

Console not opening?
  - Default key is F10; check UE4SS settings if remapped

Hotkeys not responding?
  - Use the "Enable Player Keybinds" button in the Keybinds section of the GUI,
    or run enable_mortal_shell_mod_keybinds in console
  - Hotkeys only work while fully loaded in-game (not in menus)

"Player not found" errors?
  - You must be fully loaded into a game session, not on the main menu

Mods not re-enabling after death?
  - The auto-re-enable fires ~4 seconds after respawn
  - Only applies to mods that were active before death
  - Does not apply if Toggle All Mods was not active and no individual toggles were on


DEPENDENCIES
============
  * UE4SS (experimental/zDev)  - Required. https://github.com/UE4SS-RE/RE-UE4SS
  * UEHelpers                  - Shared UE4SS helper library (in Mods\shared\)
  * ImGui                      - Bundled with UE4SS, used for the GUI panel
