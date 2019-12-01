class Item_DoorKey extends Item_Abstract {

	constructor(name, extra, amount) {
		super(name, extra, amount);
		this.weight = 0.01;
		this.priority = 1;
	}

	get label() {
		return "Ключ от двери";
 	}

	get description() {
		if (this.extra.desc !== undefined) {
			return this.extra.desc;
		}
	}
}
