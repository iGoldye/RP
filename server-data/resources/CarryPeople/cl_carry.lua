ESX                     = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

local carryingBackInProgress = false
local carried = false

Citizen.CreateThread(function()

	RequestAnimDict('nm')
	RequestAnimDict('missfinale_c2mcs_1')

	while not HasAnimDictLoaded('nm') do
		Citizen.Wait(100)
	end

	while not HasAnimDictLoaded('missfinale_c2mcs_1') do
		Citizen.Wait(100)
	end

	while true do
		Citizen.Wait(100)
		if carried == true then
			if not IsEntityPlayingAnim(PlayerPedId(), 'nm', 'firemans_carry', 3) then
				TaskPlayAnim(PlayerPedId(), 'nm', 'firemans_carry', 8.0, -8.0, -1, 33, 0, false, false, false)
			end
		elseif carryingBackInProgress then
			if not IsEntityPlayingAnim(PlayerPedId(), 'missfinale_c2mcs_1', 'fin_c2_mcs_1_camman', 3) then
				TaskPlayAnim(PlayerPedId(), 'missfinale_c2mcs_1', 'fin_c2_mcs_1_camman', 8.0, -8.0, -1, 49, 0, false, false, false)
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if (carried or carryingBackInProgress) and IsControlJustPressed(0, 73) then -- X
                	StopCarry()
		end
	end
end)

function StopCarry()
	if carried then
		local me = GetPlayerServerId(PlayerId())
		TriggerServerEvent("cmg2_animations:stop", me)
	elseif carryingBackInProgress then
		carryingBackInProgress = false
		ClearPedSecondaryTask(GetPlayerPed(-1))
		DetachEntity(GetPlayerPed(-1), true, false)
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		if closestPlayer > 0 and closestDistance < 3.0 then
			target = GetPlayerServerId(closestPlayer)
			TriggerServerEvent("cmg2_animations:stop",target)
		end
	end
end

function Carry()
	print("carrying")
	if not carryingBackInProgress then
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

		if closestPlayer > 0 and closestDistance < 3.0 then
			target = GetPlayerServerId(closestPlayer)

			ESX.TriggerServerCallback('esx_request:request', function(res)
				if res == true then
					carryingBackInProgress = true
					lib = 'missfinale_c2mcs_1'
					print("triggering cmg2_animations:sync")
					TriggerServerEvent('cmg2_animations:sync', target)
				end
			end, target, "разрешение поднять вас")
		else
			ESX.ShowNotification('Рядом никого нет')
		end
	else
		StopCarry()
	end
end

-- RegisterCommand("carry",function(source, args)
--	Carry()
-- end,false)

RegisterNetEvent('cmg2_animations:syncTarget')
AddEventHandler('cmg2_animations:syncTarget', function(target)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
	carryingBackInProgress = true
	print("triggered cmg2_animations:syncTarget")

	local distance = 0.15
	local distance2 = 0.27
	local height = 0.63
	local spin = 0.0

	AttachEntityToEntity(PlayerPedId(), targetPed, 0, distance2, distance, height, 0.5, 0.5, spin, false, false, false, false, 2, false)
	TaskPlayAnim(PlayerPedId(), 'nm', 'firemans_carry', 8.0, -8.0, -1, 33, 0, false, false, false)
	carried = true
end)

RegisterNetEvent('cmg2_animations:syncMe')
AddEventHandler('cmg2_animations:syncMe', function()
	print("triggered cmg2_animations:syncMe")
	Wait(500)
	TaskPlayAnim(PlayerPedId(), 'missfinale_c2mcs_1', 'fin_c2_mcs_1_camman', 8.0, -8.0, -1, 49, 0, false, false, false)
end)

RegisterNetEvent('cmg2_animations:cl_stop')
AddEventHandler('cmg2_animations:cl_stop', function()
	carryingBackInProgress = false
	carried = false
	ClearPedSecondaryTask(GetPlayerPed(-1))
	DetachEntity(GetPlayerPed(-1), true, false)
end)

AddEventHandler('CarryPeople:carry', function()
	if carried == true then
		StopCarry()
	else
		Carry()
	end
end)
