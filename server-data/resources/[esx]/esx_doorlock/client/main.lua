ESX = nil
closestDoor = -1

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()

	-- Update the door list
	ESX.TriggerServerCallback('esx_doorlock:getDoorInfo', function(doorInfo)
		for doorID,state in pairs(doorInfo) do
			Config.DoorList[doorID].locked = state
		end
	end)

	for _,door in ipairs(Config.DoorList) do
		if door.ajar ~= nil then
			Citizen.InvokeNative(0x6F8838D03D1DC226, door.ajar, GetHashKey(door.objName), door.objCoords.x, door.objCoords.y, door.objCoords.z, 0,0,0)
		end
	end

--	local doorExists = Citizen.InvokeNative(0xC153C43EA202C8C1, 1206354175)
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

-- Get objects every second, instead of every frame
Citizen.CreateThread(function()
	while true do
		local playerCoords = GetEntityCoords(PlayerPedId())
		local distance

		for _,doorID in ipairs(Config.DoorList) do
			if doorID.doors then
				distance = #(playerCoords - doorID.doors[1].objCoords)
				if distance < 100 then
					for k,v in ipairs(doorID.doors) do
						if not v.object or not DoesEntityExist(v.object) then
							v.object = GetClosestObjectOfType(v.objCoords, 1.0, GetHashKey(v.objName), false, false, false)
						end
					end
				end
			else
				distance = #(playerCoords - doorID.objCoords)
				if distance < 100 then
					if not doorID.object or not DoesEntityExist(doorID.object) then
						doorID.object = GetClosestObjectOfType(doorID.objCoords, 1.0, GetHashKey(doorID.objName), false, false, false)
					end
				end
			end
		end

		Citizen.Wait(1000)
	end
end)

function processDoor(door, locked)
	SetDoorAjarAngle(1206354175, -1.0, 0, 1)
	if door.ajar ~= nil then
		if door.locked then
			SetDoorAjarAngle(door.ajar, -1.0, 0,1)
		else
			SetDoorAjarAngle(door.ajar, 0.0, 0,1)
		end
--[[
	elseif door.forceCoords ~= nil and locked then
		SetEntityCoordsNoOffset(door.object, door.forceCoords.x,door.forceCoords.y,door.forceCoords.z, 0, 0, 0)
		SetEntityRotation(door.object, door.forceRot.x,door.forceRot.y,door.forceRot.z)
		FreezeEntityPosition(door.object, true)
		SetDoorAjarAngle(1206354175, 0.0, 0,0)
]]--
	else
		FreezeEntityPosition(door.object, locked)

		if locked and door.objYaw and GetEntityRotation(door.object).z ~= door.objYaw then
			SetEntityRotation(door.object, 0.0, 0.0, door.objYaw, 2, true)
		end
	end

	return door
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerCoords = GetEntityCoords(PlayerPedId())
		closestDoor = -1

		for k,doorID in ipairs(Config.DoorList) do
			local distance

			if doorID.doors then
				distance = #(playerCoords - doorID.doors[1].objCoords)
			else
				distance = #(playerCoords - doorID.objCoords)
			end

			if distance < 50 then
				if doorID.doors then
					for kk,v in ipairs(doorID.doors) do
						doorID.doors[kk] = processDoor(v, doorID.locked)
					end
				else
					Config.DoorList[k] = processDoor(doorID, doorID.locked)
				end
			end

			local maxDistance = 1.25

			if doorID.distance then
				maxDistance = doorID.distance
			end

			if distance < maxDistance then
				local isAuthorized = IsAuthorized(doorID)
				local displayText = _U('unlocked')
				local size = 0.5

				if doorID.size then
					size = doorID.size
				end

				if doorID.locked then
					displayText = _U('locked')
				end

				if isAuthorized then
					displayText = _U('press_button', displayText)
				end

				ESX.Game.Utils.DrawText3D(doorID.textCoords, displayText, size)
				closestDoor = k

				if IsControlJustReleased(0, 38) then
					if isAuthorized then
						doorID.locked = not doorID.locked

						TriggerServerEvent('esx_doorlock:updateState', k, doorID.locked) -- Broadcast new state of the door to everyone
					end
				end
			end
		end
	end
end)

function IsAuthorized(doorID)
	if ESX.PlayerData.job == nil then
		return false
	end

	for _,job in pairs(doorID.authorizedJobs) do
		if job == ESX.PlayerData.job.name then
			return true
		end
	end

	return false
end

-- Set state for a door
RegisterNetEvent('esx_doorlock:setState')
AddEventHandler('esx_doorlock:setState', function(doorID, state)
	Config.DoorList[doorID].locked = state
end)


RegisterNetEvent('esx_doorlock:getClosestDoor')
AddEventHandler('esx_doorlock:getClosestDoor', function(cb)
	local doorInfo = nil
	if closestDoor ~= -1 then
		doorInfo = Config.DoorList[closestDoor]
	end
	cb(closestDoor, doorInfo)
end)

RegisterNetEvent('esx_doorlock:setClosestDoorState')
AddEventHandler('esx_doorlock:setClosestDoorState', function(state)
	if closestDoor ~= -1 then
		TriggerServerEvent('esx_doorlock:updateState', closestDoor, state)
	end
end)
