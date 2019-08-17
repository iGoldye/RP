ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


TriggerEvent('es:addGroupCommand', 'emote', 'admin', function(source, args, user)
	TriggerClientEvent('admin_commands:emote', source, args)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = "Get current player coordinates"})


TriggerEvent('es:addGroupCommand', 'repair', 'admin', function(source, args, user)
	TriggerClientEvent('admin_commands:repair', source)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = "Починить автомобиль"})

TriggerEvent('es:addGroupCommand', 'addpassport', 'admin', function(source, args, user)
	local xPlayer = ESX.GetPlayerFromId(source)

	if #args >= 1 then
		local target = tonumber(args[1])
		if target ~= nil then
			xPlayer = ESX.GetPlayerFromId(target)
		end
	end

	TriggerEvent("esx_inventory:createItem", "passport", {}, 1, 0, function(item)
		TriggerEvent("esx_inventory:addItem", "pocket", xPlayer.identifier, item, function(ret)
		end)
	end)

end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = "Получить паспорт игрока"})

TriggerEvent('es:addGroupCommand', 'sethunger', 'admin', function(source, args, user)
	TriggerClientEvent('esx_status:set', source, 'hunger', tonumber(args[1]) or 0)

end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = "Установить значение сытости"})

TriggerEvent('es:addGroupCommand', 'setthirst', 'admin', function(source, args, user)
	TriggerClientEvent('esx_status:set', source, 'thirst', tonumber(args[1]) or 0)

end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = "Установить значение жажды"})

TriggerEvent('es:addGroupCommand', 'setmodel', 'admin', function(source, args, user)
	TriggerClientEvent('admin_commands:setmodel', source, args)

end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = "Установить хэш игрока"})
