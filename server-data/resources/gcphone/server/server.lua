ESX                = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- DB CACHE

local dbcache_numbers = {}
local dbcache_idents = {}
local dbcache_contacts = {}
local dbcache_messages = {}
local dbcache_calls = {}

TriggerEvent('es:addGroupCommand', 'gcphone_clearcache', 'admin', function(source, args, user)
    dbcache_numbers = {}
    dbcache_idents = {}
    dbcache_contacts = {}
    dbcache_messages = {}
    dbcache_calls = {}
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = "Очищаем кэш базы данных gcphone"})

-- Добавляем игроку уникальную SIM-карту
AddEventHandler('gcPhone:addNewSIM', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
        local numb = getPhoneRandomNumber()

	local found = false
	for i=1, 10 do
		local result = MySQL.Sync.fetchAll("SELECT id FROM sim_cards WHERE number = @number LIMIT 1", {
			['@number'] = numb
	    })
	    if #result == 0 then
		found = true
		break
            end
	end

	if found == true then
		TriggerEvent("esx_inventory:createItem", "sim", {["number"] = numb}, 1, 0, function(item)
			TriggerEvent("esx_inventory:addItem", "pocket", xPlayer.identifier, item, function(ret)
				if ret == true then
					MySQL.Async.insert("INSERT INTO sim_cards (`identifier`, `number`) VALUES(@identifier, @number)", {
					        ['@identifier'] = xPlayer.identifier,
					        ['@number'] = numb,
					    },function()
					    end)
				end
			end)
		end)
	end
end)

ESX.RegisterUsableItem('sim', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('sim', 1)
	TriggerEvent("gcPhone:addNewSIM", source)
end)

--====================================================================================
-- #Author: Jonathan D @Gannon
-- #Version 2.0
--====================================================================================

math.randomseed(os.time())

--- Pour les numero du style XXX-XXXX
function getPhoneRandomNumber()
    local numBase0 = math.random(10,99)
    local numBase1 = math.random(0,999)
    local num = string.format("%02d%03d", numBase0, numBase1 )
	return num
end

--- Exemple pour les numero du style 06XXXXXXXX
-- function getPhoneRandomNumber()
--     return '0' .. math.random(600000000,699999999)
-- end


--[[
  Ouverture du téphone lié a un item
  Un solution ESC basé sur la solution donnée par HalCroves
  https://forum.fivem.net/t/tutorial-for-gcphone-with-call-and-job-message-other/177904
--]]
--[[
local ESX = nil
TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
    ESX.RegisterServerCallback('gcphone:getItemAmount', function(source, cb, item)
        print('gcphone:getItemAmount call item : ' .. item)
        local xPlayer = ESX.GetPlayerFromId(source)
        local items = xPlayer.getInventoryItem(item)
        if items == nil then
            cb(0)
        else
            cb(items.count)
        end
    end)
end)
--]]



--====================================================================================
--  Utils
--====================================================================================
function getSourceFromIdentifier(identifier, cb)
    TriggerEvent("es:getPlayers", function(users)
        for k , user in pairs(users) do
            if (user.getIdentifier ~= nil and user.getIdentifier() == identifier) or (user.identifier == identifier) then
                cb(k)
                return
            end
        end
    end)
    cb(nil)
end
function getPhoneNumber(identifier)
    if dbcache_numbers[identifier] == nil then
	    local result = MySQL.Sync.fetchAll("SELECT users.phone_number FROM users WHERE users.identifier = @identifier", {
	        ['@identifier'] = identifier
	    })
	    if result[1] ~= nil then
	        dbcache_numbers[identifier] = result[1].phone_number
	    end
    end

    return dbcache_numbers[identifier]
end

function getIdentifierByPhoneNumber(phone_number)
    if dbcache_idents[phone_number] == nil then
	    local result = MySQL.Sync.fetchAll("SELECT users.identifier FROM users WHERE users.phone_number = @phone_number", {
	        ['@phone_number'] = phone_number
	    })
	    if result[1] ~= nil then
	        dbcache_idents[phone_number] = result[1].identifier
	    end
    end

    return dbcache_idents[phone_number]
