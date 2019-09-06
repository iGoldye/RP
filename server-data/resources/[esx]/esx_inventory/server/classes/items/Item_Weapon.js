class Item_Weapon extends Item_Abstract {
	constructor(name, extra, amount) {
		super(name, extra, amount);

		this.config = GetWeaponConfig(extra.weapon_name)
		this.weight = this.config.weight
		this.priority = 1;

//		this.actions.push(new Action_EquipWeapon(this));
	}

	getLabel() {
		return this.config.label;
	}

	getProp() {
		if (this.config && this.config.prop) {
			return this.config.prop; 
		} else {
			return 'prop_money_bag_01'
		}
	}


}

function GetWeaponConfig(name) {
	name = name.toUpperCase();
	for (var i in Config.Weapons) {
		if (name == Config.Weapons[i].name) {
			return Config.Weapons[i];
        }
    }

	return null;
}
