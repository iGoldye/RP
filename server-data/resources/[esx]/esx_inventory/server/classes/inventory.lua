ESXItemDB = {}
Inventories = {}

function CreateInventory(name, owner, items)
	local self = {}

	self.name = name
	self.owner = owner
	self.items = items or {}
	self.dirty = false

	self.onChange = function()
		self.updateWeight()
		self.dirty = true

		local xPlayer = self.getXPlayer()
		TriggerClientEvent('esx_inventory:onInventoryUpdate', xPlayer.source, self.serialize())
	end

	self.getXPlayer = function()
		if self.owner == nil then
			return nil
		end
		return ESX.GetPlayerFromIdentifier(self.owner)
	end

	self.updateWeight = function()
		local xPlayer = self.getXPlayer()
		local weight = 0.0

		for _,item in pairs(self.items) do
			if item.name == 'esx_item' then
				item.weight = ESXItemDB[item.name] or 0
			end

			if item.weigth ~= nil and item.amount ~= nil then
				weight = weight + item.weight * item.amount
			end
		end

		if xPlayer ~= nil then
			for i=1, #xPlayer.inventory, 1 do
				local item = xPlayer.inventory[i]
				if item.count > 0 then
					local itemWeight = 0
					if ESXItemDB[item.name] ~= nil then
						itemWeight = ESXItemDB[item.name].weight or 0
					end

					if itemWeight ~= nil and item.count > 0 then
						 weight = weight + item.count * itemWeight / 1000.0
					end
				end
			end
		end

		self.weight = weight
	--	print("updateWeight "..tostring(weight))
	end

	self.findItem = function (item)
		item = DeserializeItem(item)

		if item == nil then
			return nil, nil
		end

		for k,v in pairs(self.items) do
			if v.equals(item) then
				return k,v
			end
		end

		return nil, nil
	end

	self.removeItem = function(item, silent)
		local xPlayer = self.getXPlayer()
		item = DeserializeItem(item)

		if item == nil then
			print("Nil item!")
			return false
		end

		if item.amount < 0 then
			print("Wrong item amount!")
			return false
		end

		-- Pocket
		if xPlayer ~= nil then
			if item.name == "esx_item" then
				if item.extra ~= nil then
					local curitem = xPlayer.getInventoryItem(item.extra.name)
					if curitem == nil then
						return false
					end
					if curitem.count ~= nil and curitem.count >= item.amount then
						xPlayer.removeInventoryItem(item.extra.name, item.amount)
					else
						return false
					end
					self.onChange()
					return true
				end
				return false

			elseif item.name == "money" then
				if ESX.Round(xPlayer.getMoney() - item.amount, 2) >= 0 then
					xPlayer.removeMoney(item.amount)
					if not silent then
						TriggerClientEvent('esx_inventory:showItemNotification', xPlayer.source, false, item.getLabel(), item.amount)
					end
					self.onChange()
					return true
				end
				return false
			elseif item.name == "black_money" then
				if ESX.Round(xPlayer.getAccount('black_money').money - item.amount, 2) >= 0 then
					xPlayer.removeAccountMoney('black_money', item.amount)
					if not silent then
						TriggerClientEvent('esx_inventory:showItemNotification', xPlayer.source, false, item.getLabel(), item.amount)
					end
					self.onChange()
					return true
				end
				return false
			end

		end

		local old_item_index, old_item = self.findItem(item)

		if old_item_index then
			if old_item.amount - item.amount > 0 then
				self.items[old_item_index].amount = old_item.amount - item.amount
				self.onChange()
			elseif old_item.amount - item.amount == 0 then
				self.items[old_item_index] = nil
				self.onChange()
			else
				return false
			end
		else
			return false
		end

		if xPlayer ~= nil and not silent then
			TriggerClientEvent('esx_inventory:showItemNotification', xPlayer.source, false, item.getLabel(), item.amount)
		end

		self.onChange()
		return true
	end

	self.addItem = function(item, silent)
		local xPlayer = self.getXPlayer()
		item = DeserializeItem(item)

		if item == nil then
			print("Nil item!")
			return false
		end

		if item.amount < 0 then
			print("Wrong item amount!")
			return false
		end

		-- Pocket
		if xPlayer ~= nil then
			if item.name == "esx_item" then
				if xPlayer ~= nil then
					if item.extra == nil then
						return false
					end

					xPlayer.addInventoryItem(item.extra.name, item.amount)
					self.onChange()
					return true
				end
				return false
			elseif item.name == "money" then
				if xPlayer then
					xPlayer.addMoney(item.amount)
					if not silent then
						TriggerClientEvent('esx_inventory:showItemNotification', xPlayer.source, true, item.getLabel(), item.amount)
					end
					self.onChange()
					return true
				end
				return false
			elseif item.name == "black_money" then
				if xPlayer  then
					xPlayer.addAccountMoney('black_money', item.amount)
					if not silent then
						TriggerClientEvent('esx_inventory:showItemNotification', xPlayer.source, true, item.getLabel(), item.amount)
					end
					self.onChange()
					return true
				end
				return false
			end
		end

		local old_item_index, old_item = self.findItem(item)

		if old_item_index then
			if item.amount + old_item.amount > 0 then
				self.items[old_item_index].amount = item.amount + old_item.amount
				self.onChange()
			elseif item.amount + old_item.amount == 0 then
				self.items[old_item_index] = nil
				self.onChange()
			else
				return false
			end
		elseif item.amount > 0 then
			table.insert(self.items, item)
			self.onChange()
		end

		if xPlayer ~= nil and not silent then
			TriggerClientEvent('esx_inventory:showItemNotification', xPlayer.source, true, item.getLabel(), item.amount)
		end

		return true
	end

	self.save = function(force)
		local xPlayer = self.getXPlayer()

		if xPlayer == false then
			return false
		end

		if self.dirty == false and not force then
			return false
		end

		local ser = self.serialize()

		TriggerEvent('esx_datastore:getDataStore', 'esx_inventory', xPlayer.identifier, function(store)
			store.set(name, ser.items)
		end)

		self.dirty = false
		return true
	end

	self.serialize = function()
		local ser = {}
		ser.name = self.name
		ser.owner = self.owner

		ser.items = {}
		for k,v in pairs(self.items) do
			table.insert(ser.items, v.serialize())
		end

		return ser
	end

	self.weight = self.updateWeight()
	return self

end

function DeserializeInventory(name, owner, items)
	local inv = CreateInventory(name, owner, {})

	for k,v in pairs(items) do
		inv.addItem(DeserializeItem(v), true)
	end

	return inv
end

function LoadInventory(name, owner)
	TriggerEvent('esx_datastore:getDataStore', 'esx_inventory', owner, function(store)
		local items = store.get(name) or {}

		getInventory(name, owner) -- create new inventory if not exists
		Inventories[name][owner] = DeserializeInventory(name, owner, items) -- replace new iunventory
	end)
end

function loadESXItemDB()
	ESXItemDB = {}
	local items = MySQL.Sync.fetchAll('SELECT * FROM items')
	for i=1,#items do
		local item = items[i]
		ESXItemDB[item.name] = item
	end
end

function getInventory(name, owner)
	if Inventories[name] == nil then
		Inventories[name] = {}
	end

	if Inventories[name][owner] == nil then
		Inventories[name][owner] = CreateInventory(name, owner, {})
	end

	return Inventories[name][owner]
end