end

function getPlayerID(source)
      local xPlayer = ESX.GetPlayerFromId(source)
      if xPlayer == nil then
	print(debug.traceback())
      end
      return xPlayer.identifier
end

function getOrGeneratePhoneNumber (sourcePlayer, identifier, cb)
    local sourcePlayer = sourcePlayer
    local identifier = identifier
    local myPhoneNumber = getPhoneNumber(identifier)
    if myPhoneNumber == '0' or myPhoneNumber == nil then
        repeat
            myPhoneNumber = getPhoneRandomNumber()
            local id = getIdentifierByPhoneNumber(myPhoneNumber)
        until id == nil
        MySQL.Async.insert("UPDATE users SET phone_number = @myPhoneNumber WHERE identifier = @identifier", {
            ['@myPhoneNumber'] = myPhoneNumber,
            ['@identifier'] = identifier
        }, function ()
            cb(myPhoneNumber)
        end)
    else
        cb(myPhoneNumber)
    end
end

function setPhoneNumber (source, numb, cb)
      local xPlayer = ESX.GetPlayerFromId(source)
	if numb ~= nil then
	        local id = getIdentifierByPhoneNumber(numb)
		if id ~= nil then
			local xTarget = ESX.GetPlayerFromId(source)
			setPhoneNumber(xTarget.source, nil, nil)
		end
	end

	local oldPhoneNumber = getPhoneNumber(identifier)
	if oldPhoneNumber ~= nil then
		dbcache_idents[oldPhoneNumber] = nil
	end

        MySQL.Async.insert("UPDATE users SET phone_number = @myPhoneNumber WHERE identifier = @identifier", {
            ['@myPhoneNumber'] = numb,
            ['@identifier'] = xPlayer.identifier
        }, function ()
            if numb ~= nil then
		dbcache_numbers[xPlayer.identifier] = nil
                dbcache_idents[numb] = nil
                allUpdate(source, numb)
            end

            if cb ~= nil then
	            cb(numb)
            end
        end)
end

AddEventHandler('gcPhone:setPhoneNumber', function(source, numb, cb)
	setPhoneNumber(source, numb, cb)
end)


--====================================================================================
--  Contacts
--====================================================================================
function getContacts(identifier)
    if dbcache_contacts[identifier] == nil then
	    dbcache_contacts[identifier] = MySQL.Sync.fetchAll("SELECT * FROM phone_users_contacts WHERE phone_users_contacts.identifier = @identifier", {
	        ['@identifier'] = identifier
	    })
    end
    return dbcache_contacts[identifier]
end
function addContact(source, identifier, number, display)
    local sourcePlayer = tonumber(source)
    MySQL.Async.insert("INSERT INTO phone_users_contacts (`identifier`, `number`,`display`) VALUES(@identifier, @number, @display)", {
        ['@identifier'] = identifier,
        ['@number'] = number,
        ['@display'] = display,
    },function()
        dbcache_contacts[identifier] = nil
        notifyContactChange(sourcePlayer, identifier)
    end)
end
function updateContact(source, identifier, id, number, display)
    local sourcePlayer = tonumber(source)
    MySQL.Async.insert("UPDATE phone_users_contacts SET number = @number, display = @display WHERE id = @id", {
        ['@number'] = number,
        ['@display'] = display,
        ['@id'] = id,
    },function()
        dbcache_contacts[identifier] = nil
        notifyContactChange(sourcePlayer, identifier)
    end)
end
function deleteContact(source, identifier, id)
    local sourcePlayer = tonumber(source)
    MySQL.Sync.execute("DELETE FROM phone_users_contacts WHERE `identifier` = @identifier AND `id` = @id", {
        ['@identifier'] = identifier,
        ['@id'] = id,
    })
    dbcache_contacts[identifier] = nil
    notifyContactChange(sourcePlayer, identifier)
end
function deleteAllContact(identifier)
    MySQL.Sync.execute("DELETE FROM phone_users_contacts WHERE `identifier` = @identifier", {
        ['@identifier'] = identifier
    })
    dbcache_contacts[identifier] = nil
