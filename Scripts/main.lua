
print('----------------------- MORTAL SHELL MOD ENABLED -----------------------')
print('Use "mortal_shell_mod" to see available commands')
print("Open console with F10")

local UEHelpers = require('UEHelpers.UEHelpers')
local CheatUtils = require('cheat_utils')
local Utils = require('Utils')
local WeaponMod = require('weapon_mod')

local function GetPlayer()
    local pc = UEHelpers.GetPlayerController()
    if pc then
        return pc.Pawn
    end
    return nil
end
if not UEHelpers.GetPlayer then
    UEHelpers.GetPlayer = GetPlayer
end


local function mortal_shell_mod_keybinds(Ar)
    Utils.Log(Ar, '--------------------------------')
    Utils.Log(Ar, 'F1: Stone form no cooldown')
    Utils.Log(Ar, 'F2: Toggle super stone form max')
    Utils.Log(Ar, 'F3: Toggle walk fast')
    Utils.Log(Ar, 'F4: Toggle super stamina')
    Utils.Log(Ar, 'F5: Max resolve')
    Utils.Log(Ar, 'F6: Toggle enhanced parry chance')
    Utils.Log(Ar, 'F7: Toggle all mods')
    Utils.Log(Ar, 'F8: Toggle god mode')
    Utils.Log(Ar, 'F9: Max out inventory')
    Utils.Log(Ar, 'PAGE_UP: Show mod status')
    Utils.Log(Ar, 'NUM_LOCK: Unlock all shells')
    Utils.Log(Ar, 'PAGE_DOWN: Exploit inventory ( no cost for items / upgrades ) + infinite currency')
    Utils.Log(Ar, 'HOME: Always allow fast travel with ornate mask')
    Utils.Log(Ar, 'BACKSPACE: Unlock all player funcs')
    Utils.Log(Ar, '--------------------------------')
end

RegisterConsoleCommandHandler("enable_mortal_shell_mod_keybinds", function(FullCommand, Parameters, Ar)
    CheatUtils.EnableKeybinds()
    return true
end)

RegisterConsoleCommandHandler("mortal_shell_mod_keybinds", function(FullCommand, Parameters, Ar)
    mortal_shell_mod_keybinds(Ar)
    return true
end)

RegisterConsoleCommandHandler("stone_form_no_cooldown", function(FullCommand, Parameters, Ar)
    CheatUtils.StoneFormNoCooldown()
    return true
end)

RegisterConsoleCommandHandler("toggle_super_stone_form_max", function(FullCommand, Parameters, Ar)
    CheatUtils.ToggleSuperStoneFormMax()
    return true
end)

RegisterConsoleCommandHandler("toggle_walk_fast", function(FullCommand, Parameters, Ar)
    local modifier = tonumber(Parameters[1])
    if modifier ~= nil then
        CheatUtils.ToggleWalkFast(modifier)
    else
        CheatUtils.ToggleWalkFast()
    end
    return true
end)

RegisterConsoleCommandHandler("toggle_super_stamina", function(FullCommand, Parameters, Ar)
    CheatUtils.ToggleSuperStamina()
    return true
end)

RegisterConsoleCommandHandler("max_resolve", function(FullCommand, Parameters, Ar)
    CheatUtils.MaxResolve()
    return true
end)

RegisterConsoleCommandHandler("toggle_enhanced_parry_chance", function(FullCommand, Parameters, Ar)
    CheatUtils.ToggleEnhancedParryChance()
    return true
end)

RegisterConsoleCommandHandler("toggle_mods", function(FullCommand, Parameters, Ar)
    CheatUtils.ToggleMortalShellMods()
    local state = CheatUtils.GetModState()
    Ar:Log("--- Mortal Shell Mods Toggled ---")
    Ar:Log("StoneFormNoCooldown: " .. (state.no_stone_cooldown and "ON" or "OFF"))
    Ar:Log("SuperStoneForm: "      .. (state.super_stone_form  and "ON" or "OFF"))
    Ar:Log("WalkFast: "            .. (state.walk_fast         and "ON" or "OFF"))
    Ar:Log("SuperStamina: "        .. (state.super_stamina     and "ON" or "OFF"))
    Ar:Log("MaxResolve: "          .. (state.max_resolve       and "ON" or "OFF"))
    Ar:Log("EnhancedParry: "       .. (state.enhanced_parry    and "ON" or "OFF"))
    Ar:Log("GodMode: "             .. (state.god_mode          and "ON" or "OFF"))
    Ar:Log("---------------------------------")
    return true
end)

RegisterConsoleCommandHandler("toggle_god_mode", function(FullCommand, Parameters, Ar)
    CheatUtils.ToggleGodMode()
    return true
end)

RegisterConsoleCommandHandler("max_out_inventory", function(FullCommand, Parameters, Ar)
    CheatUtils.MaxOutInventory()
    return true
end)

RegisterConsoleCommandHandler("show_status", function(FullCommand, Parameters, Ar)
    CheatUtils.ShowStatus()
    return true
end)

RegisterConsoleCommandHandler("unlock_all_shells", function(FullCommand, Parameters, Ar)
    CheatUtils.UnlockAllShells()
    return true
end)

RegisterConsoleCommandHandler("unlock_all_player_funcs", function(FullCommand, Parameters, Ar)
    CheatUtils.UnlockAllPlayerFuncs()
    return true
end)

RegisterConsoleCommandHandler("exploit_inventory", function(FullCommand, Parameters, Ar)
    CheatUtils.ExploitInventory()
    return true
end)

