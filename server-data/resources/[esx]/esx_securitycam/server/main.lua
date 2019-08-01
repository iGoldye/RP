ESX = nil

locationHacked = {
	["police"] = false,
	["bank"] = false,
}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_securitycam:unhackanimserver')
AddEventHandler('esx_securitycam:unhackanimserver', function()
	local _source = source
	TriggerClientEvent('esx_securitycam:unhackanim', _source)
end)

RegisterServerEvent('esx_securitycam:setLocationHackedState')
AddEventHandler('esx_securitycam:setLocationHackedState', function(location, state)
	print(('esx_securitycam: %s has set the "%s" cameras to %s!'):format(GetPlayerIdentifiers(source)[1], location, state))
	TriggerClientEvent('esx_securitycam:setLocationHackedState', -1, location, state)
end)


RegisterServerEvent('esx_securitycam:setCameraBroken')
AddEventHandler('esx_securitycam:setCameraBroken', function(location, cam_index)
--	print(('esx_securitycam: %s has set the location "%s" cameras to %s!'):format(GetPlayerIdentifiers(source)[1], location, state))
	if location == "police" or location == "bank" then	
		TriggerClientEvent('esx_securitycam:setCameraBrokenTimer', -1, location, cam_index, Config.CameraBreakTimer)
	end
end)

