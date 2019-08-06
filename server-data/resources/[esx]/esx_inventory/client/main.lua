ESX = nil

--inventory = {}
pickups = {}
itemActions = {}

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

function GetWeaponConfig(name)
	name = name:upper()
	for i=1, #Config.Weapons, 1 do
		if name == Config.Weapons[i].name then
			return Config.Weapons[i]
		end
	end

	return nil
end

function registerItemAction(itemName, actionName, actionLabel, cb)
	if itemActions[itemName] == nil then
		itemActions[itemName] = {}
	end

	local act = {}
	act.label = actionLabel
	act.cb = cb

	itemActions[itemName][actionName] = act
end

function getItemActions(itemName)
	if itemActions[itemName] == nil then
		return {}
	end

	return itemActions[itemName]
end

registerItemAction("esx_item", "esx_use", _U("inventory_action_use"), function(item)
	TriggerServerEvent('esx:useItem', item.extra.name)
end)

registerItemAction("money_pack", "unpack", _U("inventory_action_unpack"), function(item)
	TriggerServerEvent('esx_inventory:actionUnpackMoney', item)
end)

registerItemAction("equipped_weapon", "unequip", _U("inventory_action_unequip"), function(item)

	local amount = 0
	if item.extra.ammo > 0 then
		amount = tonumber(showInputDialog("inventory_unequip_item_dialog", _U("amount")))
	end

	if amount ~= nil and amount >= 0 and amount <= item.extra.ammo then
		TriggerServerEvent('esx_inventory:unequipWeapon', item.extra.weapon_name, amount)
	else
		ESX.ShowNotification(_U('amount_invalid'))
	end

end)

registerItemAction("weapon", "equip", _U("inventory_action_equip"), function(item)
	TriggerServerEvent('esx_inventory:equipWeapon', item)
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

--	ESX.PlayerData = ESX.GetPlayerData()
end)

--RegisterNetEvent('esx:setJob')
--AddEventHandler('esx:setJob', function(job)
--	ESX.PlayerData.job = job
--end)

-- pickups
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		-- if there's no nearby pickups we can wait a bit to save performance
		if next(pickups) == nil then
			Citizen.Wait(500)
		end

		for id,v in pairs(pickups) do
			local distance = GetDistanceBetweenCoords(coords, v.coords.x, v.coords.y, v.coords.z, true)
			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
--		 	print("Pickup distance: "..closestDistance)

			if distance <= 5.0 then
				ESX.Game.Utils.DrawText3D({
					x = v.coords.x,
					y = v.coords.y,
					z = v.coords.z + 0.25
				}, v.label .. ' ['..v.item.amount..']')
			end

			if (closestDistance == -1 or closestDistance > 3) and distance <= 1.0 and not v.inRange and IsPedOnFoot(playerPed) then
				TriggerServerEvent('esx_inventory:onPickup', id)
				PlaySoundFrontend(-1, 'PICK_UP', 'HUD_FRONTEND_DEFAULT_SOUNDSET', false)
				v.inRange = true

				if ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'inventory-menu') or ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'inventory-item-menu') then
					TriggerServerEvent('esx_inventory:getInventory', "pocket", false, 'esx_inventory:showInventoryMenu')
				end
			end
		end
	end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlJustReleased(0, 243) and IsControlPressed(2, 19) and IsInputDisabled(0) and not isDead and not ESX.UI.Menu.IsOpen('default', 'es_extended', 'inventory') then
			TriggerServerEvent('esx_inventory:getInventory', "pocket", false, 'esx_inventory:showInventoryMenu')	
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local forward = GetEntityForwardVector(playerPed)
		TriggerServerEvent('esx_inventory:playerCoords', coords, forward)
	end
end)


--RegisterNetEvent('esx_inventory:updateInventory')
--AddEventHandler('esx_inventory:updateInventory', function(_inventory)
--	inventory = _inventory
--end)

