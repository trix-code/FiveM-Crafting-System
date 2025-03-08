QBCore = exports['qb-core']:GetCoreObject()

-- Recepty na crafteni zbrani
local WeaponCraftingRecipes = {
    ["WEAPON_PISTOL"] = {materials = {metal = 5, screws = 2, plastic = 3}},
    ["WEAPON_SMG"] = {materials = {metal = 10, screws = 5, plastic = 7}},
    ["WEAPON_ASSAULTRIFLE"] = {materials = {metal = 20, screws = 10, plastic = 15}}
}

-- Ověření, zda má hráč potřebné materiály
local function HasRequiredMaterials(player, weapon)
    local materials = WeaponCraftingRecipes[weapon].materials
    for item, count in pairs(materials) do
        if player.Functions.GetItemByName(item) == nil or player.Functions.GetItemByName(item).amount < count then
            return false, item
        end
    end
    return true
end

-- Odebrání materiálů po craftění
local function RemoveMaterials(player, weapon)
    local materials = WeaponCraftingRecipes[weapon].materials
    for item, count in pairs(materials) do
        player.Functions.RemoveItem(item, count)
    end
end

-- Hlavní funkce pro craftění zbraní
RegisterNetEvent('qb-weaponcrafting:server:CraftWeapon')
AddEventHandler('qb-weaponcrafting:server:CraftWeapon', function(weapon)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if not WeaponCraftingRecipes[weapon] then
        TriggerClientEvent('QBCore:Notify', src, 'Neplatná zbraň k vytvoření!', 'error', 2500)
        return
    end

    local hasMaterials, missingItem = HasRequiredMaterials(Player, weapon)
    if hasMaterials then
        RemoveMaterials(Player, weapon)
        Player.Functions.AddItem(weapon, 1)
        TriggerClientEvent('QBCore:Notify', src, 'Úspěšně jsi vyrobil zbraň!', 'success', 2500)
    else
        TriggerClientEvent('QBCore:Notify', src, 'Chybí materiál: ' .. missingItem, 'error', 2500)
    end
end)

-- Přidání NPC pro otevření craftovacího menu
local craftingLocation = vector3(123.45, -321.67, 45.67) -- Souradnice NPC

CreateThread(function()
    local model = GetHashKey("s_m_y_blackops_01") -- NPC model
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(100)
    end
    
    local npc = CreatePed(4, model, craftingLocation.x, craftingLocation.y, craftingLocation.z - 1.0, 90.0, false, true)
    SetEntityInvincible(npc, true)
    FreezeEntityPosition(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)
    
    exports['qb-target']:AddTargetEntity(npc, {
        options = {
            {
                type = "client",
                event = "qb-weaponcrafting:client:OpenMenu",
                icon = "fas fa-wrench",
                label = "Otevřít crafting menu",
            }
        },
        distance = 2.5
    })
end)

-- Client Event pro otevření menu
RegisterNetEvent('qb-weaponcrafting:client:OpenMenu')
AddEventHandler('qb-weaponcrafting:client:OpenMenu', function()
    local craftingMenu = {
        {label = 'Vyrobit Pistol', value = 'WEAPON_PISTOL'},
        {label = 'Vyrobit SMG', value = 'WEAPON_SMG'},
        {label = 'Vyrobit Assault Rifle', value = 'WEAPON_ASSAULTRIFLE'}
    }
    TriggerEvent('qb-menu:client:openMenu', craftingMenu)
end)
