ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

requests = {}

RegisterServerEvent('esx_request:onReply')
AddEventHandler('esx_request:onReply', function(player, res)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer ~= nil then
		if res == true then
			requests[xPlayer.source] = player
		else
			requests[xPlayer.source] = -1
		end
	end
end)

ESX.RegisterServerCallback('esx_request:request', function(source, cb, target, text)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromId(target)

	local name = GetPlayerName(source)

	requests[xTarget.source] = 0
	TriggerClientEvent('esx_request:request', target, source, name, text, 'esx_request:onReply')
	local tm = 0

	while requests[xTarget.source] == 0 and tm < 100 do
		Citizen.Wait(100)
		tm = tm + 1
	end

	if requests[xTarget.source] == source then
		cb(true)
	elseif requests[xTarget.source] == 0 then
		cb(nil) -- no answer
	else
		cb(false)
	end
	requests[xTarget.source] = nil
end)
