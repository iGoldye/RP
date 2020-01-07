ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local menuIsShowed = false
local societyName = "mechanic"

RegisterNetEvent('esx_bossmenu:show')
AddEventHandler('esx_bossmenu:show', function(society, options)
	societyName = society
	menuIsShowed = true
	showMenu(options)
	SetNuiFocus(true, true)
end)

function showMenu(options)
	ESX.TriggerServerCallback('esx:getPlayerData', function(plData)
	ESX.TriggerServerCallback('esx_society:getJob', function(job)
	ESX.TriggerServerCallback('esx_society:getEmployees', function(employees)
	ESX.TriggerServerCallback('esx_bossmenu:getMoneyWashAmount', function(wash_money)
	ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
		local black = 0
		for k,v in pairs(plData.accounts) do
			if v.name == "black_money" then
				black = v.money
				break
			end
		end

		SendNUIMessage({
			showMenu = true,
			options = options,
			society = {
				job = job,
				money = money,
				employees = employees,
				wash_money = wash_money,
			},
			player = {
				money = plData.money,
				black_money = black,
			},
		})
	end, societyName)
	end, societyName)
	end, societyName)
	end, societyName)
	end)
end

RegisterNetEvent('esx_bossmenu:moneyChange')
AddEventHandler('esx_bossmenu:moneyChange', function()
	if menuIsShowed then
		showMenu()
	end
end)


Citizen.CreateThread(function()
	while true do
		if menuIsShowed then
			BlockWeaponWheelThisFrame()
			DisableControlAction(0, 1, true) -- LookLeftRight
			DisableControlAction(0, 2, true) -- LookUpDown
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 142, true) -- MeleeAttackAlternate
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, 322, true) -- ESC
			DisablePlayerFiring(PlayerPedId(), true) -- Disable weapon firing
			Citizen.Wait(0)
		else
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent('esx_bossmenu:closeMenu')
AddEventHandler('esx_bossmenu:closeMenu', function()
	SetNuiFocus(false)
	menuIsShowed = false
	SendNUIMessage({ hideAll = true })
end)

RegisterNUICallback('escape', function(data, cb)
	TriggerEvent('esx_bossmenu:closeMenu')
	cb('ok')
end)

RegisterNUICallback('setGrade', function(data, cb)
	local newJob = societyName
	local newGrade = data.grade
	local desc = 'promote'

	if data.grade < 0 then
		newJob = 'unemployed'
		newGrade = 0
		desc = 'fire'
	end

	ESX.TriggerServerCallback('esx_society:setJob', function()
		TriggerEvent('esx:showNotification', "Должность установлена!")
	end, data.identifier, newJob, tostring(newGrade), desc)
end)

RegisterNUICallback('setSalary', function(data, cb)
	ESX.TriggerServerCallback('esx_society:setJobSalary', function()
		cb('ok')
		showMenu()
		TriggerEvent('esx:showNotification', "Зарплата установлена!")
	end, societyName, data.grade, data.amount)
end)

RegisterNUICallback('wash', function(data, cb)
	TriggerServerEvent('esx_society:washMoney', societyName, data.amount)
	cb('ok')
	Citizen.Wait(1000)
	showMenu()
end)


RegisterNUICallback('deposit', function(data, cb)
	TriggerServerEvent('esx_society:depositMoney', societyName, data.amount)
	cb('ok')
	Citizen.Wait(1000)
	showMenu()
end)

RegisterNUICallback('withdraw', function(data, cb)
	TriggerServerEvent('esx_society:withdrawMoney', societyName, data.amount)
	cb('ok')
	Citizen.Wait(1000)
	showMenu()
end)

RegisterNUICallback('hire', function(data, cb)
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

	if closestPlayer == -1 or closestDistance > 5 then
		TriggerEvent('esx:showNotification', "Нет никого рядом!")
		return
	end

	TriggerServerEvent('esx_bossmenu:hire', societyName, GetPlayerServerId(closestPlayer))
	cb('ok')
	Citizen.Wait(1000)
	showMenu()
end)

