ESX = nil
local playersHealing = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_ambulancejob:useMedikit')
AddEventHandler('esx_ambulancejob:useMedikit', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	local item = xPlayer.getInventoryItem('medikit')

	if item and item.count >= 1 then
		xPlayer.removeInventoryItem('medikit', 1)
		TriggerClientEvent('esx_ambulancejob:heal', target, 'big')
		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('heal_complete', xPlayer.name))
	end
end)

RegisterServerEvent('esx_ambulancejob:useMedikitRevive')
AddEventHandler('esx_ambulancejob:useMedikitRevive', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromId(target)
	local item = xPlayer.getInventoryItem('medikit')

	if item and item.count >= 1 then
		xPlayer.removeInventoryItem('medikit', 1)
		TriggerClientEvent('esx_ambulancejob:revive', target)

		if Config.ReviveReward > 0 and xPlayer.job.name == 'ambulance' then
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('revive_complete_award', xTarget.name, Config.ReviveReward))
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('revive_complete', xTarget.name))
		end
	end
end)

RegisterServerEvent('esx_ambulancejob:useBandage')
AddEventHandler('esx_ambulancejob:useBandage', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	local item = xPlayer.getInventoryItem('bandage')

	if item and item.count >= 1 then
		xPlayer.removeInventoryItem('bandage', 1)
		TriggerClientEvent('esx_ambulancejob:heal', target, 'small')
		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('heal_complete', xPlayer.name))
	end
end)

