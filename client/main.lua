-- Player in Range Thread
Citizen.CreateThread(function()
    while true do
        local playerePed = GetPlayerPed(-1)
        local playerCoords = GetEntityCoords(playerPed)
        
        if #(playerCoords - Config.WashingPosition) < 1.5 then 
            print("Ped is in Range")
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