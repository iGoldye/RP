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

function convertNotificationMessage(msg)
	local function count(base, pattern)
	    return select(2, string.gsub(base, pattern, ""))
	end

	local function convert_color_to_html(str, from ,to, endtag)
		local result = str
		result = result:gsub(from, to)
		for i=1,count(str,from) do
			result = result .. endtag
		end
		return result
	end

	local str = msg;
	str = str:gsub("&", "&amp;")
	str = str:gsub("<", "&lt;")
	str = str:gsub(">", "&gt;")
	str = str:gsub("\"", "&quot;")
	str = str:gsub("~n~","<br>")
	str = convert_color_to_html(str, "~r~", "<span class='notify-red'>", "</span>")
	str = convert_color_to_html(str, "~b~", "<span class='notify-blue'>", "</span>")
	str = convert_color_to_html(str, "~g~", "<span class='notify-green'>", "</span>")
	str = convert_color_to_html(str, "~y~", "<span class='notify-yellow'>", "</span>")
	str = convert_color_to_html(str, "~p~", "<span class='notify-purple'>", "</span>")
	str = convert_color_to_html(str, "~o~", "<span class='notify-orange'>", "</span>")
	str = convert_color_to_html(str, "~c~", "<span class='notify-gray'>", "</span>")
	str = convert_color_to_html(str, "~m~", "<span class='notify-darkgray'>", "</span>")
	str = convert_color_to_html(str, "~u~", "<span class='notify-black'>", "</span>")
	str = convert_color_to_html(str, "~w~", "<span class='notify-white'>", "</span>")
	str = convert_color_to_html(str, "~s~", "<span class='notify-default'>", "</span>")
	str = convert_color_to_html(str, "~h~", "<span class='notify-bold'>", "</span>")

	return str
end

RegisterNetEvent('sosamba_ui:showNotification')
AddEventHandler('sosamba_ui:showNotification', function(args)

	SendNUIMessage({
		action  = 'showNotification',
		text = convertNotificationMessage(args.text),
	})
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