end
function notifyContactChange(source, identifier)
    local sourcePlayer = tonumber(source)
    local identifier = identifier
    if sourcePlayer ~= nil then
        TriggerClientEvent("gcPhone:contactList", sourcePlayer, getContacts(identifier))
    end
end

RegisterServerEvent('gcPhone:addContact')
AddEventHandler('gcPhone:addContact', function(display, phoneNumber)
    local sourcePlayer = tonumber(source)
    local identifier = getPlayerID(source)
    local simid = getPhoneNumber(identifier)
    addContact(sourcePlayer, simid, phoneNumber, display)
end)

RegisterServerEvent('gcPhone:updateContact')
AddEventHandler('gcPhone:updateContact', function(id, display, phoneNumber)
    local sourcePlayer = tonumber(source)
    local identifier = getPlayerID(source)
    local simid = getPhoneNumber(identifier)
    updateContact(sourcePlayer, simid, id, phoneNumber, display)
end)

RegisterServerEvent('gcPhone:deleteContact')
AddEventHandler('gcPhone:deleteContact', function(id)
    local sourcePlayer = tonumber(source)
    local identifier = getPlayerID(source)
    local simid = getPhoneNumber(identifier)
    deleteContact(sourcePlayer, simid, id)
end)

RegisterServerEvent('gcPhone:acceptAction')
AddEventHandler('gcPhone:acceptAction', function(action)
    local sourcePlayer = tonumber(source)
    TriggerClientEvent("gcPhone:acceptAction", -1, sourcePlayer, action)
end)

--====================================================================================
--  Messages
--====================================================================================
function getMessages(numb)
    if dbcache_messages[numb] == nil then
	    dbcache_messages[numb] = MySQL.Sync.fetchAll("SELECT phone_messages.* FROM phone_messages WHERE phone_messages.receiver = @phone_number", {
	         ['@phone_number'] = numb
	    })
    end
    return dbcache_messages[numb]
    --return MySQLQueryTimeStamp("SELECT phone_messages.* FROM phone_messages LEFT JOIN users ON users.identifier = @identifier WHERE phone_messages.receiver = users.phone_number", {['@identifier'] = identifier})
end

RegisterServerEvent('gcPhone:_internalAddMessage')
AddEventHandler('gcPhone:_internalAddMessage', function(transmitter, receiver, message, owner, options, cb)
    dbcache_messages[receiver] = nil
    cb(_internalAddMessage(transmitter, receiver, message, owner, options))
end)

function _internalAddMessage(transmitter, receiver, message, owner, options)
    local id = MySQL.Sync.insert("INSERT INTO phone_messages (`transmitter`, `receiver`,`message`, `isRead`,`owner`,`options`) VALUES(@transmitter, @receiver, @message, @isRead, @owner, @options);", {
        ['@transmitter'] = transmitter,
        ['@receiver'] = receiver,
        ['@message'] = message,
        ['@isRead'] = owner,
        ['@owner'] = owner,
	['@options'] = json.encode(options),
    })

    if id == nil then
        return nil
    end

    local res = MySQL.Sync.fetchAll('SELECT * from phone_messages WHERE `id` = @id;', {
        ['@id'] = id
    })[1]

    if res ~= nil and res.options ~= nil then
       res.options = json.decode(res.options)
    end

    return res
end

function addMessage(source, identifier, phone_number, message, options)
    local sourcePlayer = tonumber(source)
    local otherIdentifier = getIdentifierByPhoneNumber(phone_number)
    local myPhone = getPhoneNumber(identifier)
    dbcache_messages[myPhone] = nil
    if otherIdentifier ~= nil then
        dbcache_messages[phone_number] = nil
        local tomess = _internalAddMessage(myPhone, phone_number, message, 0, options)
        getSourceFromIdentifier(otherIdentifier, function (osou)
            if tonumber(osou) ~= nil then
                -- TriggerClientEvent("gcPhone:allMessage", osou, getMessages(otherIdentifier))
                TriggerClientEvent("gcPhone:receiveMessage", tonumber(osou), tomess)
            end
        end)
    end
    local memess = _internalAddMessage(phone_number, myPhone, message, 1, options)
    TriggerClientEvent("gcPhone:receiveMessage", sourcePlayer, memess)
