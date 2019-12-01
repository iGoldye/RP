ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_clotheshop:saveOutfit')
AddEventHandler('esx_clotheshop:saveOutfit', function(label, skin)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
		local dressing = store.get('dressing')

		if dressing == nil then
			dressing = {}
		end

		table.insert(dressing, {
			label = label,
			skin  = skin
		})

		store.set('dressing', dressing)
	end)
end)

ESX.RegisterServerCallback('esx_clotheshop:buyClothes', function(source, cb)
	TriggerEvent('esx_atm:pay', source, "clotheshop", Config.Price, function(res)
		if res == true then
			TriggerClientEvent('esx:showNotification', source, _U('you_paid', Config.Price))
			cb(true)
		else
			cb(false)
		end
	end)
end)

ESX.RegisterServerCallback('esx_clotheshop:checkPropertyDataStore', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local foundStore = false

	TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
		foundStore = true
	end)

	cb(foundStore)
end)
