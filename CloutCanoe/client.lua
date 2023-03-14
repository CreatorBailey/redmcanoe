local canoe = -1 

RegisterNetEvent('clout:canoe')
AddEventHandler('clout:canoe', function()
    TriggerEvent("vorp_inventory:CloseInv")
    if canoe ~= -1 then
        SetEntityAsMissionEntity(canoe)
        DeleteVehicle(canoe)
        canoe = -1
    end
   RequestModel(GetHashKey("canoe"))
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 3000, true, false, false, false)
    exports['progressBars']:startUI(3000, "You're placing a canoe...")
    Citizen.Wait(3000)
    if not HasModelLoaded(GetHashKey("canoe")) then
        RequestModel(GetHashKey("canoe"))
        while not HasModelLoaded(GetHashKey("canoe")) do
            Citizen.Wait(10)
        end
    end
    ClearPedTasksImmediately(PlayerPedId())
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local prop = CreateVehicle(GetHashKey("canoe"), x, y, z, GetEntityHeading(PlayerPedId()), true, false,false)
    SetVehicleOnGroundProperly(prop)
    SetEntityVisible(prop, true)
    --NetworkSetEntityInvisibleToNetwork(prop, false)
    RequestCollisionForModel(GetHashKey("canoe"))
    SetModelAsNoLongerNeeded(GetHashKey("canoe"));

    SetPedIntoVehicle(playerPed, prop, -1)
    canoe = prop
end)

RegisterCommand('dcanoe', function(source, args, rawCommand)
    if canoe == -1 then
     --   print("There is no canoe.")
    else
        SetEntityAsMissionEntity(canoe)
        DeleteVehicle(canoe)
        canoe = -1
        TriggerServerEvent('clout:additem', "canoe")
    end
end, false)