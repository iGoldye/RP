local IsAlreadyDrunk = false
local DrunkLevel     = -1

function Drunk(level, start)
	Citizen.CreateThread(function()
		local playerPed = GetPlayerPed(-1)

		if start then
			DoScreenFadeOut(800)
			Wait(1000)
		end

		local levels = {
			[0] = "move_m@drunk@slightlydrunk",
			[1] = "move_m@drunk@moderatedrunk",
			[2] = "move_m@drunk@verydrunk",
		}

		if levels[level] ~= nil then
			RequestAnimSet(levels[level])
			while not HasAnimSetLoaded(levels[level]) do
				Citizen.Wait(0)
			end
			SetPedMovementClipset(playerPed, levels[level], true)
		end

		SetTimecycleModifier("spectator5")
		SetPedMotionBlur(playerPed, true)
		SetPedIsDrunk(playerPed, true)

		if start then
			DoScreenFadeIn(800)
		end
	end)
end

function Reality()
	Citizen.CreateThread(function()
		local playerPed = GetPlayerPed(-1)

		DoScreenFadeOut(800)
		Wait(1000)

		ClearTimecycleModifier()
		ResetScenarioTypesEnabled()
		ResetPedMovementClipset(playerPed, 0)
		SetPedIsDrunk(playerPed, false)
		SetPedMotionBlur(playerPed, false)

		DoScreenFadeIn(800)
	end)
end

AddEventHandler('esx_status:loaded', function(status)

	TriggerEvent('esx_status:registerStatus', 'drunk', 0, '#8F15A5',  function(status)
		return status.val > 0
	end, function(status)
		status.remove(1500)
	end)

	Citizen.CreateThread(function()
		while true do
			Wait(1000)
			TriggerEvent('esx_status:getStatus', 'drunk', function(status)
				if status.val > 0 then
					local level = 0

					if status.val <= 250000 then
						level = 0
					elseif status.val <= 500000 then
						level = 1
					else
						level = 2
					end

					if level ~= DrunkLevel then
						Drunk(level, not IsAlreadyDrunk)
					end

					IsAlreadyDrunk = true
					DrunkLevel     = level

				elseif status.val == 0 then
					if IsAlreadyDrunk then
						Reality()
					end

					IsAlreadyDrunk = false
					DrunkLevel     = -1
				end
			end)
		end
	end)

end)

RegisterNetEvent('esx_optionalneeds:onDrink')
AddEventHandler('esx_optionalneeds:onDrink', function()
	local playerPed = GetPlayerPed(-1)
	TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_DRINKING", 0, 1)
	Citizen.Wait(1000)
	ClearPedTasksImmediately(playerPed)
end)
