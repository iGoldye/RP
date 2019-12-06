ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function getIdentity(source, callback)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT identifier, firstname, lastname, dateofbirth, sex, height FROM `users` WHERE `identifier` = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
		if #result > 0 and result[1].firstname ~= nil then
			local data = {
				identifier	= result[1].identifier,
				firstname	= result[1].firstname,
				lastname	= result[1].lastname,
				dateofbirth	= result[1].dateofbirth,
				sex			= result[1].sex,
				height		= result[1].height
			}

			callback(data)
		else
			local data = {
				identifier	= '',
				firstname	= '',
				lastname	= '',
				dateofbirth	= '',
				sex			= '',
				height		= ''
			}

			callback(data)
		end
	end)
end

function getCharacters(source, callback)
	local xPlayer = ESX.GetPlayerFromId(source)
	local identifier = xPlayer.identifier
	MySQL.Async.fetchAll('SELECT * FROM `characters` WHERE `identifier` = @identifier', {
		['@identifier'] = identifier
	}, function(result)
		if result[1] and result[2] and result[3] then

			local data = {
				identifier		= result[1].identifier,
				firstname1		= result[1].firstname,
				lastname1		= result[1].lastname,
				dateofbirth1	= result[1].dateofbirth,
				sex1			= result[1].sex,
				height1			= result[1].height,
				firstname2		= result[2].firstname,
				lastname2		= result[2].lastname,
				dateofbirth2	= result[2].dateofbirth,
				sex2			= result[2].sex,
				height2			= result[2].height,
				firstname3		= result[3].firstname,
				lastname3		= result[3].lastname,
				dateofbirth3	= result[3].dateofbirth,
				sex3			= result[3].sex,
				height3			= result[3].height
			}

			callback(data)

		elseif result[1] and result[2] and not result[3] then

			local data = {
				identifier		= result[1].identifier,
				firstname1		= result[1].firstname,
				lastname1		= result[1].lastname,
				dateofbirth1	= result[1].dateofbirth,
				sex1			= result[1].sex,
				height1			= result[1].height,
				firstname2		= result[2].firstname,
				lastname2		= result[2].lastname,
				dateofbirth2	= result[2].dateofbirth,
				sex2			= result[2].sex,
				height2			= result[2].height,
				firstname3		= '',
				lastname3		= '',
				dateofbirth3	= '',
				sex3			= '',
				height3			= ''
			}

			callback(data)

		elseif result[1] and not result[2] and not result[3] then

			local data = {
				identifier		= result[1].identifier,
				firstname1		= result[1].firstname,
				lastname1		= result[1].lastname,
				dateofbirth1	= result[1].dateofbirth,
				sex1			= result[1].sex,
				height1			= result[1].height,
				firstname2		= '',
				lastname2		= '',
				dateofbirth2	= '',
				sex2			= '',
				height2			= '',
				firstname3		= '',
				lastname3		= '',
				dateofbirth3	= '',
				sex3			= '',
				height3			= ''
			}

			callback(data)

		else

			local data = {
				identifier		= '',
				firstname1		= '',
				lastname1		= '',
				dateofbirth1	= '',
				sex1			= '',
				height1			= '',
				firstname2		= '',
				lastname2		= '',
				dateofbirth2	= '',
				sex2			= '',
				height2			= '',
				firstname3		= '',
				lastname3		= '',
				dateofbirth3	= '',
				sex3			= '',
				height3			= ''
			}

			callback(data)

		end
	end)
end

function setIdentity(identifier, data, callback)
	MySQL.Async.execute('UPDATE `users` SET `firstname` = @firstname, `lastname` = @lastname, `dateofbirth` = @dateofbirth, `sex` = @sex, `height` = @height WHERE identifier = @identifier', {
		['@identifier']		= identifier,
		['@firstname']		= data.firstname,
		['@lastname']		= data.lastname,
		['@dateofbirth']	= data.dateofbirth,
		['@sex']			= data.sex,
		['@height']			= data.height
	}, function(rowsChanged)
		if callback then
			callback(true)
		end
	end)

	MySQL.Async.execute('INSERT INTO characters (identifier, firstname, lastname, dateofbirth, sex, height) VALUES (@identifier, @firstname, @lastname, @dateofbirth, @sex, @height)', {
		['@identifier']		= identifier,
		['@firstname']		= data.firstname,
		['@lastname']		= data.lastname,
		['@dateofbirth']	= data.dateofbirth,
		['@sex']			= data.sex,
		['@height']			= data.height
	})
