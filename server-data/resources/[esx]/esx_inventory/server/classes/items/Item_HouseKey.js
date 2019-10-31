class Item_HouseKey extends Item_Abstract {

	constructor(name, extra, amount) {
		super(name, extra, amount);
		this.weight = 0.02;
		this.priority = 1;
	}

	get label() {
		return "Ключ от недвижимости";
 	}

	get description() {
		if (!this.extra.label) {
			return "";
		}
		return "" + this.extra.label;
	}

}
