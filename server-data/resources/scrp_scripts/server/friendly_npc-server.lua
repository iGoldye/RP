ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('scrp_scripts:updateRelationships')
AddEventHandler('scrp_scripts:updateRelationships', function()
	TriggerEvent("es:getPlayerFromId", source, function(user)
		local roles = {}
		local xPlayer = ESX.GetPlayerFromId(source)

		for group,v in pairs(Config.RoleRelationships) do
			if user.hasRole(group) then
				table.insert(roles, group)
			end
		end

		if xPlayer and xPlayer.job and xPlayer.job.name then
			table.insert(roles, "job_"..xPlayer.job.name)
		end

		if #roles > 0 then
			TriggerClientEvent('scrp_scripts:setRelationships', source, roles)
		end
	end)
end)
