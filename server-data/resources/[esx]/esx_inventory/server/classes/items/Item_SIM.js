class Item_SIM extends Item_Abstract {
	constructor(name, extra, amount) {
		super(name, extra, amount);

		this.priority = 3;
//		if (this.weight == 0) this.weight = 0.2;
	}

	get label() {
		return "SIM-карта";
 	}

	get description() {
		if (!this.extra.number) {
			return "";
		}
		return "" + this.extra.number;
	}

}
