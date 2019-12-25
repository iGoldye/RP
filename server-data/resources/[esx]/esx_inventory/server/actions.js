RegisterServerEvent('esx_inventory:outfitWear')
AddEventHandler('esx_inventory:outfitWear', function(item) {
	var xPlayer = ESX.GetPlayerFromId(source)
	if (xPlayer == null) {
		print("esx_inventory:getInventory Unknown player!")
		return
	}

	TriggerClientEvent("esx_inventory:outfitWear", xPlayer.source, item.extra.outfit)
})

RegisterServerEvent('esx_inventory:actionActivatePhone')
AddEventHandler('esx_inventory:actionActivatePhone', function(item) {
	var xPlayer = ESX.GetPlayerFromId(source)
	if (xPlayer == null) {
		print("esx_inventory:getInventory Unknown player!")
		return
	}

	TriggerEvent('gcPhone:setPhoneNumber', xPlayer.source, item.extra.number, function() {
		TriggerClientEvent('esx:showNotification', xPlayer.source, "Телефон ~b~"+item.extra.number+"~s~ выбран!")
	})
})

RegisterServerEvent('esx_inventory:actionPhoneRemoveSIM')
AddEventHandler('esx_inventory:actionPhoneRemoveSIM', function(item) {
	var xPlayer = ESX.GetPlayerFromId(source)
	if (xPlayer == null) {
		print("esx_inventory:getInventory Unknown player!")
		return
	}

	var inv = getInventory("pocket", xPlayer.identifier);
	var simNumber = item.extra.number;

	if (inv.removeItem(item) && simNumber !== null) {
		inv.addItem(CreateItem("sim", {"number": simNumber}, 1))
		inv.addItem(CreateItem("esx_item", {"name": "phone"}, 1))
		TriggerClientEvent('esx:showNotification', xPlayer.source, "~g~Вы забрали карту из телефона!")
	}
})

RegisterServerEvent('esx_inventory:actionInsertSim')
AddEventHandler('esx_inventory:actionInsertSim', function(item) {
	var xPlayer = ESX.GetPlayerFromId(source)
	if (xPlayer == null) {
		print("esx_inventory:getInventory Unknown player!")
		return
	}

	var inv = getInventory("pocket", xPlayer.identifier);

	var phoneItem = CreateItem("esx_item", {"name": "phone"}, 1)
	var simItem = CreateItem(item.name, item.extra, 1)
	var simNumber = item.extra.number

	if (inv.findItem(phoneItem).count < 1) {
		TriggerClientEvent('esx:showNotification', xPlayer.source, "~r~У вас нет телефона без sim-карты!")
		return
	}

	if (inv.removeItem(phoneItem) && inv.removeItem(simItem)) {
		inv.addItem(CreateItem("phone", {"number": simNumber}, 1))
		TriggerClientEvent('esx:showNotification', xPlayer.source, "~g~Карта установлена в телефон!")
	}
})

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
