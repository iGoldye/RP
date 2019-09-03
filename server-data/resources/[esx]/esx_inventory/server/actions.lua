RegisterServerEvent('esx_inventory:actionUnpackMoney')
AddEventHandler('esx_inventory:actionUnpackMoney', function(item)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer == nil then
		print("esx_inventory:getInventory Unknown player!")
		return
	end

	local inv = getInventory("pocket", xPlayer.identifier)

	if inv.removeItem(CreateItem(item.name, item.extra, 1)) == true then
		xPlayer.addMoney(item.extra["cash"])
		xPlayer.addAccountMoney('black_money', item.extra["black"])
	end
end)

RegisterServerEvent('esx_inventory:unequipWeapon')
AddEventHandler('esx_inventory:unequipWeapon', function(weaponName, ammo, config)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer == nil then
		print("esx_inventory:unequipWeapon Unknown player!")
		return
	end

	local inv = getInventory("pocket", xPlayer.identifier)

	if inv.addItem(CreateItem("weapon", { ["weapon_name"] = weaponName, ["weapon_label"] = config.label, ["ammo"] = ammo }, 1, config.weight)) == true then
--		TriggerClientEvent("esx_inventory:unequipWeapon", source, weaponName, ammo)
		TriggerClientEvent('esx_inventory:onInventoryUpdate', source, inv)
	end
end)


RegisterServerEvent('esx_inventory:equipWeapon')
AddEventHandler('esx_inventory:equipWeapon', function(item)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer == nil then
		print("esx_inventory:equipWeapon Unknown player!")
		return
	end

	local inv = getInventory("pocket", xPlayer.identifier)
	local tmpItem = CreateItem("weapon", item.extra, 1)

	if inv.removeItem(tmpItem) == true then
		TriggerClientEvent("esx_inventory:equipWeapon", source, item)
	end
end)

RegisterServerEvent('esx_inventory:dropItem')
AddEventHandler('esx_inventory:dropItem', function(name, shared, iteminfo)

		if players[source] == nil then
			print("esx_inventory:dropItem Unknown player coords!")
			return
		end

		local xPlayer = ESX.GetPlayerFromId(source)
		if xPlayer == nil then
			print("esx_inventory:dropItem Unknown player!")
			return
		end

		if iteminfo.amount <= 0 then
			print("esx_inventory:dropItem Incorrect item amount "..tostring(item.amount).."!")
			return
		end

		local owner = ""

		if not shared then
			owner = xPlayer.identifier
		end

		local inv = getInventory(name,owner)
		local item = CreateItem(iteminfo.name, iteminfo.extra, iteminfo.amount, iteminfo.weight)
		if inv.removeItem(item) then
				if createPickup(source, item, item.getLabel()) == false then
					inv.addItem(item)
				end
		end
end)
