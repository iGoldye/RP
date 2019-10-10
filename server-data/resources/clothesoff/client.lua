ESX                     = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

RegisterNetEvent('clothesoff:overdress')
AddEventHandler('clothesoff:overdress', function()
	local clothesSkin = {
		['tshirt_1'] = 15, ['tshirt_2'] = 0,
		['torso_1'] = 15, ['torso_2'] = 0,
		['arms'] = 15, ['arms_2'] = 0
	}

	TriggerEvent('skinchanger:getSkin', function(skin)
		if skin["torso_1"] == clothesSkin["torso_1"] and skin["tshirt_1"] == clothesSkin["tshirt_1"] then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(orig_skin)
				clothesSkin = {
					['tshirt_1'] = orig_skin['tshirt_1'], ['tshirt_2'] = orig_skin['tshirt_2'],
					['torso_1'] = orig_skin['torso_1'], ['torso_2'] = orig_skin['torso_2'],
					['arms'] = orig_skin['arms'], ['arms_2'] = orig_skin['arms_2']
				}
				TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
			end)
		else
			TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
		end
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

		if skin["pants_1"] == clothesSkin["pants_1"] then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(orig_skin)
				clothesSkin = {
					['pants_1'] = orig_skin['pants_1'], ['pants_2'] = orig_skin['pants_2'],
				}
				TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
			end)
		else
			TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
		end
	end)
end)

RegisterNetEvent('clothesoff:helmet')
AddEventHandler('clothesoff:helmet', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
		local clothesSkin = {['helmet_1'] = -1}

		if skin["helmet_1"] == clothesSkin["helmet_1"] then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(orig_skin)
				clothesSkin = {
					['helmet_1'] = orig_skin['helmet_1'],
				}
				TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
			end)
		else
			TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
		end
	end)
end)


RegisterNetEvent('clothesoff:ears')
AddEventHandler('clothesoff:ears', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
		local clothesSkin = {['ears_1'] = -1}

		if skin["ears_1"] == clothesSkin["ears_1"] then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(orig_skin)
				clothesSkin = {
					['ears_1'] = orig_skin['ears_1'],
				}
				TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
			end)
		else
			TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
		end
	end)
end)

RegisterNetEvent('clothesoff:mask')
AddEventHandler('clothesoff:mask', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
		local clothesSkin = {['mask_1'] = -1}

		if skin["mask_1"] == clothesSkin["mask_1"] then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(orig_skin)
				clothesSkin = {
					['mask_1'] = orig_skin['mask_1'],
				}
				TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
			end)
		else
			TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
		end
	end)
end)

RegisterNetEvent('clothesoff:glasses')
AddEventHandler('clothesoff:glasses', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
		local clothesSkin = {['glasses_1'] = -1}

		if skin["glasses_1"] == clothesSkin["glasses_1"] then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(orig_skin)
				clothesSkin = {
					['glasses_1'] = orig_skin['glasses_1'],
				}
				TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
			end)
		else
			TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
		end
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

		if skin["shoes_1"] == clothesSkin["shoes_1"] then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(orig_skin)
				clothesSkin = {
					['shoes_1'] = orig_skin['shoes_1'], ['shoes_2'] = orig_skin['shoes_2'],
				}
				TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
			end)
		else
			TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
		end
	end)
end)

function OpenActionMenuInteraction(target)
	local elements = {}

	table.insert(elements, {label = ('Одеться'), value = 'clotheson'})
	table.insert(elements, {label = ('Верхняя одежда'), value = 'overdress'})
	table.insert(elements, {label = ('Штаны'), value = 'pants'})
	table.insert(elements, {label = ('Обувь'), value = 'shoes'})
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
