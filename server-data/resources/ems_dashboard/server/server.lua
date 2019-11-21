ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function RandomString(length)
  local res = ""
  for i = 1, length do
      res = res .. string.char(math.random(97, 122))
  end
  return res
end

RegisterServerEvent('ems_dashboard:sessionid')
AddEventHandler('ems_dashboard:sessionid', function()
  local xPlayer = ESX.GetPlayerFromId(source)
  local sessionid = RandomString(32)
  MySQL.Async.execute('INSERT INTO user_sessionid (`identifier`, `sessionid`) VALUES (@identifier, @sessionid);',
  {
      identifier = xPlayer.identifier,
      sessionid = sessionid,
  }, function(rowsChanged)
      TriggerClientEvent('ems_dashboard:sessionid', xPlayer.source, sessionid)
  end)
end)
