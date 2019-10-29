local instances = {}
--[[
RegisterCommand("instances", function(source, args, raw)
	for k,v in pairs(instances) do
		TriggerClientEvent('chatMessage', -1, 'INSTANCES', {255, 0, 0}, tostring(k))
		TriggerClientEvent('chatMessage', -1, 'INSTANCES', {255, 0, 0}, json.encode(v))
	end
end)

RegisterCommand("instance_enter", function(source, args, raw)
	for k,v in pairs(instances) do
		if k == args[1] then
			TriggerClientEvent('chatMessage', -1, 'INSTANCES', {255, 0, 0}, "Entering...")
			AddPlayerToInstance(v, source)
			break
		end
	end
end)

RegisterCommand("instance_exit", function(source, args, raw)
	for k,v in pairs(instances) do
		if k == args[1] then
			TriggerClientEvent('chatMessage', -1, 'INSTANCES', {255, 0, 0}, "Exiting...")
			RemovePlayerFromInstance(v, source)
			break
		end
	end
end)
]]--
function GetInstancedPlayers()
	local players = {}

	for k,v in pairs(instances) do
		for k2,v2 in ipairs(v.players) do
			players[v2] = true
		end
	end

	return players
end

function CreateInstance(id, type, player, data)
	if instances[id] == nil then

		instances[id] = {
			id      = id,
			type    = type,
			host    = player,
			players = {},
			data    = data
		}
	end

	TriggerEvent('instance:onCreate', instances[id])
	TriggerClientEvent('instance:onCreate', player, instances[id])
	TriggerClientEvent('instance:onInstancedPlayersData', -1, GetInstancedPlayers())
end

function CloseInstance(id, source)
	if instances[id] then

		for i=1, #instances[id].players do
			TriggerClientEvent('instance:onClose', instances[id].players[i])
		end

		instances[id] = nil

		TriggerClientEvent('instance:onInstancedPlayersData', -1, GetInstancedPlayers())
		TriggerEvent('instance:onClose', id)
	end
end

function AddPlayerToInstance(instance, player)
	local found = false

	local id = instance.id

	for i=1, #instances[id].players do
		if instances[id].players[i] == player then
			found = true
			break
		end
	end

	if not found then
		table.insert(instances[id].players, player)
	end

	TriggerClientEvent('instance:onEnter', player, instances[id])

	for i=1, #instances[id].players do
		if instances[id].players[i] ~= player then
			TriggerClientEvent('instance:onPlayerEntered', instances[id].players[i], instances[id], player)
		end
	end

	TriggerClientEvent('instance:onInstancedPlayersData', -1, GetInstancedPlayers())
end

function RemovePlayerFromInstance(id, player)
	if instances[id] then
		TriggerClientEvent('instance:onLeave', player, instances[id])
--[[
		if instances[id].host == player then
			for i=1, #instances[id].players do
				if instances[id].players[i] ~= player then
					TriggerClientEvent('instance:onPlayerLeft', instances[id].players[i], instances[id], player)
				end
			end

			CloseInstance(id)
		else
	]]--

			for i=1, #instances[id].players do
				if instances[id].players[i] == player then
--					instances[id].players[i] = nil
					table.remove(instances[id].players, i)
					break
				end
			end


			for i=1, #instances[id].players do
				if instances[id].players[i] ~= player then
					TriggerClientEvent('instance:onPlayerLeft', instances[id].players[i], instances[id], player)
				end
			end


			TriggerClientEvent('instance:onInstancedPlayersData', -1, GetInstancedPlayers())
	end
--	end
end

function InvitePlayerToInstance(id, type, player, data)
	TriggerClientEvent('instance:onInvite', player, id, type, data)
end

RegisterServerEvent('instance:create')
AddEventHandler('instance:create', function(id, type, data)
	CreateInstance(id, type, source, data)
end)

RegisterServerEvent('instance:close')
AddEventHandler('instance:close', function(id)
	CloseInstance(id, source)
end)

RegisterServerEvent('instance:enter')
AddEventHandler('instance:enter', function(instance)
	AddPlayerToInstance(instance, source)
end)

RegisterServerEvent('instance:leave')
AddEventHandler('instance:leave', function(id)
	RemovePlayerFromInstance(id, source)
end)

RegisterServerEvent('instance:invite')
AddEventHandler('instance:invite', function(id, type, player, data)
	InvitePlayerToInstance(id, type, player, data)
end)