end

RegisterServerEvent('gcPhone:addFakeMessage')
AddEventHandler('gcPhone:addFakeMessage', function(fake_number, to_number, message)
    addFakeMessage(fake_number, to_number, message)
end)
function addFakeMessage(fake_number, to_number, message, options)
    local otherIdentifier = getIdentifierByPhoneNumber(to_number)
    if otherIdentifier ~= nil then
        dbcache_messages[to_number] = nil
        local tomess = _internalAddMessage(fake_number, to_number, message, 0, options)
        getSourceFromIdentifier(otherIdentifier, function (osou)
            if tonumber(osou) ~= nil then
                TriggerClientEvent("gcPhone:receiveMessage", tonumber(osou), tomess)
            end
        end)
    end
end

function setReadMessageNumber(identifier, num)
    local mePhoneNumber = getPhoneNumber(identifier)
    MySQL.Sync.execute("UPDATE phone_messages SET phone_messages.isRead = 1 WHERE phone_messages.receiver = @receiver AND phone_messages.transmitter = @transmitter", {
        ['@receiver'] = mePhoneNumber,
        ['@transmitter'] = num
    })

    dbcache_messages[mePhoneNumber] = nil
end

function deleteMessage(msgId)
    MySQL.Sync.execute("DELETE FROM phone_messages WHERE `id` = @id", {
        ['@id'] = msgId
    })
end

function deleteAllMessageFromPhoneNumber(source, identifier, phone_number)
    local source = source
    local identifier = identifier
    local mePhoneNumber = getPhoneNumber(identifier)
    MySQL.Sync.execute("DELETE FROM phone_messages WHERE `receiver` = @mePhoneNumber and `transmitter` = @phone_number", {['@mePhoneNumber'] = mePhoneNumber,['@phone_number'] = phone_number})
end

function deleteAllMessage(identifier)
    local mePhoneNumber = getPhoneNumber(identifier)
    MySQL.Sync.execute("DELETE FROM phone_messages WHERE `receiver` = @mePhoneNumber", {
        ['@mePhoneNumber'] = mePhoneNumber
    })
end

RegisterServerEvent('gcPhone:sendMessage')
AddEventHandler('gcPhone:sendMessage', function(phoneNumber, message)
    local sourcePlayer = tonumber(source)
    local identifier = getPlayerID(source)

    if #message > 0 and message:sub(1,1) == '#' then
        addFakeMessage("#####", phoneNumber, message:sub(2), {})
    else
        addMessage(sourcePlayer, identifier, phoneNumber, message, {})
    end

end)

RegisterServerEvent('gcPhone:deleteMessage')
AddEventHandler('gcPhone:deleteMessage', function(msgId)
    deleteMessage(msgId)
end)

RegisterServerEvent('gcPhone:deleteMessageNumber')
AddEventHandler('gcPhone:deleteMessageNumber', function(number)
    local sourcePlayer = tonumber(source)
    local identifier = getPlayerID(source)
    deleteAllMessageFromPhoneNumber(sourcePlayer,identifier, number)
    -- TriggerClientEvent("gcphone:allMessage", sourcePlayer, getMessages(identifier))
end)

RegisterServerEvent('gcPhone:deleteAllMessage')
AddEventHandler('gcPhone:deleteAllMessage', function()
    local sourcePlayer = tonumber(source)
    local identifier = getPlayerID(source)
    deleteAllMessage(identifier)
end)

RegisterServerEvent('gcPhone:setReadMessageNumber')
AddEventHandler('gcPhone:setReadMessageNumber', function(num)
    local identifier = getPlayerID(source)
    setReadMessageNumber(identifier, num)
end)

