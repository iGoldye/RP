
TriggerEvent('es:addGroupCommand', 'emote', 'admin', function(source, args, user)
	TriggerClientEvent('admin_commands:emote', source, args)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = "Get current player coordinates"})
