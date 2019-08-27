ESX = nil
ESXItemDB = {}
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
Inventories = { ["pocket"] = {} }
ClientInventories = {}
global_pickup_id = 0
pickups = {}
players = {}

function tablesEqual(table1, table2)
	if table1 == nil then
		return table2 == nil
	end

	if table2 == nil then
		return false
	end

	for k, v in pairs(table1) do
		if table2[k] ~= v then
			return false
		end
	end

	for k, v in pairs(table2) do
		if table1[k] ~= v then
			return false
		end
	end

	return true
end

function onInventoryChanged(name, owner)
	updateWeight(name, owner)
	Inventories[name][owner].dirty = true
end

function updateWeight(name, owner)
	local inv = getInventory(name, owner)
	local weight = 0.0

	for _,item in pairs(inv.items) do
		if item.name == 'esx_item' then
			item.weight = ESXItemDB[item.name] or 0
		end

		if item.weigth ~= nil and item.amount ~= nil then
			weight = weight + item.weight * item.amount
		end
	end

	local xPlayer = ESX.GetPlayerFromIdentifier(owner)

	if xPlayer ~= nil then
		for i=1, #xPlayer.inventory, 1 do
			local item = xPlayer.inventory[i]
			if item.count > 0 then
				local itemWeight = 0
				if ESXItemDB[item.name] ~= nil then
					itemWeight = ESXItemDB[item.name].weight or 0
				end

				if itemWeight ~= nil and item.count > 0 then
					weight = weight + item.count * itemWeight / 1000.0
				end
			end
		end
	end

	Inventories[name][owner].weight = weight
--	print("updateWeight "..tostring(weight))
end

function getInventory(name, owner)
	if Inventories[name] == nil then
		Inventories[name] = {}
	end

	if Inventories[name][owner] == nil then
		Inventories[name][owner] = {}
		Inventories[name][owner].name = name
		Inventories[name][owner].owner = owner
		Inventories[name][owner].dirty = false
		Inventories[name][owner].weight = 0.0
		Inventories[name][owner].items = {}
	end

	return Inventories[name][owner]
end


function compareItems(item1, item2)
	if item1 == nil then
		return item1 == item2
	end

	if item2 == nil then
		return false
	end

	if item1["name"] ~= item2["name"] then
		return false
	end

	if not tablesEqual(item1["extra"], item2["extra"]) then
		return false
	end

	return true
end


function findItem(name, owner, item)
	if Inventories[name] == nil then
		return nil, nil
	end

	if Inventories[name][owner] == nil then
		return nil, nil
	end

	if Inventories[name][owner].items == nil then
		return nil, nil
	end

	for k,v in pairs(Inventories[name][owner].items) do
		if compareItems(item, v) == true then
			return k,v
		end
	end

	return nil, nil
end

function getItemLabel(item)
	if item.name == "money" then
		return _U('cash')
	elseif item.name == "weapon" then
		return _U(item.extra.weapon_name:lower())
	elseif item.name == "esx_item" then
		return item.extra.label
	end

	return _U(item.name)
end

function createItem(name, extra, amount, weight)
	local item = {}
	item["name"] = name
	item["extra"] = json.decode(json.encode(extra))
	item["amount"] = amount
	item["weight"] = weight or 0.0
	return item
end

function addItem(name, owner, item)

	if name == "pocket" then
		local xPlayer = ESX.GetPlayerFromIdentifier(owner)

		if item.name == "esx_item" then
			if xPlayer ~= nil then
				xPlayer.addInventoryItem(item.extra.name, item.amount)
				return true
			end
			return false
		elseif item.name == "money" then
			if xPlayer then
				xPlayer.addMoney(item.amount)
				return true
			end
			return false
		elseif item.name == "black_money" then
			if xPlayer  then
				xPlayer.addAccountMoney('black_money', item.amount)
				return true
			end
			return false
		end
	end

	local old_item_index, old_item = findItem(name, owner, item)
	if item.amount < 0 then
		print("Wrong item amount!")
		return false
	end

	if old_item_index then
		if item.amount + old_item.amount > 0 then
			Inventories[name][owner].items[old_item_index].amount = item.amount + old_item.amount
			onInventoryChanged(name,owner)
		elseif item.amount + old_item.amount == 0 then
			Inventories[name][owner].items[old_item_index] = nil
			onInventoryChanged(name,owner)
		else
			return false
		end
	elseif item.amount > 0 then
		table.insert(Inventories[name][owner].items, item)
		onInventoryChanged(name,owner)
	end

	if owner ~= nil and owner ~= "" then
		local xPlayer = ESX.GetPlayerFromIdentifier(owner)
		if xPlayer ~= nil then
			TriggerClientEvent('esx_inventory:showItemNotification', xPlayer.source, true, { ["label"] = getItemLabel(item) }, item.amount)
		end
	end

	return true
