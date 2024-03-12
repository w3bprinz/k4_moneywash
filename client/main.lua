    -- Player in Range Thread
Citizen.CreateThread(function()
    while true do
        local playerCoords = GetEntityCoords(PlayerPedId())
        
        if #(playerCoords - Config.WashingPosition) < 1.5 then 
            DisplayHelpText()
            if IsControlJustReleased(0, 38) then
                TriggerEvent("k4_moneywash:openLaundry")
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
    AddTextComponentString(Translate('press_to_wash'))
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function checkPlayerJob(playerData)
    local hasJob = false

    for _, job in ipairs(Config.Factions) do
        if playerData.job.name == job then 
            hasJob = true
            print("Player hat den richtigen job!")
            break
        end
    end
    return hasJob
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

RegisterNetEvent('k4_moneywash:openLaundry')
AddEventHandler('k4_moneywash:openLaundry', function()
    local PlayerData = ESX.GetPlayerData()
    print("Playerjob: " .. PlayerData.job.name)
    if Config.FactionOnly == true then
        --print("Nur Fraktionen!")
        if checkPlayerJob(PlayerData) == true then
            TriggerEvent("showMoneywashUI")
        else
            ESX.ShowNotification(Translate('wrong_job'), 5000, "info")
        end
    else 
        TriggerEvent("showMoneywashUI")
    end
end)