class Item_Outfit extends Item_Abstract {

	constructor(name, extra, amount) {
		super(name, extra, amount);
		this.weight = 1.00;
		if (this.extra.weight !== undefined) {
			this.weight = this.extra.weight;
		}

		this.priority = 1;
	}

	get label() {
		if (this.extra.name !== undefined) {
			return this.extra.name;
		}

		return "Комплект одежды";
		
 	}

	get description() {
		return "";
	}

}