end

function updateIdentity(identifier, data, callback)
	MySQL.Async.execute('UPDATE `users` SET `firstname` = @firstname, `lastname` = @lastname, `dateofbirth` = @dateofbirth, `sex` = @sex, `height` = @height WHERE identifier = @identifier', {
		['@identifier']		= identifier,
		['@firstname']		= data.firstname,
		['@lastname']		= data.lastname,
		['@dateofbirth']	= data.dateofbirth,
		['@sex']			= data.sex,
		['@height']			= data.height
	}, function(rowsChanged)
		if callback then
			callback(true)
		end
	end)
end

function deleteIdentity(identifier, data, callback)
	MySQL.Async.execute('DELETE FROM `characters` WHERE identifier = @identifier AND firstname = @firstname AND lastname = @lastname AND dateofbirth = @dateofbirth AND sex = @sex AND height = @height', {
		['@identifier']		= identifier,
		['@firstname']		= data.firstname,
		['@lastname']		= data.lastname,
		['@dateofbirth']	= data.dateofbirth,
		['@sex']			= data.sex,
		['@height']			= data.height
	}, function(rowsChanged)
		if callback then
			callback(true)
		end
	end)
end

RegisterServerEvent('esx_identity:setIdentity')
AddEventHandler('esx_identity:setIdentity', function(data, myIdentifiers)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local identifier = myIdentifiers.steamid
	if xPlayer ~= nil and xPlayer.identifier ~= nil then
		identifier = xPlayer.identifier
	end

	setIdentity(identifier, data, function(callback)
		if callback then
			TriggerClientEvent('esx_identity:identityCheck', _source, data)

			if xPlayer ~= nil then
				xPlayer.setSessionVar("identity", data)
				xPlayer.setMoney(500)
				xPlayer.setBankBalance(1500)
				xPlayer.setAccountMoney('black_money', 0)
				xPlayer.setInventoryItem('phone', 1)
			end
		else
			TriggerClientEvent('chat:addMessage', _source, { args = { '^[IDENTITY]', 'Failed to set character, try again later or contact the server admin!' } })
		end
	end)
end)

AddEventHandler('esx:playerLoaded', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	local myID = {
		steamid = xPlayer.identifier,
		playerid = source
	}

	TriggerClientEvent('esx_identity:saveID', source, myID)
	getIdentity(source, function(data)
		local xPlayer = ESX.GetPlayerFromId(source)
		if data.firstname == '' then
			xPlayer.setSessionVar("identity", nil)
			TriggerClientEvent('esx_identity:identityCheck', source, nil)
			TriggerClientEvent('esx_identity:showRegisterIdentity', source)
		else
			xPlayer.setSessionVar("identity", data)
			TriggerClientEvent('esx_identity:identityCheck', source, data)
		end
	end)
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(3000)

		-- Set all the client side variables for connected users one new time
		local xPlayers, xPlayer = ESX.GetPlayers()
		for i=1, #xPlayers, 1 do
			xPlayer = ESX.GetPlayerFromId(xPlayers[i])

			local myID = {
				steamid  = xPlayer.identifier,
				playerid = xPlayer.source
			}

			TriggerClientEvent('esx_identity:saveID', xPlayer.source, myID)

			getIdentity(xPlayer.source, function(data)
				if data.firstname == '' then
					xPlayer.setSessionVar("identity", nil)
					TriggerClientEvent('esx_identity:identityCheck', xPlayer.source, nil)
					TriggerClientEvent('esx_identity:showRegisterIdentity', xPlayer.source)
				else
					xPlayer.setSessionVar("identity", data)
					TriggerClientEvent('esx_identity:identityCheck', xPlayer.source, data)
				end
			end)
		end
	end
end)

TriggerEvent('es:addCommand', 'register', function(source, args, user)
	getCharacters(source, function(data)
		if data.firstname3 ~= '' then
			TriggerClientEvent('chat:addMessage', source, { args = { '^[IDENTITY]', 'You can only have 3 registered characters. Use the ^3/chardel^0  command in order to delete existing characters.' } })
		else
			TriggerClientEvent('esx_identity:showRegisterIdentity', source, {})
		end
	end)
end, {help = "Register a new character"})

