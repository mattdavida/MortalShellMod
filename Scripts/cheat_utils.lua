local UEHelpers = require('UEHelpers.UEHelpers')
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
-- Consolidated mod state
MOD_STATE = {
    no_stone_cooldown = false,
    max_resolve = false,
    super_stone_form = false,
    walk_fast = false,
    super_stamina = false,
    enhanced_parry = false,
    god_mode = false,
    toggle_mods = false,
}

function GetModState()
    return MOD_STATE
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

local WalkSpeedModifier = 2
local WalkFastHandle = nil
function ToggleWalkFast(modifier)
    modifier = modifier or 2
    WalkSpeedModifier = modifier
    local player = UEHelpers.GetPlayer()
    if not player then
        print('Player not found - try again when in-game')
        return
    end

    -- Always cancel any existing loop so repeated toggles don't stack loops
    if WalkFastHandle then
        CancelDelayedAction(WalkFastHandle)
        WalkFastHandle = nil
    end

    MOD_STATE.walk_fast = not MOD_STATE.walk_fast

    if MOD_STATE.walk_fast then
        WalkFastHandle = LoopInGameThreadWithDelay(100, function()
            if player and player:IsValid() then
                player.WalkSpeedModifier = modifier
            end
        end)
    else
        if player and player:IsValid() then
            player.WalkSpeedModifier = 1
        end
    end
end

function ToggleSuperStamina()
    local player = UEHelpers.GetPlayer()
    if not player then
        print('Player not found - try again when in-game')
        return
    end

    print('Player found: ' .. player:GetFullName())
    MOD_STATE.super_stamina = not MOD_STATE.super_stamina
    if MOD_STATE.super_stamina then
        print('Setting Stamina Cost Modifier to 0 - Super Stamina')
        player.StaminaCostModifier = 0
    else
        print('Setting Stamina Cost Modifier to 1 - Normal Stamina')
        player.StaminaCostModifier = 1
    end
end

function ToggleEnhancedParryChance()
    local player = UEHelpers.GetPlayer()
    if not player then
        print('Player not found - try again when in-game')
        return
    end

    MOD_STATE.enhanced_parry = not MOD_STATE.enhanced_parry
    if MOD_STATE.enhanced_parry then
        print('Setting Enhanced Parry Chance to 1000 - Enhanced Parry Chance')
        player.EnhancedParry_Chance = 1000
    else
        print('Setting Enhanced Parry Chance to 0 - Normal Parry Chance')
        player.EnhancedParry_Chance = 0
    end
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
end

function ShowStatus()
    print('=============== MOD STATUS ===============')
    print('God Mode: ' .. (MOD_STATE.god_mode and 'ON' or 'OFF'))
    print('Super Stone Form: ' .. (MOD_STATE.super_stone_form and 'ON' or 'OFF'))
    print('Walk Fast: ' .. (MOD_STATE.walk_fast and 'ON' or 'OFF'))
    print('Super Stamina: ' .. (MOD_STATE.super_stamina and 'ON' or 'OFF'))
    print('Enhanced Parry: ' .. (MOD_STATE.enhanced_parry and 'ON' or 'OFF'))
    print('Stone Form No Cooldown: ' .. (MOD_STATE.no_stone_cooldown and 'ON' or 'OFF'))
    print('Max Resolve: ' .. (MOD_STATE.max_resolve and 'ON' or 'OFF'))
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

function ToggleMortalShellMods()
    StoneFormNoCooldown()
    ToggleWalkFast(WalkSpeedModifier)
    ToggleSuperStamina()
    MaxResolve()
    ToggleEnhancedParryChance()
    AlwaysAllowFastTravel()
    ToggleGodMode()
    WeaponMod.MaxOutBolts()
    WeaponMod.SuperBallistazooka()


    MOD_STATE.toggle_mods = not MOD_STATE.toggle_mods
    if MOD_STATE.toggle_mods then
        print('Mortal Shell Mods: ON')
    else
        print('Mortal Shell Mods: OFF')
        print('------------------------------------------------------------------------------------------------')
        print('Stone Form No Cooldown: Cannot turn off ( MUST TRAVEL TO NEW AREA TO RESET )')
        print('------------------------------------------------------------------------------------------------')
    end
end

function GetGamePlayAndStormMode()
    local storm = FindFirstOf('GameplayGM_StormMode_C')
    local gm = FindFirstOf('GameplayGM_C')
    return storm, gm
end

function SpawnMoreEnemies()
    ExecuteInGameThread(function()
        local storm, gm = GetGamePlayAndStormMode()
        if gm and gm:IsValid() then
            gm:DH_RespawnNearbySpawners()
        end
        if storm and storm:IsValid() then
            storm:DH_RespawnNearbySpawners()
        end
    end)
end

