local hunger = 0
local thirst = 0
local paused = false

Citizen.CreateThread(function()
while true do

	TriggerEvent('esx_status:getStatus', 'hunger', function(status)
		if status ~= nil then
			hunger = status.val / 1000000
		end
	end)

	TriggerEvent('esx_status:getStatus', 'thirst', function(status)
		if status ~= nil then
			thirst = status.val / 1000000
		end
	end)

	SendNUIMessage({
		action  = 'setNeeds',
		hunger = hunger,
		thirst = thirst
	})

	Citizen.Wait(1000)
end
end)

Citizen.CreateThread(function()

	while true do
		local pauseMenuActive = IsPauseMenuActive()

		if pauseMenuActive ~= paused then
			paused = pauseMenuActive
			SendNUIMessage({
				action  = 'setPause',
				paused = paused
			})
		end
		Citizen.Wait(100)
	end
end)
