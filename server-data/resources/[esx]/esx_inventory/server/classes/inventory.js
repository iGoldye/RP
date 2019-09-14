let Inventories = [];

class Inventory {
	constructor(name, owner, items) {
		this.name = name;
		this.owner = owner;

		if (items) {
			this.items = items;
		} else {
			this.items = new Array();
		}

		this.dirty = false;
		this.weight = this.updateWeight()
	};

	onChange() {
		this.updateWeight();
		this.dirty = true;

		var xPlayer = this.getXPlayer();
		TriggerClientEvent('esx_inventory:onInventoryUpdate', xPlayer.source, this.serialize());
//		console.log("onChange: " + JSON.stringify(this.serialize()));
	}

	getXPlayer() {
		if (this.owner == null) {
			return null;
		}
		return ESX.GetPlayerFromIdentifier(this.owner);
	}

	updateWeight() {
		var xPlayer = this.getXPlayer()
		var weight = 0.0

		for (var k in this.items) {
			var item = this.items[k];
			if (item.weight != null && item.amount != null) {
				weight = weight + item.weight * item.amount
			}
		}

/*
		if (xPlayer != null) {
			for (var k in xPlayer.inventory) {
				var item = xPlayer.inventory[k]
				if (item.count > 0) {
					var itemWeight = 0
					if (global.ESXItemDB[item.name] != null) {
						itemWeight = global.ESXItemDB[item.name].weight || 0
					}

					if (itemWeight != null && item.count > 0) {
						 weight = weight + item.count * itemWeight / 1000.0
					}
				}
			}
		}
*/
		this.weight = weight
//		print(weight)
	}

	findItem(item) {
		item = DeserializeItem(item)

		if (item == null) {
			return null;
		}

		for (var k in this.items) {
			if (this.items[k].equals(item)) {
				return this.items[k];
			}
		}

		return null
	}

	findItemIndex(item) {
		item = DeserializeItem(item)

		if (item == null) {
			return null;
		}

		for (var k in this.items) {
			if (this.items[k].equals(item)) {
				return k;
			}
		}

		return null
	}

	removeItem(item, silent) {
		var xPlayer = this.getXPlayer()
		item = DeserializeItem(item)

		if (item == null) {
			console.log("null item!")
			return false
		}

		if (item.amount < 0) {
			console.log("Wrong item amount!")
			return false
		}

		var res = item.removeItem(this)
		if (res == true) {
			this.onChange()
		}

		return res
	}

	addItem(item, silent) {
		var xPlayer = this.getXPlayer();
		var item = DeserializeItem(item);

		if (item == null) {
			console.log("null item!")
			return false
		}

		if (item.amount == null || item.amount < 0) {
			console.log("Wrong item amount!")
			return false
		}

		var res = item.addItem(this)
		if (res == true) {
			this.onChange()
		}

		return res
	}

	save(force) {
//		console.log("Trying to save!")
		if (this.dirty == false && !force) {
			return false;
		}

		var ser = this.serialize(true);

		let invname = 'esx_inventory';
		if (this.name != 'pocket') {
			invname = 'esx_inventory_' + this.name
		}

		TriggerEvent('esx_datastore:getDataStore', invname, this.owner, function(store) {
			if (store !== undefined) {
				store.set(ser.name, ser.items);
			} else {
				print("Unable to get datastore with name '"+this.name+"' and owner '"+this.owner+"'")
			}
		});

		this.dirty = false;
		return true;
	}

	serialize(forSaving) {
		var ser = {}
		ser.name = this.name
		ser.owner = this.owner
		ser.weight = this.weight

		ser.items = []
		for (var i in this.items) {
			if (!forSaving || this.items[i].saveable || this.name != "pocket") {
				var item_ser_str = this.items[i].serialize()
				if (item_ser_str != null) {
					ser.items.push(item_ser_str)
				}
			}
		}

		return ser;
	}

	removeItems(name) {
		var items2 = []

		for (var k in this.items) {
            var item = this.items[k]
			if (item.name != name) {
				items2.push(item);
			}
		}

		this.items = items2;
	}

	updateLoadout() {
		this.removeItems("equipped_weapon")
		var loadout = getInventoryLoadout(this.name, this.owner);
		for (var k in loadout) {
			var item = DeserializeItem(loadout[k]);
			if (item != null) {
				this.items.push(item);
			}
		}

		return this.loadout;
	}