local function hit_enemy(obj)
    local p = UEHelpers.GetPlayer()
    local hitResult = {
        bBlockingHit = false,
        bStartPenetrating = false,
        FaceIndex = 0,
        Time = 0.0,
        Distance = 0.0,
        Location = { 0.0, 0.0, 0.0 },
        ImpactPoint = { 0.0, 0.0, 0.0 },
        Normal = { 0.0, 0.0, 0.0 },
        ImpactNormal = { 0.0, 0.0, 0.0 },
        TraceStart = { 0.0, 0.0, 0.0 },
        TraceEnd = { 0.0, 0.0, 0.0 },
        PenetrationDepth = 0.0,
        Item = 0,
        PhysMaterial = nil,
        Actor = nil,
        Component = nil,
        BoneName = FName(""),
        MyBoneName = FName(""),
    }

    local HealthToTake = obj.MaxHealth - 1
    obj:HitEnemyAfterDelay(0.0, HealthToTake, { 0.0, 0.0, 0.0 }, hitResult, p, p)

end

function HitAllSpawnedEnemies()

    local current_enemies = FindAllOf('EnemyCharacter_C')
    if current_enemies and #current_enemies > 0 then
        for _, enemy in pairs(current_enemies) do
            hit_enemy(enemy)
        end
    end
end


local OneHitKillEnabled = false
local OneHitKillRegistered = false
function EnableOneHitKill()
    OneHitKillEnabled = not OneHitKillEnabled
    if OneHitKillEnabled then
        print("One Hit Kill Enabled")
    else
        print("One Hit Kill Disabled")
    end
    
    if OneHitKillEnabled then
        HitAllSpawnedEnemies()   
    end


    if not OneHitKillRegistered then
        NotifyOnNewObject("/Game/Enemies/EnemyCharacter.EnemyCharacter_C", function(obj)
            if OneHitKillEnabled then
                hit_enemy(obj)
            end
        end)
        OneHitKillRegistered = true
    end
end

local PassiveTarAndGlimpsesRegistered = false
function PassiveTarAndGlimpses()
    local p = UEHelpers.GetPlayer()
    if not PassiveTarAndGlimpsesRegistered then
        NotifyOnNewObject("/Game/Enemies/EnemyCharacter.EnemyCharacter_C", function(obj)
            obj:DropTar(p)
            obj:DropGlimpses(p)
        end)
        PassiveTarAndGlimpsesRegistered = true
    end
end

function ToggleFog()
    local storm, gm = GetGamePlayAndStormMode()
    if gm and gm:IsValid() then
        gm:GameModeUtils_ToggleFog()
        gm:GameModeUtils_ToggleFog()
    end
    if storm and storm:IsValid() then
        storm:GameModeUtils_ToggleFog()
        storm:GameModeUtils_ToggleFog()
    end
end

-- MAX ALL FAMILIARITY FOR ITEMS IN THE GAME
function MaxAllFamiliarity()
    local storm, gm = GetGamePlayAndStormMode()
    if gm and gm:IsValid() then
        gm:DH_MaxAllFamiliarity()
    end
    if storm and storm:IsValid() then
        storm:DH_MaxAllFamiliarity()
    end
end

-- ADD ALL CONSUMABLES TO THE PLAYERS INVENTORY
function AddAllConsumables()
    local storm, gm = GetGamePlayAndStormMode()
    if gm and gm:IsValid() then
        gm:DH_AddAllConsumables()
    end
    if storm and storm:IsValid() then
        storm:DH_AddAllConsumables()
    end
end

-- UNLOCK ALL ITEM ENTRIES IN THE GAME
function UnlockAllItemEntries()
    local storm, gm = GetGamePlayAndStormMode()
    if gm and gm:IsValid() then
        gm:DH_UnlockAllItemEntries()
    end
    if storm and storm:IsValid() then
        storm:DH_UnlockAllItemEntries()
    end
end

-- UNLOCK ALL TUTORIALS IN THE GAME
function UnlockAllTutorials()
    local storm, gm = GetGamePlayAndStormMode()
    if gm and gm:IsValid() then
        gm:DH_UnlockAllTutorials()
    end
    if storm and storm:IsValid() then
        storm:DH_UnlockAllTutorials()
    end
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

