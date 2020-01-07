
local hasAlreadyEnteredMarker, hasPaid, currentActionData = false, false, {}
local lastZone, currentAction, currentActionMsg
local previous_skin = nil
ESX = nil

function LoadPreviousSkin()
	if previous_skin then
		TriggerEvent('skinchanger:loadSkin', previous_skin)
	end
end

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function SaveInDressing(skin)
	ESX.TriggerServerCallback('esx_clotheshop:checkPropertyDataStore', function(foundStore)
		if foundStore then
			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'outfit_name', {
				title = _U('name_outfit')
			}, function(data3, menu3)
				menu3.close()

				TriggerEvent('skinchanger:getSkin', function(skin)
					TriggerServerEvent('esx_clotheshop:saveOutfit', data3.value, skin)
					ESX.ShowNotification(_U('saved_outfit'))
				end)
			end, function(data3, menu3)
				menu3.close()
			end)
		end
	end)
end

function OpenBoughtMenu(skin)
		local elements = {
					{label = "Сохранить в гардероб", value = "savedress"},
--					{label = "Получить комплект одежды", value = "giveoutfit"},
					{label = "Переодеться в предыдущее", value = "prev"},
					{label = "Выход", value = "exit"},
			}

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloth_bought_menu', {
			title    = "Покупки",
			align    = 'top-right',
			elements = elements
		}, function(data, menu)
			local cmd = data.current.value

			if cmd == "savedress" then
				SaveInDressing(skin)
			elseif cmd == "giveoutfit" then
			elseif cmd == "prev" then
				LoadPreviousSkin()
			elseif cmd == "exit" then
				menu.close()
			end

		end, function(data, menu)
			menu.close()
			TriggerServerEvent('esx_skin:save', skin)
			TriggerServerEvent('esx_accessories:save', skin, "Helmet")
			TriggerServerEvent('esx_accessories:save', skin, "Glasses")
		end)
end

function OpenShopMenu()
	hasPaid = false
	TriggerEvent('skinchanger:getSkin', function(skin)
		previous_skin = skin
	end)

	TriggerEvent('esx_skin:openRestrictedMenu', function(data, menu)
		menu.close()

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm', {
			title = _U('valid_this_purchase'),
			align = 'top-left',
			elements = {
				{label = _U('no'), value = 'no'},
				{label = _U('yes'), value = 'yes'}
		}}, function(data, menu)
			menu.close()

			if data.current.value == 'yes' then
				ESX.TriggerServerCallback('esx_clotheshop:buyClothes', function(bought)
					if bought then
						hasPaid = true
						TriggerEvent('skinchanger:getSkin', function(skin)
							OpenBoughtMenu(skin)
						end)
					else
						LoadPreviousSkin()
						ESX.ShowNotification(_U('not_enough_money'))
					end
				end)
			elseif data.current.value == 'no' then
				LoadPreviousSkin()
			end

			currentAction     = 'shop_menu'
			currentActionMsg  = _U('press_menu')
			currentActionData = {}
		end, function(data, menu)
			menu.close()

			currentAction     = 'shop_menu'
			currentActionMsg  = _U('press_menu')
			currentActionData = {}
		end)

	end, function(data, menu)
		menu.close()

		currentAction     = 'shop_menu'
		currentActionMsg  = _U('press_menu')
		currentActionData = {}
	end, {
		'tshirt_1', 'tshirt_2',
		'torso_1', 'torso_2',
		'decals_1', 'decals_2',
		'arms', 'arms_2',
		'pants_1', 'pants_2',
		'shoes_1', 'shoes_2',
		'chain_1', 'chain_2',
		'bags_1', 'bags_2',
		'helmet_1', 'helmet_2',
		'glasses_1', 'glasses_2',
		'watches_1', 'watches_2',
		'bracelets_1', 'bracelets_2',
	})
end

AddEventHandler('esx_clotheshop:hasEnteredMarker', function(zone)
	currentAction     = 'shop_menu'
	currentActionMsg  = _U('press_menu')
	currentActionData = {}
end)

AddEventHandler('esx_clotheshop:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
	currentAction = nil

	if not hasPaid then
		LoadPreviousSkin()
	end
end)

-- Create Blips
Citizen.CreateThread(function()
	for k,v in ipairs(Config.Shops) do
		local blip = AddBlipForCoord(v)

		SetBlipSprite (blip, 73)
		SetBlipColour (blip, 47)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName(_U('clothes'))
		EndTextCommandSetBlipName(blip)
	end
end)

-- Enter / Exit marker events & draw markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerCoords, isInMarker, currentZone, letSleep = GetEntityCoords(PlayerPedId()), false, nil, true

		for k,v in pairs(Config.Shops) do
			local distance = #(playerCoords - v)

			if distance < Config.DrawDistance then
				letSleep = false
				DrawMarker(Config.MarkerType, v, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, nil, nil, false)

				if distance < Config.MarkerSize.x then
					isInMarker, currentZone = true, k
				end
			end
		end

		if (isInMarker and not hasAlreadyEnteredMarker) or (isInMarker and lastZone ~= currentZone) then
			hasAlreadyEnteredMarker, lastZone = true, currentZone
			TriggerEvent('esx_clotheshop:hasEnteredMarker', currentZone)
		end

		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('esx_clotheshop:hasExitedMarker', lastZone)
		end

		if letSleep then
			Citizen.Wait(500)
		end
	end
end)

-- Key controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if currentAction then
			ESX.ShowHelpNotification(currentActionMsg)

			if IsControlJustReleased(0, 38) then
				if currentAction == 'shop_menu' then
					OpenShopMenu()
				end

				currentAction = nil
			end
		else
			Citizen.Wait(500)
		end
	end
end)
