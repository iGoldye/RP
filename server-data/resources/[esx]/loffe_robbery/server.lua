local pickups = {}

RegisterServerEvent('loffe_robbery:setStoreNetworkId')
AddEventHandler('loffe_robbery:setStoreNetworkId', function(store, id)
	local src = source
	if not Config.Shops[store].id then
			Config.Shops[store].id = id
			TriggerClientEvent('loffe_robbery:setPedNetworkId', -1, store, id)
	else
			TriggerClientEvent('loffe_robbery:deleteSpawnedPed', src, store, Config.Shops[store].id)
	end
end)

RegisterServerEvent('loffe_robbery:loadAllStores')
AddEventHandler('loffe_robbery:loadAllStores', function()
	local src = source
	for i = 1, #Config.Shops do
			TriggerClientEvent('loffe_robbery:loadStore', src, i, Config.Shops[i].id)
	end
end)

RegisterServerEvent('loffe_robbery:getCops')
AddEventHandler('loffe_robbery:getCops', function()
	local src = source
	TriggerClientEvent('loffe_robbery:setCops', src, getCops())
end)

RegisterServerEvent('loffe_robbery:createPickup')
AddEventHandler('loffe_robbery:createPickup', function(store, coords)
	table.insert(pickups, {store = store, id = #pickups+1})
	TriggerClientEvent('loffe_robbery:createPickup', -1, coords, #pickups)
end)

RegisterServerEvent('loffe_robbery:pickUpPickup')
AddEventHandler('loffe_robbery:pickUpPickup', function(pickupid)
	local src = source
	if pickups[pickupid] then
			local store = pickups[pickupid].store
			local randomMoney = math.random(Config.Shops[store].money[1], Config.Shops[store].money[2])
			TriggerClientEvent('loffe_robbery:notify', src, Translation[Config.Locale]['cashrecieved'] .. ' ~g~' .. randomMoney .. ' ' .. Translation[Config.Locale]['currency'], 5)
			table.remove(pickups, pickupid)
			addMoney(src, randomMoney)
			TriggerClientEvent('loffe_robbery:removePickup', -1, pickupid)
	end
end)
