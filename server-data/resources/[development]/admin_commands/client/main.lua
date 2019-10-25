ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local function _ch(hash)
	if type(hash) == 'string' then
		return GetHashKey(hash)
	end

	return hash
end

function loadAnimDict(dict)
	RequestAnimDict(dict)

	for i=1,100 do
		if HasAnimDictLoaded(dict) then
			break
		end

		Citizen.Wait(0)
	end
end

RegisterNetEvent('admin_commands:guitar')
AddEventHandler('admin_commands:guitar', function(args)
-- AMP: spawnobject v_res_fh_guitaramp
	local gtrModel = "prop_el_guitar_03"
	local x = -0.1
	local y = -0.2
	local z = 0.06
	local xR = 300.0
	local yR = 70.0
	local zR = -20.0


	if #args > 0 then
		local num = tostring(args[1])
		gtrModel = "prop_el_guitar_0"..num
		if num == "4" then
			gtrModel = "prop_acc_guitar_01"
			x = -0.12
			xR = 304.0
		end
	end

	local animDict = 'amb@world_human_musician@guitar@male@idle_a'
	local animName = 'idle_b' -- idle_a, idle_c

	loadAnimDict(animDict)
	RequestModel(gtrModel)
	while not HasModelLoaded(gtrModel) do
		Citizen.Wait(1)
	end

	local flag = 49
        TaskPlayAnim(PlayerPedId(), animDict, animName, 8.0, 8.0, -1, flag, 1.0, false, false, false);
	Citizen.Wait(50)

        local attachedPropGtr = CreateObject(GetHashKey(gtrModel), 1.0, 1.0, 1.0, true, false, true);
	local bone = GetPedBoneIndex(PlayerPedId(), 18905)--28422)

	Citizen.Wait(100)

        AttachEntityToEntity(attachedPropGtr, PlayerPedId(), bone, x, y, z, xR, yR, zR, true, true, false, true, 1, true);
        while IsEntityPlayingAnim(PlayerPedId(), animDict, animName, 3) do
		Citizen.Wait(0)
	end

        DeleteObject(attachedPropGtr)
end)

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

RegisterNetEvent('admin_commands:scenario')
AddEventHandler('admin_commands:scenario', function(args)
	if #args < 1 then
		return
	end

	local anim = args[1]
	TaskStartScenarioInPlace(PlayerPedId(), anim, 5000, true)
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

function setModel(model)
		local characterModel = _ch(model)

		RequestModel(characterModel)
		for i=1,10 do
			if HasModelLoaded(characterModel) then
				break
			end
			Citizen.Wait(100)
		end

		if not HasModelLoaded(characterModel) then
			TriggerEvent('chat:addMessage', { args = { '^1SYSTEM', 'Невозможно загрузить модель.' } })
			return
		end

		if IsModelInCdimage(characterModel) and IsModelValid(characterModel) then
			SetPlayerModel(PlayerId(), characterModel)
			SetPedDefaultComponentVariation(PlayerPedId())
		end

		SetModelAsNoLongerNeeded(characterModel)
end

RegisterNetEvent('admin_commands:setmodel')
AddEventHandler('admin_commands:setmodel', function(model)

		if model == "skin" then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				if skin['sex'] == 0 then
					setModel('mp_m_freemode_01')
				else
					setModel('mp_f_freemode_01')
				end

				TriggerEvent('skinchanger:loadSkin', skin)
			end)
		else
			setModel(model)
		end
end)

RegisterNetEvent('admin_commands:spawncar')
AddEventHandler('admin_commands:spawncar', function(props)
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	ESX.Game.SpawnVehicle(props.model, coords, 90.0, function(vehicle)
		ESX.Game.SetVehicleProperties(vehicle, props)
		TaskWarpPedIntoVehicle(playerPed,  vehicle, -1)
	end)
end)