TriggerEvent('es:addGroupCommand', 'char', 'user', function(source, args, user)
	getIdentity(source, function(data)
		if data.firstname == '' then
			TriggerClientEvent('chat:addMessage', source, { args = { '^1[IDENTITY]', 'You do not have an active character!' } })
		else
			TriggerClientEvent('chat:addMessage', source, { args = { '^1[IDENTITY]', 'Active character: ^2' .. data.firstname .. ' ' .. data.lastname } })
		end
	end)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient permissions!' } })
end, {help = "List your current character"})

TriggerEvent('es:addGroupCommand', 'charlist', 'user', function(source, args, user)
	getCharacters(source, function(data)
		if data.firstname1 ~= '' then
			TriggerClientEvent('chat:addMessage', source, { args = { '^1[IDENTITY] Character 1:', data.firstname1 .. ' ' .. data.lastname1 } })

			if data.firstname2 ~= '' then
				TriggerClientEvent('chat:addMessage', source, { args = { '^1[IDENTITY] Character 2:', data.firstname2 .. ' ' .. data.lastname2 } })

				if data.firstname3 ~= '' then
					TriggerClientEvent('chat:addMessage', source, { args = { '^1[IDENTITY] Character 3:', data.firstname3 .. ' ' .. data.lastname3 } })
				end
			end
		else
			TriggerClientEvent('chat:addMessage', source, { args = { '^[IDENTITY]', 'You have no registered characters. Use the ^3/register^0 command to register a character.' } })
		end
	end)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient permissions!' } })
end, {help = "List all your registered characters"})

TriggerEvent('es:addGroupCommand', 'charselect', 'user', function(source, args, user)
	local xPlayer = ESX.GetPlayerFromId(source)
	local charNumber = tonumber(args[1])

	if charNumber == nil or charNumber > 3 or charNumber < 1 then
		TriggerClientEvent('chat:addMessage', source, { args = { '^1[IDENTITY]', 'That\'s an invalid character!' } })
		return
	end

	getCharacters(source, function(data)
			local cn = tostring(charNumber)
			local data = {
				identifier	= data.identifier,
				firstname	= data["firstname"..cn],
				lastname	= data["lastname"..cn],
				dateofbirth	= data["dateofbirth"..cn],
				sex		= data["sex"..cn],
				height		= data["height"..cn],
			}

			if data.firstname ~= '' then
				updateIdentity(xPlayer.identifier, data, function(callback)
					if callback then
						TriggerClientEvent('chat:addMessage', source, { args = { '^5[IDENTITY]', 'Updated your active character to ^2' .. data.firstname .. ' ' .. data.lastname } })
					else
						TriggerClientEvent('chat:addMessage', source, { args = { '^5[IDENTITY]', 'Failed to update your identity, try again later or contact the server admin!' } })
					end
				end)
			else
				TriggerClientEvent('chat:addMessage', source, { args = { '^1[IDENTITY]', 'You don\'t have a character in slot '..cn..'!' } })
			end
	end)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient permissions!' } })
end, {help = "Switch between character", params = {{name = "char", help = "the character id, ranges from 1-3"}}})

TriggerEvent('es:addGroupCommand', 'chardel', 'user', function(source, args, user)
	local xPlayer = ESX.GetPlayerFromId(source)
	local charNumber = tonumber(args[1])

	if charNumber == nil or charNumber > 3 or charNumber < 1 then
		TriggerClientEvent('chat:addMessage', source, { args = { '^[IDENTITY]', 'That\'s an invalid character!' } })
		return
	end

	getCharacters(source, function(data)
			local cn = tostring(charNumber)

			local data = {
				identifier	= data.identifier,
				firstname	= data["firstname"..cn],
				lastname	= data["lastname"..cn],
				dateofbirth	= data["dateofbirth"..cn],
				sex		= data["sex"..cn],
				height		= data["height"..cn],
			}

			if data.firstname ~= '' then
				deleteIdentity(xPlayer.identifier, data, function(callback)
					if callback then
						TriggerClientEvent('chat:addMessage', source, { args = { '^1[IDENTITY]', 'You have deleted ^1' .. data.firstname .. ' ' .. data.lastname } })
					else
						TriggerClientEvent('chat:addMessage', source, { args = { '^1[IDENTITY]', 'Failed to delete the character, try again later or contact the server admin!' } })
					end
				end)
			else
				TriggerClientEvent('chat:addMessage', source, { args = { '^1[IDENTITY]', 'You don\'t have a character in slot '..cn..'!' } })
			end
	end)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient permissions!' } })
end, {help = "Delete a registered character", params = {{name = "char", help = "the character id, ranges from 1-3"}}})
