ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('lockpick', function(source)
	TriggerClientEvent("mlockpick:useItem", source)
end)

RegisterServerEvent('mlockpick:fail')
AddEventHandler('mlockpick:fail', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem('lockpick', 1)

	local item = xPlayer.getInventoryItem('lockpick')
	if item then
		TriggerClientEvent("mlockpick:setLockpickCount", _source, item.count)
	end

	if not item or item.count == 0 then
		TriggerClientEvent("mlockpick:hide", _source)
	end
end)

ESX.RegisterServerCallback('mlockpick:haveLockpick', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer == nil then
		cb(false)
		return
	end

	local item = xPlayer.getInventoryItem('lockpick')

	if item then
		TriggerClientEvent("mlockpick:setLockpickCount", source, item.count)
	end

	if not item or item.count == 0 then
		cb(false)
		return
	end

	cb(true)
end)