function ExploitInventory()
    -- INFINITE UPGRADES
    RegisterHook('/Game/UI/Blueprints/Waifu/UI_ShellUpgradeMenu.UI_ShellUpgradeMenu_C:SetCanBuy',
        function(self, Glimpses, Tar)
            local obj = self:get()
            obj.CanBuy = true
            obj.Glimpses_Cost = 0
            obj.Tar_Cost = 0
        end)

    RegisterHook(
        '/Game/UI/Blueprints/Waifu/UI_ShellUpgrade_SelectAbility.UI_ShellUpgrade_SelectAbility_C:GetAbilityCost',
        function(self, Tar, Glimpses, Glimpse_Out, Tar_Out)
            local obj = self:get()
            obj:RemoveGlimpses()
            obj:RemoveTar()
            Glimpse_Out = 0
            Tar_Out = 0
            return true
        end)

    -- INFINITE CURRENCY
    RegisterHook('/Game/UI/Blueprints/Merchant/UI_MerchantPanelNew.UI_MerchantPanelNew_C:GetPlayerCurrency',
        function(self, other)
            return 9999999
        end)

    RegisterHook('/Game/UI/Blueprints/Waifu/UI_ShellUpgrade_AbilityRow.UI_ShellUpgrade_AbilityRow_C:SetCanBuy',
        function(self, Glimpses, Tar)
            local obj = self:get()
            obj.Tar_Enough = true
            obj.Glimpses_Enough = true
            obj.CanBuy = true
            obj.Tar = 0
            obj.Glimpses = 0
            return true
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
end

function OpenAllFastTravels()
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
    RegisterKeyBind(Key.F7, {}, ToggleMortalShellMods)
    RegisterKeyBind(Key.F8, {}, ToggleGodMode)
    RegisterKeyBind(Key.F9, {}, MaxOutInventory)
    RegisterKeyBind(Key.PAGE_UP, {}, ShowStatus)
    RegisterKeyBind(Key.NUM_LOCK, {}, UnlockAllShells)
    RegisterKeyBind(Key.PAGE_DOWN, {}, ExploitInventory)
    RegisterKeyBind(Key.HOME, {}, AlwaysAllowFastTravel)
    RegisterKeyBind(Key.BACKSPACE, {}, UnlockAllPlayerFuncs)
end

NotifyOnNewObject("/Game/Blueprints/Characters/Barbarous.Barbarous_C", function(obj)
    print("NEW PLAYER FOUND: REENABLING MODS")
    ExecuteWithDelay(4000, function()
        if MOD_STATE.toggle_mods then
            MOD_STATE.toggle_mods = false
            MOD_STATE.god_mode = false
            MOD_STATE.max_resolve = false
            MOD_STATE.super_stone_form = false
            MOD_STATE.walk_fast = false
            MOD_STATE.super_stamina = false
            MOD_STATE.enhanced_parry = false
            MOD_STATE.no_stone_cooldown = false
            print("Reenabling Mortal Shell Mods")
            ToggleMortalShellMods()
        else
            if MOD_STATE.god_mode then
                MOD_STATE.god_mode = false
                print("Reenabling God Mode")
                ToggleGodMode()
            end
            if MOD_STATE.max_resolve then
                MOD_STATE.max_resolve = false
                print("Reenabling Max Resolve")
                MaxResolve()
            end
            if MOD_STATE.super_stone_form then
                MOD_STATE.super_stone_form = false
                print("Reenabling Super Stone Form")
                ToggleSuperStoneFormMax()
            end
            if MOD_STATE.walk_fast then
                MOD_STATE.walk_fast = false
                print("Reenabling Walk Fast")
                ToggleWalkFast(WalkSpeedModifier)
            end
            if MOD_STATE.super_stamina then
                MOD_STATE.super_stamina = false
                print("Reenabling Super Stamina")
                ToggleSuperStamina()
            end
            if MOD_STATE.enhanced_parry then
                MOD_STATE.enhanced_parry = false
                print("Reenabling Enhanced Parry Chance")
                ToggleEnhancedParryChance()
            end
            if MOD_STATE.no_stone_cooldown then
                MOD_STATE.no_stone_cooldown = false
                print("Reenabling Stone Form No Cooldown")
                StoneFormNoCooldown()
            end
        end
    end)
end)

local CheatUtils = {
    GetModState = GetModState,
    StoneFormNoCooldown = StoneFormNoCooldown,
    ToggleSuperStoneFormMax = ToggleSuperStoneFormMax,
    MaxResolve = MaxResolve,
    ToggleWalkFast = ToggleWalkFast,
    ToggleSuperStamina = ToggleSuperStamina,
    ToggleEnhancedParryChance = ToggleEnhancedParryChance,
    ToggleGodMode = ToggleGodMode,
    ShowStatus = ShowStatus,
    AlwaysAllowFastTravel = AlwaysAllowFastTravel,
    ToggleMortalShellMods = ToggleMortalShellMods,
    MaxOutInventory = MaxOutInventory,
    UnlockAllShells = UnlockAllShells,
    UnlockAllPlayerFuncs = UnlockAllPlayerFuncs,
    ExploitInventory = ExploitInventory,
    EnableKeybinds = EnableKeybinds,
    OpenAllFastTravels = OpenAllFastTravels,
    EnableWeaponModKeybinds = WeaponMod.EnableWeaponModKeybinds,
    MaxOutBolts = WeaponMod.MaxOutBolts,
    SuperBallistazooka = WeaponMod.SuperBallistazooka,
    MaxAllFamiliarity = MaxAllFamiliarity,
    AddAllConsumables = AddAllConsumables,
    UnlockAllItemEntries = UnlockAllItemEntries,
    UnlockAllTutorials = UnlockAllTutorials,
    ToggleFog = ToggleFog,
    SpawnMoreEnemies = SpawnMoreEnemies,
    EnableOneHitKill = EnableOneHitKill,
    PassiveTarAndGlimpses = PassiveTarAndGlimpses,
    HitAllSpawnedEnemies = HitAllSpawnedEnemies,
}

return CheatUtils
