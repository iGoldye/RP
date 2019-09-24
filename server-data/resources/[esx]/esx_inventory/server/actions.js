RegisterServerEvent('esx_inventory:actionUnpackMoney')
AddEventHandler('esx_inventory:actionUnpackMoney', function(item) {
	var xPlayer = ESX.GetPlayerFromId(source)
	if (xPlayer == null) {
		print("esx_inventory:getInventory Unknown player!")
		return
	}

	var inv = getInventory("pocket", xPlayer.identifier)

	if (inv.removeItem(CreateItem(item.name, item.extra, 1)) == true) {
		xPlayer.addMoney(item.extra["cash"])
		xPlayer.addAccountMoney('black_money', item.extra["black"])
	}
})

RegisterServerEvent('esx_inventory:unequipWeapon')
AddEventHandler('esx_inventory:unequipWeapon', function(weaponName, ammo, config) {
	var xPlayer = ESX.GetPlayerFromId(source)
	if (xPlayer == null) {
		print("esx_inventory:unequipWeapon Unknown player!")
		return
	}

	var inv = getInventory("pocket", xPlayer.identifier)

	if (inv.addItem(CreateItem("weapon", { "weapon_name": weaponName, "ammo": ammo }, 1)) == true) {
		inv.onChange();
	}
})


RegisterServerEvent('esx_inventory:equipWeapon')
AddEventHandler('esx_inventory:equipWeapon', function(item) {
	var xPlayer = ESX.GetPlayerFromId(source)
	if (xPlayer == null) {
		print("esx_inventory:equipWeapon Unknown player!")
		return
	}

	if (item && item.extra && xPlayer.hasWeapon(item.extra.weapon_name)) {
		TriggerClientEvent("esx:showNotification", xPlayer.source, _U("already_equipped"))
		return
	}

	var inv = getInventory("pocket", xPlayer.identifier)
	var tmpItem = CreateItem("weapon", item.extra, 1)

	if (inv.removeItem(tmpItem) == true) {
		TriggerClientEvent("esx_inventory:equipWeapon", source, item)
	}
})

RegisterServerEvent('esx_inventory:dropItem')
AddEventHandler('esx_inventory:dropItem', function(name, shared, iteminfo) {
		var xPlayer = ESX.GetPlayerFromId(source)
		if (players[xPlayer.source] == null) {
			print("esx_inventory:dropItem Unknown player coords!")
			return
		}

		if (xPlayer == null) {
			print("esx_inventory:dropItem Unknown player!")
			return
		}

		if (iteminfo.amount <= 0) {
			print("esx_inventory:dropItem Incorrect item amount " + tostring(item.amount) + "!")
			return
		}

		var owner = ""

		if (!shared) {
			owner = xPlayer.identifier
		}

		var inv = getInventory(name,owner)
		var item = DeserializeItem(iteminfo)
		if (inv.removeItem(item)) {
				if (createPickup(xPlayer.source, item, item.label) == false) {
					inv.addItem(item)
				}
		}
})
