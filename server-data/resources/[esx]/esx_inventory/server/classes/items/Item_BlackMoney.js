class Item_BlackMoney extends Item_Abstract {
	constructor(name, extra, amount) {
		super(name, extra, amount);
		this.weight = 0.00001;
		this.priority = 98;
		this.saveable = false;
	}

	addItem(inventory) {
		var xPlayer = inventory.getXPlayer();
	        if (!xPlayer) {
			return super.addItem(inventory);
		}

        xPlayer.addAccountMoney('black_money', this.amount);
        TriggerClientEvent('esx_inventory:showItemNotification', xPlayer.source, true, this.label, this.amount);
        return true;
	}

	removeItem(inventory) {
		var xPlayer = inventory.getXPlayer()
                if (!xPlayer) {
			return super.removeItem(inventory);
		}

                if (ESX.Round(xPlayer.getAccount('black_money').money - this.amount, 2) >= 0) {
                    xPlayer.removeAccountMoney('black_money', this.amount);
                    TriggerClientEvent('esx_inventory:showItemNotification', xPlayer.source, false, this.label, this.amount);
                    return true;
                }

                return false;
	}

	get label() {
            return _U('black_money');
	}

	getProp() {
		if (this.amount >= 10000) {
			return "prop_cash_case_02";
		} else if (this.amount >= 1000) {
			return "prop_poly_bag_money"
		}

		return "prop_cash_pile_02";
	}

}