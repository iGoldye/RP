ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local Vehicles = nil

RegisterServerEvent('esx_lscustom:duplicateKey')
AddEventHandler('esx_lscustom:duplicateKey', function(plate)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if string.find(plate, " ") == nil then
		TriggerClientEvent('esx:showNotification', _source, "Ключ сломался")
		return
	end

	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_mechanic', function(account)
		if account.money >= 10 then
			local item = exports['esx_inventory']:createItem("carkey", { ["plate"] = plate }, 1, 0)
			TriggerEvent('esx_inventory:addItem', "pocket", xPlayer.identifier, item, function()
				TriggerClientEvent('esx:showNotification', _source, _U('purchased'))
				account.removeMoney(10)
			end)
		else
			TriggerClientEvent('esx:showNotification', _source, _U('not_enough_money'))
		end
	end)
end)

RegisterServerEvent('esx_lscustom:buyMod')
AddEventHandler('esx_lscustom:buyMod', function(price)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	price = tonumber(price)

	if Config.IsMechanicJobOnly then

		local societyAccount = nil
		TriggerEvent('esx_addonaccount:getSharedAccount', 'society_mechanic', function(account)
			societyAccount = account
		end)
		if price < societyAccount.money then
			TriggerClientEvent('esx_lscustom:installMod', _source)
			TriggerClientEvent('esx:showNotification', _source, _U('purchased'))
			societyAccount.removeMoney(price)
		else
			TriggerClientEvent('esx_lscustom:cancelInstallMod', _source)
			TriggerClientEvent('esx:showNotification', _source, _U('not_enough_money'))
		end

	else

		if price < xPlayer.getMoney() then
			TriggerClientEvent('esx_lscustom:installMod', _source)
			TriggerClientEvent('esx:showNotification', _source, _U('purchased'))
			xPlayer.removeMoney(price)
		else
			TriggerClientEvent('esx_lscustom:cancelInstallMod', _source)
			TriggerClientEvent('esx:showNotification', _source, _U('not_enough_money'))
		end

	end
end)

RegisterServerEvent('esx_lscustom:refreshOwnedVehicle')
AddEventHandler('esx_lscustom:refreshOwnedVehicle', function(myCar)
	MySQL.Async.execute('UPDATE `owned_vehicles` SET `vehicle` = @vehicle WHERE `plate` = @plate',
	{
		['@plate']   = myCar.plate,
		['@vehicle'] = json.encode(myCar)
	})
end)

ESX.RegisterServerCallback('esx_lscustom:getVehiclesPrices', function(source, cb)
	if Vehicles == nil then
		MySQL.Async.fetchAll('SELECT * FROM vehicles', {}, function(result)
			local vehicles = {}

			for i=1, #result, 1 do
				table.insert(vehicles, {
					model = result[i].model,
					price = result[i].price
				})
			end

			Vehicles = vehicles
			cb(Vehicles)
		end)
	else
		cb(Vehicles)
	end
end)