class Item_BankMoney extends Item_Abstract {
	constructor(name, extra, amount) {
		super(name, extra, amount);
		this.weight = 0;
		this.priority = 99;
		this.saveable = false;
		this.droppable = false;
	}

	addItem(inventory) {
		var xPlayer = inventory.getXPlayer();
	        if (!xPlayer) {
			return false;
		}

        	xPlayer.addAccountMoney('bank', this.amount);
 	       TriggerClientEvent('esx_inventory:showItemNotification', xPlayer.source, true, this.getLabel(), this.amount);
	        return true;
	}

	removeItem(inventory) {
		var xPlayer = inventory.getXPlayer()
                if (!xPlayer) {
			return false;
		}

                if (ESX.Round(xPlayer.getAccount('bank').money - this.amount, 2) >= 0) {
                    xPlayer.removeAccountMoney('bank', this.amount);
                    TriggerClientEvent('esx_inventory:showItemNotification', xPlayer.source, false, this.getLabel(), this.amount);
                    return true;
                }

                return false;
	}

	getLabel() {
            return _U('bank');
	}

}