ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

MySQL.ready(function()
end)

RegisterServerEvent('esx_bossmenu:hire')
AddEventHandler('esx_bossmenu:hire', function(jobname, target)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromId(target)
	xTarget.setJob(jobname, 0)
	ESX.ServerCallbacks['esx_society:setJob'](xPlayer.source, function() end, xTarget.identifier, jobname, 0, 'hire')
end)
--ESX.RegisterServerCallback('esx_society:setJob', function(source, cb, identifier, job, grade, type)
ESX.RegisterServerCallback('esx_bossmenu:getMoneyWashAmount', function(source, cb, societyName)
	MySQL.Async.fetchAll('SELECT amount FROM society_moneywash WHERE society = @society', { ["@society"] = societyName }, function(result)
		local wholeMoney = 0
		for i=1, #result, 1 do
			wholeMoney = wholeMoney + result[i].amount
		end

		cb(wholeMoney)
	end)
end)

