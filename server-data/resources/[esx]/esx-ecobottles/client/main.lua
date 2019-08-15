ESX                           = nil

local cachedBins = {}
local binEntity, binEntityDst = 0, 10000

Citizen.CreateThread(function ()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) 
            ESX = obj 
        end)

        Citizen.Wait(5)
    end
end)

Citizen.CreateThread(function()
    Citizen.Wait(100)

    for locationIndex = 1, #Config.SellBottleLocations do
        local locationPos = Config.SellBottleLocations[locationIndex]

        local blip = AddBlipForCoord(locationPos)

        SetBlipSprite (blip, 409)
        SetBlipDisplay(blip, 4)
        SetBlipScale  (blip, 0.8)
        SetBlipColour (blip, 48)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Сдать бутылки")
        EndTextCommandSetBlipName(blip)
    end

    while true do
        local sleepThread = 500

        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)

        for locationIndex = 1, #Config.SellBottleLocations do
            local locationPos = Config.SellBottleLocations[locationIndex]

            local dstCheck = GetDistanceBetweenCoords(pedCoords, locationPos, true)

            if dstCheck <= 5.0 then
                sleepThread = 5

                local text = "Сдать бутылки"

                if dstCheck <= 1.5 then
                    text = "[~g~E~s~] " .. text

                    if IsControlJustReleased(0, 38) then
                        TriggerServerEvent("esx-ecobottles:sellBottles")
                    end
                end
                
                ESX.Game.Utils.DrawText3D(locationPos, text, 0.4)
            end
        end

        Citizen.Wait(sleepThread)
    end
end)

Citizen.CreateThread(function()
    while true do
	Citizen.Wait(300)

        local playerCoords = GetEntityCoords(PlayerPedId())

        binEntity = nil
        binEntityDst = 10000
	for _,v in pairs(Config.BinsAvailable) do
		local obj = GetClosestObjectOfType(playerCoords.x,playerCoords.y,playerCoords.z, 5.0, GetHashKey(v))
		if DoesEntityExist(obj) then
			binEntity = obj
                        binEntityDst = #(playerCoords-GetEntityCoords(obj))
			break
		end
	end
-- It will be faster if we have 30+ bin models
--        binEntity, binEntityDst = ESX.Game.GetClosestObject(Config.BinsAvailable)
    end
end)

Citizen.CreateThread(function()
    Citizen.Wait(100)

    while true do
        local sleepThread = 100

        if DoesEntityExist(binEntity) and binEntityDst <= 1.5 then
            sleepThread = 0

            local binCoords = GetEntityCoords(binEntity)

            ESX.Game.Utils.DrawText3D(binCoords + vector3(0.0, 0.0, 0.5), "[~g~E~s~] Искать бутылки", 0.4)

            if IsControlJustReleased(0, 38) then
                if not cachedBins[binEntity] then
                    cachedBins[binEntity] = true

                    OpenTrashCan()
                else
                    ESX.ShowNotification("В этой урне вы уже искали!")
                end
            end
        end

        Citizen.Wait(sleepThread)
    end
end)

function OpenTrashCan()
    TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)

    Citizen.Wait(10000)

    TriggerServerEvent("esx-ecobottles:retrieveBottle")

    ClearPedTasks(PlayerPedId())
end
