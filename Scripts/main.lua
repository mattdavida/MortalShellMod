print('----------------------- MATTS MOD -----------------------')
print('F1: Stone form no cooldown')
print('F2: Toggle super stone form max')
print('F3: Toggle walk fast')
print('F4: Toggle super stamina')
print('F5: Max resolve')
print('F6: Toggle enhanced parry chance')
print('F7: Toggle matts mods')
print('F8: Toggle god mode')
print('F9: Max out inventory')
print('PAGE_UP: Show mod status')
print('NUM_LOCK: Unlock all shells')
print('PAGE_DOWN: Exploit inventory ( no cost for items / upgrades ) + unlock ALL fast travel locations')
print('HOME: Always allow fast travel with ornate mask')
print('B: Super Ballistazooka (machine gun mode)')
print('----------------------------------------------------------')
local UEHelpers = require('UEHelpers.UeHelpers')
local Utils = require('Utils.Utils')

local weapon_map = {
    [0] = "Hallowed Sword",
    [1] = "Smoldering Mace",
    [2] = "Hammer and Chisel",
    [3] = "Martyr's Blade",
    [4] = "Axatana twin blades",
    [5] = "Axatana axe", 
}

-- Consolidated mod state
local mod_state = {
    no_stone_cooldown = false,
    max_resolve = false,
    super_stone_form = false,
    walk_fast = false,
    super_stamina = false,
    enhanced_parry = false,
    enable_matts_notes = false,
    god_mode = false
}


local function update_button_text()
    if mod_state.enable_matts_notes then
        print('Overriding Resume Button Text in Pause menu.')
        print('CAUTION: This will override the default resume button text for the entire game session.')
        local buttons = FindAllOf('UI_MainMenu_Button_C')
        local scale_boxes = FindAllOf('ScaleBox')
        if buttons then
            for _, button in ipairs(buttons) do
                if Utils.StringContains(button:GetFullName(), 'Button_Resume') then
                    local status_text = "RESUME - MATT'S MOD\n"
                    status_text = status_text ..
                    "F1: No stone cooldown (" .. (mod_state.no_stone_cooldown and "ON" or "OFF") .. ")\n"
                    status_text = status_text ..
                        "F2: Super stone form (" .. (mod_state.super_stone_form and "ON" or "OFF") .. ")\n"
                    status_text = status_text .. "F3: Walk fast (" .. (mod_state.walk_fast and "ON" or "OFF") .. ")\n"
                    status_text = status_text ..
                        "F4: Super stamina (" .. (mod_state.super_stamina and "ON" or "OFF") .. ")\n"
                    status_text = status_text ..
                    "F5: Max resolve (" .. (mod_state.max_resolve and "ON" or "OFF") .. ")\n"
                    status_text = status_text ..
                        "F6: Enhanced parry (" .. (mod_state.enhanced_parry and "ON" or "OFF") .. ")\n"
                    status_text = status_text .. "F7: ALL mods toggle\n"
                    status_text = status_text .. "F8: God mode (" .. (mod_state.god_mode and "ON" or "OFF") .. ")\n"
                    status_text = status_text .. "F9: Max out inventory\n"
                    status_text = status_text .. "PAGE_UP: Show detailed status\n"
                    status_text = status_text .. "NUM_LOCK: Unlock all shells\n"
                    status_text = status_text ..
                        "PAGE_DOWN: Exploit inventory ( no cost for items / upgrades ) + unlock ALL fast travel locations\n"
                    status_text = status_text .. "HOME: Always allow fast travel with ornate mask\n"
                    button.Text_Value = FText(status_text)
                    button.Button_Width = 1040
                    button.FontSize = 25
                end
            end
        end

        for _, scale_box in ipairs(scale_boxes) do
            if Utils.StringContains(scale_box:GetFullName(), 'Button_Resume') then
                scale_box.IgnoreInheritedScale = true
            end
        end
    end
end

local function stone_form_no_cooldown()
    local player = UEHelpers.GetPlayer()
    if not player then
        print('Player not found - try again when in-game')
        return
    end
    print('Setting Player Stone Form Cooldown to 0')
    mod_state.no_stone_cooldown = true
    player.StoneFormCooldown = 0
end

