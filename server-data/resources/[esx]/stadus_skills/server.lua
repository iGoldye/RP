ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

AddEventHandler('esx:playerLoaded', function(source)
  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(_source)
	MySQL.Async.fetchAll('SELECT * FROM `stadus_skills` WHERE `identifier` = @identifier', {['@identifier'] = xPlayer.identifier}, function(skillInfo)
		if ( skillInfo and skillInfo[1] ) then
			TriggerClientEvent('stadus_skills:sendPlayerSkills', _source, skillInfo[1])
			else
				MySQL.Async.execute('INSERT INTO `stadus_skills` (`identifier`, `strength`, `stamina`, `driving`, `shooting`, `fishing`, `drugs`) VALUES (@identifier, @strength, @stamina, @driving, @shooting, @fishing, @drugs);',
				{
				['@identifier'] = xPlayer.identifier,
				['@strength'] = 0,
				['@stamina'] = 0,
				['@driving'] = 0,
				['@shooting'] = 0,
				['@fishing'] = 0,
				['@drugs'] = 0
				}, function ()
				end)
		end
	end)
end)

function updatePlayerInfo(source)
  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(_source)
	MySQL.Async.fetchAll('SELECT * FROM `stadus_skills` WHERE `identifier` = @identifier', {['@identifier'] = xPlayer.identifier}, function(skillInfo)
		if ( skillInfo and skillInfo[1] ) then
			TriggerClientEvent('stadus_skills:sendPlayerSkills', _source, skillInfo[1])
		end
	end)
end

RegisterServerEvent("stadus_skills:addStamina")
AddEventHandler("stadus_skills:addStamina", function(source, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
--	TriggerClientEvent('esx:showNotification', source, 'Вы чувствуете себя на ~g~' .. round(amount, 2) .. '% ~s~быстрее!')
	MySQL.Async.fetchAll('SELECT * FROM `stadus_skills` WHERE `identifier` = @identifier', {['@identifier'] = xPlayer.identifier}, function(skillInfo)
		local newStamina = (skillInfo[1].stamina + amount)
		if newStamina > 100 then
			newStamina = 100
		end
		MySQL.Async.execute('UPDATE `stadus_skills` SET `stamina` = @stamina WHERE `identifier` = @identifier',
			{
			['@stamina'] = newStamina,
			['@identifier'] = xPlayer.identifier
			}, function ()
			updatePlayerInfo(source)
		end)
	end)
end)

RegisterServerEvent("stadus_skills:addStrength")
AddEventHandler("stadus_skills:addStrength", function(source, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
--	TriggerClientEvent('esx:showNotification', source, 'Вы чувствуете себя на ~g~' .. round(amount, 2) .. '% ~s~сильнее!')
	MySQL.Async.fetchAll('SELECT * FROM `stadus_skills` WHERE `identifier` = @identifier', {['@identifier'] = xPlayer.identifier}, function(skillInfo)
		local newStrength = (skillInfo[1].strength + amount)
		if newStrength > 100 then
			newStrength = 100
		end
		MySQL.Async.execute('UPDATE `stadus_skills` SET `strength` = @strength WHERE `identifier` = @identifier',
			{
			['@strength'] = newStrength,
			['@identifier'] = xPlayer.identifier
			}, function ()
			updatePlayerInfo(source)
		end)
	end)
end)

RegisterServerEvent("stadus_skills:addDriving")
AddEventHandler("stadus_skills:addDriving", function(source, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
--	TriggerClientEvent('esx:showNotification', source, 'Вы на ~g~' .. round(amount, 2) .. '% ~s~лучше чувствуете себя за рулем!')
	MySQL.Async.fetchAll('SELECT * FROM `stadus_skills` WHERE `identifier` = @identifier', {['@identifier'] = xPlayer.identifier}, function(skillInfo)
		local newDriving = (skillInfo[1].driving + amount)
		if newDriving > 100 then
			newDriving = 100
		end
		MySQL.Async.execute('UPDATE `stadus_skills` SET `driving` = @driving WHERE `identifier` = @identifier',
			{
			['@driving'] = newDriving,
			['@identifier'] = xPlayer.identifier
			}, function ()
			updatePlayerInfo(source)
		end)
	end)
end)

RegisterServerEvent("stadus_skills:addFishing")
AddEventHandler("stadus_skills:addFishing", function(source, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
--	TriggerClientEvent('esx:showNotification', source, 'Вы совершенствуете на ~g~' .. round(amount, 2) .. '% ~s~мастерство рыбалки!')
	MySQL.Async.fetchAll('SELECT * FROM `stadus_skills` WHERE `identifier` = @identifier', {['@identifier'] = xPlayer.identifier}, function(skillInfo)
		local newFishing = (skillInfo[1].fishing + amount)
		if newFishing > 100 then
			newFishing = 100
		end
		MySQL.Async.execute('UPDATE `stadus_skills` SET `fishing` = @fishing WHERE `identifier` = @identifier',
			{
			['@fishing'] = newFishing,
			['@identifier'] = xPlayer.identifier
			}, function ()
			updatePlayerInfo(source)
		end)
	end)
end)

RegisterServerEvent("stadus_skills:addDrugs")
AddEventHandler("stadus_skills:addDrugs", function(source, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
--	TriggerClientEvent('esx:showNotification', source, 'Вы совершенстувете навык ~g~' .. round(amount, 2) .. '% ~s~производства ~y~наркотиков~s~!')
	MySQL.Async.fetchAll('SELECT * FROM `stadus_skills` WHERE `identifier` = @identifier', {['@identifier'] = xPlayer.identifier}, function(skillInfo)
		local newDrugs = (skillInfo[1].drugs + amount)
		if newDrugs > 100 then
			newDrugs = 100
		end
		MySQL.Async.execute('UPDATE `stadus_skills` SET `drugs` = @drugs WHERE `identifier` = @identifier',
			{
			['@drugs'] = newDrugs,
			['@identifier'] = xPlayer.identifier
			}, function ()
			updatePlayerInfo(source)
		end)
	end)
end)

ESX.RegisterServerCallback('stadus_skills:getSkills', function(source, cb)
  local xPlayer    = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll('SELECT * FROM `stadus_skills` WHERE `identifier` = @identifier', {['@identifier'] = xPlayer.identifier}, function(skillInfo)
		cb(skillInfo[1])
	end)
end)
