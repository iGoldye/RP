
ESX = nil
car_pos = vector3(0,0,0)
car_health = 1000

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx_carsync:spawnCar')
AddEventHandler('esx_carsync:spawnCar', function(props,pos,heading)
	local coords = vector3(pos.x,pos.y,pos.z)
	local tries = 0

	local vehicles = ESX.Game.GetVehicles()
	for k,v in pairs(vehicles) do
		local plate = ESX.Math.Trim(GetVehicleNumberPlateText(v))
		if plate == props.plate then
			TriggerServerEvent("esx_carsync:carSpawned", props.plate)
			return
		end
	end
--[[
	while not ESX.Game.IsSpawnPointClear(coords, 2.0) do
		local coords2 = GetSafeCoordForPed(coords, true, 16)
		if coords2 ~= false then
			coords = coords2
		end
		tries = tries + 1
		Citizen.Wait(1000)

		if tries > 10 then
			print("Unable to spawn saved car! Position blocked! "..json.encode(pos))
			break
		end
	end
]]--
	ESX.Game.SpawnVehicle(props.model, coords, heading, function(vehicle)
		ESX.Game.SetVehicleProperties(vehicle, props)
		TriggerServerEvent("esx_carsync:carSpawned", props.plate)
	end)
end)

RegisterNetEvent('esx_carsync:updateCarHealth')
AddEventHandler('esx_carsync:updateCarHealth', function(vehicle)
	updateVehicleHealth(vehicle)
end)

RegisterNetEvent('esx_carsync:updateCarPos')
AddEventHandler('esx_carsync:updateCarPos', function(vehicle)
	updateVehiclePos(vehicle)
end)


function updateVehicleHealth(vehicle)
	if DoesEntityExist(vehicle) then
		local health = GetEntityHealth(vehicle)
		local plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))
		local props = ESX.Game.GetVehicleProperties(vehicle)
		TriggerServerEvent("esx_carsync:updateCarHealth", plate, health, props)
	end
end

function updateVehiclePos(vehicle)
	if DoesEntityExist(vehicle) then
		local plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))
		local coords = GetEntityCoords(vehicle)
		local heading = GetEntityHeading(vehicle)
		TriggerServerEvent("esx_carsync:updateCarPos", plate, coords, heading)
	end
end

Citizen.CreateThread(function()
	while true do
		local playerPed = PlayerPedId()
		local vehicle = GetVehiclePedIsIn(playerPed, false)

		if vehicle > 0 and DoesEntityExist(vehicle) then
			local plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))
			local coords = GetEntityCoords(vehicle)
			local health = GetEntityHealth(vehicle)

			if #(coords-car_pos) > 1 then
				updateVehiclePos(vehicle)
			end

			if car_health ~= health then
				updateVehicleHealth(vehicle)
			end

			car_pos = coords
		end

		Citizen.Wait(1000)
	end
end)
