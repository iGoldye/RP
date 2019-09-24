ESX                     = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

local carryingBackInProgress = false

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
					anim1 = 'fin_c2_mcs_1_camman'
					lib2 = 'nm'
					anim2 = 'firemans_carry'
					distance = 0.15
					distance2 = 0.27
					height = 0.63
					spin = 0.0
					length = 100000
					controlFlagMe = 49
					controlFlagTarget = 33
					animFlagTarget = 1
					print("triggering cmg2_animations:sync")
					TriggerServerEvent('cmg2_animations:sync', closestPlayer, lib,lib2, anim1, anim2, distance, distance2, height,target,length,spin,controlFlagMe,controlFlagTarget,animFlagTarget)
				end
			end, target, "разрешение поднять вас")
		else
			ESX.ShowNotification('Рядом никого нет')
		end
	else
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

-- RegisterCommand("carry",function(source, args)
--	Carry()
-- end,false)

RegisterNetEvent('cmg2_animations:syncTarget')
AddEventHandler('cmg2_animations:syncTarget', function(target, animationLib, animation2, distance, distance2, height, length,spin,controlFlag)
	local playerPed = GetPlayerPed(-1)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
	carryingBackInProgress = true
	print("triggered cmg2_animations:syncTarget")
	RequestAnimDict(animationLib)

	while not HasAnimDictLoaded(animationLib) do
		Citizen.Wait(10)
	end
	if spin == nil then spin = 180.0 end
	AttachEntityToEntity(GetPlayerPed(-1), targetPed, 0, distance2, distance, height, 0.5, 0.5, spin, false, false, false, false, 2, false)
	if controlFlag == nil then controlFlag = 0 end
	TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
end)

RegisterNetEvent('cmg2_animations:syncMe')
AddEventHandler('cmg2_animations:syncMe', function(animationLib, animation,length,controlFlag,animFlag)
	local playerPed = GetPlayerPed(-1)
	print("triggered cmg2_animations:syncMe")
	RequestAnimDict(animationLib)

	while not HasAnimDictLoaded(animationLib) do
		Citizen.Wait(10)
	end
	Wait(500)
	if controlFlag == nil then controlFlag = 0 end
	TaskPlayAnim(playerPed, animationLib, animation, 8.0, -8.0, length, controlFlag, 0, false, false, false)

	Citizen.Wait(length)
end)

RegisterNetEvent('cmg2_animations:cl_stop')
AddEventHandler('cmg2_animations:cl_stop', function()
	carryingBackInProgress = false
	ClearPedSecondaryTask(GetPlayerPed(-1))
	DetachEntity(GetPlayerPed(-1), true, false)
end)

AddEventHandler('CarryPeople:carry', function()
	Carry()
end)
