local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local isDead = false
local inAnim = false
local submenuOpened = false
local Favorites = {}
ESX = nil

local menuIsShowed = false

RegisterNetEvent('esx_animations:closeMenu')
AddEventHandler('esx_animations:closeMenu', function()
	SetNuiFocus(false)
	menuIsShowed = false
	SendNUIMessage({ hideAll = true })
end)

RegisterNUICallback('escape', function(data, cb)
	TriggerEvent('esx_animations:closeMenu')
	cb('ok')
end)

RegisterNUICallback('start-anim', function(data, cb)
	StartAnimById(data.value)
	SetNuiFocus(false)
	menuIsShowed = false
	SendNUIMessage({ hideAll = true })
	cb('ok')
end)

RegisterNUICallback('add-favorite', function(data, cb)
	local fav = FindFavorite(data.value)
	if fav > 0 then
		Favorites[fav] = nil
		ESX.TriggerServerCallback('esx_animations:setFavorites', function()
		end, Favorites)
	else
		AddFavoriteAnim(data.value)
	end

	SetNuiFocus(false)
	menuIsShowed = false
	SendNUIMessage({ hideAll = true })
	cb('ok')
end)

function disableActions()
	BlockWeaponWheelThisFrame()
	DisableControlAction(0, 1, true) -- LookLeftRight
	DisableControlAction(0, 2, true) -- LookUpDown
	DisableControlAction(0, 24, true) -- Attack
	DisableControlAction(0, 25, true) -- Aim
	DisableControlAction(0, 142, true) -- MeleeAttackAlternate
	DisableControlAction(0, 257, true) -- Attack 2
	DisableControlAction(0, 263, true) -- Melee Attack 1
	DisableControlAction(0, 322, true) -- ESC
	DisablePlayerFiring(PlayerPedId(), true) -- Disable weapon firing
end

Citizen.CreateThread(function()
	local hasShown = false
	while true do
		if menuIsShowed then
			disableActions()
			hasShown = true
			Citizen.Wait(0)
		elseif hasShown then
			while IsDisabledControlPressed(0,25) do
				disableActions()
				Citizen.Wait(0)
			end
			hasShown = false
		else
			Citizen.Wait(500)
		end
	end
end)

function showMenu(options)
	SendNUIMessage({
		showMenu = true,
		options = options,
	})
end

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
	ESX.TriggerServerCallback('esx_animations:getFavorites', function(favs)
		Favorites = favs
	end)
end)

function startAttitude(lib, anim)
	ESX.SetPlayerData('gait', anim)
	ESX.SetPlayerData('healthy_gait', anim)

	ESX.Streaming.RequestAnimSet(lib, function()
		SetPedMovementClipset(PlayerPedId(), anim, true)
	end)
end

function startAnim(lib, anim, flag)
	flag = flag or 0
	ESX.Streaming.RequestAnimDict(lib, function()
		TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, flag, 0, false, false, false)
	end)
end

RegisterNetEvent('esx_animations:startAnimById')
AddEventHandler('esx_animations:startAnimById', function(id)
	StartAnimById(id)
end)

RegisterNetEvent('esx_animations:startAnim')
AddEventHandler('esx_animations:startAnim', function(lib, anim, flag)
	startAnim(lib, anim, flag)
end)

RegisterNetEvent('esx_animations:startAttitude')
AddEventHandler('esx_animations:startAttitude', function(anim)
	startAttitude(anim, anim)
end)

function startFacial(anim)
	SetFacialIdleAnimOverride(PlayerPedId(), anim, 0)
end

function startScenario(anim)
	TaskStartScenarioInPlace(PlayerPedId(), anim, 0, false)
end

RegisterNetEvent('esx_animations:startScenario')
AddEventHandler('esx_animations:startScenario', function(anim)
	startScenario(anim)
end)

function OpenAnimationsMenu()

	local cells = {}
	for k,v in pairs(Config.Animations) do
		local subcells = {}
		local j = 0
		for ki,item in pairs(v.items) do
			j = j + 1
			local fav = FindFavorite(ki)
			if fav < 0 then
				fav = undefined
			end

			table.insert(subcells, {
				text = item.label,
				--icon = "img/icons/menus/"..tostring(menuName).."/"..tostring(k)..".png",
				favorite = fav,
				hotkey = item.hotkey,

				cmd = "anim",
				value = ki,
			})
		end


		table.insert(cells, {
			text = v.label,
			icon = "img/icons/menus/"..tostring(k)..".png",
			hotkey = v.hotkey, --k:sub(1,1):upper(),

			cmd = "animmenu",
			value = k,
			cells = subcells,
		})
	end

	options = {
		cells = cells
	}

	menuIsShowed = true
	showMenu(options)
	SetNuiFocus(true, true)

--[[
	local elements = {}

	for k,v in pairs(Config.Animations) do
		table.insert(elements, {label = v.label, value = k})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'animations',
	{
		title    = 'Анимации',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		OpenAnimationsSubMenu(data.current.value)
	end, function(data, menu)
		menu.close()
	end)
]]--
end

