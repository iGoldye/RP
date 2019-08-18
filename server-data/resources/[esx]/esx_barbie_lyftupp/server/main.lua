ESX = nil

local give = false

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

RegisterServerEvent('esx_barbie_lyftupp:lyfter')
AddEventHandler('esx_barbie_lyftupp:lyfter', function(target)
	local targetPlayer = ESX.GetPlayerFromId(target)

	TriggerClientEvent('esx_barbie_lyftupp:upplyft', targetPlayer.source, source)
end)

RegisterServerEvent('esx_barbie_lyftupp:lyfteruppn')
AddEventHandler('esx_barbie_lyftupp:lyfteruppn', function(source)
	TriggerClientEvent('esx:showNotification', source, ('Кто-то пытается поднять вас...'))
end)

RegisterServerEvent('esx_barbie_lyftupp:startRequest')
AddEventHandler('esx_barbie_lyftupp:startRequest', function(target, text, trigger)
	print("CCC "..target.." "..text.." "..trigger)
	print(source)
	local name = GetPlayerName(source)
	TriggerClientEvent('esx_request:request', target, source, name, text, trigger)
end)


RegisterServerEvent('esx_barbie_lyftupp:liftupp_afterRequest')
AddEventHandler('esx_barbie_lyftupp:liftupp_afterRequest', function(initiator, decision)
--	print("afterRequest: "..tostring(initiator).." "..tostring(decision))

	if decision == true then
		TriggerClientEvent('esx_barbie_lyftupp:liftupp_afterRequest', initiator)
	end
end)
