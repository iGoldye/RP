
RegisterServerEvent('flatbed3:OneSyncDecorSetInt')
AddEventHandler('flatbed3:OneSyncDecorSetInt', function(netEnt, name, val)
--	print("Decor sync int: "..tostring(netEnt).." "..tostring(name).." "..tostring(val))
	TriggerClientEvent('flatbed3:OneSyncDecorSetInt', -1, netEnt, name, val)
end)

RegisterServerEvent('flatbed3:OneSyncDecorSetBool')
AddEventHandler('flatbed3:OneSyncDecorSetBool', function(netEnt, name, val)
--	print("Decor sync bool: "..tostring(netEnt).." "..tostring(name).." "..tostring(val))
	TriggerClientEvent('flatbed3:OneSyncDecorSetBool', -1, netEnt, name, val)
end)