RegisterNetEvent('esx_inventory:createPickup')
AddEventHandler('esx_inventory:createPickup', function(id, pickup)
	local ped     = PlayerPedId()
	local player_coords  = GetEntityCoords(ped)
--	local forward = GetEntityForwardVector(ped)
--	local x, y, z = table.unpack(coords)
--	local coords = pickup.coords + forward * -2.0
	local dist = #(player_coords - pickup.coords)
	local rotation = vector3(0,0,0)

	local propName = 'prop_money_bag_01'

	if pickup.item.name == "weapon" then
		local weaponConfig = GetWeaponConfig(pickup.item.extra.weapon_name)
		if weaponConfig ~= nil and weaponConfig.prop ~= nil then
			propName = weaponConfig.prop
		end

		rotation = vector3(90,0,0)
	end

	if pickup.item.name == "money" or pickup.item.name == "black_money" then
		propName = "prop_cash_pile_02"
		if pickup.item.amount >= 10000 then
			propName = "prop_cash_case_02"
		elseif pickup.item.amount >= 1000 then
			propName = "prop_poly_bag_money"
		end
	end

	local propHash = GetHashKey(propName)
	ESX.Streaming.RequestModel(propHash)
	local obj = CreateObject(propHash, pickup.coords.x, pickup.coords.y, pickup.coords.z, false, false, false)

	SetEntityCollision(obj, false, false)
	SetEntityAsMissionEntity(obj, true, false)
	PlaceObjectOnGroundProperly(obj)
	SetEntityRotation(obj, rotation, 2, true)

	pickups[id] = {
		item = pickup.item,
		label = pickup.label,
		coords = pickup.coords,
		source = pickup.source,
		obj = obj,
	}
end)

RegisterNetEvent('esx_inventory:removePickup')
AddEventHandler('esx_inventory:removePickup', function(id)
	if pickups[id] == nil then
		return
	end

	if pickups[id].obj ~= nil then
		ESX.Game.DeleteObject(pickups[id].obj)
	end
	                                                                                     
	pickups[id] = nil
end)

RegisterNetEvent('esx_inventory:showInventoryMenu')
AddEventHandler('esx_inventory:showInventoryMenu', function(inventory)
--	TriggerEvent('chat:addMessage', { args = { '^1SYSTEM', json.encode(inventory) } })
--	inventory = _inventory
	showInventoryMenu(inventory)
end)

function inventoryAddMoneyItems(elements)
	local playerData = ESX.GetPlayerData()
	if playerData.money > 0 then
		local formattedMoney = _U('locale_currency', ESX.Math.GroupDigits(playerData.money))

		local item = {}
		item.name = 'money'
		item.extra = {}
		item.amount = playerData.money
		item.droppable = true

		table.insert(elements, {
			label     = ('%s: <span style="color:green;">%s</span>'):format(_U('cash'), formattedMoney),
			value     = item,
		})
	end

	for i=1, #playerData.accounts, 1 do
		if playerData.accounts[i].money > 0 then
			local formattedMoney = _U('locale_currency', ESX.Math.GroupDigits(playerData.accounts[i].money))

			local item = {}
			item.name = 'account_money'
			item.extra = {["account_name"] = playerData.accounts[i].name}

			if playerData.accounts[i].name == "black_money" then
				item.name = "black_money"
				item.extra = {}
			end

			item.amount = playerData.accounts[i].money
			item.droppable = playerData.accounts[i].name ~= 'bank'
			
			table.insert(elements, {
				label     = ('%s: <span style="color:green;">%s</span>'):format(playerData.accounts[i].label, formattedMoney),
				value     = item,
			})
		end
	end
end

function inventoryAddWeaponItems(elements)
	local playerPed = PlayerPedId()
	for i=1, #Config.Weapons, 1 do
		local weaponHash = GetHashKey(Config.Weapons[i].name)

		if HasPedGotWeapon(playerPed, weaponHash, false) and Config.Weapons[i].name ~= 'WEAPON_UNARMED' then
			local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)

			local item = {}
			item.name = 'equipped_weapon'
			item.extra = {["weapon_name"] = Config.Weapons[i].name, ["ammo"] = ammo, equipped = true}
			item.amount = 1
			item.droppable = false

			local elem_label = Config.Weapons[i].label .. ' [' .. ammo .. ']'.._U("inventory_status_equipped")
			if ammo == 0 then
				elem_label = Config.Weapons[i].label .. _U("inventory_status_equipped")
			end

			table.insert(elements, {
				label     = elem_label,
				value     = item,
			})
		end
	end
end

function inventoryAddESXItems(elements)
	local playerData = ESX.GetPlayerData()
	for i=1, #playerData.inventory, 1 do
		if playerData.inventory[i].count > 0 then
			local item = {}
			item.name = "esx_item"
			item.extra = {["name"]=playerData.inventory[i].name, ["label"]=playerData.inventory[i].label, ["usable"] = playerData.inventory[i].usable , ["rare"] = playerData.inventory[i].rare, ["canRemove"] = playerData.inventory[i].canRemove}
			item.amount = playerData.inventory[i].count
			item.droppable = playerData.inventory[i].canRemove

			table.insert(elements, {
				label     = playerData.inventory[i].label .. ' x' .. item.amount,
				value     = item,
			})
		end
	end
end

