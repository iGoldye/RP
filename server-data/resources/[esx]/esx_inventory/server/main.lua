ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
ClientInventories = {}

MySQL.ready(function()
	loadESXItemDB()
	LoadInventories()
end)

function LoadInventories()
	local xPlayers = ESX.GetPlayers()

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		LoadInventory("pocket", xPlayer.identifier)
	end
end

AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
	local owner = xPlayer.identifier
	local name = "pocket"
	LoadInventory("pocket", xPlayer.identifier)
end)

AddEventHandler('playerDropped', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer ~= nil then
		Inventories["pocket"][xPlayer.identifier].save()
	end
end)

-- SAVE INVENTORIES
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60000)

		for name,_ in pairs(Inventories) do
		for owner,_ in pairs(Inventories[name]) do

			if (Inventories[name][owner].save()) then
				print(string.format("Inventory saved %s/%s", name, owner))
			end
		end
		end

	end
end)

ESX.RegisterServerCallback('esx_inventory:getInventory', function(source, cb, name, shared)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer == nil then
		print("esx_inventory:getInventory Unknown player!")
		return
	end

	local owner = ""

	if not shared then
		owner = xPlayer.identifier
	end

	local inv = getInventory(name, owner)
	cb(inv)
end)

RegisterServerEvent('esx_inventory:createItem')
AddEventHandler('esx_inventory:createItem', function(name, extra, amount, weight, cb)
	cb(CreateItem(name, extra, amount, weight))
end)

function giveItemTo(source, target, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromId(target)

	if getInventory("pocket", xPlayer.identifier).removeItem(item) == true then
		return getInventory("pocket", xTarget.identifier).addItem(item)
	end

	return false
end

ESX.RegisterServerCallback('esx_inventory:giveItemTo', function(source, cb, playerid, item)
	return giveItemTo(source, playerid, item)
end)

RegisterServerEvent('esx_inventory:playerSpawned')
AddEventHandler('esx_inventory:playerSpawned', function()
	sendAllPickups(source)
end)