end

function removeItem(name, owner, item)

	if item == nil then
		print("Nil item!")
		return false
	end

	if item.amount < 0 then
		print("Wrong item amount!")
		return false
	end

	if name == "pocket" then
		local xPlayer = ESX.GetPlayerFromIdentifier(owner)

		if item.name == "esx_item" then
			if xPlayer ~= nil and item.extra ~= nil then
				local curitem = xPlayer.getInventoryItem(item.extra.name)
				if curitem == nil then
					return false
				end
				if curitem.count ~= nil and curitem.count >= item.amount then
					xPlayer.removeInventoryItem(item.extra.name, item.amount)
				else
					return false
				end
				return true
			end
			return false

		elseif item.name == "money" then
			if xPlayer and ESX.Round(xPlayer.getMoney() - item.amount, 2) >= 0 then
				xPlayer.removeMoney(item.amount)
				return true
			end
			return false
		elseif item.name == "black_money" then
			if xPlayer and ESX.Round(xPlayer.getAccount('black_money').money - item.amount, 2) >= 0 then
				xPlayer.removeAccountMoney('black_money', item.amount)
				return true
			end
			return false
		end

	end

	local old_item_index, old_item = findItem(name, owner, item)

	if old_item_index then
		if old_item.amount - item.amount > 0 then
			Inventories[name][owner].items[old_item_index].amount = old_item.amount - item.amount
			onInventoryChanged(name,owner)
		elseif old_item.amount - item.amount == 0 then
			Inventories[name][owner].items[old_item_index] = nil
			onInventoryChanged(name,owner)
		else
			return false
		end
	elseif item.amount > 0 then
		table.insert(Inventories[name][owner].items, item)
		onInventoryChanged(name,owner)
	end

	if owner ~= nil and owner ~= "" then
		local xPlayer = ESX.GetPlayerFromIdentifier(owner)
		if xPlayer ~= nil then
			TriggerClientEvent('esx_inventory:showItemNotification', xPlayer.source, false, { ["label"] = getItemLabel(item) }, item.amount)
		end
	end

	return true
end

--[[
function setItem(name, owner, item)
	if name == "pocket" and item.name == "esx_item" then
		local xPlayer = ESX.GetPlayerFromIdentifier(owner)
		if xPlayer ~= nil then
			xPlayer.addInventoryItem(item.extra.name, item.amount)
			return true
		end
		return false
	end

	local old_amount = item.amount
	local old_item_index, old_item = findItem(name, owner, item)
	if item.amount < 0 then
		print("Wrong item amount!")
		return false
	end

	if old_item_index then
		if item.amount > 0 then
			Inventories[name][owner].items[old_item_index].amount = item.amount
			onInventoryChanged(name,owner)
		elseif item.amount == 0 then
			Inventories[name][owner].items[old_item_index] = nil
			onInventoryChanged(name,owner)
		else
			return false
		end
	elseif item.amount > 0 then
		table.insert(Inventories[name][owner].items, item)
		onInventoryChanged(name,owner)
	end

	if owner ~= nil and owner ~= "" then
		local add = old_amount < amount
		local xPlayer = ESX.GetPlayerFromIdentifier(owner)
		if xPlayer ~= nil then
			if add then
				TriggerClientEvent('esx_inventory:showItemNotification', xPlayer.source, true, { ["label"] = getItemLabel(item) }, item.amount - old_amount)
			else
				TriggerClientEvent('esx_inventory:showItemNotification', xPlayer.source, false, { ["label"] = getItemLabel(item) }, old_amount - item.amount)
			end
		end
	end


	return true
end
]]--

