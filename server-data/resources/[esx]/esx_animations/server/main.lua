ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('esx_animations:getFavorites', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getDataStore', 'user', xPlayer.identifier, function(store)
		cb(store.get('favoriteAnims') or {})
	end)
end)

ESX.RegisterServerCallback('esx_animations:setFavorites', function(source, cb, favs)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getDataStore', 'user', xPlayer.identifier, function(store)
		cb(store.set('favoriteAnims', favs))
	end)
end)
