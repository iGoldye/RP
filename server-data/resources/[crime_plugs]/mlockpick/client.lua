ESX 			    			= nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local pick_result_cb = nil
local started = false
local pick_vehicle = nil

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if started == true then
			if IsDisabledControlJustPressed( 0, 322 ) or IsDisabledControlJustPressed( 0, 177 ) then
				TriggerEvent('mlockpick:hide')
			end

			DisableAllControlActions(0)
		else
			Citizen.Wait(100)
		end
	end
end)

RegisterNetEvent('mlockpick:setLockpickCount')
AddEventHandler('mlockpick:setLockpickCount', function(count)
	SendNUIMessage({ ["name"] = "lockCount", ["count"] = count })
end)

RegisterNetEvent('mlockpick:start')
AddEventHandler('mlockpick:start', function(difficulty, pick_result_cb)
	local skills = ESX.GetPlayerData().skills
	local realDifficulty

	if skills ~= nil and skills.lockpicking ~= nil then
		realDifficulty = difficulty + 50 - 50*skills.lockpicking/100.0
	else
		realDifficulty = difficulty
	end

	ESX.TriggerServerCallback('mlockpick:haveLockpick', function(res)
		if res == true then
			TriggerEvent('sosamba_ui:hideInventoryMenu')
			Citizen.Wait(100)
			TriggerEvent("mlockpick:show", realDifficulty, pick_result_cb)
		else
			ESX.ShowNotification("У вас ~r~нет отмычки!~s~")
		end
	end)
end)


RegisterNetEvent('mlockpick:show')
AddEventHandler('mlockpick:show', function(difficulty, cb)
	pick_result_cb = cb
	SendNUIMessage({ ["name"] = "start", ["difficulty"] = difficulty })
	SetNuiFocus(true, false)
	started = true
end)

RegisterNetEvent('mlockpick:useItem')
AddEventHandler('mlockpick:useItem', function()

	local vehicle
	local coords = GetEntityCoords(PlayerPedId())

	if IsPedInAnyVehicle(PlayerPedId(), false) then
		vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
	else
		vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
	end

	if DoesEntityExist(vehicle) then
		pick_vehicle = vehicle
		local difficulty = math.random(10,30)
		TriggerEvent('mlockpick:start', difficulty, function(res)
			if res == true then

				if DoesEntityExist(pick_vehicle) then
					local plate = ESX.Math.Trim(GetVehicleNumberPlateText(pick_vehicle))
					SetVehicleDoorsLocked(pick_vehicle, 1)
					SetVehicleDoorsLockedForAllPlayers(pick_vehicle, false)
					TriggerEvent('esx_locksystem:setLock', plate, false)
					ClearPedTasksImmediately(PlayerPedId())
					ESX.ShowNotification("Транспорт разблокирован")
					TriggerServerEvent('stadus_skills:addSkill', 'lockpicking', difficulty*0.01)
				end
			end
		end)
	else
		TriggerEvent("esx_doorlock:getClosestDoor", function(doorid, door)
			if doorid ~= -1 then
		
				local difficulty = 100.0
				if door and door.difficulty then
					difficulty = door.difficulty
				end

				TriggerEvent('mlockpick:start', difficulty, function(res)
					if res == true then
						TriggerEvent("esx_doorlock:setClosestDoorState", false)
						TriggerServerEvent('stadus_skills:addSkill', 'lockpicking', difficulty*0.01)
					end
				end)
			else
				ESX.ShowNotification("Нечего взламывать!")
			end
		end)
	end
end)


RegisterNetEvent('mlockpick:hide')
AddEventHandler('mlockpick:hide', function()
	SendNUIMessage({ ["name"] = "stop" })
	SetNuiFocus(false, false)
	started = false
end)

RegisterNUICallback('fail', function(data, cb)
    TriggerServerEvent('mlockpick:fail')
    if pick_result_cb ~= nil then
	pick_result_cb(false)
    end
end)

RegisterNUICallback('success', function(data, cb)
    TriggerEvent('mlockpick:hide')
    if pick_result_cb ~= nil then
	pick_result_cb(true)
    end
end)

