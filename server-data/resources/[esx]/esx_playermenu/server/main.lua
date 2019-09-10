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