function StartAnimData(tp, data)
		local type = tp
		local lib  = data.lib
		local anim = data.anim
		local flag = data.flag
		if flag == nil then
			flag = 0
		end

		if data.in_vehicle == true and not IsPedSittingInAnyVehicle(PlayerPedId()) then
			return
		end

		if data.repeat_anim == true then
			flag = flag + 1
		end
		if data.stop_last_frame == true then
			flag = flag + 2
		end

		if data.upper == true then
			flag = flag + 16
		end

		if data.control == true then
			flag = flag + 32
		end

		if type == 'scenario' then
			startScenario(anim)
		elseif type == 'attitude' then
			startAttitude(lib, anim)
		elseif type == 'anim' then
			startAnim(lib, anim, flag)
		elseif type == 'facial' then
			startFacial(anim)
		elseif type == 'event' then
			TriggerEvent(anim, data)
		elseif type == 'dpemotes' then
			TriggerEvent("dpemotes:emote", anim)
		end
end

function FindFavorite(value)
	for i=1,9 do
		if Favorites[i] == value then
			return i
		end
	end

	return -1
end

function OpenAnimationsSubMenu(menu)
	local title    = nil
	local elements = {}

	if Config.Animations[menu] == nil then
		return
	end

	local m = Config.Animations[menu]
	title = m.label

	for k,v in pairs(m.items) do
		local label = v.label
		v.data.label = v.label

		local fav = FindFavorite(k)
		if fav > 0 then
			label = label .. ' [' .. tostring(fav) .. ']'
		end

		table.insert(elements, {
			label = label,
			type  = v.type,
			value = v.data
		})
	end


	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'animations_sub',
	{
		title    = title,
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.value.flag == nil then
			data.current.value.flag = 0
		end

		if IsControlPressed(0, Keys['LEFTSHIFT']) then
			local fav = FindFavorite(data.current.value.value)
			if fav > 0 then
				Favorites[fav] = nil
				ESX.TriggerServerCallback('esx_animations:setFavorites', function()
				end, Favorites)
			else
				AddFavoriteAnim(data.current.value.value)
			end
			menu.close()
			return
		end

		StartAnimData(data.current.type, data.current.value)

	end, function(data, menu)
		menu.close()
	end)
end

function StartAnimById(id)
	for k,v in pairs(Config.Animations) do
		if v.items[id] ~= nil then
			StartAnimData(v.items[id].type, v.items[id].data)
			return true
		end
	end

	return false
end

function RunFavoriteAnim(num)
	if Favorites[num] == nil then
		ESX.ShowNotification("Избранная анимация не назначена!")
		return
	end

	if not StartAnimById(Favorites[num]) then
		-- favorite not found
		Favorites[num] = nil
		ESX.TriggerServerCallback('esx_animations:setFavorites', function()
		end, Favorites)
		ESX.ShowNotification("Избранная анимация не назначена!")
	end
end

function AddFavoriteAnim(value)
	local favNum = -1
	for i=1,9 do
		if Favorites[i] == nil then
			favNum = i
			break
		end
	end

	if favNum == -1 then
		ESX.ShowNotification("Слишком много избранных анимаций!")
		return
	end

	Favorites[favNum] = value
	ESX.TriggerServerCallback('esx_animations:setFavorites', function()
	end, Favorites)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		submenuOpened = ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'animations_sub')
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if submenuOpened then
			ESX.ShowHelpNotification("~INPUT_SPRINT~ + ~INPUT_CELLPHONE_SELECT~ добавить в избранное")
		end

		if IsControlPressed(0, Keys['LEFTALT']) then
			BlockWeaponWheelThisFrame()
			if IsControlJustReleased(0, Keys['1']) then
				RunFavoriteAnim(1)
			elseif IsControlJustReleased(0, Keys['2']) then
				RunFavoriteAnim(2)
			elseif IsControlJustReleased(0, Keys['3']) then
				RunFavoriteAnim(3)
			elseif IsControlJustReleased(0, Keys['4']) then
				RunFavoriteAnim(4)
			elseif IsControlJustReleased(0, Keys['5']) then
				RunFavoriteAnim(5)
			elseif IsControlJustReleased(0, Keys['6']) then
				RunFavoriteAnim(6)
			elseif IsControlJustReleased(0, Keys['7']) then
				RunFavoriteAnim(7)
			elseif IsControlJustReleased(0, Keys['8']) then
				RunFavoriteAnim(8)
			elseif IsControlJustReleased(0, Keys['9']) then
				RunFavoriteAnim(9)
			end
		end

		if IsControlJustReleased(0, Keys['K']) and IsInputDisabled(0) and not isDead then
			OpenAnimationsMenu()
		end

		if IsControlJustReleased(0, Keys['X']) and IsInputDisabled(0) and not isDead then
			ClearPedTasks(PlayerPedId())
		end

	end
end)

AddEventHandler('esx_animations:startAnimData', function(tp, data)
	StartAnimData(tp, data)
end)


AddEventHandler('esx_animations:openAnimationsMenu', function()
	OpenAnimationsMenu()
end)