local function toggle_super_stone_form_max()
    local player = UEHelpers.GetPlayer()
    if not player then
        print('Player not found - try again when in-game')
        return
    end

    mod_state.super_stone_form = not mod_state.super_stone_form
    print('Player found: ' .. player:GetFullName())
    -- infinite stone form
    if mod_state.super_stone_form then
        print('Setting Super Stone Form to true, next time you cast stone form it will be super')
        player.SuperStoneForm = true
        player.ShouldEnableSuperStoneForm = true
        player.SuperStoneForm_Duration = 1000000
    else
        print('Setting Super Stone Form to false, next time you cast stone form it will be normal')
        player.SuperStoneForm = false
        player.ShouldEnableSuperStoneForm = false
        player.SuperStoneForm_Duration = 0
    end
    update_button_text()
end

local function max_resolve()
    local player = UEHelpers.GetPlayer()
    if not player then
        print('Player not found - try again when in-game')
        return
    end
    print('Setting Max Resolve to 1000000')
    player.MaxResolve = 1000000
    player.CurrentResolve = 1000000
    player.ResolveDrainDelay = 0
    player.ResolveDrainRate = 0
    mod_state.max_resolve = true
end

local function toggle_walk_fast()
    local player = UEHelpers.GetPlayer()
    if not player then
        print('Player not found - try again when in-game')
        return
    end

    mod_state.walk_fast = not mod_state.walk_fast
    if mod_state.walk_fast then
        print('Setting Walk Speed to 5 - Super Fast')
        player.WalkSpeedModifier = 5
    else
        print('Setting Walk Speed to 1 - Normal Speed')
        player.WalkSpeedModifier = 1
    end
    update_button_text()
end


local function toggle_super_stamina()
    local player = UEHelpers.GetPlayer()
    if not player then
        print('Player not found - try again when in-game')
        return
    end

    print('Player found: ' .. player:GetFullName())
    -- infinite stone form
    mod_state.super_stamina = not mod_state.super_stamina
    if mod_state.super_stamina then
        print('Setting Stamina Cost Modifier to 0 - Super Stamina')
        player.StaminaCostModifier = 0
    else
        print('Setting Stamina Cost Modifier to 1 - Normal Stamina')
        player.StaminaCostModifier = 1
    end
    update_button_text()
end

local function toggle_enhanced_parry_chance()
    local player = UEHelpers.GetPlayer()
    if not player then
        print('Player not found - try again when in-game')
        return
    end

    -- infinite stone form
    mod_state.enhanced_parry = not mod_state.enhanced_parry
    if mod_state.enhanced_parry then
        print('Setting Enhanced Parry Chance to 100 - Enhanced Parry Chance')
        player.EnhancedParry_Chance = 100
    else
        print('Setting Enhanced Parry Chance to 0 - Normal Parry Chance')
        player.EnhancedParry_Chance = 0
    end
    update_button_text()
end


local function toggle_god_mode()
    ---@class UCheatManager : UObject
    local cheat_manager = FindFirstOf('CheatManager')
    if cheat_manager then
        print('Toggling God Mode')
        mod_state.god_mode = not mod_state.god_mode
        cheat_manager:God()
    else
        print('CheatManager not found - try again when in-game')
    end
    update_button_text()
end

local function show_status()
    print('=============== MOD STATUS ===============')
    print('Super Stone Form: ' .. (mod_state.super_stone_form and 'ON' or 'OFF'))
    print('Walk Fast: ' .. (mod_state.walk_fast and 'ON' or 'OFF'))
    print('Super Stamina: ' .. (mod_state.super_stamina and 'ON' or 'OFF'))
    print('Enhanced Parry: ' .. (mod_state.enhanced_parry and 'ON' or 'OFF'))
    print('=========================================')
end

-- always allow fast travel with ornate mask -- no more gettin stuck after picking up gland from boss
local function always_allow_fast_travel()
    RegisterHook('/Game/Blueprints/GamePlay/GameplayPC.GameplayPC_C:InventoryUtil_GetCanUseItem',
        function(self, ID, UsableInDarkForm)
            if ID:get():ToString() == 'Mask_Ornate' then
                -- Enum_InventoryItem_CanUse -- 11 maps to NewEnumerator4 -- found value by trial and error
                -- seems to work though and we are able to set per item
                return 11
            end
        end)
end

local function enable_matts_notes()
    mod_state.enable_matts_notes = not mod_state.enable_matts_notes
    update_button_text()
end

