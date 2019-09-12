class Item_Abstract {

	constructor(name, extra, amount) {
		this.name = name;
		this.extra = extra;
		this.amount = amount;
		this.weight = 0;
		this.saveable = true;
		this.droppable = true;
//		this.actions = [];
		this.priority = 0;

		if (ESXItemDB[name] !== undefined) {
			this.weight = ESXItemDB[name].weight || 0;
		}

//		this.actions.push(new Action_Drop(this));
	}


	equals(item2) {
		if (item2 == null) {
			return false;
		}

		if (this.name != item2.name) {
			return false;
		}

		if (!tablesEqual(this.extra, item2.extra)) {
			return false;
		}

		return true;
	}

	duplicate(modifiers) {
		var item2 = DeserializeItem(this.serialize());

		if (modifiers != null) {
			for (var k in modifiers) {
				item2[k] = modifiers[k];
			}
		}

		return item2;
	}

	serialize(inventory) {
		var ser = {};
		ser.name = this.name;
		ser.label = this.label;
		ser.extra = this.extra;
		ser.amount = this.amount;
		ser.weight = this.weight;
		ser.droppable = this.droppable;
/*
		ser.actions = [];
		for (var k in this.actions) {
			var action = this.actions[k];
//			print("aA"+ action.getLabel(inventory))
			if (inventory === undefined || action.condition(inventory) == true) {
				ser.actions.push({
					name: action.name,
					label: action.getLabel(inventory),
					priority: action.priority,
				});
			}
		}


		ser.actions.sort(function(a, b) {
			return a.priority - b.priority;
		})
*/
//		print(JSON.stringify(ser.actions))

		return ser;
	}

	getProp() {
		return 'prop_money_bag_01'; 
	}

	get label() {
	        return _U(this.name);
	}

	addItem(inventory) {
	        var xPlayer = inventory.getXPlayer();

		if (this.amount <= 0) {
			return false
		}

		var old_item = inventory.findItem(this)

		if (old_item) {
		        old_item.amount += this.amount;
	        } else {
			inventory.items.push(this);
		}

	        if (xPlayer != null) {
	            TriggerClientEvent('esx_inventory:showItemNotification', xPlayer.source, true, this.label, this.amount);
	        }

	        return true;
	}

	removeItem(inventory) {
        	var xPlayer = inventory.getXPlayer()
		var old_item_index = inventory.findItemIndex(this);
		var old_item = inventory.items[old_item_index];

		if (old_item_index) {
	        	if (old_item.amount - this.amount > 0) {
				old_item.amount -= this.amount;
			} else if (old_item.amount - this.amount == 0) {
				inventory.items.splice(old_item_index, 1);
			} else {
				return false;
			}
		} else {
			return false;
		}

		if (xPlayer != null) {
	            TriggerClientEvent('esx_inventory:showItemNotification', xPlayer.source, false, this.label, this.amount);
	        }

		return true;
	}
}

