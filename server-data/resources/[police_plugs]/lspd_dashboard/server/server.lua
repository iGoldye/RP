RegisterNetEvent('lspd_dashboard:sessionid')
AddEventHandler('lspd_dashboard:sessionid', function(sessionid)
    SendNUIMessage({name = 'sessionid', value = sessionid})
end)