RegisterServerEvent('gcPhone:deleteALL')
AddEventHandler('gcPhone:deleteALL', function()
    local sourcePlayer = tonumber(source)
    local identifier = getPlayerID(source)
    deleteAllMessage(identifier)
    deleteAllContact(identifier)
    appelsDeleteAllHistorique(identifier)
    TriggerClientEvent("gcPhone:contactList", sourcePlayer, {})
    TriggerClientEvent("gcPhone:allMessage", sourcePlayer, {})
    TriggerClientEvent("appelsDeleteAllHistorique", sourcePlayer, {})
end)

--====================================================================================
--  Gestion des appels
--====================================================================================
local AppelsEnCours = {}
local PhoneFixeInfo = {}
local lastIndexCall = 10

function getHistoriqueCall (num)
    if dbcache_calls[num] == nil then
	    dbcache_calls[num] = MySQL.Sync.fetchAll("SELECT * FROM phone_calls WHERE phone_calls.owner = @num ORDER BY time DESC LIMIT 120", {
	        ['@num'] = num
	    })
    end
    return dbcache_calls[num]
end

function sendHistoriqueCall (src, num)
    local histo = getHistoriqueCall(num)
    TriggerClientEvent('gcPhone:historiqueCall', src, histo)
end

function saveAppels (appelInfo)
    if appelInfo.extraData == nil or appelInfo.extraData.useNumber == nil then
        MySQL.Async.insert("INSERT INTO phone_calls (`owner`, `num`,`incoming`, `accepts`) VALUES(@owner, @num, @incoming, @accepts)", {
            ['@owner'] = appelInfo.transmitter_num,
            ['@num'] = appelInfo.receiver_num,
            ['@incoming'] = 1,
            ['@accepts'] = appelInfo.is_accepts
        }, function()
            notifyNewAppelsHisto(appelInfo.transmitter_src, appelInfo.transmitter_num)
            dbcache_calls[appelInfo.receiver_num] = nil
        end)
    end
    if appelInfo.is_valid == true then
        local num = appelInfo.transmitter_num
        if appelInfo.hidden == true then
            mun = "###-####"
        end
        MySQL.Async.insert("INSERT INTO phone_calls (`owner`, `num`,`incoming`, `accepts`) VALUES(@owner, @num, @incoming, @accepts)", {
            ['@owner'] = appelInfo.receiver_num,
            ['@num'] = num,
            ['@incoming'] = 0,
            ['@accepts'] = appelInfo.is_accepts
        }, function()
            if appelInfo.receiver_src ~= nil then
                notifyNewAppelsHisto(appelInfo.receiver_src, appelInfo.receiver_num)
                dbcache_calls[num] = nil
            end
        end)
    end
end

function notifyNewAppelsHisto (src, num)
    sendHistoriqueCall(src, num)
end

RegisterServerEvent('gcPhone:getHistoriqueCall')
AddEventHandler('gcPhone:getHistoriqueCall', function()
    local sourcePlayer = tonumber(source)
    local srcIdentifier = getPlayerID(source)
    local srcPhone = getPhoneNumber(srcIdentifier)
    sendHistoriqueCall(sourcePlayer, num)
end)


