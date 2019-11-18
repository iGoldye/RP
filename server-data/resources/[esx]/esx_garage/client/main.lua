ESX                	  = nil
local LastGarage 	  = nil
local LastPart   	  = nil
local LastParking	  = nil
local thisGarage 	  = nil
local PlayerData          = nil
local blips               = {}
local myProperties        = {}

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	updateBlipsAndMarkers()
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	PlayerData = ESX.GetPlayerData()
	updateOwnedProperties()
	updateBlipsAndMarkers()
end)


AddEventHandler('esx_property:initialized', function()
	updateOwnedProperties()
	updateBlipsAndMarkers()
end)

function getPosRot(vehicle)
	local pos = GetEntityCoords(vehicle)
	local hea = GetEntityHeading(vehicle)
	return {["x"] = pos.x, ["y"] = pos.y, ["z"] = pos.z, ["r"] = hea}
end

function updateOwnedProperties()
	ESX.TriggerServerCallback('esx_property:getOwnedProperties', function(ownedProperties)
		TriggerEvent('esx_property:getProperties', function(properties)
			myProperties = {}
			for i=1, #ownedProperties, 1 do
				local propertyName = ownedProperties[i]
				local property = getPropertyByName(properties, propertyName)
				myProperties[propertyName] = property
			end
		end)
		updateBlipsAndMarkers()
	end)
end

function propertyOwned(propName)
	if myProperties == nil then
		updateOwnedProperties()
		return false
	end

	for propertyName, property in pairs(myProperties) do
		if propertyName == propName or (property ~= nil and property.gateway == propName) then
			return true
		end
	end
	return false
end

function SaveGarageCars(name)
	local garage    = Config.Garages[name]
	local vehicle = 0
	local cars = {}

	-- save first 20 vehicles into garage
	for i=1, 20 do
		vehicle = GetClosestVehicle(garage.InteriorCenter.Pos.x,  garage.InteriorCenter.Pos.y,  garage.InteriorCenter.Pos.z,  garage.InteriorCenter.Radius,  0,  71)
		if vehicle > 0 and DoesEntityExist(vehicle) then
			local vehicleProps  = ESX.Game.GetVehicleProperties(vehicle)
			table.insert(cars, {
				["props"] = vehicleProps,
				["pos"] = getPosRot(vehicle),
			})
			ESX.Game.DeleteVehicle(vehicle)
		else
			break
		end
	end

	TriggerServerEvent('esx_garage:setParkings', name, cars)
end

function SpawnGarageCar(props, pos, heading)
	local exvehicle = GetClosestVehicle(pos.x,  pos.y,  pos.z,  2.0,  0,  71)

	if DoesEntityExist(exvehicle) then
		ESX.Game.DeleteVehicle(exvehicle)
	end

	ESX.Game.SpawnLocalVehicle(props.model, {
		x = pos.x,
		y = pos.y,
		z = pos.z + Config.ZDiff
	}, heading, function(vehicle)
		ESX.Game.SetVehicleProperties(vehicle, props)
	end)
end

function SpawnGarageCars(name)
	local garage    = Config.Garages[name]
	ESX.TriggerServerCallback('esx_vehicleshop:getVehiclesInGarage', function(vehicles)

		for j=1, #vehicles, 1 do
			local vehInfo = vehicles[j]
			local zone = vehInfo.zone

			if zone > 0 and zone <= #garage.Parkings then
				local pos = garage.Parkings[zone].Pos
				local hea = garage.Parkings[zone].Heading
				SpawnGarageCar(vehInfo.vehicle, pos, hea)
			elseif zone == 0 then
				local vehicles2 = vehInfo.vehicle
				for k=1, #vehicles2 do
					local veh = vehicles2[k]
					local pos = veh.pos
					local hea = veh.pos.r
					SpawnGarageCar(veh.props, pos, hea)
				end
			end
		end
	end, name)
end

TriggerEvent('instance:registerType', 'garage')

RegisterNetEvent('instance:onCreate')
AddEventHandler('instance:onCreate', function(instance)
	if instance.type == 'garage' then
		TriggerEvent('instance:enter', instance)
	end
end)

