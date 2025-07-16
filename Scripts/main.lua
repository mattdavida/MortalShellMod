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
print('----------------------------------------------------------')
local Utils = require('Utils.Utils')
local UEHelpers = require('UEHelpers.UeHelpers')

-- Consolidated mod state
local mod_state = {
    super_stone_form = false,
    walk_fast = false,
    super_stamina = false,
    enhanced_parry = false
}

local function stone_form_no_cooldown()
    local player = UEHelpers.GetPlayer()
    if not player then
        print('Player not found - try again when in-game')
        return
    end
    print('Setting Player Stone Form Cooldown to 0')
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
end

local function toggle_enhanced_parry_chance()
    local player = UEHelpers.GetPlayer()
    if not player then
        print('Player not found - try again when in-game')
        return
    end

    print('Player found: ' .. player:GetFullName())
    -- infinite stone form
    mod_state.enhanced_parry = not mod_state.enhanced_parry
    if mod_state.enhanced_parry then
        print('Setting Enhanced Parry Chance to 100 - Enhanced Parry Chance')
        player.EnhancedParry_Chance = 100
    else
        print('Setting Enhanced Parry Chance to 0 - Normal Parry Chance')
        player.EnhancedParry_Chance = 0
    end
end


local function toggle_god_mode()
    ---@class UCheatManager : UObject
    local cheat_manager = FindFirstOf('CheatManager')
    if cheat_manager then
        print('Toggling God Mode')
        cheat_manager:God()
    else
        print('CheatManager not found - try again when in-game')
    end
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

local function toggle_matts_mods()
    stone_form_no_cooldown()
    toggle_walk_fast()
    toggle_super_stamina()
    max_resolve()
    toggle_enhanced_parry_chance()
    always_allow_fast_travel()

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
