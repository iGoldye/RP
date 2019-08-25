local skins = {
  ['steam:110000105e4e0c5'] = 'a_f_y_hipster_02'
}

RegisterServerEvent('playerSpawn')
AddEventHandler('playerSpawn', function()
  local steamID = nil
  for k,v in ipairs(GetPlayerIdentifiers(source)) do
    if string.sub(v, 1, 5) == "steam" then
        steamID = string.lower(v)
        break
    end
  end
  local skin = nil
  if skins[steamID] ~= nil then
      skin = skins[steamID]
  else
      skin = skins['default']
  end
  TriggerClientEvent("applyskin", source, skin)
end)