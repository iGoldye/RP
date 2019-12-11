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

-- internal variables
ESX = nil
local _currentMarker = nil
local _currentZone = nil

local _enteredZone = nil
local _enteredMarker = nil

function createBlip(vBlip, vMarker)
	local blip = AddBlipForCoord(vMarker.Pos.x, vMarker.Pos.y, vMarker.Pos.z)
	SetBlipSprite  (blip, vBlip.Sprite)
	SetBlipDisplay (blip, vBlip.Display)
	SetBlipScale   (blip, vBlip.Scale)
	SetBlipCategory(blip, vBlip.Category)
	SetBlipColour  (blip, vBlip.Color)
	SetBlipAsShortRange(blip, vBlip.ShortRange)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(vBlip.Name)
	EndTextCommandSetBlipName(blip)
	return blip
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if _currentMarker ~= nil and _enteredMarker == nil then
			_enteredZone = _currentZone
			_enteredMarker = _currentMarker
			TriggerEvent(_enteredZone.Events.Enter, _enteredZone, _enteredMarker)

		elseif _currentMarker == nil and _enteredMarker ~= nil then
			TriggerEvent(_enteredZone.Events.Exit, _enteredZone, _enteredMarker)
			_enteredZone = nil
			_enteredMarker = nil

		elseif _enteredMarker ~= nil and (_enteredMarker.id ~= _currentMarker.id) then
			TriggerEvent(_enteredZone.Events.Exit, _enteredZone, _enteredMarker)
			_enteredZone = _currentZone
			_enteredMarker = _currentMarker
			TriggerEvent(_enteredZone.Events.Enter, _enteredZone, _enteredMarker)
		end
	end
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	for _,zone in pairs(Config.Zones) do
		if zone.Blip ~= nil then
			for _,marker in pairs(zone.Markers) do
				createBlip(zone.Blip, marker)
			end
		end
	end

end)

-- Display markers
Citizen.CreateThread(function()
	local can_sleep = false
	while true do
		if can_sleep then
			Citizen.Wait(300)
		else
			Citizen.Wait(0)
			can_sleep = true
		end

		local coords = GetEntityCoords(PlayerPedId())
		local foundMarker = false

		for k,v in pairs(Config.Zones) do
		for mid,marker in pairs(v.Markers) do
			local marker_coords = vector3(marker.Pos.x,marker.Pos.y,marker.Pos.z+1)
			local dist = #(coords-marker_coords)

			if dist < 100 then
				can_sleep = false
				if marker.Type ~= nil then
					DrawMarker(marker.Type, marker.Pos.x, marker.Pos.y, marker.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, marker.Size.x, marker.Size.y, marker.Size.z, marker.Color.r, marker.Color.g, marker.Color.b, marker.Color.a, false, true, 2, false, false, false, false)
				end

				if dist < marker.Size.x then
					_currentMarker = marker
					_currentZone = v
					_currentZone.name = k
					_currentMarker.id = mid
					foundMarker = true
				end
			end
		end
		end

		if not foundMarker then
			_currentZone = nil
			_currentMarker = nil
		end
	end
end)