RegisterServerEvent('esx_ambulancejob:revive')
AddEventHandler('esx_ambulancejob:revive', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' or xPlayer.job.name =='police' then
		xPlayer.addMoney(Config.ReviveReward)
		TriggerClientEvent('esx_ambulancejob:revive', target)
	else
		print(('esx_ambulancejob: %s attempted to revive!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_ambulancejob:heal')
AddEventHandler('esx_ambulancejob:heal', function(target, type)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' then
		TriggerClientEvent('esx_ambulancejob:heal', target, type)
	else
		print(('esx_ambulancejob: %s attempted to heal!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_ambulancejob:alcotest')
AddEventHandler('esx_ambulancejob:alcotest', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' then
		TriggerEvent('esx_status:getStatus', target, 'drunk', function(status)
	                if status.val < 1 then
				TriggerClientEvent('esx:showNotification', xPlayer.source, "Степень опьянения: не выявлено")
			elseif status.val < 250000 then
				TriggerClientEvent('esx:showNotification', xPlayer.source, "Степень опьянения: ~g~лёгкое")
			elseif status.val < 500000 then
				TriggerClientEvent('esx:showNotification', xPlayer.source, "Степень опьянения: ~y~умеренное")
			elseif status.val < 750000 then
				TriggerClientEvent('esx:showNotification', xPlayer.source, "Степень опьянения: ~r~тяжёлое")
			else
				TriggerClientEvent('esx:showNotification', xPlayer.source, "Степень опьянения: ~r~крайне тяжёлое")
			end
		end)
	else
		print(('esx_ambulancejob: %s attempted to start alcohol test!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_ambulancejob:putInVehicle')
AddEventHandler('esx_ambulancejob:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' then
		TriggerClientEvent('esx_ambulancejob:putInVehicle', target)
	else
		print(('esx_ambulancejob: %s attempted to put in vehicle!'):format(xPlayer.identifier))
	end
end)

TriggerEvent('esx_phone:registerNumber', 'ambulance', _U('alert_ambulance'), true, true)

TriggerEvent('esx_society:registerSociety', 'ambulance', 'Ambulance', 'society_ambulance', 'society_ambulance', 'society_ambulance', {type = 'public'})

ESX.RegisterServerCallback('esx_ambulancejob:removeItemsAfterRPDeath', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if Config.RemoveCashAfterRPDeath then
		if xPlayer.getMoney() > 0 then
			xPlayer.removeMoney(xPlayer.getMoney())
		end

		if xPlayer.getAccount('black_money').money > 0 then
			xPlayer.setAccountMoney('black_money', 0)
		end
	end

	if Config.RemoveItemsAfterRPDeath then
		for i=1, #xPlayer.inventory, 1 do
			if xPlayer.inventory[i].count > 0 then
				xPlayer.setInventoryItem(xPlayer.inventory[i].name, 0)
			end
		end
	end

	local playerLoadout = {}
	if Config.RemoveWeaponsAfterRPDeath then
		for i=1, #xPlayer.loadout, 1 do
			xPlayer.removeWeapon(xPlayer.loadout[i].name)
		end
	else -- save weapons & restore em' since spawnmanager removes them
		for i=1, #xPlayer.loadout, 1 do
			table.insert(playerLoadout, xPlayer.loadout[i])
		end

		-- give back wepaons after a couple of seconds
		Citizen.CreateThread(function()
			Citizen.Wait(5000)
			for i=1, #playerLoadout, 1 do
				if playerLoadout[i].label ~= nil then
					xPlayer.addWeapon(playerLoadout[i].name, playerLoadout[i].ammo)
				end
			end
		end)
	end

	cb()
end)

if Config.EarlyRespawnFine then
	ESX.RegisterServerCallback('esx_ambulancejob:checkBalance', function(source, cb)
		local xPlayer = ESX.GetPlayerFromId(source)
		local bankBalance = xPlayer.getAccount('bank').money

		cb(bankBalance >= Config.EarlyRespawnFineAmount)
	end)

	RegisterServerEvent('esx_ambulancejob:payFine')
	AddEventHandler('esx_ambulancejob:payFine', function()
		local xPlayer = ESX.GetPlayerFromId(source)
		local fineAmount = Config.EarlyRespawnFineAmount

		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('respawn_bleedout_fine_msg', ESX.Math.GroupDigits(fineAmount)))
		xPlayer.removeAccountMoney('bank', fineAmount)
	end)
end

ESX.RegisterServerCallback('esx_ambulancejob:getItemAmount', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local quantity = xPlayer.getInventoryItem(item).count

	cb(quantity)
end)

ESX.RegisterServerCallback('esx_ambulancejob:buyJobVehicle', function(source, cb, vehicleProps, type)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = getPriceFromHash(vehicleProps.model, xPlayer.job.grade_name, type)
	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ambulance', function(account)

		-- vehicle model not found
		if price == 0 then
			print(('esx_ambulancejob: %s attempted to exploit the shop! (invalid vehicle model: %s)'):format(xPlayer.identifier, vehicleProps.model))
			cb(false)
		else
			local displayName = type
			if vehicleProps.label ~= nil then
				displayName = vehicleProps.label
			end

			if account.money >= price then
				account.removeMoney(price)

				MySQL.Async.execute('INSERT INTO owned_vehicles (owner, vehicle, plate, type, job, `stored`, vehiclename) VALUES (@owner, @vehicle, @plate, @type, @job, @stored, @vehiclename)', {
					['@owner'] = xPlayer.identifier,
					['@vehicle'] = json.encode(vehicleProps),
					['@plate'] = vehicleProps.plate,
					['@type'] = type,
					['@job'] = xPlayer.job.name,
					['@stored'] = true,
					['@vehiclename'] = displayName,
				}, function (rowsChanged)
					cb(true)
				end)
			else
				cb(false)
			end
		end
	end)
end)

ESX.RegisterServerCallback('esx_ambulancejob:storeNearbyVehicle', function(source, cb, nearbyVehicles)
	local xPlayer = ESX.GetPlayerFromId(source)
	local foundPlate, foundProps, foundNum

	for k,v in ipairs(nearbyVehicles) do
		local result = MySQL.Sync.fetchAll('SELECT plate, vehicle FROM owned_vehicles WHERE owner = @owner AND plate = @plate AND job = @job', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = v.plate,
			['@job'] = xPlayer.job.name
		})

		if result[1] then
			foundPlate, foundProps, foundNum = result[1].plate, result[1].vehicle, k
			break
		end
	end

	if not foundPlate then
		cb(false)
	else
		if foundProps ~= nil then
			foundProps = json.decode(foundProps)
		end
		local props = nearbyVehicles[foundNum].props

		if props.health ~= nil then
			foundProps.health = math.floor(props.health)
		end

		if props.engineHealth ~= nil then
			foundProps.engineHealth = math.floor(props.engineHealth)
		end

		if props.bodyHealth ~= nil then
			foundProps.bodyHealth = math.floor(props.bodyHealth)
		end

		MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = true, `vehicle` = @vehicle WHERE owner = @owner AND plate = @plate AND job = @job', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = foundPlate,
			['@job'] = xPlayer.job.name,
			['@vehicle'] = json.encode(foundProps),
		}, function (rowsChanged)
			if rowsChanged == 0 then
				print(('esx_ambulancejob: %s has exploited the garage!'):format(xPlayer.identifier))
				cb(false)
			else
				cb(true, foundNum)
			end
		end)
	end

end)

function getPriceFromHash(hashKey, jobGrade, type)
	if type == 'helicopter' then
		local vehicles = Config.AuthorizedHelicopters[jobGrade]

		for k,v in ipairs(vehicles) do
			if GetHashKey(v.model) == hashKey then
				return v.price
			end
		end
	elseif type == 'car' then
		local vehicles = Config.AuthorizedVehicles[jobGrade]

		for k,v in ipairs(vehicles) do
			if GetHashKey(v.model) == hashKey then
				return v.price
			end
		end
	end

	return 0
end

RegisterServerEvent('esx_ambulancejob:removeItem')
AddEventHandler('esx_ambulancejob:removeItem', function(item)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem(item, 1)

	if item == 'bandage' then
		TriggerClientEvent('esx:showNotification', _source, _U('used_bandage'))
	elseif item == 'medikit' then
		TriggerClientEvent('esx:showNotification', _source, _U('used_medikit'))
	elseif item == 'pill' then
		TriggerClientEvent('esx:showNotification', _source, _U('used_pill'))
	elseif item == 'drug1' then
		TriggerClientEvent('esx:showNotification', _source, _U('used_drug1'))
	elseif item == 'drug2' then
		TriggerClientEvent('esx:showNotification', _source, _U('used_drug2'))
	elseif item == 'drug3' then
		TriggerClientEvent('esx:showNotification', _source, _U('used_drug3'))
	end
end)

RegisterServerEvent('esx_ambulancejob:giveItem')
AddEventHandler('esx_ambulancejob:giveItem', function(itemName)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'ambulance' then
		print(('esx_ambulancejob: %s attempted to spawn in an item!'):format(xPlayer.identifier))
		return
	elseif (itemName ~= 'medikit' and itemName ~= 'bandage' and itemName ~= 'pill' and itemName ~= 'drug1' and itemName ~= 'drug2' and itemName ~= 'drug3') then
		print(('esx_ambulancejob: %s attempted to spawn in an item!'):format(xPlayer.identifier))
		return
	end

	local xItem = xPlayer.getInventoryItem(itemName)
	local count = 1

	if xItem.limit ~= -1 then
		count = xItem.limit - xItem.count
	end

	if xItem.count < xItem.limit then
		xPlayer.addInventoryItem(itemName, count)
	else
		TriggerClientEvent('esx:showNotification', source, _U('max_item'))
	end
end)

TriggerEvent('es:addGroupCommand', 'revive', 'admin', function(source, args, user)
	if args[1] ~= nil then
		if GetPlayerName(tonumber(args[1])) ~= nil then
			print(('esx_ambulancejob: %s used admin revive'):format(GetPlayerIdentifiers(source)[1]))
			TriggerClientEvent('esx_ambulancejob:revive', tonumber(args[1]))
		end
	else
		TriggerClientEvent('esx_ambulancejob:revive', source)
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, { help = _U('revive_help'), params = {{ name = 'id' }} })

ESX.RegisterUsableItem('medikit', function(source)
	if not playersHealing[source] then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('medikit', 1)

		playersHealing[source] = true
		TriggerClientEvent('esx_ambulancejob:useItem', source, 'medikit')

		Citizen.Wait(10000)
		playersHealing[source] = nil
	end
end)

ESX.RegisterUsableItem('bandage', function(source)
	if not playersHealing[source] then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('bandage', 1)

		playersHealing[source] = true
		TriggerClientEvent('esx_ambulancejob:useItem', source, 'bandage')

		Citizen.Wait(10000)
		playersHealing[source] = nil
	end
end)

ESX.RegisterUsableItem('pill', function(source)
	if not playersHealing[source] then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('pill', 1)

		playersHealing[source] = true
		TriggerClientEvent('esx_ambulancejob:useItem', source, 'pill')

		Citizen.Wait(10000)
		playersHealing[source] = nil
	end
end)

ESX.RegisterUsableItem('drug1', function(source)
	if not playersHealing[source] then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('drug1', 1)

		playersHealing[source] = true
		TriggerClientEvent('esx_ambulancejob:useItem', source, 'drug1')

		Citizen.Wait(10000)
		playersHealing[source] = nil
	end
end)

ESX.RegisterUsableItem('drug2', function(source)
	if not playersHealing[source] then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('drug2', 1)

		playersHealing[source] = true
		TriggerClientEvent('esx_ambulancejob:useItem', source, 'drug2')

		Citizen.Wait(10000)
		playersHealing[source] = nil
	end
end)

ESX.RegisterUsableItem('drug3', function(source)
	if not playersHealing[source] then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('drug3', 1)

		playersHealing[source] = true
		TriggerClientEvent('esx_ambulancejob:useItem', source, 'drug3')

		Citizen.Wait(10000)
		playersHealing[source] = nil
	end
end)

ESX.RegisterServerCallback('esx_ambulancejob:getDeathStatus', function(source, cb)
	local identifier = GetPlayerIdentifiers(source)[1]

	MySQL.Async.fetchScalar('SELECT is_dead FROM users WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(isDead)
		if isDead then
			print(('esx_ambulancejob: %s attempted combat logging!'):format(identifier))
		end

		cb(isDead)
	end)
end)

RegisterServerEvent('esx_ambulancejob:setDeathStatus')
AddEventHandler('esx_ambulancejob:setDeathStatus', function(isDead)
	local identifier = GetPlayerIdentifiers(source)[1]

	if type(isDead) ~= 'boolean' then
		print(('esx_ambulancejob: %s attempted to parse something else than a boolean to setDeathStatus!'):format(identifier))
		return
	end

	MySQL.Sync.execute('UPDATE users SET is_dead = @isDead WHERE identifier = @identifier', {
		['@identifier'] = identifier,
		['@isDead'] = isDead
	})
end)

RegisterServerEvent('esx_ambulancejob:getStockItem')
AddEventHandler('esx_ambulancejob:getStockItem', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_ambulance', function(inventory)
		local item = inventory.getItem(itemName)
		local sourceItem = xPlayer.getInventoryItem(itemName)

		-- is there enough in the society?
		if count > 0 and item.count >= count then

			-- can the player carry the said amount of x item?
			if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('player_cannot_hold'))
			else
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_withdrawn', count, item.label))
			end
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_quantity'))
		end
	end)
end)

ESX.RegisterServerCallback('esx_ambulancejob:getStockItems', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_ambulance', function(inventory)
		cb(inventory.items)
	end)
end)

RegisterServerEvent('esx_ambulancejob:putStockItems')
AddEventHandler('esx_ambulancejob:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_ambulance', function(inventory)
		local item = inventory.getItem(itemName)
		local playerItemCount = xPlayer.getInventoryItem(itemName).count

		if item.count >= 0 and count <= playerItemCount then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_quantity'))
		end

		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_deposited', count, item.label))
	end)
end)

ESX.RegisterServerCallback('esx_ambulancejob:getPlayerInventory', function(source, cb)
	local xPlayer    = ESX.GetPlayerFromId(source)
	local items      = xPlayer.inventory

	cb({items = items})
end)
