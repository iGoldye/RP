Keys = {
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

ESX = nil
isAdmin = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
			if IsControlJustPressed(0, Keys['~']) then
				OpenMenu()
			end
	end
end)

RegisterNetEvent('esx_playermenu:setAdmin')
AddEventHandler('esx_playermenu:setAdmin', function(val)
	isAdmin = val
end)

function OpenTextInput(title, defaultText, maxInputLength)

	if title == nil then
		title = "FMMC_KEY_TIP8"
	else
		AddTextEntry('FT_TEXT', title)
		title = "FT_TEXT"
        end

	DisplayOnscreenKeyboard(true, title, "", defaultText, "", "", "", maxInputLength)

	while UpdateOnscreenKeyboard() == 0 do
		DisableAllControlActions(0)
		Citizen.Wait(10)
	end

	local result = GetOnscreenKeyboardResult()
	if result then
		return result
	else
		return nil
	end

end


function OpenAdminMenu()
	local elements = {}

	table.insert(elements, {label = 'Игроки', value = 'players'})
	table.insert(elements, {label = 'Транспорт', value = 'transport'})

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'admin_menu', {
		title    = "Администрирование",
		align    = 'top-right',
		elements = elements
	}, function(data, menu)
		local cmd = data.current.value
		menu.close()

		if cmd == "players" then
			OpenAdminMenuPlayers()
		end


		if cmd == "transport" then
			OpenAdminMenuVehicle()
		end

	end, function(data, menu)
		menu.close()
	end)
end

function OpenAdminMenuPlayers()

	ESX.TriggerServerCallback('esx_playermenu:adminGetPlayers', function(players)
		local elements = {}
		for k,v in pairs(players) do
			local name = tostring(v.id)..". "..v.name
			print(json.encode(v))
			if v.identity ~= nil then
				name = name .." &lt; ".. v.identity.firstname .. " " .. v.identity.lastname .." &gt;"
			end

			table.insert(elements, {label = name, value = v})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'admin_menu_players', {
			title    = "Администрирование: Игроки",
			align    = 'top-right',
			elements = elements
		}, function(data, menu)
			local cmd = data.current.value
			menu.close()

			OpenAdminMenuPlayer(cmd)

		end, function(data, menu)
			menu.close()
		end)
	end)
end

function OpenAdminMenuPlayer(player)
		local elements = {}
		table.insert(elements, {label = "Наличка: $"..tostring(player.money), value = "cash"})
		table.insert(elements, {label = "Банк: $"..tostring(player.bank), value = "bank"})
		table.insert(elements, {label = "Грязные деньги: $"..tostring(player.black_money), value = "black_money"})

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'admin_menu_player', {
			title    = "Администрирование: Игроки",
			align    = 'top-right',
			elements = elements
		}, function(data, menu)
			local cmd = data.current.value
			menu.close()
			if cmd == "cash" then
				OpenAdminMenuPlayerMoney(player, "cash")
			elseif cmd == "bank" then
				OpenAdminMenuPlayerMoney(player, "bank")
			elseif cmd == "black_money" then
				OpenAdminMenuPlayerMoney(player, "black")
			end

		end, function(data, menu)
			menu.close()
		end)
end

function OpenAdminMenuPlayerMoney(player, moneytype)
		local elements = {}
		table.insert(elements, {label = "Добавить", value = "add"})
		table.insert(elements, {label = "Установить", value = "set"})
		table.insert(elements, {label = "Забрать", value = "remove"})

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'admin_menu_player', {
			title    = "Администрирование: Деньги игрока",
			align    = 'top-right',
			elements = elements
		}, function(data, menu)
			local cmd = data.current.value
			menu.close()

			local amount = OpenTextInput("Введите количество денег", "", 60)
			if tonumber(amount) ~= nil then
				ESX.TriggerServerCallback('esx_playermenu:adminMoney', function(res) end, player.identifier, moneytype, cmd, tonumber(amount))
			end

		end, function(data, menu)
			menu.close()
		end)
end


function OpenAdminMenuVehicle()
	local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
	local plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))
	if vehicle == 0 then
		return
	end

	local elements = {}
	table.insert(elements, {label = 'Починить', value = 'repair'})
	table.insert(elements, {label = 'Установить количество горючего', value = 'setfuel'})

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'admin_menu_vehicle', {
		title    = "Администрирование: Транспорт",
		align    = 'top-right',
		elements = elements
	}, function(data, menu)
		local cmd = data.current.value
		menu.close()

		if cmd == "repair" then
			SetVehicleFixed(vehicle)
			SetVehicleDeformationFixed(vehicle)
			SetVehicleUndriveable(vehicle, false)
			SetVehicleEngineOn(vehicle, true, true)
		elseif cmd == "setfuel" then
			local amount = OpenTextInput("Введите количество горючего", "", 6)
			if tonumber(amount) ~= nil then
				amount = tonumber(amount)*1.0
				TriggerServerEvent('legacyfuel:setFuel', plate, amount)
				SetVehicleFuelLevel(vehicle, amount)
			end
		end

	end, function(data, menu)
		menu.close()
	end)
