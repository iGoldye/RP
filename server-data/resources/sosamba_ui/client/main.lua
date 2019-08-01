local hunger = 0
local thirst = 0
local paused = true
local webShow = false

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
	if webShow then
		local playerPed = PlayerPedId()

		if IsControlJustPressed(1, 177) then
			TriggerEvent('sosamba_ui:toggleweb')
		end

		DisableControlAction(0, 1, true) -- LookLeftRight
		DisableControlAction(0, 2, true) -- LookUpDown
		DisablePlayerFiring(playerPed, true) -- Disable weapon firing
		DisableControlAction(0, 142, true) -- MeleeAttackAlternate
		DisableControlAction(0, 106, true) -- VehicleMouseControlOverride
	else
		if IsControlJustPressed(1, 10) then
			TriggerEvent('sosamba_ui:toggleweb')
		end
	end


	Citizen.Wait(0)
end
end)

Citizen.CreateThread(function()

	while GetIsLoadingScreenActive() do
		Citizen.Wait(1000)
	end

	while true do
		local pauseMenuActive = IsPauseMenuActive() or IsRadarHidden()

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

RegisterNetEvent('sosamba_ui:toggleweb')
AddEventHandler('sosamba_ui:toggleweb', function()
	webShow = not webShow
	if webShow then
		SetNuiFocus(true, true)
		SendNUIMessage({
			action  = 'setWebsite',
			url = 'http://127.0.0.1/dashboard/',
		})
	else
		SetNuiFocus(false)
		SendNUIMessage({
			action  = 'setWebsite',
			url = nil,
		})
	end
end)
