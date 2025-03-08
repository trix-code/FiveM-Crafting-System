# 🔫 ESX Weapon Crafting System

## 📌 Popis
Tento skript přidává pokročilý **systém výroby zbraní** do vašeho **FiveM ESX serveru** pomocí **NPC a ox_target**. Hráči mohou použít materiály k výrobě zbraní a celý proces zahrnuje animace a interakci s NPC.

---

## 🛠️ Instalace
1️⃣ **Stáhněte skript** a umístěte jej do složky `resources/esx-weaponcrafting/` na vašem serveru.
2️⃣ **Přidejte následující řádek do `server.cfg`**:
   ```ini
   ensure esx-weaponcrafting
   ```
3️⃣ **Ujistěte se, že máte nainstalovány následující závislosti:**
   - ✅ `es_extended`
   - ✅ `ox_target`
   - ✅ `esx_menu`
   - ✅ `esx_inventory`

---

## 🎮 Jak to funguje
1️⃣ **Hráč se přiblíží k NPC** na předdefinované lokaci.
2️⃣ Použije **ox_target interakci** (například podržením `E`).
3️⃣ **Otevře se craftovací menu**, kde si hráč může vybrat zbraň k výrobě.
4️⃣ Pokud hráč má **potřebné materiály**, spustí se **animace svařování**.
5️⃣ Po dokončení procesu výroby se **zbraň přidá do inventáře hráče**! 🚀

---

## ⚙️ Konfigurace
### 🔹 **Změna lokace NPC**
📍 Najděte následující řádek v `esx-weaponcrafting.lua` a změňte souřadnice:
```lua
local craftingLocation = vector3(123.45, -321.67, 45.67) -- Změňte na požadovanou lokaci
```

### 🔹 **Přidání nových craftovacích receptů**
📜 Otevřete `esx-weaponcrafting.lua` a přidejte nové recepty:
```lua
local WeaponCraftingRecipes = {
    ["WEAPON_PISTOL"] = {materials = {metal = 5, screws = 2, plastic = 3}},
    ["WEAPON_SMG"] = {materials = {metal = 10, screws = 5, plastic = 7}},
    ["WEAPON_ASSAULTRIFLE"] = {materials = {metal = 20, screws = 10, plastic = 15}}
}
```

---

## 📜 Příkazy a události
✅ **Client Events:**
- 🔹 `esx-weaponcrafting:client:OpenMenu` – Otevře crafting menu
- 🔹 `esx-weaponcrafting:client:StartCraftingAnimation` – Spustí animaci svařování

✅ **Server Events:**
- 🔹 `esx-weaponcrafting:server:CraftWeapon` – Zahájí proces výroby zbraně
- 🔹 `esx-weaponcrafting:server:FinishCraftingWeapon` – Dokončí výrobu a přidá zbraň do inventáře hráče

---

## ❓ Podpora
📌 Pokud narazíte na jakékoli problémy nebo máte dotazy, kontaktujte mě na **tomaskotik08@gmail.com**! 🚀
