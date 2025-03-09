# 🔨 FiveM Crafting System

## 📌 Description
This script adds an advanced **crafting system** to your **FiveM ESX server** using **NPCs and ox_target**. Players can use materials to craft weapons, with full animations and NPC interactions enhancing the experience.

---

## 🛠️ Installation

1️⃣ **Download the script** and place it in the `resources/fivem-crafting-system/` folder on your server.  
2️⃣ **Add the following line to `server.cfg`**:  
   ```ini
   ensure fivem-crafting-system
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
3️⃣ **The crafting menu opens**, allowing the player to select an item to craft.  
4️⃣ If the player has **the required materials**, a **welding animation** starts.  
5️⃣ Once the crafting process is complete, **the item is added to the player's inventory**! 🚀  

---

## ⚙️ Configuration

### 🔹 **Changing the NPC Location**
📍 Modify the coordinates in `config.lua`:  
   ```lua
   Config.CraftingNPC = vector3(123.45, -321.67, 45.67) -- Change to your desired location
   ```

### 🔹 **Adding New Crafting Recipes**
📜 Open `config.lua` and add new recipes:  
   ```lua
   Config.CraftingRecipes = {
       ["WEAPON_PISTOL"] = {materials = {metal = 5, screws = 2, plastic = 3}},
       ["WEAPON_SMG"] = {materials = {metal = 10, screws = 5, plastic = 7}},
       ["WEAPON_ASSAULTRIFLE"] = {materials = {metal = 20, screws = 10, plastic = 15}}
   }
   ```

---

## 📜 Commands & Events

✅ **Client Events:**
   - 🔹 `fivem-crafting-system:client:OpenMenu` – Opens the crafting menu  
   - 🔹 `fivem-crafting-system:client:StartCraftingAnimation` – Starts the crafting animation  

✅ **Server Events:**
   - 🔹 `fivem-crafting-system:server:CraftItem` – Initiates the crafting process  
   - 🔹 `fivem-crafting-system:server:FinishCraftingItem` – Completes crafting and adds the item to the player's inventory  

---

## ❓ Support

📌 If you encounter any issues or have questions, feel free to reach out! 🚀
