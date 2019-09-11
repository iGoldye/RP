ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function updateAdmin(xPlayer)
	TriggerEvent('es:canGroupTarget', xPlayer.getGroup(), "admin", function(canTarget)
		TriggerClientEvent('esx_playermenu:setAdmin', xPlayer.source, canTarget)
	end)
end

AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
	updateAdmin(xPlayer)
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.CreateThread(function()
			Citizen.Wait(1000)
			local xPlayers = ESX.GetPlayers()

			for i=1, #xPlayers, 1 do
				local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
				if xPlayer ~= nil then
					updateAdmin(xPlayer)
				end
			end
		end)
	end
end)


ESX.RegisterServerCallback('esx_playermenu:adminGetPlayers', function(source, cb)
    xPlayer = ESX.GetPlayerFromId(source)
    if not exports["essentialmode"]:canGroupTarget(xPlayer.getGroup(), "admin") then
        return
    end

    local xPlayers = ESX.GetPlayers()
    local arr = {}
    for i=1, #xPlayers, 1 do
        local pl = ESX.GetPlayerFromId(xPlayers[i])
        table.insert(arr, {
            ["id"] = i,
            ["name"] = pl.name,
            ["identifier"] = pl.identifier,
	    ["money"] = pl.getMoney(),
        })
    end

    cb(arr)
end)

ESX.RegisterServerCallback('esx_playermenu:adminMoney', function(source, cb, identifier, act, val)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not exports["essentialmode"]:canGroupTarget(xPlayer.getGroup(), "admin") then
        return
    end
    xTarget = ESX.GetPlayerFromIdentifier(identifier)
    TriggerEvent('admin_commands:setmoney', xPlayer.source, xTarget.source, "cash", act, val)
    cb()
end)
