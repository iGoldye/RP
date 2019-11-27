-- change all these functions to the one your framework uses, default is esx :)

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

addMoney = function(src, amount)
	local xPlayer = ESX.GetPlayerFromId(src)
	xPlayer.addMoney(amount)
end

getCops = function()
	local cops = 0
	local xPlayers = ESX.GetPlayers()
	for i = 1, #xPlayers do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			if xPlayer.job.name == 'police' then
					cops = cops + 1
			end
	end
	return cops
end

notifyCops = function(store)
	Config.Shops[store].pickup_available = false
		local xPlayers = ESX.GetPlayers()
		for i = 1, #xPlayers do
				local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
				if xPlayer.job.name == 'police' then
						TriggerClientEvent('loffe_robbery:msgPolice', xPlayer.source, store, source)
				end
		end
end

msgPolice = function(store, robber)
	local mugshot, mugshotStr = ESX.Game.GetPedMugshot(GetPlayerPed(GetPlayerFromServerId(robber)))
	ESX.ShowAdvancedNotification(Config.Shops[store].name, Translation[Config.Locale]['robbery'], Translation[Config.Locale]['cop_msg'], mugshotStr, 4)
	UnregisterPedheadshot(mugshot)
	while true do
			local name = GetCurrentResourceName() .. math.random(999)
			AddTextEntry(name, '~INPUT_CONTEXT~ ' .. Translation[Config.Locale]['set_waypoint'] .. '\n~INPUT_FRONTEND_RRIGHT~ ' .. Translation[Config.Locale]['hide_box'])
			DisplayHelpTextThisFrame(name, false)
			if IsControlPressed(0, 38) then
					SetNewWaypoint(Config.Shops[store].coords.x, Config.Shops[store].coords.y)
					return
			elseif IsControlPressed(0, 194) then
					return
			end
			Wait(0)
	end
end
