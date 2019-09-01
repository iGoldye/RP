ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


TriggerEvent('es:addGroupCommand', 'toggleweb', 'admin', function(source, args, user)
	TriggerClientEvent('sosamba_ui:toggleweb', source)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = "Переключить отображение сайта поверх игрового окна"})

RegisterServerEvent('sosamba_ui:actionShowPassport')
AddEventHandler('sosamba_ui:actionShowPassport', function(item)
	local xPlayer = ESX.GetPlayerFromId(source)

	if item and item.extra and item.extra.id then
		xPlayer = ESX.GetPlayerFromIdentifier(item.extra.id)
	end

	if xPlayer == nil then
		print("sosamba_ui:actionShowPassport Unknown player!")
		return
	end

	TriggerClientEvent("esx_policejob:openIdentityCardMenu", source, xPlayer.source)
end)