end


function OpenVehicleMenu()
	local vehicle  = GetVehiclePedIsIn(PlayerPedId(), false)
	if vehicle == 0 then
		return
	end

	local elements = {}

	if IsVehicleEngineOn(vehicle) then
		table.insert(elements, {label = 'Заглушить двигатель', value = 'engine-off'})
	else
		table.insert(elements, {label = 'Завести двигатель', value = 'engine-on'})
	end

	table.insert(elements, {label = 'Опустить стёкла', value = 'rolldown-windows'})
	table.insert(elements, {label = 'Поднять стёкла', value = 'rollup-windows'})

	table.insert(elements, {label = 'Открыть капот', value = 'hood-open'})
	table.insert(elements, {label = 'Закрыть капот', value = 'hood-shut'})

	table.insert(elements, {label = 'Открыть багажник', value = 'trunk-open'})
	table.insert(elements, {label = 'Закрыть багажник', value = 'trunk-shut'})

	table.insert(elements, {label = 'Открыть все двери', value = 'doors-open'})
	table.insert(elements, {label = 'Закрыть все двери', value = 'doors-shut'})

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_menu', {
		title    = "Транспорт",
		align    = 'top-right',
		elements = elements
	}, function(data, menu)
		local cmd = data.current.value

		if cmd == 'rolldown-windows' then
			RollDownWindows(vehicle)
		end

		if cmd == 'rollup-windows' then
			for i=0,4 do
				RollUpWindow(vehicle, i)
			end
		end

		if cmd == 'engine-on' then
			SetVehicleEngineOn(vehicle, true, false, true)
		end

		if cmd == 'engine-off' then
			SetVehicleEngineOn(vehicle, false, false, true)
		end

		if cmd == 'hood-open' then
			SetVehicleDoorOpen(vehicle, 4, false, false)
		end

		if cmd == 'hood-shut' then
			SetVehicleDoorShut(vehicle, 4, false, false)
		end

		if cmd == 'trunk-open' then
			SetVehicleDoorOpen(vehicle, 5, false, false)
		end

		if cmd == 'trunk-shut' then
			SetVehicleDoorShut(vehicle, 5, false, false)
		end

		if cmd == 'doors-open' then
			for i=0,10 do --GetNumberOfVehicleDoors(vehicle)
				SetVehicleDoorOpen(vehicle, i, false, false)
			end
		end

		if cmd == 'doors-shut' then
			for i=0,10 do
				SetVehicleDoorShut(vehicle, i, false, false)
			end
		end

		menu.close()

	end, function(data, menu)
		menu.close()
	end)
end

function OpenReporterMenu()
	local elements = {}

	table.insert(elements, {label = 'Достать/спрятать камеру', value = 'cam'})
	table.insert(elements, {label = 'Достать/спрятать микрофон', value = 'mic'})
	table.insert(elements, {label = 'Достать/спрятать микрофон-удочку', value = 'bmic'})

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'reporter_menu', {
		title    = "Журналист",
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		local cmd = data.current.value
		local player, distance = ESX.Game.GetClosestPlayer()

		if cmd == 'cam' then
			TriggerEvent("Cam:ToggleCam")
		elseif cmd == 'bmic' then
			TriggerEvent("Mic:ToggleBMic")
		elseif cmd == 'mic' then
			TriggerEvent("Mic:ToggleMic")
		end

		menu.close()

	end, function(data, menu)
		menu.close()
	end)

end

function OpenPersonalMenu()
	local elements = {}

	table.insert(elements, {label = 'Посмотреть паспорт', value = 'lookpass'})
	table.insert(elements, {label = 'Посмотреть вод.права', value = 'lookdrivelic'})
	table.insert(elements, {label = 'Посмотреть лиц. на оружие', value = 'lookgunlic'})
	table.insert(elements, {label = 'Показать паспорт', value = 'showpass'})
	table.insert(elements, {label = 'Показать вод.права', value = 'showdrivelic'})
	table.insert(elements, {label = 'Показать лиц. на оружие', value = 'showgunlic'})

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'personal_menu', {
		title    = "Персональная информация",
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		local cmd = data.current.value
		local player, distance = ESX.Game.GetClosestPlayer()

		if cmd == 'lookpass' then
			TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
		elseif cmd == 'lookdrivelic' then
			TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')
		elseif cmd == 'lookgunlic' then
			TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'weapon')
		elseif cmd == 'showpass' then
			if distance ~= -1 and distance <= 3.0 then
				TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player))
			else
				ESX.ShowNotification('Некому показать :(')
			end
		elseif cmd == 'showdrivelic' then
			if distance ~= -1 and distance <= 3.0 then
				TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'driver')
			else
				ESX.ShowNotification('Некому показать :(')
			end
		elseif cmd == 'showgunlic' then
			if distance ~= -1 and distance <= 3.0 then
				TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'weapon')
			else
				ESX.ShowNotification('Некому показать :(')
			end
		end

		menu.close()

	end, function(data, menu)
		menu.close()
	end)
