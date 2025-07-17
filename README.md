# MattsMod - Ultimate Enhancement Suite for Mortal Shell

**Complete gameplay enhancement with cheats, unlocks, and quality-of-life improvements for Mortal Shell**

[![Lua](https://img.shields.io/badge/language-Lua-blue.svg)](https://www.lua.org/)
[![UE4SS](https://img.shields.io/badge/framework-UE4SS-green.svg)](https://github.com/UE4SS-RE/RE-UE4SS)
[![Game](https://img.shields.io/badge/game-Mortal%20Shell-darkred.svg)](https://mortalshell.com/)

![Dynamic Status Dashboard](https://github.com/user-attachments/assets/63c870be-1818-4774-9b42-53a5c44dda88)
*Dynamic status dashboard showing real-time mod status integrated into the pause menu - press CAPS_LOCK to toggle*

## 🎯 Overview

MattsMod is a **comprehensive UE4SS-based modification** for Mortal Shell, souls-like that's seeing renewed interest ( for me ) with the announcement of Mortal Shell 2. This mod provides extensive gameplay enhancements, shell unlocks, combat modifications, and quality-of-life improvements through intuitive hotkeys and powerful behind-the-scenes hooks.

Perfect for veterans wanting to experience the game differently, newcomers needing assistance, or anyone wanting to explore all content without the traditional grind and have a little fun.

## ✨ Key Features

### ⚔️ Combat Enhancement System
- **Stone Form Mastery** - Remove cooldowns and enable super stone form with massive duration
- **Enhanced Parry System** - 100% enhanced parry chance when activated
- **God Mode Toggle** - Complete invulnerability via UE4 cheat system
- **Resolve Management** - Unlimited resolve with no drain
- **One-Hit Kills** - Developer testing feature for rapid progression
- **Instant Weapon Switching** - Hotkey access to all weapons (1-6) regardless of unlock status

### 🏃‍♂️ Movement & Exploration
- **Super Speed Walking** - 5x movement speed for faster exploration
- **Unlimited Stamina** - Zero stamina cost for all actions
- **Fast Travel Unlock** - Instant access to all teleport locations
- **Anti-Softlock System** - Always allow ornate mask usage to prevent getting stuck
- **Shell Unlocking** - Unlock all shells immediately

### 🎒 Inventory & Progression
- **Inventory Maximization** - Set all stackable items to maximum capacity
- **Unlimited Upgrades** - Zero cost for all shell upgrades and abilities
- **Infinite Currency** - Unlimited tar and glimpses for purchases
- **Complete Unlock System** - Unlock all shells, shell names, weapons, and riposte abilities instantly
- **Smart Exploit System** - Hook-based modification for seamless experience

### 🔧 User Experience
- **Hotkey System** - F1-F9 + special keys for instant access
- **Status Display** - Real-time mod state monitoring
- **Dynamic Status Dashboard** - Live mod status in pause menu Resume button
- **Smart Toggles** - Individual control over each enhancement
- **Console Integration** - Help command and professional logging

## 🚀 Quick Start

### Prerequisites
- **[UE4SS for Unreal Engine 4](https://github.com/UE4SS-RE/RE-UE4SS)** - Install the latest UE4SS release
- Mortal Shell (Steam/Epic Games/GOG)


### Installation
1. **Install UE4SS** in your Mortal Shell game directory
   - Download latest UE4SS release
   - Extract to `Mortal Shell/Binaries/Win64/`
   - Ensure `UE4SS.dll` is in the Win64 folder
2. **Download MattsMod**
   - Clone or download this repository
   - Place in `Mortal Shell/Binaries/Win64/ue4ss/Mods/MattsMod/`
3. **Install Shared Framework**
   - Download from [UE4SS_Lua_Utils](https://github.com/mattdavida/UE4SS_Lua_Utils)
   - Place contents in `Mortal Shell/Binaries/Win64/ue4ss/Mods/shared/`
4. **Configure UE4SS**
   - Add `MattsMod: 1` to your `mods.txt` file
   - Ensure console is enabled in UE4SS settings
5. **Launch the game** - Mod will auto-initialize with welcome message

### Basic Usage
```lua
-- Hotkeys (in-game)
F1          -- Remove stone form cooldown
F2          -- Toggle super stone form (1,000,000 duration)
F3          -- Toggle 5x walk speed
F4          -- Toggle unlimited stamina
F5          -- Max resolve (1,000,000)
F6          -- Toggle 100% enhanced parry chance
F7          -- Enable ALL Matt's mods at once
F8          -- Toggle god mode (invulnerability)
F9          -- Max out all inventory items
PAGE_UP     -- Show current mod status
NUM_LOCK    -- Unlock all shells
PAGE_DOWN   -- Enable unlimited upgrades + unlock fast travel
HOME        -- Enable anti-softlock (always allow ornate mask)
CAPS_LOCK   -- Toggle dynamic status dashboard in pause menu
BACKSPACE   -- Unlock ALL shells, shell names, weapons, and riposte abilities

-- Instant Weapon Switching (works even if weapon not unlocked)
1           -- Summon Hallowed Sword
2           -- Summon Smoldering Mace
3           -- Summon Hammer and Chisel
4           -- Summon Martyr's Blade
5           -- Summon Axatana twin blades
6           -- Summon Axatana axe

-- Console Commands (press ~ or console key)
matts_mod_help              -- Show all available hotkeys
summon_weapon <id>          -- Summon specific weapon by ID (0-5)
```

## 📋 Features Reference

### Core Combat Modifications
| Hotkey | Feature | Description | Toggle |
|--------|---------|-------------|--------|
| **F1** | Stone Form Cooldown | Sets cooldown to 0 for instant reuse | ❌ One-time |
| **F2** | Super Stone Form | 1,000,000 duration + always super | ✅ Toggle |
| **F4** | Super Stamina | Zero stamina cost for all actions | ✅ Toggle |
| **F5** | Max Resolve | Sets resolve to 1,000,000 with no drain | ❌ One-time |
| **F6** | Enhanced Parry | 100% enhanced parry chance | ✅ Toggle |
| **F8** | God Mode | Complete invulnerability via UE4 cheats | ❌ Engine toggle |

### Movement & Exploration
| Hotkey | Feature | Description | Toggle |
|--------|---------|-------------|--------|
| **F3** | Walk Fast | 5x movement speed modifier | ✅ Toggle |
| **PAGE_DOWN** | Fast Travel Unlock | Unlock all teleport locations | ❌ Permanent |
| **HOME** | Anti-Softlock | Always allow ornate mask usage (prevents getting stuck after boss fights) | ❌ Hook-based |

### Inventory & Progression
| Hotkey | Feature | Description | Toggle |
|--------|---------|-------------|--------|
| **F9** | Max Inventory | Set all stackable items to max capacity | ❌ One-time |
| **NUM_LOCK** | Unlock Shells | Unlock all shells via game function | ❌ One-time |
| **BACKSPACE** | Unlock Everything | Unlock all shells, shell names, weapons, riposte abilities | ❌ One-time |
| **PAGE_DOWN** | Unlimited Upgrades | Zero cost upgrades + infinite currency | ❌ Hook-based |

### Instant Weapon Access
| Hotkey | Weapon | Description | Notes |
|--------|--------|-------------|-------|
| **1** | Hallowed Sword | Summon starting weapon | 🗡️ Works without unlock |
| **2** | Smoldering Mace | Summon Hadern's weapon | 🔥 Works without unlock |
| **3** | Hammer and Chisel | Summon Crucix's weapon | 🔨 Works without unlock |
| **4** | Martyr's Blade | Summon Tarsus's weapon | ⚔️ Works without unlock |
| **5** | Axatana Twin Blades | Summon Imrod's twin blades | 🗡️🗡️ Works without unlock |
| **6** | Axatana Axe | Summon Imrod's axe form | 🪓 Works without unlock |

### Utility & Information
| Hotkey | Feature | Description | Notes |
|--------|---------|-------------|-------|
| **F7** | Matt's Mods ALL | Activates F1,F3,F4,F5,F6 + one-hit kill | ⚠️ See warnings |
| **PAGE_UP** | Status Display | Shows current state of all toggles | ℹ️ Information |
| **CAPS_LOCK** | Dynamic Status Dashboard | Transforms pause menu Resume button into live mod status display | 🎯 UI Enhancement |

## ⚠️ Important Warnings & Limitations

### Permanent Effects
Some modifications **cannot be toggled off** and require area transitions to reset:

```
⚠️  PERMANENT UNTIL AREA CHANGE:
• Stone Form Cooldown (F1) - Cannot be restored
• One-Hit Kill (F7 component) - Cannot be disabled
• Must travel to new area to reset these effects
```

### Smart Usage Tips
- **Use F7 carefully** - Combines multiple effects including permanent ones
- **Save before experimenting** - Some effects persist until area change
- **Check status regularly** - Use PAGE_UP to monitor active modifications or CAPS_LOCK for visual dashboard
- **Dynamic dashboard** - CAPS_LOCK transforms pause menu Resume button into live status display with all mod states
- **God mode is engine-level** - Managed by UE4 cheat system, not mod state

## 🏗️ Technical Implementation

### Hook-Based Architecture
The mod uses UE4SS hooks for seamless integration:

```lua
-- Unlimited Upgrades - Cost Override
RegisterHook('/Game/UI/Blueprints/Waifu/UI_ShellUpgradeMenu.UI_ShellUpgradeMenu_C:SetCanBuy', 
    function(self, other)
        local obj = self:get()
        obj.CanBuy = true
        obj.Tar_Cost = 0
        obj.Glimpses_Cost = 0
    end)

-- Infinite Currency - Return Override  
RegisterHook('/Game/UI/Blueprints/Merchant/UI_MerchantPanelNew.UI_MerchantPanelNew_C:GetPlayerCurrency',
    function(self, other)
        return 9999
    end)

-- Fast Travel Unlock - Access Override
RegisterHook('/Game/UI/Blueprints/Waifu/UI_FastTravel.UI_FastTravel_C:GetIsUnlocked',
    function(self, other)
        return true
    end)

-- Anti-Softlock System - Item Usage Override
RegisterHook('/Game/Blueprints/GamePlay/GameplayPC.GameplayPC_C:InventoryUtil_GetCanUseItem',
    function(self, ID, UsableInDarkForm)
        if ID:get():ToString() == 'Mask_Ornate' then
            return 11  -- Always allow ornate mask usage (prevents post-boss softlocks)
        end
    end)

-- Dynamic Status Dashboard - UI Text Override
local function update_button_text()
    local buttons = FindAllOf('UI_MainMenu_Button_C')
    if buttons then
        for _, button in ipairs(buttons) do
            if Utils.StringContains(button:GetFullName(), 'Button_Resume') then
                local status_text = "RESUME - MATT'S MOD\n"
                status_text = status_text .. "F2: Super stone form (" .. (mod_state.super_stone_form and "ON" or "OFF") .. ")\n"
                status_text = status_text .. "F3: Walk fast (" .. (mod_state.walk_fast and "ON" or "OFF") .. ")\n"
                -- ... (full status display with all features)
                button.Text_Value = FText(status_text)
                button.Button_Width = 1040
                button.FontSize = 25
            end
        end
    end
end
```

### Error Handling & User Experience
Professional error handling with helpful messages:

```lua
local function stone_form_no_cooldown()
    local player = UEHelpers.GetPlayer()
    if not player then 
        print('Player not found - try again when in-game')
        return 
    end
    print('Setting Player Stone Form Cooldown to 0')
    player.StoneFormCooldown = 0
end
```

### State Management
Consolidated toggle state tracking:

```lua
local mod_state = {
    super_stone_form = false,
    walk_fast = false,
    super_stamina = false,
    enhanced_parry = false
}
```

## 📁 File Structure

```
MattsMod/
├── Scripts/
│   └── main.lua                # Core mod implementation (286 lines)
└── README.md                   # This documentation
```

## ⚖️ License

This project is shared freely for educational and personal use. The code demonstrates game modding techniques and serves as a foundation for the Mortal Shell modding community.

**Dependencies:**
- **UE4SS**: Open source UE4 scripting system
- **Shared Framework**: Custom utilities for UE4SS development

---

**Built with ❤️ for the Mortal Shell community**  