RegisterServerEvent('gcPhone:internal_startCall')
AddEventHandler('gcPhone:internal_startCall', function(source, phone_number, rtcOffer, extraData)
    if FixePhone[phone_number] ~= nil then
        onCallFixePhone(source, phone_number, rtcOffer, extraData)
        return
    end

    local rtcOffer = rtcOffer
    if phone_number == nil or phone_number == '' then
        print('BAD CALL NUMBER IS NIL')
        return
    end

    local hidden = string.sub(phone_number, 1, 1) == '#'
    if hidden == true then
        phone_number = string.sub(phone_number, 2)
    end

    local indexCall = lastIndexCall
    lastIndexCall = lastIndexCall + 1

    local sourcePlayer = tonumber(source)
    local srcIdentifier = getPlayerID(source)

    local srcPhone = ''
    if extraData ~= nil and extraData.useNumber ~= nil then
        srcPhone = extraData.useNumber
    else
        srcPhone = getPhoneNumber(srcIdentifier)
    end
    local destPlayer = getIdentifierByPhoneNumber(phone_number)
    local is_valid = destPlayer ~= nil and destPlayer ~= srcIdentifier
    AppelsEnCours[indexCall] = {
        id = indexCall,
        transmitter_src = sourcePlayer,
        transmitter_num = srcPhone,
        receiver_src = nil,
        receiver_num = phone_number,
        is_valid = destPlayer ~= nil,
        is_accepts = false,
        hidden = hidden,
        rtcOffer = rtcOffer,
        extraData = extraData
    }


    if is_valid == true then
        getSourceFromIdentifier(destPlayer, function (srcTo)
            if srcTo ~= nill then
                AppelsEnCours[indexCall].receiver_src = srcTo
                TriggerEvent('gcPhone:addCall', AppelsEnCours[indexCall])
                TriggerClientEvent('gcPhone:waitingCall', sourcePlayer, AppelsEnCours[indexCall], true)
                TriggerClientEvent('gcPhone:waitingCall', srcTo, AppelsEnCours[indexCall], false)
            else
                TriggerEvent('gcPhone:addCall', AppelsEnCours[indexCall])
                TriggerClientEvent('gcPhone:waitingCall', sourcePlayer, AppelsEnCours[indexCall], true)
            end
        end)
    else
        TriggerEvent('gcPhone:addCall', AppelsEnCours[indexCall])
        TriggerClientEvent('gcPhone:waitingCall', sourcePlayer, AppelsEnCours[indexCall], true)
    end

end)

RegisterServerEvent('gcPhone:startCall')
AddEventHandler('gcPhone:startCall', function(phone_number, rtcOffer, extraData)
    TriggerEvent('gcPhone:internal_startCall',source, phone_number, rtcOffer, extraData)
end)

RegisterServerEvent('gcPhone:candidates')
AddEventHandler('gcPhone:candidates', function (callId, candidates)
    -- print('send cadidate', callId, candidates)
    if AppelsEnCours[callId] ~= nil then
        local source = source
        local to = AppelsEnCours[callId].transmitter_src
        if source == to then
            to = AppelsEnCours[callId].receiver_src
        end
        -- print('TO', to)
        TriggerClientEvent('gcPhone:candidates', to, candidates)
    end
end)


RegisterServerEvent('gcPhone:acceptCall')
AddEventHandler('gcPhone:acceptCall', function(infoCall, rtcAnswer)
    local id = infoCall.id
    if AppelsEnCours[id] ~= nil then
        if PhoneFixeInfo[id] ~= nil then
            onAcceptFixePhone(source, infoCall, rtcAnswer)
            return
        end
        AppelsEnCours[id].receiver_src = infoCall.receiver_src or AppelsEnCours[id].receiver_src
        if AppelsEnCours[id].transmitter_src ~= nil and AppelsEnCours[id].receiver_src~= nil then
            AppelsEnCours[id].is_accepts = true
            AppelsEnCours[id].rtcAnswer = rtcAnswer
            TriggerClientEvent('gcPhone:acceptCall', AppelsEnCours[id].transmitter_src, AppelsEnCours[id], true)
	    SetTimeout(1000, function() -- change to +1000, if necessary.
       		TriggerClientEvent('gcPhone:acceptCall', AppelsEnCours[id].receiver_src, AppelsEnCours[id], false)
	    end)
            saveAppels(AppelsEnCours[id])
        end
    end
end)




RegisterServerEvent('gcPhone:rejectCall')
AddEventHandler('gcPhone:rejectCall', function (infoCall)
    local id = infoCall.id
    if AppelsEnCours[id] ~= nil then
        if PhoneFixeInfo[id] ~= nil then
            onRejectFixePhone(source, infoCall)
            return
        end
        if AppelsEnCours[id].transmitter_src ~= nil then
            TriggerClientEvent('gcPhone:rejectCall', AppelsEnCours[id].transmitter_src)
        end
        if AppelsEnCours[id].receiver_src ~= nil then
            TriggerClientEvent('gcPhone:rejectCall', AppelsEnCours[id].receiver_src)
        end

        if AppelsEnCours[id].is_accepts == false then
            saveAppels(AppelsEnCours[id])
        end
        TriggerEvent('gcPhone:removeCall', AppelsEnCours)
        AppelsEnCours[id] = nil
    end
end)

