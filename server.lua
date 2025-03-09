ESX = exports['es_extended']:getSharedObject()

-- Definice craftovacích receptů
local WeaponCraftingRecipes = {
    ["WEAPON_PISTOL"] = {materials = {water = 5}},
    ["WEAPON_SMG"] = {materials = {water = 5}},
    ["WEAPON_ASSAULTRIFLE"] = {materials = {water = 5}}
}

-- Ověření, zda má hráč potřebné materiály
local function HasRequiredMaterials(xPlayer, weapon)
    local materials = WeaponCraftingRecipes[weapon].materials
    for item, count in pairs(materials) do
        local inventoryItem = xPlayer.getInventoryItem(item)
        if not inventoryItem or inventoryItem.count < count then
            return false, item
        end
    end
    return true
end

-- Odebrání materiálů po craftění
local function RemoveMaterials(xPlayer, weapon)
    local materials = WeaponCraftingRecipes[weapon].materials
    for item, count in pairs(materials) do
        xPlayer.removeInventoryItem(item, count)
    end
end

-- Hlavní funkce pro craftění zbraní
RegisterNetEvent('esx-weaponcrafting:server:CraftWeapon')
AddEventHandler('esx-weaponcrafting:server:CraftWeapon', function(weapon)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if not WeaponCraftingRecipes[weapon] then
        TriggerClientEvent('esx:showNotification', src, '~r~Neplatná zbraň k vytvoření!')
        return
    end

    local hasMaterials, missingItem = HasRequiredMaterials(xPlayer, weapon)
    if hasMaterials then
        TriggerClientEvent('esx-weaponcrafting:client:StartCraftingAnimation', src, weapon)
    else
        TriggerClientEvent('esx:showNotification', src, '~r~Chybí materiál: ' .. missingItem)
    end
end)

-- Dokončení craftění zbraně
RegisterNetEvent('esx-weaponcrafting:server:FinishCraftingWeapon')
AddEventHandler('esx-weaponcrafting:server:FinishCraftingWeapon', function(weapon)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    RemoveMaterials(xPlayer, weapon)
    xPlayer.addInventoryItem(weapon, 1)
    TriggerClientEvent('esx:showNotification', src, '~g~Úspěšně jsi vyrobil zbraň!')
end)
