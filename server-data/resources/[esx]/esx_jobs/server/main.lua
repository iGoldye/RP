local PlayersWorking = {}
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local function Work(worker_id, source, item, notifyTimer)
	notifyTimer = notifyTimer or -1

	SetTimeout(item[1].time, function()
		if PlayersWorking[source] and PlayersWorking[source] == worker_id then

			local xPlayer = ESX.GetPlayerFromId(source)
			if xPlayer == nil then
				return
			end

			for i=1, #item, 1 do
				local itemQtty = 0
				if item[i].name ~= _U('delivery') then
					itemQtty = xPlayer.getInventoryItem(item[i].db_name).count
				end

				local requiredItemQtty = 0
				if item[1].requires ~= "nothing" then
					requiredItemQtty = xPlayer.getInventoryItem(item[1].requires).count
				end

				if item[i].name ~= _U('delivery') and itemQtty >= item[i].max then
					TriggerClientEvent('esx:showNotification', source, _U('max_limit', item[i].name))
				elseif item[i].requires ~= "nothing" and requiredItemQtty <= 0 then
					if notifyTimer < 0 then
						TriggerClientEvent('esx:showNotification', source, _U('not_enough', item[1].requires_name))
					end
				else
					if item[i].name ~= _U('delivery') then
						-- Chances to drop the item
						if item[i].drop == 100 then
							xPlayer.addInventoryItem(item[i].db_name, item[i].add)
						else
							local chanceToDrop = math.random(100)
							if chanceToDrop <= item[i].drop then
								xPlayer.addInventoryItem(item[i].db_name, item[i].add)
							end
						end
					else
						xPlayer.addMoney(item[i].price)
					end
				end
			end

			if item[1].requires ~= "nothing" then
				local itemToRemoveQtty = xPlayer.getInventoryItem(item[1].requires).count
				if itemToRemoveQtty > 0 then
					xPlayer.removeInventoryItem(item[1].requires, item[1].remove)
				end
			end

			if notifyTimer < 0 then
				notifyTimer = 5000
			end

			Work(worker_id, source, item, notifyTimer - item[1].time)

		end
	end)
end

RegisterServerEvent('esx_jobs:startWork')
AddEventHandler('esx_jobs:startWork', function(item)
	local xPlayer = ESX.GetPlayerFromId(source)
	if PlayersWorking[source] == nil then
		local worker_id = math.random(1,1000)
		PlayersWorking[source] = worker_id
		Work(worker_id, source, item)
	else
		print(('esx_jobs: %s attempted to exploit the marker!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_jobs:stopWork')
AddEventHandler('esx_jobs:stopWork', function()
	PlayersWorking[source] = nil
end)

RegisterServerEvent('esx_jobs:caution')
AddEventHandler('esx_jobs:caution', function(cautionType, cautionAmount, spawnPoint, vehicle)
	local xPlayer = ESX.GetPlayerFromId(source)

	if cautionType == "take" then
		TriggerEvent('esx_addonaccount:getAccount', 'caution', xPlayer.identifier, function(account)
			xPlayer.removeAccountMoney('bank', cautionAmount)
			account.addMoney(cautionAmount)
		end)

		TriggerClientEvent('esx:showNotification', source, _U('bank_deposit_taken', ESX.Math.GroupDigits(cautionAmount)))
		TriggerClientEvent('esx_jobs:spawnJobVehicle', source, spawnPoint, vehicle)
	elseif cautionType == "give_back" then

-- FIXME: In future we need to get caution amount from server config to prevent cheating!
--[[
		if cautionAmount > 1 then
			print(('esx_jobs: %s is using cheat engine!'):format(xPlayer.identifier))
			return
		end
]]--
		TriggerEvent('esx_addonaccount:getAccount', 'caution', xPlayer.identifier, function(account)
--			local caution = account.money
			local toGive = ESX.Math.Round(cautionAmount)

			xPlayer.addAccountMoney('bank', toGive)
			account.removeMoney(toGive)
			TriggerClientEvent('esx:showNotification', source, _U('bank_deposit_returned', ESX.Math.GroupDigits(toGive)))
		end)
	end
end)