RegisterConsoleCommandHandler("enable_all_fast_travels", function(FullCommand, Parameters, Ar)
    CheatUtils.OpenAllFastTravels()
    return true
end)

RegisterConsoleCommandHandler("always_allow_fast_travel", function(FullCommand, Parameters, Ar)
    CheatUtils.AlwaysAllowFastTravel()
    return true
end)

RegisterConsoleCommandHandler("enable_weapon_mod_keybinds", function(FullCommand, Parameters, Ar)
    CheatUtils.EnableWeaponModKeybinds()
    return true
end)

RegisterConsoleCommandHandler("max_out_bolts", function(FullCommand, Parameters, Ar)
    CheatUtils.MaxOutBolts()
    return true
end)

RegisterConsoleCommandHandler("super_b", function(FullCommand, Parameters, Ar)
    CheatUtils.SuperBallistazooka()
    return true
end)

RegisterConsoleCommandHandler("summon_weapon", function(FullCommand, Parameters, Ar)
    local weapon_id = tonumber(Parameters[1])
    if weapon_id ~= nil then
        WeaponMod.SummonWeaponFromKeybind(weapon_id)
    else
        Ar:Log("Usage: summon_weapon <weapon_id> 0-5")
    end

    return true
end)

RegisterConsoleCommandHandler("max_all_familiarity", function(FullCommand, Parameters, Ar)
    CheatUtils.MaxAllFamiliarity()
    return true
end)

RegisterConsoleCommandHandler("add_all_consumables", function(FullCommand, Parameters, Ar)
    CheatUtils.AddAllConsumables()
    return true
end)

RegisterConsoleCommandHandler("unlock_all_item_entries", function(FullCommand, Parameters, Ar)
    CheatUtils.UnlockAllItemEntries()
    return true
end)

RegisterConsoleCommandHandler("unlock_all_tutorials", function(FullCommand, Parameters, Ar)
    CheatUtils.UnlockAllTutorials()
    return true
end)

RegisterConsoleCommandHandler("toggle_fog", function(FullCommand, Parameters, Ar)
    CheatUtils.ToggleFog()
    return true
end)

RegisterConsoleCommandHandler("more_enemies", function(FullCommand, Parameters, Ar)
    CheatUtils.SpawnMoreEnemies()
    return true
end)

RegisterConsoleCommandHandler("one_hit_kill", function(FullCommand, Parameters, Ar)
    CheatUtils.EnableOneHitKill()
    return true
end)

RegisterConsoleCommandHandler("passive_tar", function(FullCommand, Parameters, Ar)
    CheatUtils.PassiveTarAndGlimpses()
    return true
end)

RegisterConsoleCommandHandler("hit_enemies", function(FullCommand, Parameters, Ar)
    HitAllSpawnedEnemies()
    print("HIT ALL SPAWNED ENEMIES")
    Ar:Log("HIT ALL SPAWNED ENEMIES")
    return true
end)

RegisterConsoleCommandHandler("mortal_shell_mod", function(FullCommand, Parameters, Ar)
    
    Utils.Log(Ar, "CMDS AVAILABLE: ")
    Utils.Log(Ar, "enable_mortal_shell_mod_keybinds: Enable mortal shell mod keybinds")
    Utils.Log(Ar, "mortal_shell_mod_keybinds: Show mortal shell mod keybinds")
    Utils.Log(Ar, "stone_form_no_cooldown: No cooldown for stone form")
    Utils.Log(Ar, "toggle_super_stone_form_max: Toggle super stone form max")
    Utils.Log(Ar, "toggle_walk_fast: Toggle walk fast")
    Utils.Log(Ar, "toggle_super_stamina: Toggle super stamina")
    Utils.Log(Ar, "max_resolve: Max resolve")
    Utils.Log(Ar, "toggle_enhanced_parry_chance: Toggle enhanced parry chance")
    Utils.Log(Ar, "toggle_mods: Toggle all mods at once")
    Utils.Log(Ar, "toggle_god_mode: Toggle god mode")
    Utils.Log(Ar, "max_out_inventory: Max out inventory")
    Utils.Log(Ar, "show_status: Show status")
    Utils.Log(Ar, "unlock_all_shells: Unlock all shells")
    Utils.Log(Ar, "unlock_all_player_funcs: Unlock all player funcs")
    Utils.Log(Ar, "exploit_inventory: Zero-cost upgrades + infinite currency")
    Utils.Log(Ar, "enable_all_fast_travels: Unlock all fast travel locations")
    Utils.Log(Ar, "always_allow_fast_travel: Always allow fast travel")
    Utils.Log(Ar, "enable_weapon_mod_keybinds: Enable weapon mod keybinds")
    Utils.Log(Ar, "max_out_bolts: Max out bolts")
    Utils.Log(Ar, "super_b: Super ballistazooka")
    Utils.Log(Ar, "summon_weapon <int>: Summon weapon from keybind 0-5")
    Utils.Log(Ar, "max_all_familiarity: Max all familiarity")
    Utils.Log(Ar, "add_all_consumables: Add all consumables")
    Utils.Log(Ar, "unlock_all_item_entries: Unlock all item entries")
    Utils.Log(Ar, "unlock_all_tutorials: Unlock all tutorials")
    Utils.Log(Ar, "toggle_fog: Toggle fog")
    Utils.Log(Ar, "more_enemies: Spawn more enemies")
    Utils.Log(Ar, "one_hit_kill: One hit kill")
    Utils.Log(Ar, "passive_tar: Passive tar and glimpses")
    Utils.Log(Ar, "hit_enemies: Hit all spawned enemies")
    return true
end)
