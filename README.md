# 🔫 ESX Weapon Crafting System

## 📌 Description
This script adds an advanced **weapon crafting system** to your **FiveM ESX server** using **NPCs and ox_target**. Players can use materials to craft weapons, and the entire process includes animations and interaction with an NPC.

---

## 🛠️ Installation

1️⃣ **Download the script** and place it in the `resources/esx-weaponcrafting/` folder on your server.  
2️⃣ **Add the following line to `server.cfg`**:  
   ```ini
   ensure esx-weaponcrafting
   ```
3️⃣ **Make sure you have the following dependencies installed:**
   - ✅ `es_extended`
   - ✅ `ox_target`
   - ✅ `esx_menu`
   - ✅ `esx_inventory`

---

## 🎮 How It Works

1️⃣ **A player approaches an NPC** at a predefined location.  
2️⃣ They use the **ox_target interaction** (e.g., by holding `E`).  
3️⃣ **The crafting menu opens**, allowing the player to select a weapon to craft.  
4️⃣ If the player has **the required materials**, a **welding animation** starts.  
5️⃣ Once the crafting process is complete, **the weapon is added to the player's inventory**! 🚀  

---

## ⚙️ Configuration

### 🔹 **Changing the NPC Location**
📍 Find the following line in `esx-weaponcrafting.lua` and modify the coordinates:  
   ```lua
   local craftingLocation = vector3(123.45, -321.67, 45.67) -- Change to your desired location
   ```

### 🔹 **Adding New Crafting Recipes**
📜 Open `esx-weaponcrafting.lua` and add new recipes:  
   ```lua
   local WeaponCraftingRecipes = {
       ["WEAPON_PISTOL"] = {materials = {metal = 5, screws = 2, plastic = 3}},
       ["WEAPON_SMG"] = {materials = {metal = 10, screws = 5, plastic = 7}},
       ["WEAPON_ASSAULTRIFLE"] = {materials = {metal = 20, screws = 10, plastic = 15}}
   }
   ```

---

## 📜 Commands & Events

✅ **Client Events:**
   - 🔹 `esx-weaponcrafting:client:OpenMenu` – Opens the crafting menu  
   - 🔹 `esx-weaponcrafting:client:StartCraftingAnimation` – Starts the welding animation  

✅ **Server Events:**
   - 🔹 `esx-weaponcrafting:server:CraftWeapon` – Initiates the weapon crafting process  
   - 🔹 `esx-weaponcrafting:server:FinishCraftingWeapon` – Completes crafting and adds the weapon to the player's inventory  

---

## ❓ Support

📌 If you encounter any issues or have questions, feel free to contact me at **tomaskotik08@gmail.com**! 🚀  

---
