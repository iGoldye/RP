ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_atm:deposit')
AddEventHandler('esx_atm:deposit', function(amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	amount = tonumber(amount)

	if not tonumber(amount) then return end
	amount = ESX.Math.Round(amount)

	if amount == nil or amount <= 0 or amount > xPlayer.getMoney() then
		TriggerClientEvent('esx:showNotification', _source, _U('invalid_amount'))
	else
		xPlayer.removeMoney(amount)
		xPlayer.addAccountMoney('bank', amount)
		TriggerClientEvent('esx:showNotification', _source, _U('deposit_money', amount))
	end
end)

RegisterServerEvent('esx_atm:withdraw')
AddEventHandler('esx_atm:withdraw', function(amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	amount = tonumber(amount)
	local accountMoney = xPlayer.getAccount('bank').money

	if not tonumber(amount) then return end
	amount = ESX.Math.Round(amount)

	if amount == nil or amount <= 0 or amount > accountMoney then
		TriggerClientEvent('esx:showNotification', _source, _U('invalid_amount'))
	else
		xPlayer.removeAccountMoney('bank', amount)
		xPlayer.addMoney(amount)
		TriggerClientEvent('esx:showNotification', _source, _U('withdraw_money', amount))
	end
end)

-- not suitable for net
AddEventHandler('esx_atm:pay', function(source, description, amount, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if amount < 0 then
		print("esx_atm: pay cheating "..xPlayer.identifier)
		cb(false)
		return
	end

	if amount <= xPlayer.getMoney() then
		xPlayer.removeMoney(amount)
		cb(true)
		return
	elseif amount <= xPlayer.getBank() then
		xPlayer.removeAccountMoney('bank', amount)
		cb(true)
		return
	else
		cb(false)
		return
	end
end)
