    -- Player in Range Thread
Citizen.CreateThread(function()
    while true do
        local playerCoords = GetEntityCoords(PlayerPedId())
        
        if #(playerCoords - Config.WashingPosition) < 1.5 then 
            --print("Ped is in Range")
            DisplayHelpText()
            if IsControlJustReleased(0, 38) then
                TriggerEvent("showMoneywashUI")
            end
        end
        Citizen.Wait(0)
    end
end)

-- Spawn NPC Thread
Citizen.CreateThread(function()

    SpawnNPCByModelName(Config.NPC.model, Config.NPC.position.x, Config.NPC.position.y, Config.NPC.position.z, Config.NPC.heading)
    
end)


function SpawnNPCByModelName(modelName, x, y, z, heading)
    RequestModel(modelName)

    while not HasModelLoaded(modelName) do
        Wait(500)
    end

    local npc = CreatePed(4, modelName, x, y, z - 1, heading, false, false)

    -- Weitere Anpassungen, falls benötigt
    FreezeEntityPosition(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)
    SetEntityInvincible(npc, true)  -- Der NPC kann nicht verletzt werden

    -- Weitere Aufgaben oder Anpassungen können je nach Bedarf hinzugefügt werden
end

function DisplayHelpText()
    SetTextComponentFormat("STRING")
    AddTextComponentString("Drücke ~r~ ~INPUT_CONTEXT~ ~w~um die ~r~Geldwäsche ~w~zu öffnen.")
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

-- NUI
RegisterNetEvent("showMoneywashUI", function()
    SetNuiFocus(true, true)
    SendNUIMessage({action = "show"})
end)

RegisterNetEvent("hideMoneywashUI", function()
    SetNuiFocus(false, false)
    SendNUIMessage({action = "hide"})
end)

RegisterNuiCallback("hideMoneywashUI", function()
    SetNuiFocus(false, false)
    SendNUIMessage({action = "hide"})
end)

RegisterNuiCallback("washMoney", function(data, cb)

    --print(data.dirtymoney)
    TriggerEvent("hideMoneywashUI")
    TriggerServerEvent('k4_moneywash:washMoney', data.dirtymoney)
end)