AddEventHandler('esx_garage:hasEnteredMarker', function(name, part, parking)
	
	if part == 'ExteriorEntryPoint' then

		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)
		local garage    = Config.Garages[name]
		thisGarage 		= garage
		
		for i=1, #Config.Garages, 1 do
			if Config.Garages[i].name ~= name then
				Config.Garages[i].disabled = true
			end
		end

		local vehicle = 0
		repeat
			vehicle = GetClosestVehicle(garage.InteriorCenter.Pos.x,  garage.InteriorCenter.Pos.y,  garage.InteriorCenter.Pos.z,  garage.InteriorCenter.Radius,  0,  71)
			if vehicle > 0 and DoesEntityExist(vehicle) then
				ESX.Game.DeleteVehicle(vehicle)
			else
				break
			end
		until vehicle ~= 0

		if IsPedInAnyVehicle(playerPed,  false) then

			local vehicle       = GetVehiclePedIsIn(playerPed,  false)
			local maxHealth     = GetEntityMaxHealth(vehicle)
			local health        = GetEntityHealth(vehicle)
			local healthPercent = (health / maxHealth) * 100

			if healthPercent < Config.MinimumHealthPercent then
				ESX.ShowNotification(_U('veh_health'))
			else

				if GetPedInVehicleSeat(vehicle,  -1) == playerPed then

					local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)

					local spawnCoords  = {
						x = garage.InteriorSpawnPoint.Pos.x,
						y = garage.InteriorSpawnPoint.Pos.y,
						z = garage.InteriorSpawnPoint.Pos.z + Config.ZDiff
					}

					TriggerEvent('instance:create', 'garage')
					NetworkSetEntityInvisibleToNetwork(vehicle, true)
					SetEntityCoords(vehicle, spawnCoords.x, spawnCoords.y, spawnCoords.z, 0, 0, 0, true)
					SetEntityHeading(vehicle, garage.ExteriorSpawnPoint.Heading)

					SpawnGarageCars(name)
				else

					ESX.Game.Teleport(playerPed, {
						x = garage.InteriorSpawnPoint.Pos.x,
						y = garage.InteriorSpawnPoint.Pos.y,
						z = garage.InteriorSpawnPoint.Pos.z + Config.ZDiff
					}, function()
						TriggerEvent('instance:create', 'garage')
						SpawnGarageCars(name)
					end)

				end

			end

		else

			ESX.Game.Teleport(playerPed, {
				x = garage.InteriorSpawnPoint.Pos.x,
				y = garage.InteriorSpawnPoint.Pos.y,
				z = garage.InteriorSpawnPoint.Pos.z + Config.ZDiff
			}, function()

				TriggerEvent('instance:create', 'garage')
				SpawnGarageCars(name)
			end)

		end

	end

	if part == 'InteriorExitPoint' then

		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)
		local garage = thisGarage

		if IsPedInAnyVehicle(playerPed,  false) then

			local vehicle      = GetVehiclePedIsIn(playerPed,  false)
			local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
			
			local spawnCoords  = {
				x = garage.ExteriorSpawnPoint.Pos.x,
				y = garage.ExteriorSpawnPoint.Pos.y,
				z = garage.ExteriorSpawnPoint.Pos.z
			}
--[[
			SetEntityCoords(vehicle, spawnCoords.x, spawnCoords.y, spawnCoords.z, 0, 0, 0, true)
			SetEntityHeading(vehicle, garage.ExteriorSpawnPoint.Heading)
			NetworkSetEntityInvisibleToNetwork(vehicle, false)
			TriggerEvent('instance:close')
]]--
			ESX.Game.DeleteVehicle(vehicle)

			ESX.Game.Teleport(playerPed, spawnCoords, function()

				TriggerEvent('instance:close')

				ESX.Game.SpawnVehicle(vehicleProps.model, spawnCoords, garage.ExteriorSpawnPoint.Heading, function(vehicle)
					TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
					ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
					SetVehicleEngineOn(vehicle, (not GetIsVehicleEngineRunning(vehicle)), false, true)
				end)

			end)
		else


			ESX.Game.Teleport(playerPed,{
						x = garage.ExteriorSpawnPoint.Pos.x,
						y = garage.ExteriorSpawnPoint.Pos.y,
						z = garage.ExteriorSpawnPoint.Pos.z
					}, function()
				TriggerEvent('instance:close')
			end)

		end

		SaveGarageCars(name)
		
		for i=1, #Config.Garages, 1 do
			if Config.Garages[i].name ~= name then
				Config.Garages[i].disabled = false
			end
		end
		
		thisGarage = nil

	end
end)

AddEventHandler('esx_property:hasExitedMarker', function(name, part, parking)

end)

function updateBlipsAndMarkers()
	for k,v in pairs(blips) do
		RemoveBlip(v)
	end

	if PlayerData == nil then
		PlayerData = ESX.GetPlayerData()
	end

	for k,v in pairs(Config.Garages) do
		local garageAllowedJob = PlayerData == nil or (v.NeedJob == nil) or (PlayerData.job ~= nil and v.NeedJob == PlayerData.job.name)
		local garageAllowedProp = PlayerData == nil or (v.NeedProperty == nil) or (propertyOwned(v.NeedProperty))
		v.allowedJob = garageAllowedJob
		v.allowedProp = garageAllowedProp

		if v.IsClosed and garageAllowedJob and garageAllowedProp then

			local blip = AddBlipForCoord(v.ExteriorEntryPoint.Pos.x, v.ExteriorEntryPoint.Pos.y, v.ExteriorEntryPoint.Pos.z)
			table.insert(blips, blip)

			SetBlipSprite (blip, 357)
			SetBlipDisplay(blip, 4)
			SetBlipScale  (blip, 1.2)
			SetBlipColour (blip, 3)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Гараж")
			EndTextCommandSetBlipName(blip)

		end

	end