RegisterServerEvent('gcPhone:appelsDeleteHistorique')
AddEventHandler('gcPhone:appelsDeleteHistorique', function (numero)
    local sourcePlayer = tonumber(source)
    local srcIdentifier = getPlayerID(source)
    local srcPhone = getPhoneNumber(srcIdentifier)
    MySQL.Sync.execute("DELETE FROM phone_calls WHERE `owner` = @owner AND `num` = @num", {
        ['@owner'] = srcPhone,
        ['@num'] = numero
    })
    dbcache_calls[numero] = nil
end)

function appelsDeleteAllHistorique(srcIdentifier)
    local srcPhone = getPhoneNumber(srcIdentifier)
    MySQL.Sync.execute("DELETE FROM phone_calls WHERE `owner` = @owner", {
        ['@owner'] = srcPhone
    })
end

RegisterServerEvent('gcPhone:appelsDeleteAllHistorique')
AddEventHandler('gcPhone:appelsDeleteAllHistorique', function ()
    local sourcePlayer = tonumber(source)
    local srcIdentifier = getPlayerID(source)
    appelsDeleteAllHistorique(srcIdentifier)
end)

RegisterServerEvent('gcPhone:bankTransferMoney')
AddEventHandler('gcPhone:bankTransferMoney', function(target_phone_number, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local otherIdentifier = getIdentifierByPhoneNumber(target_phone_number)

    local source_phone_number = getPhoneNumber(xPlayer.identifier)

    if otherIdentifier == nil or xPlayer == nil then
	TriggerClientEvent('esx:showNotification', xPlayer.source, "Абонент недоступен")
        return
    end

    local xTarget = ESX.GetPlayerFromIdentifier(otherIdentifier)
    if xTarget == nil then
	TriggerClientEvent('esx:showNotification', xPlayer.source, "Абонент недоступен")
        return
    end

    if amount > 0 and xPlayer.getBank() >= amount then
	xPlayer.removeBank(amount)
	xTarget.addBank(amount)
	addFakeMessage("MAZEBANK", target_phone_number, "Вы получили перевод на сумму $"..tostring(amount).." от абонента "..source_phone_number)
	addFakeMessage("MAZEBANK", source_phone_number, "Вы отправили перевод на сумму $"..tostring(amount).." абоненту "..target_phone_number)
    else
	TriggerClientEvent('esx:showNotification', xPlayer.source, "Недостаточно средств")
    end
end)










































--====================================================================================
--  OnLoad
--====================================================================================
function allUpdate(source, num)
    local xPlayer = ESX.GetPlayerFromId(source)
    local sourcePlayer = tonumber(source)
    local identifier = xPlayer.identifier

    TriggerClientEvent("gcPhone:myPhoneNumber", sourcePlayer, num)
    TriggerClientEvent("gcPhone:contactList", sourcePlayer, getContacts(num))
    TriggerClientEvent("gcPhone:allMessage", sourcePlayer, getMessages(num))
    TriggerClientEvent('gcPhone:getBourse', sourcePlayer, getBourse())
    TriggerClientEvent("gcPhone:updatePhotoInfo", sourcePlayer, GetConvar('gcphone_photo_url', ''), GetConvar('gcphone_photo_field', ''))
    sendHistoriqueCall(sourcePlayer, num)
end

AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
    local phoneNumber = getPhoneNumber(xPlayer.identifier)
    allUpdate(xPlayer.source, phoneNumber)
end)

-- Just For reload
RegisterServerEvent('gcPhone:allUpdate')
AddEventHandler('gcPhone:allUpdate', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local myPhoneNumber = getPhoneNumber(xPlayer.identifier)
    allUpdate(xPlayer.source, myPhoneNumber)
end)


AddEventHandler('onMySQLReady', function ()
    -- MySQL.Async.fetchAll("DELETE FROM phone_messages WHERE (DATEDIFF(CURRENT_DATE,time) > 10)")
end)

