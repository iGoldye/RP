ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(60*60*1000) -- 1 hour
		MySQL.Async.execute([[UPDATE `stadus_skills` SET 
			stamina=stamina*0.998,
			strength=strength*0.998,
			driving=driving*0.998,
			shooting=shooting*0.998,
			fishing=fishing*0.998,
			drugs=drugs*0.998,
			lockpicking=lockpicking*0.998]],
		{})
	end
end)

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
				['@drugs'] = 0,
				['@lockpicking'] = 0,
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

function addSkill(identifier, skill, amount, cb)
	if(skill:match("%W")) then
		print("stadus_skills: addSkill possible db injection attempt! "..identifier)
		return
	end

	MySQL.Async.fetchAll('SELECT * FROM `stadus_skills` WHERE `identifier` = @identifier', {['@identifier'] = identifier}, function(skillInfo)
		if skillInfo[1][skill] ~= nil then
			local newSkill = (skillInfo[1][skill] + amount)
			if newSkill > 100 then
				newSkill = 100
			end
			MySQL.Async.execute('UPDATE `stadus_skills` SET `'..skill..'` = @skill WHERE `identifier` = @identifier',
			{
				['@skill'] = newSkill,
				['@identifier'] = identifier
			}, function ()
				cb(newSkill)
			end)
		end
	end)
end

RegisterServerEvent("stadus_skills:addSkill")
AddEventHandler("stadus_skills:addSkill", function(name, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	addSkill(xPlayer.identifier, name, amount, function(val)
		updatePlayerInfo(xPlayer.source)
	end)
end)

RegisterServerEvent("stadus_skills:addStamina")
AddEventHandler("stadus_skills:addStamina", function(source, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	addSkill(xPlayer.identifier, "stamina", amount, function(val)
--		TriggerClientEvent('esx:showNotification', source, 'Вы чувствуете себя на ~g~' .. round(amount, 2) .. '% ~s~быстрее!')
		updatePlayerInfo(xPlayer.source)
	end)
end)

RegisterServerEvent("stadus_skills:addStrength")
AddEventHandler("stadus_skills:addStrength", function(source, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	addSkill(xPlayer.identifier, "strength", amount, function(val)
--		TriggerClientEvent('esx:showNotification', source, 'Вы чувствуете себя на ~g~' .. round(amount, 2) .. '% ~s~сильнее!')
		updatePlayerInfo(xPlayer.source)
	end)
end)

RegisterServerEvent("stadus_skills:addDriving")
AddEventHandler("stadus_skills:addDriving", function(source, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	addSkill(xPlayer.identifier, "strength", amount, function(val)
--		TriggerClientEvent('esx:showNotification', source, 'Вы на ~g~' .. round(amount, 2) .. '% ~s~лучше чувствуете себя за рулем!')
		updatePlayerInfo(xPlayer.source)
	end)
end)

RegisterServerEvent("stadus_skills:addFishing")
AddEventHandler("stadus_skills:addFishing", function(source, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	addSkill(xPlayer.identifier, "strength", amount, function(val)
--		TriggerClientEvent('esx:showNotification', source, 'Вы совершенствуете на ~g~' .. round(amount, 2) .. '% ~s~мастерство рыбалки!')
		updatePlayerInfo(xPlayer.source)
	end)
end)

RegisterServerEvent("stadus_skills:addDrugs")
AddEventHandler("stadus_skills:addDrugs", function(source, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	addSkill(xPlayer.identifier, "strength", amount, function(val)
--		TriggerClientEvent('esx:showNotification', source, 'Вы совершенстувете навык ~g~' .. round(amount, 2) .. '% ~s~производства ~y~наркотиков~s~!')
		updatePlayerInfo(xPlayer.source)
	end)
end)

ESX.RegisterServerCallback('stadus_skills:getSkills', function(source, cb)
  local xPlayer    = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll('SELECT * FROM `stadus_skills` WHERE `identifier` = @identifier', {['@identifier'] = xPlayer.identifier}, function(skillInfo)
		cb(skillInfo[1])
	end)
end)
