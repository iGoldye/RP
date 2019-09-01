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

	if #args >= 2 then
		local target = tonumber(args[1])
		if target ~= nil then
			xPlayer = ESX.GetPlayerFromId(target)
			if xPlayer ~= nil then
				TriggerClientEvent('admin_commands:setmodel', xPlayer.source, args[2])
			else
				TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Игрок не найден на сервере.' } })
			end
		else
			TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Неверный ID пользователя.' } })
		end
	else
		TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Неверное число аргументов.' } })
	end

end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = "Установить хэш игрока", params = {{name = "userid", help = "ID игрока"},{name = "hash", help = "имя хэша или skin"}}})


TriggerEvent('es:addGroupCommand', 'spawncar', 'admin', function(source, args, user)
	local plate = table.concat(args, " ")
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE `stored` = false and fourrieremecano = false', {
	}, function(results)

		for i=1,#results do
			local res = results[i]
			if res.plate == plate then
				local props = json.decode(res.vehicle)
				TriggerClientEvent('admin_commands:spawncar', source, props)
				break
			end
		end
	end)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = "Заспавнить автомобиль игрока", params = {{name = "plate", help = "Автомобильный номер"}}})