--====================================================================================
--  App bourse
--====================================================================================
function getBourse()
    --  Format
    --  Array
    --    Object
    --      -- libelle type String    | Nom
    --      -- price type number      | Prix actuelle
    --      -- difference type number | Evolution
    --
    -- local result = MySQL.Sync.fetchAll("SELECT * FROM `recolt` LEFT JOIN `items` ON items.`id` = recolt.`treated_id` WHERE fluctuation = 1 ORDER BY price DESC",{})
    local result = {
        {
            libelle = 'Google',
            price = 125.2,
            difference =  -12.1
        },
        {
            libelle = 'Microsoft',
            price = 132.2,
            difference = 3.1
        },
        {
            libelle = 'Amazon',
            price = 120,
            difference = 0
        }
    }
    return result
end

--====================================================================================
--  App ... WIP
--====================================================================================


-- SendNUIMessage('ongcPhoneRTC_receive_offer')
-- SendNUIMessage('ongcPhoneRTC_receive_answer')

-- RegisterNUICallback('gcPhoneRTC_send_offer', function (data)


-- end)


-- RegisterNUICallback('gcPhoneRTC_send_answer', function (data)


-- end)



function onCallFixePhone (source, phone_number, rtcOffer, extraData)
    local indexCall = lastIndexCall
    lastIndexCall = lastIndexCall + 1

    local hidden = string.sub(phone_number, 1, 1) == '#'
    if hidden == true then
        phone_number = string.sub(phone_number, 2)
    end
    local sourcePlayer = tonumber(source)
    local srcIdentifier = getPlayerID(source)

    local srcPhone = ''
    if extraData ~= nil and extraData.useNumber ~= nil then
        srcPhone = extraData.useNumber
    else
        srcPhone = getPhoneNumber(srcIdentifier)
    end

    AppelsEnCours[indexCall] = {
        id = indexCall,
        transmitter_src = sourcePlayer,
        transmitter_num = srcPhone,
        receiver_src = nil,
        receiver_num = phone_number,
        is_valid = false,
        is_accepts = false,
        hidden = hidden,
        rtcOffer = rtcOffer,
        extraData = extraData,
        coords = FixePhone[phone_number].coords
    }

    PhoneFixeInfo[indexCall] = AppelsEnCours[indexCall]

    TriggerClientEvent('gcPhone:notifyFixePhoneChange', -1, PhoneFixeInfo)
    TriggerClientEvent('gcPhone:waitingCall', sourcePlayer, AppelsEnCours[indexCall], true)
end



function onAcceptFixePhone(source, infoCall, rtcAnswer)
    local id = infoCall.id

    AppelsEnCours[id].receiver_src = source
    if AppelsEnCours[id].transmitter_src ~= nil and AppelsEnCours[id].receiver_src~= nil then
        AppelsEnCours[id].is_accepts = true
        AppelsEnCours[id].forceSaveAfter = true
        AppelsEnCours[id].rtcAnswer = rtcAnswer
        PhoneFixeInfo[id] = nil
        TriggerClientEvent('gcPhone:notifyFixePhoneChange', -1, PhoneFixeInfo)
        TriggerClientEvent('gcPhone:acceptCall', AppelsEnCours[id].transmitter_src, AppelsEnCours[id], true)
	SetTimeout(1000, function() -- change to +1000, if necessary.
       		TriggerClientEvent('gcPhone:acceptCall', AppelsEnCours[id].receiver_src, AppelsEnCours[id], false)
	end)
        saveAppels(AppelsEnCours[id])
    end
end

function onRejectFixePhone(source, infoCall, rtcAnswer)
    local id = infoCall.id
    PhoneFixeInfo[id] = nil
    TriggerClientEvent('gcPhone:notifyFixePhoneChange', -1, PhoneFixeInfo)
    TriggerClientEvent('gcPhone:rejectCall', AppelsEnCours[id].transmitter_src)
    if AppelsEnCours[id].is_accepts == false then
        saveAppels(AppelsEnCours[id])
    end
    AppelsEnCours[id] = nil

end
