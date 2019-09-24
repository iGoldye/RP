let ESX = null;
emit('esx:getSharedObject', (obj) => { ESX = obj });

var ClientInventories = [];
global.ItemClasses = {};
var ESXItemDB = [];


/*
RegisterServerEvent('esx_inventory:itemAction')
AddEventHandler('esx_inventory:itemAction', function(action) {
	var _source = source;
	var xPlayer = ESX.GetPlayerFromId(_source)

	var found_item = findItem("pocket", xPlayer.identifier, action.item)
	for (var i in found_item.actions) {
		var a = found_item.actions[i];
		if (a.name == action.name) {
			a.start(getInventory("pocket", xPlayer.identifier))
			break;
		}
	}
})
*/

on('esx_inventory:mysqlReady', (msync, masync) => {
//	loadESXItemDB();
	LoadInventories();
})

on('esx_inventory:ESXItemDB', (items) => {
	for (var i in items) {
		var item = items[i];
		ESXItemDB[item.name] = item;
	}
})

function LoadInventories() {
	var xPlayers = ESX.GetPlayers();

	for (var i in xPlayers) {
		var xPlayer = ESX.GetPlayerFromId(xPlayers[i]);
		LoadInventory("pocket", xPlayer.identifier);
	}
}

AddEventHandler('esx:playerLoaded', function(playerId, xPlayer) {
	var owner = xPlayer.identifier;
	var name = "pocket";
	LoadInventory("pocket", xPlayer.identifier)
});

AddEventHandler('playerDropped', function() {
	var _source = source
	var xPlayer = ESX.GetPlayerFromId(_source)
	if (xPlayer != null) {
		Inventories["pocket"][xPlayer.identifier].save()
	}
})

AddEventHandler('esx:onAddInventoryItem', function(source, item, count) {
	var xPlayer = ESX.GetPlayerFromId(source);
	var inv = getInventory("pocket", xPlayer.identifier);
	inv.onChange();
})

AddEventHandler('esx:onRemoveInventoryItem', function(source, item, count) {
	var xPlayer = ESX.GetPlayerFromId(source)
	var inv = getInventory("pocket", xPlayer.identifier);
	inv.onChange();
})

// SAVE INVENTORIES
setInterval(function() {
		for (var name in Inventories) {
		for (var owner in Inventories[name]) {

			if ((Inventories[name][owner].save())) {
				console.log('Inventory saved '+name+'/'+owner);
			}
		}
		}
}, 60000);

ESX.RegisterServerCallback('esx_inventory:getInventory', function(source, cb, name, shared) {
	var xPlayer = ESX.GetPlayerFromId(source);

	if (xPlayer == null) {
		console.log("esx_inventory:getInventory Unknown player!");
		return;
	}

	var owner = "";

	if (!shared) {
		owner = xPlayer.identifier;
	}

	var inv = getInventory(name, owner);
	if (inv != null) {
		cb(inv.serialize())
	} else {
		cb(null)
	}
})

AddEventHandler('esx_inventory:createItem', function(name, extra, amount, weight, cb) {
	cb(CreateItem(name, extra, amount, weight))
})

AddEventHandler('esx_inventory:addItem', function(name, owner, item, cb) {
	var inv = getInventory(name, owner)
	cb(inv.addItem(item))
})

AddEventHandler('esx_inventory:removeItem', function(name, owner, item, cb) {
	var inv = getInventory(name, owner);
	cb(inv.removeItem(item));
})

function giveItemTo(source, target, item) {
	var xPlayer = ESX.GetPlayerFromId(source)
	var xTarget = ESX.GetPlayerFromId(target)

	if (getInventory("pocket", xPlayer.identifier).removeItem(item) == true) {
		return getInventory("pocket", xTarget.identifier).addItem(item)
	}

	return false
}

ESX.RegisterServerCallback('esx_inventory:giveItemTo', function(source, cb, playerid, item) {
	return giveItemTo(source, playerid, item);
})

RegisterServerEvent('esx_inventory:playerSpawned')
AddEventHandler('esx_inventory:playerSpawned', function() {
	sendAllPickups(source)
})

// update loadout

//RegisterServerEvent('esx:updateLoadout')
onNet('esx:updateLoadout', function(loadout) {
	var xPlayer = ESX.GetPlayerFromId(source)
	setTimeout(function() {
	        getInventory("pocket", xPlayer.identifier).onChange()
	}, 100);
})

// ---------------------------------- exports ---------------------------------------------

function createItem(name, extra, amount, weight) {
	return CreateItem(name, extra, amount, weight);
}

function findItem(name, owner, item) {
	var inv = getInventory(name, owner);
	return inv.findItem(item);
}

// -- ITEMS --

function registerItem(name, clss) {
	ItemClasses[name] = clss;
}

registerItem("money", Item_Money);
registerItem("account_money", Item_BankMoney);
registerItem("black_money", Item_BlackMoney);
registerItem("esx_item", Item_ESX);
registerItem("weapon", Item_Weapon);
registerItem("carkey", Item_CarKey);
registerItem("equipped_weapon", Item_EquippedWeapon);
