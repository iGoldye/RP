ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

currentRequest = nil

function drawTxt(x, y, scale, text, red, green, blue, alpha)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextScale(scale, scale)
	SetTextColour(red, green, blue, alpha)
	SetTextDropShadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()

	BeginTextCommandDisplayText("STRING")
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(x, y)
end

-- Key controls
Citizen.CreateThread(function()
	while true do

		if currentRequest ~= nil then
			drawTxt(0.35, 0.8, 0.5, string.format("~b~%s~s~ запрашивает ~y~%s~s~", currentRequest.name, currentRequest.text), 255, 255, 255, 255)
			drawTxt(0.35, 0.84, 0.5, string.format("[ ~g~Разрешить: ~w~E~s~ ] [ ~r~Отказать: ~w~X~s~ ]", name, currentRequest.text), 255, 255, 255, 255)

			if GetGameTimer()-currentRequest.timeStarted > 10000 then
				currentRequest = nil
			end

			if IsControlJustPressed(1, 73) then -- X
				TriggerServerEvent(currentRequest.trigger, currentRequest.player, false)
				currentRequest = nil
			end

			if IsControlJustPressed(1, 38) then -- E
				TriggerServerEvent(currentRequest.trigger, currentRequest.player, true)
				currentRequest = nil
			end


		end

		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx_request:request')
AddEventHandler('esx_request:request', function(player, name, text, trigger)
	print("Request received: "..tostring(player).." "..name.." "..text.." "..trigger)
	currentRequest = {}
	currentRequest.player = player
	currentRequest.name = name
	currentRequest.text = text
	currentRequest.trigger = trigger
	currentRequest.timeStarted = GetGameTimer()
end)

--Citizen.CreateThread(function()
--	Citizen.Wait(1000)
--	TriggerEvent('esx_request:request', 1, "Player", "разрешение поднять вас на руки", 'test')
--end)
