class Item_BankMoney extends Item_Abstract {
	constructor(name, extra, amount) {
		super(name, extra, amount);
		this.weight = 0;
		this.priority = 99;
		this.saveable = false;
		this.droppable = false;
	}

	addItem(inventory) {
/*
		var xPlayer = inventory.getXPlayer();
	        if (!xPlayer) {
			return false;
		}

        	xPlayer.addAccountMoney('bank', this.amount);
	       TriggerClientEvent('esx_inventory:showItemNotification', xPlayer.source, true, this.label, this.amount);
	        return true;
*/
                return false;
	}

	removeItem(inventory) {
/*
		var xPlayer = inventory.getXPlayer()
                if (!xPlayer) {
			return false;
		}

                if (ESX.Round(xPlayer.getAccount('bank').money - this.amount, 2) >= 0) {
                    xPlayer.removeAccountMoney('bank', this.amount);
                    TriggerClientEvent('esx_inventory:showItemNotification', xPlayer.source, false, this.label, this.amount);
                    return true;
                }
*/
                return false;
	}

	get label() {
            return _U('bank');
	}

}