local function toggle_matts_mods()
    stone_form_no_cooldown()
    toggle_walk_fast()
    toggle_super_stamina()
    max_resolve()
    toggle_enhanced_parry_chance()
    always_allow_fast_travel()
    enable_matts_notes()

    -- this works - keeping just for me - most players won't enable this - good to get through areas quick for mod testing
    local player = UEHelpers.GetPlayer()
    if player then
        print('Setting Temp Damage to 100 - One Hit Kill')
        player.TempDamage = 100 -- normal 1
    end


    mod_state.toggle_matts_mods = not mod_state.toggle_matts_mods
    if mod_state.toggle_matts_mods then
        print('Matts Mods: ON')
    else
        print('Matts Mods: OFF')
        print('------------------------------------------------------------------------------------------------')
        print('Stone Form No Cooldown: Cannot turn off ( MUST TRAVEL TO NEW AREA TO RESET )')
        print('ONE HIT KILL: NO TOGGLE - MUST TRAVEL TO NEW AREA TO RESET')
        print('------------------------------------------------------------------------------------------------')
    end
    update_button_text()
end

local function max_out_inventory()
    print('Maxing Out Inventory')
    local inventory_component = FindFirstOf('EquipmentInventoryComponent_C')
    if inventory_component then
        local inventory = inventory_component.Inventory
        if inventory then
            for i = 1, inventory:GetArrayNum() do
                ---@class FInventoryItem
                local item = inventory[i]
                if item then
                    if item.IsStackable_49_6C7D21E34F4CA74A677416A1E92DD137 then
                        if item.Amount_104_5BD0F40343BC83E7582405A59DEF24E8 < item.MaxStackSize_105_457804EE421C991C4D20ADA6928E4B40 then
                            item.Amount_104_5BD0F40343BC83E7582405A59DEF24E8 = item
                                .MaxStackSize_105_457804EE421C991C4D20ADA6928E4B40
                        end
                    end
                end
            end
            print('All Inventory Items set to max stack size')
        end
    else
        print('EquipmentInventoryComponent_C not found - try again when in-game')
    end
end

local function unlock_all_shells()
    local player = UEHelpers.GetPlayer()
    if not player then
        print('Player not found - try again when in-game')
        return
    end
    print('Unlocking All Shells for player')
    player:DH_UnlockAllShells()
end

local function unlock_all_player_funcs()
    local player = UEHelpers.GetPlayer()
    if not player then
        print('Player not found - try again when in-game')
        return
    end

    print('Player found: ' .. player:GetFullName())
    print('Unlocking All Shells for player')
    player:DH_UnlockAllShells()
    print('Unlocking All Shells Names for player')
    player:DH_UnlockAllShellsName()
    print('Unlocking All Weapons for player')
    player:DH_UnlockAllWeapons()
    print('Unlocking All Riposte for player')
    player:DH_UnlockAllRiposte()
    print('Activating Inactive Unlocked Shell Abilities for player')
    player:DH_ActivateInactiveUnlockedShellAbilities()
    print('Unlocking Ballistazooka for player')
    player:DH_UnlockBallistazooka()

end


local function exploit_inventory_and_unlock_fast_travel_locations()
    -- INFINITE UPGRADES
    RegisterHook('/Game/UI/Blueprints/Waifu/UI_ShellUpgradeMenu.UI_ShellUpgradeMenu_C:SetCanBuy', function(self, other)
        local obj = self:get()
        obj.CanBuy = true
        obj.Tar_Cost = 0
        obj.Glimpses_Cost = 0
        obj.CanBuy = true
        obj.Tar_Cost = 0
        obj.Glimpses_Cost = 0
    end)

    -- INFINITE CURRENCY
    RegisterHook('/Game/UI/Blueprints/Merchant/UI_MerchantPanelNew.UI_MerchantPanelNew_C:GetPlayerCurrency',
        function(self, other)
            return 9999
        end)

    RegisterHook('/Game/UI/Blueprints/Merchant/MerchantPanel.MerchantPanel_C:GetPlayerCurrencyAmount',
        function(self, other)
            return 9999999999
        end)

    RegisterHook('/Game/UI/Blueprints/Merchant/UI_MerchantPanelNew.UI_MerchantPanelNew_C:SetCanBuySelected',
        function(self, other)
            local obj = self:get()
            obj.CanBuySelected = true
            return true
        end)


    -- OPEN ALL FAST TRAVELS
    RegisterHook('/Game/UI/Blueprints/Waifu/UI_FastTravel.UI_FastTravel_C:GetIsUnlocked',
        function(self, other)
            return true
        end)
end

local function summon_weapon_from_keybind(weapon_id)
    local player = UEHelpers.GetPlayer()
    print('SUMMON WEAPON: ' .. weapon_map[weapon_id])

    player:SummonWeapon(weapon_id)
end


