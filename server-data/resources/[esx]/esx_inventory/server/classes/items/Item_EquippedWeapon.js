class Item_EquippedWeapon extends Item_Abstract {

	constructor(name, extra, amount) {
		super(name, extra, amount);
		this.config = Item_EquippedWeapon.getWeaponConfig(extra.weapon_name);
		this.weight = this.config.weight;
	        this.saveable = false;
		this.droppable = false;
		this.amount = 1;
		this.priority = 2;

//		this.actions.push(new Action_UnequipWeapon(this));
	}

	addItem(inventory) {
                return false;
	}

	removeItem(inventory) {
                return false;
	}

	getLabel() {
		return this.config.label;
	}

	static getWeaponConfig(name) {
		name = name.toUpperCase();
		for (var i in Config.Weapons) {
			if (name == Config.Weapons[i].name) {
				return Config.Weapons[i];
			}
		}
	
		return null;
	}

}
