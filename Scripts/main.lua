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
print('Tab: Super Ballistazooka (machine gun mode)')
print('----------------------------------------------------------')
local UEHelpers = require('UEHelpers.UeHelpers')
local Utils = require('Utils.Utils')
require('weapon_mod')

-- Consolidated mod state
MOD_STATE = {
    no_stone_cooldown = false,
    max_resolve = false,
    super_stone_form = false,
    walk_fast = false,
    super_stamina = false,
    enhanced_parry = false,
    enable_matts_notes = false,
    god_mode = false
}

function GetModState()
    return MOD_STATE
end

function UpdateButtonText()
    if MOD_STATE.enable_matts_notes then
        print('Overriding Resume Button Text in Pause menu.')
        print('CAUTION: This will override the default resume button text for the entire game session.')
        local buttons = FindAllOf('UI_MainMenu_Button_C')
        local scale_boxes = FindAllOf('ScaleBox')
        if buttons then
            for _, button in ipairs(buttons) do
                if Utils.StringContains(button:GetFullName(), 'Button_Resume') then
                    local status_text = "RESUME - MATT'S MOD\n"
                    status_text = status_text ..
                        "F1: No stone cooldown (" .. (MOD_STATE.no_stone_cooldown and "ON" or "OFF") .. ")\n"
                    status_text = status_text ..
                        "F2: Super stone form (" .. (MOD_STATE.super_stone_form and "ON" or "OFF") .. ")\n"
                    status_text = status_text .. "F3: Walk fast (" .. (MOD_STATE.walk_fast and "ON" or "OFF") .. ")\n"
                    status_text = status_text ..
                        "F4: Super stamina (" .. (MOD_STATE.super_stamina and "ON" or "OFF") .. ")\n"
                    status_text = status_text ..
                        "F5: Max resolve (" .. (MOD_STATE.max_resolve and "ON" or "OFF") .. ")\n"
                    status_text = status_text ..
                        "F6: Enhanced parry (" .. (MOD_STATE.enhanced_parry and "ON" or "OFF") .. ")\n"
                    status_text = status_text .. "F7: ALL mods toggle\n"
                    status_text = status_text .. "F8: God mode (" .. (MOD_STATE.god_mode and "ON" or "OFF") .. ")\n"
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

function StoneFormNoCooldown()
    local player = UEHelpers.GetPlayer()
    if not player then
        print('Player not found - try again when in-game')
        return
    end
    print('Setting Player Stone Form Cooldown to 0')
    MOD_STATE.no_stone_cooldown = true
    player.StoneFormCooldown = 0
end

function ToggleSuperStoneFormMax()
    local player = UEHelpers.GetPlayer()
    if not player then
        print('Player not found - try again when in-game')
        return
    end

    MOD_STATE.super_stone_form = not MOD_STATE.super_stone_form
    print('Player found: ' .. player:GetFullName())
    -- infinite stone form
    if MOD_STATE.super_stone_form then
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
    UpdateButtonText()
end

function MaxResolve()
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
    MOD_STATE.max_resolve = true
end

function ToggleWalkFast()
    local player = UEHelpers.GetPlayer()
    if not player then
        print('Player not found - try again when in-game')
        return
    end

    MOD_STATE.walk_fast = not MOD_STATE.walk_fast
    if MOD_STATE.walk_fast then
        print('Setting Walk Speed to 5 - Super Fast')
        player.WalkSpeedModifier = 5
    else
        print('Setting Walk Speed to 1 - Normal Speed')
        player.WalkSpeedModifier = 1
    end
    UpdateButtonText()
end

function ToggleSuperStamina()
    local player = UEHelpers.GetPlayer()
    if not player then
        print('Player not found - try again when in-game')
        return
    end

    print('Player found: ' .. player:GetFullName())
    -- infinite stone form
    MOD_STATE.super_stamina = not MOD_STATE.super_stamina
    if MOD_STATE.super_stamina then
        print('Setting Stamina Cost Modifier to 0 - Super Stamina')
        player.StaminaCostModifier = 0
    else
        print('Setting Stamina Cost Modifier to 1 - Normal Stamina')
        player.StaminaCostModifier = 1
    end
    UpdateButtonText()
end

function ToggleEnhancedParryChance()
    local player = UEHelpers.GetPlayer()
    if not player then
        print('Player not found - try again when in-game')
        return
    end

    -- infinite stone form
    MOD_STATE.enhanced_parry = not MOD_STATE.enhanced_parry
    if MOD_STATE.enhanced_parry then
        print('Setting Enhanced Parry Chance to 100 - Enhanced Parry Chance')
        player.EnhancedParry_Chance = 100
    else
        print('Setting Enhanced Parry Chance to 0 - Normal Parry Chance')
        player.EnhancedParry_Chance = 0
    end
    UpdateButtonText()
end

function ToggleGodMode()
    ---@class UCheatManager : UObject
    local cheat_manager = FindFirstOf('CheatManager')
    if cheat_manager then
        print('Toggling God Mode')
        MOD_STATE.god_mode = not MOD_STATE.god_mode
        cheat_manager:God()
    else
        print('CheatManager not found - try again when in-game')
    end
    UpdateButtonText()
end