function showInventoryMenu(inventory)
	local elements = {}

	ESX.UI.Menu.CloseAll()

	if inventory == nil or inventory.items == nil then
		return
	end	

	if inventory.name == "pocket" then
		inventoryAddMoneyItems(elements)
	end

	for k,v in pairs(inventory.items) do
		local itemlabel = v.name .. " [" .. v.amount .. "]"
		if v.name == "weapon" then
			itemlabel = _U(v.extra.weapon_name:lower())  
			local amount_mod = ""
			if v.amount > 1 then
				amount_mod = " x" .. v.amount
			end

			if v.extra.ammo == 0 then
				itemlabel = itemlabel .. " [" .. v.amount .. "]"
			else
				itemlabel = itemlabel .. " [" .. v.extra.ammo .. amount_mod .. "]"
			end
		end

		table.insert(elements, {
			label = itemlabel,
			value = v,
		})
	end

	if inventory.name == "pocket" then
		inventoryAddESXItems(elements)
		inventoryAddWeaponItems(elements)
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'inventory-menu',
	{
		title    = "Inventory",
		align    = 'bottom-right',
		elements = elements,
	}, function(data, menu)
		menu.close()
		Citizen.Wait(10)
		showInventoryItemMenu(inventory, data.current.value, data.current.label)
	end, function(data, menu)
		menu.close()
	end)

end

function showInventoryItemMenu(inventory, item, menu_label)

	elements = {}
	local actions = getItemActions(item.name)

	for act_name,act_data in pairs(actions) do
		table.insert(elements, {label = act_data.label, value = act_name})		
	end

	if item.droppable ~= false then
		table.insert(elements, {label = _U("inventory_action_drop"), value = "drop"})
	end

	table.insert(elements, {label = _U("inventory_action_return"), value = "return"})

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'inventory-item-menu',
	{
		title    = menu_label,
		align    = 'bottom-right',
		elements = elements,
	}, function(data, menu)
		local cmd = data.current.value

		if cmd == "return" then
			TriggerServerEvent('esx_inventory:getInventory', "pocket", false, 'esx_inventory:showInventoryMenu')
		elseif cmd == "drop" then
			local amount = 1
			if item.amount > 1 then
				amount = tonumber(showInputDialog("inventory_drop_item_dialog", _U("amount")))
			end

			if amount ~= nil and amount > 0 then
				TriggerServerEvent('esx_inventory:dropItem', "pocket", false, duplicateItem(item, { ["amount"] = amount }))
				TriggerServerEvent('esx_inventory:getInventory', "pocket", false, 'esx_inventory:showInventoryMenu')
			end
		else
			for act_name,act_data in pairs(actions) do
				if cmd == act_name then
					act_data.cb(item)
					menu.close()
					TriggerServerEvent('esx_inventory:getInventory', "pocket", false, 'esx_inventory:showInventoryMenu')
					break
				end
			end
		end


	end, function(data, menu)
		TriggerServerEvent('esx_inventory:getInventory', "pocket", false, 'esx_inventory:showInventoryMenu')
		menu.close()
	end)
end

RegisterNetEvent('esx_inventory:unequipWeapon')
AddEventHandler('esx_inventory:unequipWeapon', function(weaponName, amount)
--	print("Unequip "..weaponName.." "..ammo)
	local playerPed = PlayerPedId()
	local weaponHash = GetHashKey(weaponName)
	local current_ammo = GetAmmoInPedWeapon(playerPed, weaponHash)

	if HasPedGotWeapon(playerPed, weaponHash, false) and current_ammo >= amount then
		if GetSelectedPedWeapon(playerPed) == weaponHash then
			SetCurrentPedWeapon(playerPed, GetHashKey("WEAPON_UNARMED"), true)
		end

		SetPedAmmo(playerPed, weaponHash, current_ammo - amount)
		RemoveWeaponFromPed(playerPed, weaponHash)

		TriggerServerEvent('esx_inventory:getInventory', "pocket", false, 'esx_inventory:showInventoryMenu')	
	end
end)

RegisterNetEvent('esx_inventory:equipWeapon')
AddEventHandler('esx_inventory:equipWeapon', function(item)
	local weaponName = item.extra.weapon_name
	local playerPed = PlayerPedId()
	local weaponHash = GetHashKey(weaponName)

--	print("Equip "..weaponName.." "..item.extra.ammo)

	if HasPedGotWeapon(playerPed, weaponHash, false) then
		ESX.ShowNotification(_U('already_equipped'))
	else
		GiveWeaponToPed(playerPed, weaponHash, item.extra.ammo, false, true)
		TriggerServerEvent('esx_inventory:getInventory', "pocket", false, 'esx_inventory:showInventoryMenu')	
	end
end)

RegisterNetEvent('esx_inventory:showItemNotification')
AddEventHandler('esx_inventory:showItemNotification', function(add, item, count)
	ESX.UI.ShowInventoryItemNotification(add, item, count)
end)
