ESX                     = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

RegisterNetEvent('clothesoff:overdress')
AddEventHandler('clothesoff:overdress', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
		local clothesSkin = {
		['tshirt_1'] = 15, ['tshirt_2'] = 0,
		['torso_1'] = 15, ['torso_2'] = 0,
		['arms'] = 15, ['arms_2'] = 0
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	end)
end)
RegisterNetEvent('clothesoff:pants')
AddEventHandler('clothesoff:pants', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
		local clothesSkin = nil

		if skin.sex == 1 then
			clothesSkin = {['pants_1'] = 15, ['pants_2'] = 0}
		else
			clothesSkin = {['pants_1'] = 21, ['pants_2'] = 0}
		end

		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	end)
end)

RegisterNetEvent('clothesoff:shoes')
AddEventHandler('clothesoff:shoes', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
		local clothesSkin

		if skin.sex == 1 then
			clothesSkin = {['shoes_1'] = 35, ['shoes_2'] = 0}
		else
			clothesSkin = {['shoes_1'] = 34, ['shoes_2'] = 0}
		end

		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	end)
end)

function OpenActionMenuInteraction(target)
	local elements = {}

	table.insert(elements, {label = ('Одеться'), value = 'clotheson'})
	table.insert(elements, {label = ('Снять верх'), value = 'overdress'})
	table.insert(elements, {label = ('Снять низ'), value = 'pants'})
	table.insert(elements, {label = ('Снять обувь'), value = 'shoes'})
--  		ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'action_menu',
		{
			title    = ('Одежда'),
			align    = 'top-left',
			elements = elements
		},
	    function(data, menu)
		if data.current.value == 'clotheson' then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', skin)
			end)
		elseif data.current.value == 'overdress' then
			TriggerEvent('clothesoff:overdress')
		elseif data.current.value == 'pants' then
			TriggerEvent('clothesoff:pants')
		elseif data.current.value == 'shoes' then
			TriggerEvent('clothesoff:shoes')
	        end
		menu.close()
	    end,
	    function(data, menu)
		menu.close()
	    end
	)
end

AddEventHandler('clothesoff:openActionMenuInteraction', function()
    if not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'action_menu') then
		OpenActionMenuInteraction()
    end
end)