end

-- Display markers
Citizen.CreateThread(function()
	local sleep = false
	while true do

		if sleep == true then
			Citizen.Wait(500)
		else
			Citizen.Wait(0)
		end

		sleep = true
		
		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)
		
		for k,v in pairs(Config.Garages) do

			if v.IsClosed then

				if v.allowedProp and v.allowedJob and (not v.disabled and GetDistanceBetweenCoords(coords, v.ExteriorEntryPoint.Pos.x, v.ExteriorEntryPoint.Pos.y, v.ExteriorEntryPoint.Pos.z, true) < Config.DrawDistance) then
					DrawMarker(Config.MarkerType, v.ExteriorEntryPoint.Pos.x, v.ExteriorEntryPoint.Pos.y, v.ExteriorEntryPoint.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
					sleep = false
				end	

				if(not v.disabled and GetDistanceBetweenCoords(coords, v.InteriorExitPoint.Pos.x, v.InteriorExitPoint.Pos.y, v.InteriorExitPoint.Pos.z, true) < Config.DrawDistance) then
					DrawMarker(Config.MarkerType, v.InteriorExitPoint.Pos.x, v.InteriorExitPoint.Pos.y, v.InteriorExitPoint.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
					sleep = false
				end

			end
		end

	end
end)

function getPropertyByName(properties, name)
	for _,v in pairs(properties) do
		if v.name == name then
			return v
		end
	end

	return nil
end

-- Enter / Exit marker events
Citizen.CreateThread(function()

	while true do

		Citizen.Wait(1)

		local playerPed      = PlayerPedId()
		local coords         = GetEntityCoords(playerPed)
		local isInMarker     = false
		local currentGarage  = nil
		local currentPart    = nil
		local currentParking = nil
		
		for k,v in pairs(Config.Garages) do
			if v.IsClosed then

								if (not v.disabled and GetDistanceBetweenCoords(coords, v.ExteriorEntryPoint.Pos.x, v.ExteriorEntryPoint.Pos.y, v.ExteriorEntryPoint.Pos.z, true) < Config.MarkerSize.x) then
									isInMarker    = true
									currentGarage = k
									currentPart   = 'ExteriorEntryPoint'
								end

				if thisGarage == v then
								if (not v.disabled and GetDistanceBetweenCoords(coords, v.InteriorExitPoint.Pos.x, v.InteriorExitPoint.Pos.y, v.InteriorExitPoint.Pos.z, true) < Config.MarkerSize.x) then
									isInMarker    = true
									currentGarage = k
									currentPart   = 'InteriorExitPoint'
								end
						
								for i=1, #v.Parkings, 1 do

									local parking = v.Parkings[i]

									if (not v.disabled and GetDistanceBetweenCoords(coords, parking.Pos.x, parking.Pos.y, parking.Pos.z, true) < Config.ParkingMarkerSize.x) then
										isInMarker     = true
										currentGarage  = k
										currentPart    = 'Parking'
										currentParking = i
									end

								end
				end
			end

		end

		if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastGarage ~= currentGarage or LastPart ~= currentPart or LastParking ~= currentParking) ) then
			
			if LastGarage ~= currentGarage or LastPart ~= currentPart or LastParking ~= currentParking then
				TriggerEvent('esx_property:hasExitedMarker', LastGarage, LastPart, LastParking)
			end

			HasAlreadyEnteredMarker = true
			LastGarage              = currentGarage
			LastPart                = currentPart
			LastParking             = currentParking

			if currentGarage ~= nil and Config.Garages[currentGarage].NeedProperty ~= nil then
				local needPropertyName = Config.Garages[currentGarage].NeedProperty
				updateOwnedProperties()

				if propertyOwned(needPropertyName) then
					TriggerEvent('esx_garage:hasEnteredMarker', currentGarage, currentPart, currentParking)
				else
					ESX.ShowNotification(_U('need_property'))
				end


			elseif currentGarage ~= nil and Config.Garages[currentGarage].NeedJob ~= nil then
				PlayerData = ESX.GetPlayerData()

				if PlayerData.job and PlayerData.job.name == Config.Garages[currentGarage].NeedJob then
					TriggerEvent('esx_garage:hasEnteredMarker', currentGarage, currentPart, currentParking)
				else
					ESX.ShowNotification(_U('need_job'))
				end
			else
				TriggerEvent('esx_garage:hasEnteredMarker', currentGarage, currentPart, currentParking)
			end
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			
			HasAlreadyEnteredMarker = false
			
			TriggerEvent('esx_property:hasExitedMarker', LastGarage, LastPart, LastParking)
		end

	end
end)