ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	TriggerEvent('esx_inventory:registerActions')
	ESX.PlayerData = ESX.GetPlayerData()
end)

--inventory = {}
itemActions = {}
itemActions["@shared"] = {}

pocketWeight = 0.0
movementSpeed = 1.0
initialized = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60000)
		ESX.PlayerData = ESX.GetPlayerData()
	end
end)

Citizen.CreateThread(function()
	while true do
		if movementSpeed < 0.9 then
			DisableControlAction(0, 22, true) -- Jump
		end
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		movementSpeed = 1.0
		while ESX == nil do
			Citizen.Wait(100)
		end

		local pocketWeightLimit = Config.PocketWeightLimit

		if ESX.PlayerData and ESX.PlayerData.skills and ESX.PlayerData.skills.strength then
			pocketWeightLimit = pocketWeightLimit + ESX.PlayerData.skills.strength / 100.0 * Config.StrengthExtraWeight
		end

		if pocketWeight > pocketWeightLimit then
			local speed = 1.0 - (pocketWeight-pocketWeightLimit)/10.0
			if speed < 0.1 then
				speed = 0.1
			end
			movementSpeed = speed

			while pocketWeight > pocketWeightLimit*2 do
				SetPedToRagdoll(PlayerPedId(), 5000, 5000, 0, 0, 0, 0)
				Citizen.Wait(1000)
			end
--[[
			local hurt = 0
			if pocketWeight > pocketWeightLimit+30 then
				hurt = 5
			elseif pocketWeight > pocketWeightLimit+20 then
				hurt = 3
			elseif pocketWeight > pocketWeightLimit+10 then
				hurt = 2
			end

			if hurt > 0 then
				local health = GetEntityHealth(PlayerPedId())
				health = health - hurt
				if health < 0 then
					health = 0
				end
				SetEntityHealth(PlayerPedId(), health)
			end
]]--
		end

		Citizen.Wait(100)
	end
end)

Citizen.CreateThread(function()
	while true do
		SetPedMoveRateOverride(PlayerPedId(), movementSpeed)
		Citizen.Wait(0)
	end
end)

function coordsToArr(coords)
	return {
		["x"] = coords.x,
		["y"] = coords.y,
		["z"] = coords.z,
	}
end

function duplicateItem(item, modifiers)
	local item2 = {}

	for k,v in pairs(item) do
		item2[k] = v
	end

	if modifiers ~= nil then
		for k,v in pairs(modifiers) do
			item2[k] = v
		end
	end

	return item2
end

function showInputDialog(name, title, cb)
        local dialog_flag = false
	local text = nil
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), name, {
		title = title
	}, function(data3, menu3)
		text = data3.value
		dialog_flag = true
		menu3.close()

	end, function(data3, menu3)
		text = nil
		dialog_flag = true
		menu3.close()
	end)

	while not dialog_flag do
		Citizen.Wait(100)
	end

	return text
end


function registerItemAction(itemName, actionName, actionLabel, actionPriority, cb_use, cb_if)
	if itemActions[itemName] == nil then
		itemActions[itemName] = {}
	end

	local act = {}
	act.label = actionLabel
	act.priority = actionPriority
	act.cb = cb_use
	act.condition = cb_if

	itemActions[itemName][actionName] = act
end

function getItemActions(itemName)

	if itemActions[itemName] == nil then
		itemActions[itemName] = {}
	end

	local actions = itemActions[itemName]
	for k,v in pairs(itemActions["@shared"]) do actions[k] = v end

	return actions
end

function runItemAction(itemName, actionName, item)
	if actionName == "giveto" then
		return action_giveto(item)
	elseif actionName == "return" then
		return
	end

	if itemActions[itemName] == nil then
		print("runItemAction: Unknown item, name = "..itemName)
	end

	if itemActions[itemName][actionName] == nil then
		if itemActions["@shared"][actionName] ~= nil then
			itemName = "@shared"
		end
	end

	if itemActions[itemName][actionName] == nil then
		print("runItemAction: Unknown action, name = "..itemName..", action = "..actionName)
	elseif itemActions[itemName][actionName].cb == nil then
		print("runItemAction: nil action callback, name = "..itemName..", action = "..actionName)
	end

	return itemActions[itemName][actionName].cb(item)
end

RegisterNetEvent("es:addedMoney")
AddEventHandler("es:addedMoney", function(m, native, current)
	TriggerEvent('esx_inventory:updateInventory', "pocket", false)
end)

RegisterNetEvent("es:removedMoney")
AddEventHandler("es:removedMoney", function(m, native, current)
	TriggerEvent('esx_inventory:updateInventory', "pocket", false)
end)

function action_giveto(item)
	local amount = item.amount

	if amount ~= nil and amount > 0 then
		TriggerServerEvent('esx_inventory:giveItemTo', "pocket", false, duplicateItem(item, { ["amount"] = amount }))
		TriggerEvent('esx_inventory:updateInventory', "pocket", false)
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local forward = GetEntityForwardVector(playerPed)

		TriggerServerEvent('esx_inventory:playerCoords', coordsToArr(coords), coordsToArr(forward))
	end
end)

RegisterNetEvent('esx_inventory:updateInventory')
AddEventHandler('esx_inventory:updateInventory', function(name, shared)
	ESX.TriggerServerCallback('esx_inventory:getInventory', function(inventory)
		TriggerEvent('esx_inventory:onInventoryUpdate', inventory)
	end, name, shared)
end)

RegisterNetEvent('esx_inventory:showInventoryMenu')
AddEventHandler('esx_inventory:showInventoryMenu', function(inventory)
--	TriggerEvent('chat:addMessage', { args = { '^1SYSTEM', json.encode(inventory) } })
--	inventory = _inventory
	showInventoryMenu(inventory)
end)

RegisterNetEvent('esx_inventory:showItemNotification')
AddEventHandler('esx_inventory:showItemNotification', function(add, label, count)
	if initialized == true then
		ESX.UI.ShowInventoryItemNotification(add, {['label'] = label}, count)
	end
end)

AddEventHandler("playerSpawned", function()
	TriggerServerEvent('esx_inventory:playerSpawned')
end)

RegisterNetEvent('esx_inventory:itemAction')
AddEventHandler('esx_inventory:itemAction', function(act)
	runItemAction(act.item.name, act.key, act.item)
end)

AddEventHandler('esx_inventory:registerItemAction', function(itemName, actionName, actionLabel, actionPriority, cb_action, cb_condition)
	return registerItemAction(itemName, actionName, actionLabel, actionPriority, cb_action, cb_condition)
end)

--[[
AddEventHandler('esx_inventory:initialized', function(cb)
	cb(true)
end)
]]--

RegisterNetEvent('esx_inventory:onInventoryUpdate')
AddEventHandler('esx_inventory:onInventoryUpdate', function(inventory)
	if inventory.name == "pocket" then
		pocketWeight = inventory.weight or 0
		initialized = true
	end
end)