function ShowStatus()
    print('=============== MOD STATUS ===============')
    print('Super Stone Form: ' .. (MOD_STATE.super_stone_form and 'ON' or 'OFF'))
    print('Walk Fast: ' .. (MOD_STATE.walk_fast and 'ON' or 'OFF'))
    print('Super Stamina: ' .. (MOD_STATE.super_stamina and 'ON' or 'OFF'))
    print('Enhanced Parry: ' .. (MOD_STATE.enhanced_parry and 'ON' or 'OFF'))
    print('=========================================')
end

-- always allow fast travel with ornate mask -- no more gettin stuck after picking up gland from boss
function AlwaysAllowFastTravel()
    RegisterHook('/Game/Blueprints/GamePlay/GameplayPC.GameplayPC_C:InventoryUtil_GetCanUseItem',
        function(self, ID, UsableInDarkForm)
            if ID:get():ToString() == 'Mask_Ornate' then
                -- Enum_InventoryItem_CanUse -- 11 maps to NewEnumerator4 -- found value by trial and error
                -- seems to work though and we are able to set per item
                return 11
            end
        end)
end

function EnableMattsNotes()
    MOD_STATE.enable_matts_notes = not MOD_STATE.enable_matts_notes
    UpdateButtonText()
end

function ToggleMattsMods()
    StoneFormNoCooldown()
    ToggleWalkFast()
    ToggleSuperStamina()
    MaxResolve()
    ToggleEnhancedParryChance()
    AlwaysAllowFastTravel()
    EnableMattsNotes()

    -- this works - keeping just for me - most players won't enable this - good to get through areas quick for mod testing
    local player = UEHelpers.GetPlayer()
    if player then
        print('Setting Temp Damage to 100 - One Hit Kill')
        player.TempDamage = 100 -- normal 1
    end


    MOD_STATE.toggle_matts_mods = not MOD_STATE.toggle_matts_mods
    if MOD_STATE.toggle_matts_mods then
        print('Matts Mods: ON')
    else
        print('Matts Mods: OFF')
        print('------------------------------------------------------------------------------------------------')
        print('Stone Form No Cooldown: Cannot turn off ( MUST TRAVEL TO NEW AREA TO RESET )')
        print('ONE HIT KILL: NO TOGGLE - MUST TRAVEL TO NEW AREA TO RESET')
        print('------------------------------------------------------------------------------------------------')
    end
    UpdateButtonText()
end

function MaxOutInventory()
    print('Maxing Out Inventory')
    local inventory_component = FindFirstOf('EquipmentInventoryComponent_C')
    if inventory_component then
        local inventory = inventory_component.Inventory
        if inventory then
            for i = 1, inventory:GetArrayNum() do
                ---@class FInventoryItem
                local item = inventory[i]
                if item then
                    -- if Utils.StringContains(item.Name_124_933A963C4D9FCA5BB44069830C37A98D:ToString(), 'TarnishedSealOffering') then
                    --     print('Tarnished Seal Offering: ' .. tostring(item.Amount_104_5BD0F40343BC83E7582405A59DEF24E8))
                    --     item.Amount_104_5BD0F40343BC83E7582405A59DEF24E8 = 999
                    -- end

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

function UnlockAllShells()
    local player = UEHelpers.GetPlayer()
    if not player then
        print('Player not found - try again when in-game')
        return
    end
    print('Unlocking All Shells for player')
    player:DH_UnlockAllShells()
end

function UnlockAllPlayerFuncs()
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

function ExploitInventoryAndUnlockFastTravelLocations()
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

function EnableKeybinds()
    RegisterKeyBind(Key.F1, {}, StoneFormNoCooldown)
    RegisterKeyBind(Key.F2, {}, ToggleSuperStoneFormMax)
    RegisterKeyBind(Key.F3, {}, ToggleWalkFast)
    RegisterKeyBind(Key.F4, {}, ToggleSuperStamina)
    RegisterKeyBind(Key.F5, {}, MaxResolve)
    RegisterKeyBind(Key.F6, {}, ToggleEnhancedParryChance)
    RegisterKeyBind(Key.F7, {}, ToggleMattsMods)
    RegisterKeyBind(Key.F8, {}, ToggleGodMode)
    RegisterKeyBind(Key.F9, {}, MaxOutInventory)
    RegisterKeyBind(Key.PAGE_UP, {}, ShowStatus)
    RegisterKeyBind(Key.NUM_LOCK, {}, UnlockAllShells)
    RegisterKeyBind(Key.PAGE_DOWN, {}, ExploitInventoryAndUnlockFastTravelLocations)
    RegisterKeyBind(Key.HOME, {}, AlwaysAllowFastTravel)
    RegisterKeyBind(Key.CAPS_LOCK, {}, EnableMattsNotes)
    RegisterKeyBind(Key.BACKSPACE, {}, UnlockAllPlayerFuncs)
end

EnableKeybinds()

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


local workBenchItemTable = FindAllOf('UI_WorkbenchItemNew_C')
if workBenchItemTable then
    for _, item in ipairs(workBenchItemTable) do
        print('Item: ' .. tostring(item:GetFullName()))

        if tostring(item:GetFullName()):find('TarnishedSealOffering') then
            item:UpgradeItem()
        end 
    end
end


RegisterHook('/Game/UI/Blueprints/Merchant/UI_WorkbenchItemNew.UI_WorkbenchItemNew_C:CheckIfCanObtainUpgrade',
    function(self, other)
        print('HasRequiredItem:::: ' .. tostring(self:get():GetFullName()))
    end)
