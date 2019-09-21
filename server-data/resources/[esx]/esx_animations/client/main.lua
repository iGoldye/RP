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
local Favorites = {}
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
	ESX.TriggerServerCallback('esx_animations:getFavorites', function(favs)
		Favorites = favs
	end)
end)

function startAttitude(lib, anim)
	ESX.SetPlayerData('gait', anim)

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

function startFacial(anim)
	SetFacialIdleAnimOverride(PlayerPedId(), anim, 0)
end

function startScenario(anim)
	TaskStartScenarioInPlace(PlayerPedId(), anim, 0, false)
end

function OpenAnimationsMenu()
	local elements = {}

	for i=1, #Config.Animations, 1 do
		table.insert(elements, {label = Config.Animations[i].label, value = Config.Animations[i].name})
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
		end
end

function FindFavorite(label)
	for i=1,#Favorites do
		if Favorites[i] == label then
			return i
		end
	end

	return -1
end

function OpenAnimationsSubMenu(menu)
	local title    = nil
	local elements = {}

	for i=1, #Config.Animations, 1 do
		if Config.Animations[i].name == menu then
			title = Config.Animations[i].label

			for j=1, #Config.Animations[i].items, 1 do
				local label = Config.Animations[i].items[j].label
				Config.Animations[i].items[j].data.label = Config.Animations[i].items[j].label
				local fav = FindFavorite(Config.Animations[i].items[j].label)
				if fav > 0 then
					label = label .. ' [' .. tostring(fav) .. ']'
				end

				table.insert(elements, {
					label = label,
					type  = Config.Animations[i].items[j].type,
					value = Config.Animations[i].items[j].data
				})
			end

			break

		end
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
			local fav = FindFavorite(data.current.value.label)
			if fav > 0 then
				table.remove(Favorites, fav)
				ESX.TriggerServerCallback('esx_animations:setFavorites', function()
				end, Favorites)
			else
				AddFavoriteAnim(data.current)
			end
			menu.close()
			return
		end

		StartAnimData(data.current.type, data.current.value)

	end, function(data, menu)
		menu.close()
	end)
end

function RunFavoriteAnim(num)
	if #Favorites < num or Favorites[num] == nil then
		ESX.ShowNotification("Избранная анимация не назначена!")
		return
	end

	for i=1, #Config.Animations, 1 do
		title = Config.Animations[i].label
		for j=1, #Config.Animations[i].items, 1 do
			local label = Config.Animations[i].items[j].label
			if label == Favorites[num] then
				local item = Config.Animations[i].items[j]
				StartAnimData(item.type, item.data)
				return
			end
		end
	end
end

function AddFavoriteAnim(current)
	if #Favorites < 9 then
		table.insert(Favorites, current.value.label)
		ESX.TriggerServerCallback('esx_animations:setFavorites', function()
		end, Favorites)
	else
		ESX.ShowNotification("Слишком много избранных анимаций!")
	end
end

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'animations_sub') then
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

--[[
		if IsControlJustReleased(0, Keys['F3']) and IsInputDisabled(0) and not isDead then
			OpenAnimationsMenu()
		end
]]--

		if IsControlJustReleased(0, Keys['X']) and IsInputDisabled(0) and not isDead then
			ClearPedTasks(PlayerPedId())
		end

	end
end)


AddEventHandler('esx_animations:openAnimationsMenu', function()
	OpenAnimationsMenu()
end)