function reloadInventories()
	Inventories = { ["pocket"] = {} }
	local result = MySQL.Sync.fetchAll('SELECT * FROM inventory')

	local xPlayers = ESX.GetPlayers()

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		getInventory("pocket", xPlayer.identifier) -- initialize empty inventories
	end

	for i=1, #result, 1 do
		local name=result[i].name
		local owner=result[i].owner

		-- load empty inventory
		local inv = getInventory(name, owner)

		local item = createItem(result[i].item, json.decode(result[i].extra), result[i].amount)
		addItem(name, owner, item)
	end

	for name,_ in pairs(Inventories) do
	for owner,_ in pairs(Inventories[name]) do
		updateWeight(name, owner)
	end
	end
end

-- Client inventory synchronizer
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for k,player_id in ipairs(ESX.GetPlayers()) do
			local xPlayer = ESX.GetPlayerFromId(player_id)
			if Inventories["pocket"][xPlayer.identifier] == nil then
				Inventories["pocket"][xPlayer.identifier] = {
					["name"] = "pocket",
					["owner"] = xPlayer.identifier,
					["items"] = {},
				}

			end

--			local moneypack = createItem("money_pack", { ["cash"] = 1000, ["black"] = 2000 }, 1)
--			local _,v = findItem("pocket", xPlayer.identifier, moneypack)
--			if v == nil then
--				addItem("pocket", xPlayer.identifier, moneypack)
--			end	

			local inv = Inventories["pocket"][xPlayer.identifier]
                	local invstr = json.encode(inv)

                	if ClientInventories[xPlayer.identifier] ~= invstr then
				TriggerClientEvent('esx_inventory:onInventoryUpdate', xPlayer.source, inv)
				ClientInventories[xPlayer.identifier] = invstr
			end
		end
		
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60000)

		for name,_ in pairs(Inventories) do
		for owner,_ in pairs(Inventories[name]) do

			if Inventories[name][owner].dirty == true then
				print(string.format("Saving inventory %s/%s", name, owner))
				Inventories[name][owner].dirty = false
				saveInventory(name,owner)
			end
		end
		end

	end
end)


RegisterServerEvent('esx_inventory:playerCoords')
AddEventHandler('esx_inventory:playerCoords', function(coords, forward)
	if players[source] == nil then
		players[source] = {}
	end

	players[source].coords = coords
	players[source].forward = forward
end)

function saveInventory(name, owner)
	local inv = getInventory(name,owner)

	MySQL.Async.execute('DELETE FROM `inventory` WHERE `name` = @name AND `owner` = CAST(@owner as CHAR(255))', {
		['@name']    = name,
		['@owner']   = owner,
	}, function(rc)

		for k,v in pairs(inv.items) do
			MySQL.Async.execute('INSERT INTO `inventory` (`name`, `owner`, `item`, `extra`, `amount`) VALUES (@name, @owner, @item, @extra, @amount)', {
				['@name']    = name,
				['@owner']   = owner,
				['@item']    = v.name,
				['@extra']   = json.encode(v.extra),
				['@amount']  = v.amount,
			}, function(rowsChanged)
			end)
		end

	end)
	
end

function createPickup(source, item, label)
--	print("createPickup "..json.encode(item))

	if players[source] == nil or players[source].coords == nil or players[source].forward == nil then
		print("Player coords unknown!")
		return false
	end

	global_pickup_id = global_pickup_id + 1
	local pickup = {}

	pickup.id = global_pickup_id
	pickup.item = duplicateItem(item)
	pickup.label = label
	pickup.coords = players[source].coords + players[source].forward * -2.0
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

--[[
function addOrSetItem(name, owner, item, add)
	local old_item_index, old_item = findItem(name, owner, item)

	if old_item_index then
		if add then
			if item.amount + old_item.amount > 0 then
				Inventories[name][owner].items[old_item_index].amount = item.amount + old_item.amount
			elseif item.amount + old_item.amount == 0 then
				Inventories[name][owner].items[old_item_index] = nil
			else
				return false
			end

		else
			if item.amount > 0 then
				Inventories[name][owner].items[old_item_index].amount = item.amount
			elseif item.amount == 0 then
				Inventories[name][owner].items[old_item_index] = nil
			else
				return false
			end
		end
	elseif item.amount > 0 then
		table.insert(Inventories[name][owner].items, item)
	end

	return true
end
]]--

