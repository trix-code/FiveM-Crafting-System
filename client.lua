local craftingLocation = vector3(123.45, -321.67, 45.67) -- Nastav správné souřadnice
local npc

CreateThread(function()
    local model = GetHashKey("s_m_y_blackops_01") -- NPC model
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(100)
    end
    
    npc = CreatePed(4, model, craftingLocation.x, craftingLocation.y, craftingLocation.z - 1.0, 90.0, false, true)
    SetEntityInvincible(npc, true)
    FreezeEntityPosition(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)
end)

-- Detekce klávesy E pro otevření crafting menu
CreateThread(function()
    while true do
        local sleep = 1000
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local dist = #(playerCoords - craftingLocation)

        if dist < 2.5 then
            sleep = 0
            ESX.ShowHelpNotification("~INPUT_CONTEXT~ Otevřít crafting menu") -- Zobrazí zprávu "Stiskněte E pro otevření menu"

            if IsControlJustPressed(0, 38) then -- 38 = klávesa E
                OpenCraftingMenu()
            end
        end

        Wait(sleep)
    end
end)

-- Funkce pro otevření crafting menu
function OpenCraftingMenu()
    local elements = {
        {label = '🔫 Vyrobit Pistol', value = 'WEAPON_PISTOL'},
        {label = '🔫 Vyrobit SMG', value = 'WEAPON_SMG'},
        {label = '🔫 Vyrobit Assault Rifle', value = 'WEAPON_ASSAULTRIFLE'}
    }

    ESX.UI.Menu.CloseAll() -- Zavře všechna otevřená menu před otevřením nového

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'crafting_menu', {
        title    = "🔧 Crafting Menu",
        align    = "center",
        elements = elements
    }, function(data, menu)
        TriggerServerEvent('esx-weaponcrafting:server:CraftWeapon', data.current.value)
        menu.close()
    end, function(data, menu)
        menu.close()
    end)
end

-- Animace pro craftění
RegisterNetEvent('esx-weaponcrafting:client:StartCraftingAnimation')
AddEventHandler('esx-weaponcrafting:client:StartCraftingAnimation', function(weapon)
    local ped = PlayerPedId()
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_WELDING", 0, true)
    
    lib.progressBar({
        duration = 5000,
        position = 'bottom',
        label = 'Vyrabis',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
            move = true,
            combat = true,
            mouse = false,
        },
        anim = {
            dict = 'misscarsteal4@actor',
            clip = 'actor_berating_loop'
        },
    })
        ClearPedTasks(ped)
        TriggerServerEvent('esx-weaponcrafting:server:FinishCraftingWeapon', weapon)
        ClearPedTasks(ped)
        TriggerEvent('esx:showNotification', '~r~Craftění přerušeno!')
end)
