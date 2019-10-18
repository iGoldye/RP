ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

roles = {}
rolesPopulated = false

function getTarget(arg, source)
	if arg == 'me' then
		return source
	end

	return tonumber(arg)
end

function populateRoles(results)
	for i=1, #results do
		local row = results[i]
		local id = row.identifier

		if roles[id] == nil then
			roles[id] = {}
		end

		if roles[id][row.role] == nil then
			roles[id][row.role] = {}
		end

		roles[id][row.role].grade = row.grade
	end

	rolesPopulated = true
end

function getRolesFromDB(cb, id)
	local result

	if id ~= nil then
		MySQL.Async.fetchAll('SELECT `identifier`,`role`,`grade` FROM user_roles WHERE `identifier` = @identifier', {
			["@identifier"] = id,
		}, cb)
	else
		MySQL.Async.fetchAll('SELECT `identifier`,`role`,`grade` FROM user_roles', {
			["@identifier"] = id,
		}, cb)
	end
end

function hasRole(identifier, role)
	if roles[identifier] == nil then
		return false
	end

	return roles[identifier][role] ~= nil
end

function getRoles(identifier)
	return roles[identifier]
end

function getRole(identifier, role)
	if roles[identifier] == nil then
		return nil
	end

	return roles[identifier][role]
end

function setRole(identifier, role, grade)
	if roles[identifier] == nil then
		roles[identifier] = {}
	end

	if role == nil then
		error("setRole role is nil!")
	end

	if grade == nil then
		error("setRole grade is nil!")
	end

	if roles[identifier][role] == nil then
		roles[identifier][role] = {}
	end

	MySQL.Async.execute('REPLACE user_roles SET identifier=@identifier, role=@role, grade=@grade', {
		['@identifier'] = identifier,
		['@role'] = role,
		['@grade'] = grade,
	}, function(rowsChanged)
		roles[identifier][role].grade = grade
		sendRoles(identifier)
	end)

end

function removeRole(identifier, role)
	if role == nil then
		error("setRole role is nil!")
	end

	MySQL.Async.execute('DELETE FROM user_roles WHERE identifier=@identifier AND role=@role', {
		['@identifier'] = identifier,
		['@role'] = role,
	}, function(rowsChanged)
		roles[identifier][role] = nil
		sendRoles(identifier)
	end)

end

function sendRoles(identifier)
	local xPlayer = ESX.GetPlayerFromIdentifier(identifier)
	if xPlayer == nil then
		return false
	end

	local roles = getRoles(identifier)
	TriggerClientEvent('esx_roles:sendRoles', xPlayer.source, roles)
	xPlayer.setSessionVar("roles", roles)
	return true
end

MySQL.ready(function()
	if #roles == 0 then
		getRolesFromDB(populateRoles)
	end

	while not rolesPopulated do
		Citizen.Wait(1000)
	end

	local xPlayers = ESX.GetPlayers()

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer ~= nil then
			TriggerClientEvent('esx_roles:sendRoles', xPlayer.source, getRoles(xPlayer.identifier))
		end
	end
end)

ESX.RegisterServerCallback('esx_roles:getRoles', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer ~= nil then
		cb(getRoles(xPlayer.identifier))
	else
		cb({})
	end
end)


AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
	if xPlayer ~= nil then
		getRolesFromDB(populateRoles, xPlayer.identifier)
		sendRoles(identifier)
	end
end)

TriggerEvent('es:addGroupCommand', 'delrole', 'admin', function(source, args, user)
	local targetId = getTarget(args[1], source)
	local xPlayer = ESX.GetPlayerFromId(targetId)

	if xPlayer == nil then
		TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Incorrect player id!' } })
		return
	end

	local rolename = args[2]
	removeRole(xPlayer.identifier, rolename)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Success.' } })

end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = "Remove player role"})


TriggerEvent('es:addGroupCommand', 'setrole', 'admin', function(source, args, user)
	local targetId = getTarget(args[1], source)
	local xPlayer = ESX.GetPlayerFromId(targetId)
	local rolename = args[2]
	local rolegrade = tonumber(args[3])

	if xPlayer == nil then
		TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Incorrect player id!' } })
		return
	end

	if rolegrade == nil or rolegrade < 0 then
		TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Incorrect role grade.' } })
		return
	end

	setRole(xPlayer.identifier, rolename, rolegrade)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Success.' } })

end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = "Set player role"})
