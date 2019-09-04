
function duplicateItem(item, modifiers)
	local item2 = {}

	for k,v in pairs(item) do
		item2[k] = v
	end

	if modifiers ~= nil then
		for k,v in pairs(modifiers) do
			item2[k] = v
		end
	end

	return item2
end

function tablesEqual(table1, table2)
	if table1 == nil then
		return table2 == nil
	end

	if table2 == nil then
		return false
	end

	for k, v in pairs(table1) do
		if table2[k] ~= v then
			return false
		end
	end

	for k, v in pairs(table2) do
		if table1[k] ~= v then
			return false
		end
	end

	return true
end
