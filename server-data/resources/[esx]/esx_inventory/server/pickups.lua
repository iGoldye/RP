global_pickup_id = 0
pickups = {}
players = {}

RegisterServerEvent('esx_inventory:playerCoords')
AddEventHandler('esx_inventory:playerCoords', function(coords, forward)
	if players[source] == nil then
		players[source] = {}
	end

	players[source].coords = coords
	players[source].forward = forward
end)

function createPickup(source, item, label)
--		print("createPickup "..json.encode(item))

		if players[source] == nil or players[source].coords == nil or players[source].forward == nil then
			print("Player coords unknown!")
			return false
		end

		global_pickup_id = global_pickup_id + 1
		local pickup = {}

		pickup.id = global_pickup_id
		pickup.item = duplicateItem(item)
		pickup.label = label
		pickup.coords = players[source].coords + players[source].forward * 0.2
		pickup.source = source

		pickups[pickup.id] = pickup

		TriggerClientEvent('esx_inventory:createPickup', -1, global_pickup_id, pickup)
		return true
end

function sendAllPickups(source)
		for i, pickup in pairs(pickups) do
			TriggerClientEvent('esx_inventory:createPickup', source, pickup.id, pickup)
		end
end


RegisterServerEvent('esx_inventory:onPickup')
AddEventHandler('esx_inventory:onPickup', function(id)

		if players[source] == nil or players[source].coords == nil or players[source].forward == nil then
			print("Player coords unknown!")
			return
		end

		local pickup  = pickups[id]
		local xPlayer = ESX.GetPlayerFromId(source)

		if pickup == nil then
			print("Non-existent pickup id: "..tostring(id))
			return
		end

		local dist = #(players[source].coords - pickup.coords)

		if dist > 10 then
			print(string.format("Player %i is too far to get pickup %i", source, id))
			return
		end

		TriggerClientEvent('esx_inventory:removePickup', -1, id)
		pickups[id] = nil

		getInventory("pocket",xPlayer.identifier).addItem(pickup.item)
end)
