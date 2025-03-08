# 🔫 QBCore Weapon Crafting System

## 📌 Description
This script adds an advanced **weapon crafting system** to your **FiveM QBCore server** using **NPCs and qb-target**. Players can use materials to craft weapons, and the entire process includes animations and NPC interaction.

---

## 🛠️ Installation
1️⃣ **Download the script** and place it in `resources/qb-weaponcrafting/` on your server.
2️⃣ **Add the following line to `server.cfg`**:
   ```ini
   ensure qb-weaponcrafting
   ```
3️⃣ **Ensure you have the following dependencies installed:**
   - ✅ `qb-core`
   - ✅ `qb-target`
   - ✅ `qb-menu`
   - ✅ `qb-inventory`

---

## 🎮 How It Works
1️⃣ **The player approaches the NPC** at the predefined location.
2️⃣ Uses **qb-target interaction** (e.g., holding `E`).
3️⃣ **A crafting menu opens**, allowing the player to choose a weapon to craft.
4️⃣ If the player has **the required materials**, a **welding animation starts**.
5️⃣ After the crafting process is completed, **the weapon is added to the player's inventory**! 🚀

---

## ⚙️ Configuration
### 🔹 **Changing NPC Location**
📍 Find the following line in `qb-weaponcrafting.lua` and change the coordinates:
```lua
local craftingLocation = vector3(123.45, -321.67, 45.67) -- Adjust to the desired location
```

### 🔹 **Adding New Crafting Recipes**
📜 Open `qb-weaponcrafting.lua` and add new recipes:
```lua
local WeaponCraftingRecipes = {
    ["WEAPON_PISTOL"] = {materials = {metal = 5, screws = 2, plastic = 3}},
    ["WEAPON_SMG"] = {materials = {metal = 10, screws = 5, plastic = 7}},
}
```

---

## 📜 Commands & Events
✅ **Client Events:**
- 🔹 `qb-weaponcrafting:client:OpenMenu` – Opens the crafting menu
- 🔹 `qb-weaponcrafting:client:StartCraftingAnimation` – Starts the welding animation

✅ **Server Events:**
- 🔹 `qb-weaponcrafting:server:CraftWeapon` – Initiates the crafting process
- 🔹 `qb-weaponcrafting:server:FinishCraftingWeapon` – Completes the crafting and adds the weapon to inventory

---

## ❓ Support
📌 If you encounter any issues or have questions, **join our Discord server** for support and the latest updates! 🚀
