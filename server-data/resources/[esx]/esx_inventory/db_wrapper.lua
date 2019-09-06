MySQL.ready(function()
	TriggerEvent("esx_inventory:mysqlReady")
	loadESXItemDB()
end)

function loadESXItemDB()
	local items = MySQL.Sync.fetchAll('SELECT * FROM items')
	TriggerEvent("esx_inventory:ESXItemDB", items)
end
