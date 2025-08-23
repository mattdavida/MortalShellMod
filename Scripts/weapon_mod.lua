local UEHelpers = require('UEHelpers.UeHelpers')

WEAPON_MAP = {
    [0] = "Hallowed Sword",
    [1] = "Smoldering Mace",
    [2] = "Hammer and Chisel",
    [3] = "Martyr's Blade",
    [4] = "Axatana twin blades",
    [5] = "Axatana axe", 
}

function SummonWeaponFromKeybind(weapon_id)
    local player = UEHelpers.GetPlayer()
    print('SUMMON WEAPON: ' .. WEAPON_MAP[weapon_id])

    player:SummonWeapon(weapon_id)
end

function SuperBallistazooka()
    local anim_montage = StaticFindObject('/Game/MainChar/anims/shooting/Char_anims/Balista_Reload_Montage.Balista_Reload_Montage')
    local equip_montage = StaticFindObject('/Game/MainChar/anims/shooting/Char_anims/Ballista_Equip_Montage.Ballista_Equip_Montage')
    local idle_to_aim = StaticFindObject('/Game/MainChar/anims/shooting/Char_anims/Ballista_Idle_To_Aim.Ballista_Idle_To_Aim')
    local idle_to_reload = StaticFindObject('/Game/MainChar/anims/shooting/Char_anims/Ballista_Idle_To_Reload.Ballista_Idle_To_Reload')
    local equip_instant_reload = StaticFindObject('/Game/MainChar/anims/shooting/Char_anims/Ballista_Equip_InstantReload_Montage.Ballista_Equip_InstantReload_Montage')
    if anim_montage then
        --  original length: 5.7333331108093
        anim_montage.SequenceLength = 0.01
        equip_montage.SequenceLength = 0.01
        idle_to_aim.SequenceLength = 0.01
        idle_to_reload.SequenceLength = 0.01
        equip_instant_reload.SequenceLength = 0.01
        print('Super Ballistazooka: ON')
    else
        print('Anim Montage not found')
    end
end

function MaxOutBolts()
    local inventory_component = FindFirstOf('EquipmentInventoryComponent_C')
    if inventory_component then
        local inventory = inventory_component.Inventory
        if inventory then
            for i = 1, inventory:GetArrayNum() do
                ---@class FInventoryItem
                local item = inventory[i]
                if item then
                    if item.IsStackable_49_6C7D21E34F4CA74A677416A1E92DD137 then
                        if item.Name_124_933A963C4D9FCA5BB44069830C37A98D:ToString() == 'Large Bolt' then
                            print("Updating Large Bolt to max stack size")
                            item.Amount_104_5BD0F40343BC83E7582405A59DEF24E8 = item.MaxStackSize_105_457804EE421C991C4D20ADA6928E4B40
                            break
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

function EnableWeaponModKeybinds() 
    RegisterKeyBind(Key.THREE, {}, MaxOutBolts)
    RegisterKeyBind(Key.FOUR, {}, SuperBallistazooka)
    RegisterKeyBind(Key.FIVE, {}, function() SummonWeaponFromKeybind(0) end)
    RegisterKeyBind(Key.SIX, {}, function() SummonWeaponFromKeybind(1) end)
    RegisterKeyBind(Key.SEVEN, {}, function() SummonWeaponFromKeybind(2) end)
    RegisterKeyBind(Key.EIGHT, {}, function() SummonWeaponFromKeybind(3) end)
    RegisterKeyBind(Key.NINE, {}, function() SummonWeaponFromKeybind(4) end)
    RegisterKeyBind(Key.ZERO, {}, function() SummonWeaponFromKeybind(5) end)
end