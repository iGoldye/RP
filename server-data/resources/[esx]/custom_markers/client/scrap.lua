local scrap_item = {
	{
		name = "Хлам",
		db_name = "scrap",
		time = 1000,
		max = 20,
		add = 1,
		remove = 1,
		requires = "nothing",
		requires_name = "Nothing",
		drop = 100
	},
}

AddEventHandler('custom_markers:scrapEnter', function()
	TriggerServerEvent('esx_jobs:startWork', scrap_item)
	TriggerEvent('esx:showNotification', "~o~Начат сбор хлама!~s~")
end)

AddEventHandler('custom_markers:scrapExit', function()
	TriggerServerEvent('esx_jobs:stopWork', scrap_item)
end)