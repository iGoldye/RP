class Item_CarKey extends Item_Abstract {

	constructor(name, extra, amount) {
		super(name, extra, amount);
		this.weight = 0.02;
		this.priority = 1;
	}

	get label() {
		return "Ключ от машины";
 	}

	get description() {
		return "Номер: " + this.extra.plate;
	}
}
