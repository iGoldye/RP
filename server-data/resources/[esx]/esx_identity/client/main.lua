local guiEnabled = false
local myIdentity = {}
local hasIdentity = false
local isDead = false

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
end)

AddEventHandler('playerSpawned', function(spawn)
	isDead = false
end)

function EnableGui(state)
	guiEnabled = state
	SetNuiFocus(state,state)

	SendNUIMessage({
		type = "enableui",
		enable = state
	})
end

RegisterNetEvent('esx_identity:hasIdentity')
AddEventHandler('esx_identity:hasIdentity', function(cb)
	cb(hasIdentity)
end)

RegisterNetEvent('esx_identity:showRegisterIdentity')
AddEventHandler('esx_identity:showRegisterIdentity', function()
	if not isDead then
		EnableGui(true)
	end
end)

RegisterNetEvent('esx_identity:identityCheck')
AddEventHandler('esx_identity:identityCheck', function(data)
	hasIdentity = data ~= nil
	ESX.SetPlayerData('identity', data)
	myIdentity = data
end)

RegisterNUICallback('escape', function(data, cb)
	if hasIdentity then
		EnableGui(false)
	else
		TriggerEvent('chat:addMessage', { args = { '^1[IDENTITY]', '^1You must create your first character in order to play' } })
	end
end)

RegisterNUICallback('register', function(data, cb)
	local reason = ""

	local ped = PlayerPedId()
	SetEntityCoordsNoOffset(ped, -1042.31, -2745.59, 21.36, false, false, false, true)
	SetEntityHeading(ped, 328.56)

	for theData, value in pairs(data) do
		if theData == "firstname" or theData == "lastname" then
			reason = verifyName(value)

			if reason ~= "" then
				break
			end
		elseif theData == "dateofbirth" then
			if value == "invalid" then
				reason = "Invalid date of birth!"
				break
			end
		elseif theData == "height" then
			local height = tonumber(value)
			if height then
				if height > 200 or height < 140 then
					reason = "Unacceptable player height!"
					break
				end
			else
				reason = "Unacceptable player height!"
				break
			end
		end
	end

	if reason == "" then
		TriggerServerEvent('esx_identity:setIdentity', data)
		EnableGui(false)
		Citizen.Wait(500)

		openSkinMenu(data)
	else
		ESX.ShowNotification(reason)
		EnableGui(true)
	end
end)

function openSkinMenu(data)
-- TriggerEvent('vueskincreator:show', data)
	TriggerEvent('esx_skin:openSaveableMenu', function()
-- successfully registered
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'skin-confirm',
		{
			title    = 'Закончить создание персонажа?',
			align    = 'top-left',
			elements = {
					{label="Нет, вернуться к редактированию персонажа", value="cancel"},
					{label="Нет, вернуться к редактированию персонажа", value="cancel"},
					{label="Нет, вернуться к редактированию персонажа", value="cancel"},
					{label="<font color='green'>Да, сохранить настройки и приступить к игре</font>", value="apply"},
					{label="Нет, вернуться к редактированию персонажа", value="cancel"},
					{label="Нет, вернуться к редактированию персонажа", value="cancel"},
					{label="Нет, вернуться к редактированию персонажа", value="cancel"},
				   }
		}, function(data, menu)
			if data.current.value ~= "apply" then
				openSkinMenu(data)
			end
			menu.close()
		end, function(data, menu)
			openSkinMenu(data)
			menu.close()
		end)

	end, function()
		openSkinMenu(data)
	end)
end

Citizen.CreateThread(function()
	while true do
		if guiEnabled then
			DisableControlAction(0, 1,   true) -- LookLeftRight
			DisableControlAction(0, 2,   true) -- LookUpDown
			DisableControlAction(0, 106, true) -- VehicleMouseControlOverride
			DisableControlAction(0, 142, true) -- MeleeAttackAlternate
			DisableControlAction(0, 30,  true) -- MoveLeftRight
			DisableControlAction(0, 31,  true) -- MoveUpDown
			DisableControlAction(0, 21,  true) -- disable sprint
			DisableControlAction(0, 24,  true) -- disable attack
			DisableControlAction(0, 25,  true) -- disable aim
			DisableControlAction(0, 47,  true) -- disable weapon
			DisableControlAction(0, 58,  true) -- disable weapon
			DisableControlAction(0, 263, true) -- disable melee
			DisableControlAction(0, 264, true) -- disable melee
			DisableControlAction(0, 257, true) -- disable melee
			DisableControlAction(0, 140, true) -- disable melee
			DisableControlAction(0, 141, true) -- disable melee
			DisableControlAction(0, 143, true) -- disable melee
			DisableControlAction(0, 75,  true) -- disable exit vehicle
			DisableControlAction(27, 75, true) -- disable exit vehicle
			DisableControlAction(0, 243, true) -- disable tilde
			SetNuiFocus(true,true)
		end

		if hasIdentity == false then
			SetEntityVisible(PlayerPedId(), not guiEnabled)
		end

		Citizen.Wait(0)
	end
end)

function verifyName(name)
	-- Don't allow short user names
	local nameLength = string.len(name)
	if nameLength > 25 or nameLength < 2 then
		return 'Your player name is either too short or too long.'
	end

	-- Don't allow special characters (doesn't always work)
	local count = 0
	for i in name:gmatch('[abcdefghijklmnopqrstuvwxyzåäöABCDEFGHIJKLMNOPQRSTUVWXYZÅÄÖ0123456789 -]') do
		count = count + 1
	end
	if count ~= nameLength then
		return 'Your player name contains special characters that are not allowed on this server.'
	end

	-- Does the player carry a first and last name?
	--
	-- Example:
	-- Allowed:     'Bob Joe'
	-- Not allowed: 'Bob'
	-- Not allowed: 'Bob joe'
	local spacesInName    = 0
	local spacesWithUpper = 0
	for word in string.gmatch(name, '%S+') do

		if string.match(word, '%u') then
			spacesWithUpper = spacesWithUpper + 1
		end

		spacesInName = spacesInName + 1
	end

	if spacesInName > 2 then
		return 'Your name contains more than two spaces'
	end

	if spacesWithUpper ~= spacesInName then
		return 'your name must start with a capital letter.'
	end

	return ''
end
