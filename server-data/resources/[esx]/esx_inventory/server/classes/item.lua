function CreateItem(name, extra, amount, weight)
	local self = {}
	self.name = name
	self.extra = json.decode(json.encode(extra))
	self.amount = amount
	self.weight = weight or 0.0

	self.equals = function(item2)
		if item2 == nil then
			return false
		end

		if self.name ~= item2["name"] then
			return false
		end

		if not tablesEqual(self.extra, item2["extra"]) then
			return false
		end

		return true
	end

	self.getLabel = function()
		if self.name == "money" then
			return _U('cash')
		elseif self.name == "weapon" then
			return _U(self.extra.weapon_name:lower())
		elseif self.name == "esx_item" then
			return self.extra.label
		elseif self.name == "carkey" and self.extra ~= nil and self.extra.plate ~= nil then
			return "Ключ от машины "..self.extra.plate
		end

		return _U(self.name)
	end

	self.duplicate = function(modifiers)
		local item2 = DeserializeItem(self.serialize())

		if modifiers ~= nil then
			for k,v in pairs(modifiers) do
				item2[k] = v
			end
		end

		return item2
	end

	self.serialize = function()
		local ser = {}
		ser.name = self.name
		ser.extra = self.extra
		ser.amount = self.amount
		ser.weight = self.weight
		return ser
	end

	return self
end


function DeserializeItem(ser)
	if ser == nil then
		return nil
	end

	if ser.serialize ~= nil then
		return ser
	end

	if type(ser)=="string" then
		ser = json.decode(ser)
	end

	return CreateItem(ser.name, ser.extra, ser.amount, ser.weight)
end
