local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

-- internal variables
local hasAlreadyEnteredMarker = false
local isInATMMarker = false
local menuIsShowed = false
local currentMarker = nil
local cardProp = nil
ESX = nil

Citizen.CreateThread(function()
	while true do
		if menuIsShowed then
			DisableControlAction(0, 1, true) -- LookLeftRight
			DisableControlAction(0, 2, true) -- LookUpDown
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 142, true) -- MeleeAttackAlternate
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisablePlayerFiring(PlayerPedId(), true) -- Disable weapon firing
			Citizen.Wait(0)
		else
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx_atm:closeATM')
AddEventHandler('esx_atm:closeATM', function()
	local prop_name = "prop_cs_credit_card"
	local playerPed = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(playerPed))
	local prop = CreateObject(GetHashKey(prop_name), x, y, z + 10.2, true, true, true)
	local boneIndex = GetPedBoneIndex(playerPed, 57005) -- 18905 = left hand, 57005 = right hand


	Citizen.CreateThread(function()
		ESX.Streaming.RequestAnimDict("amb@prop_human_atm@male@exit", function()
			TaskPlayAnim(PlayerPedId(), "amb@prop_human_atm@male@exit", "exit", 8.0, -8.0, -1, 0, 0, false, false, false)
			Citizen.Wait(3000)
			AttachEntityToEntity(prop, playerPed, boneIndex, 0.162, 0.038, -0.021, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
			Citizen.Wait(2000)
			DeleteObject(prop)
		end)
	end)


	SetNuiFocus(false)
	menuIsShowed = false
	SendNUIMessage({
		hideAll = true
	})
end)

RegisterNUICallback('escape', function(data, cb)
	TriggerEvent('esx_atm:closeATM')
	cb('ok')
end)

RegisterNUICallback('deposit', function(data, cb)
	TriggerServerEvent('esx_atm:deposit', data.amount)
	cb('ok')
end)

RegisterNUICallback('withdraw', function(data, cb)
	TriggerServerEvent('esx_atm:withdraw', data.amount)
	cb('ok')
end)

-- Create blips
Citizen.CreateThread(function()
	if not Config.EnableBlips then return end

	for i=1, #Config.ATMLocations, 1 do
		local blip = AddBlipForCoord(Config.ATMLocations[i].x, Config.ATMLocations[i].y, Config.ATMLocations[i].z - Config.ZDiff)
		SetBlipSprite (blip, Config.BlipSprite)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 0.9)
		SetBlipColour (blip, 2)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(_U('atm_blip'))
		EndTextCommandSetBlipName(blip)
	end
end)

-- Activate menu when player is inside marker
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local coords = GetEntityCoords(PlayerPedId())
		local canSleep = true
		isInATMMarker = false

		for k,v in pairs(Config.ATMLocations) do
			if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.0 then
				isInATMMarker, canSleep = true, false
				currentMarker = v
				break
			end
		end

		if isInATMMarker and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
			canSleep = false
		end
	
		if not isInATMMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			SetNuiFocus(false)
			menuIsShowed = false
			canSleep = false

			SendNUIMessage({
				hideAll = true
			})
		end

		if canSleep then
			Citizen.Wait(500)
		end
	end
end)

-- Menu interactions
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if isInATMMarker and not menuIsShowed then

			ESX.ShowHelpNotification(_U('press_e_atm'))

			if IsControlJustReleased(0, Keys['E']) and IsPedOnFoot(PlayerPedId()) then


				Citizen.CreateThread(function()
					local prop_name = "prop_cs_credit_card"
					local playerPed = PlayerPedId()
					local coords = GetEntityCoords(playerPed)
					local prop = CreateObject(GetHashKey(prop_name), coords.x, coords.y, coords.z + 10.2, true, true, true)
					local boneIndex = GetPedBoneIndex(playerPed, 57005) -- 18905 = left hand, 57005 = right hand
					AttachEntityToEntity(prop, playerPed, boneIndex, 0.162, 0.038, -0.021, 10.0, 175.0, 0.0, true, true, false, true, 1, true)

					ESX.Streaming.RequestAnimDict("anim@mp_atm@enter", function()
						TaskPlayAnim(playerPed, "anim@mp_atm@enter", "enter", 8.0, -8.0, -1, 2, 0, false, false, false)
						Citizen.Wait(1300)
						DeleteObject(prop)
						Citizen.Wait(2700)
						ESX.Streaming.RequestAnimDict("anim@mp_atm@base", function()
							TaskPlayAnim(playerPed, "anim@mp_atm@base", "base", 8.0, -8.0, -1, 1, 0, false, false, false)
						end)
					end)
				end)
				Citizen.Wait(4000)

				menuIsShowed = true
				ESX.TriggerServerCallback('esx:getPlayerData', function(data)
					SendNUIMessage({
						showMenu = true,
						player = {
							money = data.money,
							accounts = data.accounts
						}
					})
				end)

				SetNuiFocus(true, true)
			end

		else
			Citizen.Wait(500)
		end
	end
end)

-- close the menu when script is stopping to avoid being stuck in NUI focus
AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		if menuIsShowed then
			TriggerEvent('esx_atm:closeATM')
		end
	end
end)