RegisterServerEvent('esx_inventory:dropItem')
AddEventHandler('esx_inventory:dropItem', function(name, shared, item)

	if players[source] == nil then		
		print("esx_inventory:dropItem Unknown player coords!")
		return
	end

	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer == nil then
		print("esx_inventory:dropItem Unknown player!")
		return
	end

	if item.amount <= 0 then
		print("esx_inventory:dropItem Incorrect item amount "..tostring(item.amount).."!")
		return
	end

	local owner = ""

	if not shared then
		owner = xPlayer.identifier
	end	

	if removeItem(name, owner, item) then
		if createPickup(source, item, getItemLabel(item)) == false then
			addItem(name, owner, item)
		end
	end
end)

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

	if pickup.item.name == "money" then
		xPlayer.addMoney(pickup.item.amount)
	elseif pickup.item.name == "black_money" then
		xPlayer.addAccountMoney("black_money", pickup.item.amount)
	elseif pickup.item.name == "esx_item" then
		xPlayer.addInventoryItem(pickup.item.extra.name, pickup.item.amount)
	else
		addItem("pocket", xPlayer.identifier, pickup.item)
	end
end)

RegisterServerEvent('esx_inventory:getInventory')
AddEventHandler('esx_inventory:getInventory', function(name, shared, client_event)

	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer == nil then
		print("esx_inventory:getInventory Unknown player!")
		return
	end

	local owner = ""

	if not shared then
		owner = xPlayer.identifier
	end	

	updateWeight(name, owner)

	local inv = getInventory(name, owner)
--	addItem(name, owner, createItem("money_pack", { ["cash"] = 1000, ["black"] = 2000 }, 1))

	if client_event then
		TriggerClientEvent(client_event, source, inv)
	end

end)

RegisterServerEvent('esx_inventory:actionUnpackMoney')
AddEventHandler('esx_inventory:actionUnpackMoney', function(item)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer == nil then
		print("esx_inventory:getInventory Unknown player!")
		return
	end

	if removeItem("pocket", xPlayer.identifier, createItem(item.name, item.extra, 1)) == true then
		xPlayer.addMoney(item.extra["cash"])
		xPlayer.addAccountMoney('black_money', item.extra["black"])
	end
end)

RegisterServerEvent('esx_inventory:unequipWeapon')
AddEventHandler('esx_inventory:unequipWeapon', function(weaponName, ammo, config)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer == nil then
		print("esx_inventory:unequipWeapon Unknown player!")
		return
	end

	if addItem("pocket", xPlayer.identifier, createItem("weapon", { ["weapon_name"] = weaponName, ["weapon_label"] = config.label, ["ammo"] = ammo }, 1, config.weight)) == true then
--		TriggerClientEvent("esx_inventory:unequipWeapon", source, weaponName, ammo)
		local inv = getInventory("pocket", xPlayer.identifier)
		TriggerClientEvent('esx_inventory:onInventoryUpdate', source, inv)
	end	
end)

RegisterServerEvent('esx_inventory:equipWeapon')
AddEventHandler('esx_inventory:equipWeapon', function(item)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer == nil then
		print("esx_inventory:equipWeapon Unknown player!")
		return
	end

	local tmpItem = createItem("weapon", item.extra, 1)

	if removeItem("pocket", xPlayer.identifier, createItem("weapon", item.extra, 1)) == true then
		TriggerClientEvent("esx_inventory:equipWeapon", source, item)
	end	
end)

RegisterServerEvent('esx_inventory:createItem')
AddEventHandler('esx_inventory:createItem', function(name, extra, amount, weight, cb)
	cb(createItem(name, extra, amount, weight))
end)


ESX.RegisterServerCallback('esx_inventory:giveItemTo', function(source, cb, playerid, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromId(playerid)

	if removeItem("pocket", xPlayer.identifier, item) == true then
		cb(addItem("pocket", xTarget.identifier, item))
	else
		cb(false)
	end
end)


--[[
RegisterServerEvent('esx_inventory:addItem')
AddEventHandler('esx_inventory:addItem', function(name, owner, item, cb)
	cb(addItem(name, owner, item))
end)

RegisterServerEvent('esx_inventory:removeItem')
AddEventHandler('esx_inventory:removeItem', function(name, owner, item, cb)
	cb(removeItem(name, owner, item))
end)
]]--

RegisterServerEvent('esx_inventory:playerSpawned')
AddEventHandler('esx_inventory:playerSpawned', function()
	sendAllPickups(source)
end)

MySQL.ready(function()
	ESXItemDB = {}
	local items = MySQL.Sync.fetchAll('SELECT * FROM items')
	for i=1,#items do
		local item = items[i]
		ESXItemDB[item.name] = item
	end

	reloadInventories()
end)