local function super_ballistazooka()
    local anim_montage = StaticFindObject('/Game/MainChar/anims/shooting/Char_anims/Balista_Reload_Montage.Balista_Reload_Montage')
    local equip_montage = StaticFindObject('/Game/MainChar/anims/shooting/Char_anims/Ballista_Equip_Montage.Ballista_Equip_Montage')
    local idle_to_aim = StaticFindObject('/Game/MainChar/anims/shooting/Char_anims/Ballista_Idle_To_Aim.Ballista_Idle_To_Aim')
    local idle_to_reload = StaticFindObject('/Game/MainChar/anims/shooting/Char_anims/Ballista_Idle_To_Reload.Ballista_Idle_To_Reload')
    local equip_instant_reload = StaticFindObject('/Game/MainChar/anims/shooting/Char_anims/Ballista_Equip_InstantReload_Montage.Ballista_Equip_InstantReload_Montage')
    if anim_montage then
        print('Anim Montage found: ' .. tostring(anim_montage:GetFullName()))
        print('original length: ' .. tostring(anim_montage.SequenceLength))
        --  original length: 5.7333331108093
        anim_montage.SequenceLength = 0.01
        equip_montage.SequenceLength = 0.01
        idle_to_aim.SequenceLength = 0.01
        idle_to_reload.SequenceLength = 0.01
        equip_instant_reload.SequenceLength = 0.01
    else
        print('Anim Montage not found')
    end
end



RegisterKeyBind(Key.F1, {}, stone_form_no_cooldown)
RegisterKeyBind(Key.F2, {}, toggle_super_stone_form_max)
RegisterKeyBind(Key.F3, {}, toggle_walk_fast)
RegisterKeyBind(Key.F4, {}, toggle_super_stamina)
RegisterKeyBind(Key.F5, {}, max_resolve)
RegisterKeyBind(Key.F6, {}, toggle_enhanced_parry_chance)
RegisterKeyBind(Key.F7, {}, toggle_matts_mods)
RegisterKeyBind(Key.F8, {}, toggle_god_mode)
RegisterKeyBind(Key.F9, {}, max_out_inventory)
RegisterKeyBind(Key.PAGE_UP, {}, show_status)
RegisterKeyBind(Key.NUM_LOCK, {}, unlock_all_shells)
RegisterKeyBind(Key.PAGE_DOWN, {}, exploit_inventory_and_unlock_fast_travel_locations)
RegisterKeyBind(Key.HOME, {}, always_allow_fast_travel)
RegisterKeyBind(Key.CAPS_LOCK, {}, enable_matts_notes)
RegisterKeyBind(Key.BACKSPACE, {}, unlock_all_player_funcs)
RegisterKeyBind(Key.TAB, {}, super_ballistazooka)
RegisterKeyBind(Key.ONE, {}, function() summon_weapon_from_keybind(0) end)
RegisterKeyBind(Key.TWO, {}, function() summon_weapon_from_keybind(1) end)
RegisterKeyBind(Key.THREE, {}, function() summon_weapon_from_keybind(2) end)
RegisterKeyBind(Key.FOUR, {}, function() summon_weapon_from_keybind(3) end)
RegisterKeyBind(Key.FIVE, {}, function() summon_weapon_from_keybind(4) end)
RegisterKeyBind(Key.SIX, {}, function() summon_weapon_from_keybind(5) end)


local function matts_mod_help(FullCommand, Parameters, Ar)
    print('todo: help message for hotkeys')
    Utils.Log(Ar, '--------------------------------')
    Utils.Log(Ar, 'F1: Stone form no cooldown')
    Utils.Log(Ar, 'F2: Toggle super stone form max')
    Utils.Log(Ar, 'F3: Toggle walk fast')
    Utils.Log(Ar, 'F4: Toggle super stamina')
    Utils.Log(Ar, 'F5: Max resolve')
    Utils.Log(Ar, 'F6: Toggle enhanced parry chance')
    Utils.Log(Ar, 'F7: Toggle matts mods')
    Utils.Log(Ar, 'F8: Toggle god mode')
    Utils.Log(Ar, 'F9: Max out inventory')
    Utils.Log(Ar, 'PAGE_UP: Show mod status')
    Utils.Log(Ar, 'NUM_LOCK: Unlock all shells')
    Utils.Log(Ar, 'PAGE_DOWN: Exploit inventory ( no cost for items / upgrades ) + unlock ALL fast travel locations')
    Utils.Log(Ar, 'HOME: Always allow fast travel with ornate mask')
    Utils.Log(Ar, '--------------------------------')
    return true
end

RegisterConsoleCommandHandler("matts_mod_help", matts_mod_help)