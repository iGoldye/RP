class Item_Phone extends Item_Abstract {
	constructor(name, extra, amount) {
		super(name, extra, amount);

		this.priority = 3;
//		if (this.weight == 0) this.weight = 0.2;
	}

//	static mutate(esx_item, count) {
//		return new Item_Phone("phone", {}, count);
//	}

	get description() {
		if (!this.extra.number) {
			return "";
		}
		return "SIM: " + this.extra.number;
	}

}
