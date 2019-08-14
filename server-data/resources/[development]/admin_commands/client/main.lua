function loadAnimDict(dict)
	RequestAnimDict(dict)

	for i=1,100 do
		if HasAnimDictLoaded(dict) then
			break
		end

		Citizen.Wait(0)
	end
end

RegisterNetEvent('admin_commands:emote')
AddEventHandler('admin_commands:emote', function(args)
	if #args < 2 then
		return
	end

	local dict = args[1]
	local anim = args[2]

	loadAnimDict(dict)
	TaskPlayAnim(PlayerPedId(), dict, anim, 3.0, -1, -1, flag, 0, false, false, false)
	
end)

RegisterNetEvent('admin_commands:repair')
AddEventHandler('admin_commands:repair', function(args)

	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then

		local vehicle

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		SetVehicleFixed(vehicle)
		SetVehicleDeformationFixed(vehicle)
		SetVehicleUndriveable(vehicle, false)
		SetVehicleEngineOn(vehicle, true, true)
	else
		TriggerEvent('chat:addMessage', { args = { '^1SYSTEM', 'Рядом нет транспорта.' } })
	end

end)
