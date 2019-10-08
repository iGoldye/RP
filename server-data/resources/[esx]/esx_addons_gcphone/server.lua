
ESX                       = nil
local PhoneNumbers        = {}

PhoneNumbers = {
   ambulance = {
     type  = "ambulance",
     sources = {}
   },
   police = {
     type  = "police",
     sources = {}
   },
   taxi = {
     type  = "taxi",
     sources = {}
   },
   mechanic = {
     type  = "mechanic",
     sources = {}
   },
   reporter = {
     type  = "reporter",
     sources = {}
   },
   emergency = {
     type = "emergency",
     sources = {}
   }
}

TriggerEvent('esx:getSharedObject', function(obj)
  ESX = obj
end)

function notifyAlertSMS (number, alert, listSrc)
  if PhoneNumbers[number] ~= nil then
	local mess = '#' .. alert.numero  .. ' : ' .. alert.message
--	if alert.coords ~= nil then
--		mess = mess .. ' ' .. alert.coords.x .. ', ' .. alert.coords.y
--	end
    local options = {
        ["coords"] = alert.coords,
        ["customer"] = alert.numero,
    }

    for k, _ in pairs(listSrc) do
      getPhoneNumber(tonumber(k), function (n)
        if n ~= nil then
          TriggerEvent('gcPhone:_internalAddMessage', number, n, mess, 0, options, function (smsMess)
            TriggerClientEvent("gcPhone:receiveMessage", tonumber(k), smsMess)
          end)
        end
      end)
    end
  end
end

AddEventHandler('esx_phone:registerNumber', function(number, type, sharePos, hasDispatch, hideNumber, hidePosIfAnon)
	print('= INFO = Registering phone number ' .. number .. ' => ' .. type)
	local hideNumber    = hideNumber    or false
	local hidePosIfAnon = hidePosIfAnon or false

	PhoneNumbers[number] = {
		type          = type,
		sources       = {},
		alerts        = {}
	}
end)


AddEventHandler('esx:setJob', function(source, job, lastJob)
  if PhoneNumbers[lastJob.name] ~= nil then
    TriggerEvent('esx_addons_gcphone:removeSource', lastJob.name, source)
  end

  if PhoneNumbers[job.name] ~= nil then
    TriggerEvent('esx_addons_gcphone:addSource', job.name, source)
  end

  if PhoneNumbers["mechanic"] ~= nil and lastJob == "mechanic-bennys" then
    TriggerEvent('esx_addons_gcphone:removeSource', "mechanic", source)
  end

  if PhoneNumbers["mechanic"] ~= nil and job.name == "mechanic-bennys" then
    TriggerEvent('esx_addons_gcphone:addSource', "mechanic", source)
  end

end)

AddEventHandler('esx_addons_gcphone:addSource', function(number, source)
	PhoneNumbers[number].sources[tostring(source)] = true
end)

AddEventHandler('esx_addons_gcphone:removeSource', function(number, source)
	PhoneNumbers[number].sources[tostring(source)] = nil
end)

RegisterServerEvent('gcPhone:sendMessage')
AddEventHandler('gcPhone:sendMessage', function(number, message)
    local sourcePlayer = tonumber(source)
    if PhoneNumbers[number] ~= nil then
      getPhoneNumber(source, function (phone)
        notifyAlertSMS(number, {
          message = message,
          numero = phone,
        }, PhoneNumbers[number].sources)
      end)
    end
end)

RegisterServerEvent('esx_addons_gcphone:startCall')
AddEventHandler('esx_addons_gcphone:startCall', function (number, message, coords, action)
  local source = source

  if number == "admin" then
      TriggerEvent('es_admin:report', source, message)
  end

  if PhoneNumbers[number] ~= nil then
    getPhoneNumber(source, function (phone)
      local numero = phone
      if action == "anonymous" then
        numero = "#####"
      end
      notifyAlertSMS(number, {
        message = message,
        coords = coords,
        numero = numero,
        action = action,
      }, PhoneNumbers[number].sources)
    end)
  else
    print('= WARNING = Call on a non-registered service => number : ' .. number)
  end
end)


AddEventHandler('esx:playerLoaded', function(source)

  local xPlayer = ESX.GetPlayerFromId(source)

  MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier',{
    ['@identifier'] = xPlayer.identifier
  }, function(result)

    local phoneNumber = result[1].phone_number
    xPlayer.set('phoneNumber', phoneNumber)

    if PhoneNumbers[xPlayer.job.name] ~= nil then
      TriggerEvent('esx_addons_gcphone:addSource', xPlayer.job.name, source)
    end

    if PhoneNumbers["mechanic"] ~= nil and xPlayer.job.name == "mechanic-bennys" then
      TriggerEvent('esx_addons_gcphone:addSource', "mechanic", source)
    end
  end)

end)


AddEventHandler('esx:playerDropped', function(source)
  local source = source
  local xPlayer = ESX.GetPlayerFromId(source)
  if PhoneNumbers[xPlayer.job.name] ~= nil then
    TriggerEvent('esx_addons_gcphone:removeSource', xPlayer.job.name, source)
  end
  if PhoneNumbers["mechanic"] ~= nil and xPlayer.job.name == "mechanic-bennys" then
    TriggerEvent('esx_addons_gcphone:removeSource', "mechanic", source)
  end
end)

function getPhoneNumber (source, callback)
  local xPlayer = ESX.GetPlayerFromId(source)
  if xPlayer == nil then
    callback(nil)
  end
  MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier',{
    ['@identifier'] = xPlayer.identifier
  }, function(result)
    callback(result[1].phone_number)
  end)
end



RegisterServerEvent('esx_phone:send')
AddEventHandler('esx_phone:send', function(number, message, _, coords)
  local source = source
  if PhoneNumbers[number] ~= nil then
    getPhoneNumber(source, function (phone)
      notifyAlertSMS(number, {
        message = message,
        coords = coords,
        numero = phone,
      }, PhoneNumbers[number].sources)
    end)
  else
    -- print('esx_phone:send | Appels sur un service non enregistre => numero : ' .. number)
  end
end)