end

function OpenMenu()
	elements = {
		{label = "Инвентарь", value = 'inventory'},
		{label = "Анимации", value = 'animations'},
		{label = "Персональная информация", value = 'personal'},
		{label = "Счета", value = 'billing'},
		{label = "Поднять игрока", value = 'liftup'},
		{label = "Аксессуары", value = 'accessories'},
		{label = "Одежда", value = 'clothesoff'},
		{label = "Питомцы", value = 'pets'},
		{label = "Документация", value = 'documents'},
	}
	local PlayerData = ESX.GetPlayerData()
	if PlayerData.job then
		if PlayerData.job.name == 'police' then
			table.insert(elements, {label = "Действия полиции", value = 'police-actions'})
		elseif PlayerData.job.name == 'ambulance' then
			table.insert(elements, {label = "Действия доктора", value = 'ambulance-actions'})
		elseif PlayerData.job.name == 'mechanic' then
			table.insert(elements, {label = "Действия механика", value = 'mechanic-actions'})
		elseif PlayerData.job.name == 'mechanic-bennys' then
			table.insert(elements, {label = "Действия механика Benny's", value = 'mechanic-bennys-actions'})
		elseif PlayerData.job.name == 'nightclub' then
			table.insert(elements, {label = "Действия ночного клуба", value = 'nightclub-actions'})
		elseif PlayerData.job.name == 'taxi' then
			table.insert(elements, {label = "Действия такси", value = 'taxi-actions'})
		elseif PlayerData.job.name == 'unicorn' then
			table.insert(elements, {label = "Действия клуба Единорог", value = 'unicorn-actions'})
		elseif PlayerData.job.name == 'reporter' then
			table.insert(elements, {label = "Действия журналиста", value = 'reporter-actions'})
		end
	end

	if IsPedSittingInAnyVehicle(PlayerPedId()) then
		table.insert(elements, {label = "Транспорт", value = 'vehicle'})
	end

	if isAdmin == true then
		table.insert(elements, {label = "Действия администрации", value = 'admin-actions'})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'global-menu',
	{
		title = "Меню игрока",
		align = 'top-left',
		elements = elements,

	}, function(data, menu)
		menu.close()
		local cmd = data.current.value

		if cmd == 'inventory' then
--			ESX.ShowInventory()
--			TriggerServerEvent('esx_inventory:getInventory', "pocket", false, 'esx_inventory:showInventoryMenu')
			ESX.TriggerServerCallback('esx_inventory:getInventory', function(inventory)
				TriggerEvent('sosamba_ui:showInventoryMenu', inventory)
			end, "pocket", false)

		elseif cmd == 'animations' then
			TriggerEvent('esx_animations:openAnimationsMenu')
		elseif cmd == 'billing' then
			TriggerEvent('esx_billing:showBillsMenu')
		elseif cmd == 'liftup' then
			TriggerEvent('esx_barbie_lyftupp:liftUp')
		elseif cmd == 'accessories' then
			TriggerEvent('esx_accessories:openAccessoryMenu')
		elseif cmd == 'clothesoff' then
			TriggerEvent('clothesoff:openActionMenuInteraction')
		elseif cmd == 'pets' then
			TriggerEvent('eden_animal:openPetMenu')
		elseif cmd == 'vehicle' then
			OpenVehicleMenu()
		elseif cmd == 'police-actions' then
			TriggerEvent('esx_policejob:openPoliceActionsMenu')
		elseif cmd == 'ambulance-actions' then
			TriggerEvent('esx_ambulancejob:OpenMobileAmbulanceActionsMenu')
		elseif cmd == 'mechanic-actions' then
			TriggerEvent('esx_mechanicjob:OpenMobileMechanicActionsMenu')
		elseif cmd == 'mechanic-bennys-actions' then
			TriggerEvent('esx_mechanicjob-bennys:OpenMobileMechanicActionsMenu')
		elseif cmd == 'nightclub-actions'  then
			TriggerEvent('esx_nightclub:OpenSocietyActionsMenu')
		elseif cmd == 'taxi-actions'then
			TriggerEvent('esx_taxijob:OpenMobileTaxiActionsMenu')
		elseif cmd == 'unicorn-actions'then
			TriggerEvent('esx_unicornjob:OpenSocietyActionsMenu')
		elseif cmd == 'reporter-actions'then
			OpenReporterMenu()
		elseif cmd == 'admin-actions'then
			OpenAdminMenu()
		elseif cmd == 'personal' then
			-- TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
			OpenPersonalMenu()
		elseif cmd == 'documents' then
			TriggerEvent('esx_documents:openMainMenu')
		end

	end, function(data, menu)
		menu.close()
	end)

end
