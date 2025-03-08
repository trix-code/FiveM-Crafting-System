ESX = exports['es_extended']:getSharedObject()

-- Definice craftovacích receptů
local WeaponCraftingRecipes = {
    ["WEAPON_PISTOL"] = {materials = {metal = 5, screws = 2, plastic = 3}},
    ["WEAPON_SMG"] = {materials = {metal = 10, screws = 5, plastic = 7}},
    ["WEAPON_ASSAULTRIFLE"] = {materials = {metal = 20, screws = 10, plastic = 15}}
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

-- Přidání NPC pro otevření craftovacího menu
local craftingLocation = vector3(123.45, -321.67, 45.67) -- Změň souřadnice na správné

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

    exports['ox_target']:AddTargetEntity(npc, {
        options = {
            {
                event = "esx-weaponcrafting:client:OpenMenu",
                icon = "fas fa-wrench",
                label = "Otevřít crafting menu",
            }
        },
        distance = 2.5
    })
end)

-- Client Event pro otevření menu
RegisterNetEvent('esx-weaponcrafting:client:OpenMenu')
AddEventHandler('esx-weaponcrafting:client:OpenMenu', function()
    local craftingMenu = {
        {label = 'Vyrobit Pistol', value = 'WEAPON_PISTOL'},
        {label = 'Vyrobit SMG', value = 'WEAPON_SMG'},
        {label = 'Vyrobit Assault Rifle', value = 'WEAPON_ASSAULTRIFLE'}
    }
    TriggerEvent('esx_menu:open', 'default', GetCurrentResourceName(), {
        title = "Crafting Menu",
        align = "center",
        elements = craftingMenu
    }, function(data, menu)
        TriggerServerEvent('esx-weaponcrafting:server:CraftWeapon', data.current.value)
        menu.close()
    end, function(data, menu)
        menu.close()
    end)
end)

-- Animace pro craftění
RegisterNetEvent('esx-weaponcrafting:client:StartCraftingAnimation')
AddEventHandler('esx-weaponcrafting:client:StartCraftingAnimation', function(weapon)
    local ped = PlayerPedId()
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_WELDING", 0, true)
    
    ESX.Progressbar("craft_weapon", "Vyrábíš zbraň...", 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Hotovo
        ClearPedTasks(ped)
        TriggerServerEvent('esx-weaponcrafting:server:FinishCraftingWeapon', weapon)
    end, function() -- Přerušeno
        ClearPedTasks(ped)
        TriggerEvent('esx:showNotification', '~r~Craftění přerušeno!')
    end)
end)

RegisterNetEvent('esx-weaponcrafting:server:FinishCraftingWeapon')
AddEventHandler('esx-weaponcrafting:server:FinishCraftingWeapon', function(weapon)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    RemoveMaterials(xPlayer, weapon)
    xPlayer.addInventoryItem(weapon, 1)
    TriggerClientEvent('esx:showNotification', src, '~g~Úspěšně jsi vyrobil zbraň!')
end)