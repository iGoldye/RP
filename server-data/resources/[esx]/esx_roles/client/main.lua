ESX          = nil
myRoles = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

--[[
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		print(json.encode(myRoles))
	end
end)
]]--

RegisterNetEvent('esx_roles:sendRoles')
AddEventHandler('esx_roles:sendRoles', function(roles)
	ESX.SetPlayerData('roles', roles)
	myRoles = roles
	TriggerEvent('esx_roles:setRoles', roles)
end)

AddEventHandler('esx_roles:getRoles', function(cb)
	cb(myRoles)
end)