	updateESXItems() {
		this.removeItems("esx_item")
		var xPlayer = this.getXPlayer();
		var playerData = xPlayer

		for (var i in playerData.inventory) {
			if (playerData.inventory[i].count > 0) {
				var esx_item = playerData.inventory[i]
				var item = {}
				item.name = "esx_item"
				item.extra = {
					name:      esx_item.name,
					label:     esx_item.label,
					usable:    esx_item.usable,
					rare:      esx_item.rare,
					canRemove: esx_item.canRemove,
				}
				item.amount = playerData.inventory[i].count
				item.droppable = playerData.inventory[i].canRemove

				item = DeserializeItem(item);
				if (item != null) {
					this.items.push(item);
				}
			}
		}
	}

	updateMoneyItems() {
		var xPlayer = this.getXPlayer();

		this.removeItems("money")
		this.removeItems("account_money")
		this.removeItems("black_money")

		var item = {}
		item.name = 'money'
		item.extra = {}
		item.amount = xPlayer.getMoney()
		item.droppable = true
		item = DeserializeItem(item);
		if (item != null) {
			this.items.push(item);
		}
		
	        var account = xPlayer.getAccount("bank")
		item = {}
		item.name = 'account_money'
		item.extra = {"account_name": "bank"}

		item.amount = account.money
		item.droppable = false
		item = DeserializeItem(item);
		if (item != null) {
			this.items.push(item);
		}

	        var account = xPlayer.getAccount("black_money")
		item = {}
		item.name = 'black_money'
		item.extra = {"account_name": "black_money"}

		item.amount = account.money
		item.droppable = true
		item = DeserializeItem(item);
		if (item != null) {
			this.items.push(item);
		}
	}

}

function DeserializeInventory(name, owner, items) {
	var inv = new Inventory(name, owner, [])

	for (var k in items) {
		inv.addItem(DeserializeItem(items[k]), true);
	}

	return inv;
}

function LoadInventoryIfNotExists(name, owner) {
	if (Inventories[name] !== undefined && Inventories[name][owner] !== undefined) {
		return Inventories[name][owner];
	}

	if (Inventories[name] == null) {
		Inventories[name] = []
	}

	let invname = 'esx_inventory';
	if (name != 'pocket') {
		invname = 'esx_inventory_' + this.name
	}

	var items = [];
	var store = exports["esx_datastore"]["GetDataStore"](invname, owner, true)
	if (store) {
		items = store.get(name) || [];
	}

	Inventories[name][owner] = DeserializeInventory(name, owner, items) // replace new inventory
	Inventories[name][owner].onChange()

	return Inventories[name][owner]
}

function LoadInventory(name, owner) {
	TriggerEvent('esx_datastore:getDataStore', 'esx_inventory', owner, function(store) {
		var items = store.get(name) || [];

		getInventory(name, owner) // create new inventory if (not exists
		Inventories[name][owner] = DeserializeInventory(name, owner, items) // replace new inventory
		Inventories[name][owner].onChange()
	})
}

function getInventoryLoadout(name, owner) {
	var xPlayer = ESX.GetPlayerFromIdentifier(owner);
	if (xPlayer == null) {
		return {}
	}

	var loa = [];

	for (i in xPlayer.loadout) {
		var weapon = xPlayer.loadout[i];
		var item = {};
		item.name = "equipped_weapon";
		item.extra = {
			"weapon_name": weapon.name,
			"ammo": weapon.ammo,
			"weapon_label": weapon.label,
        };

		item.label = weapon.label;
		loa.push(item);
	}

	return loa;
}


function getInventory(name, owner) {
	if (Inventories[name] == null) {
		Inventories[name] = []
	}

	if (Inventories[name][owner] == null) {
		Inventories[name][owner] = new Inventory(name, owner, [])
	}

	var inv = Inventories[name][owner]
	inv.updateLoadout();
	inv.updateESXItems();
	inv.updateMoneyItems();
	inv.updateWeight();
	inv.items.sort(function(a,b) {
	var s1 = b.priority - a.priority
	if (s1 == 0 && b.weight && a.weight && b.amount && a.amount) {
		s1 = b.weight*b.amount - a.weight*a.amount
	}

        return s1;
    })

	return inv;
}
