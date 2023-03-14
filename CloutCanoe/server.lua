local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)


VorpInv = exports.vorp_inventory:vorp_inventoryApi()

Citizen.CreateThread(function()

    Citizen.Wait(1000)




    VorpInv.RegisterUsableItem("canoe", function(data)
        VorpInv.subItem(data.source, "canoe", 1)
        TriggerClientEvent("vorp:TipRight", data.source, "You're placing a canoe", 5000)
        TriggerClientEvent("clout:canoe", data.source,"CANOE")
    end)


end)



RegisterNetEvent("clout:additem")
AddEventHandler("clout:additem", function(item)
    local _source = source
    VorpInv.addItem(source, item, 1)
end)