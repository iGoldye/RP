
function getDisplayName(source)
	local name = GetPlayerName(source)
	if Config.EnableESXIdentity then name = GetCharacterName(source) end
	return name
end

function write_ooc(source, message)
	TriggerClientEvent('chat:addMessage', -1, { args = { _U('ooc_prefix', getDisplayName(source)), message }, color = { 128, 128, 128 } })
end

function write_twt(source, message)
	TriggerClientEvent('chat:addMessage', -1, { args = { _U('twt_prefix', getDisplayName(source)), message }, color = { 0, 153, 204 } })
end

function write_me(source, message)
	TriggerClientEvent('esx_rpchat:sendProximityMessage', -1, source, _U('me_prefix', getDisplayName(source)), message, { 255, 0, 0 })
	TriggerClientEvent('3dme:me', source, message)
end

function write_do(source, message)
	TriggerClientEvent('esx_rpchat:sendProximityMessage', -1, source, _U('do_prefix', getDisplayName(source)), message, { 0, 0, 255 })
end

AddEventHandler('es:invalidCommandHandler', function(source, command_args, user)
	CancelEvent()
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', _U('unknown_command', command_args[1]) } })
end)

AddEventHandler('chatMessage', function(source, name, message)
	if string.sub(message, 1, string.len('/')) ~= '/' then
		CancelEvent()
		write_me(source, message)
	end
end)

RegisterCommand('ooc', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end

	local message = table.concat(args, ' ')
	write_ooc(source, message)

end, false)

RegisterCommand('twt', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end

	local message = table.concat(args, ' ')
	write_twt(source, message)

end, false)

RegisterCommand('me', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end

	local message = table.concat(args, ' ')
	write_me(source, message)

end, false)

RegisterCommand('do', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end

	local message = table.concat(args, ' ')
	write_do(source, message)

end, false)

function GetCharacterName(source)
	local result = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
		['@identifier'] = GetPlayerIdentifiers(source)[1]
	})

	if result[1] and result[1].firstname and result[1].lastname then
		if Config.OnlyFirstname then
			return result[1].firstname
		else
			return ('%s %s'):format(result[1].firstname, result[1].lastname)
		end
	else
		return GetPlayerName(source)
	end
end
