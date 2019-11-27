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
--ESX = nil
local currentZone = nil

Citizen.CreateThread(function()
--	while ESX == nil do
--		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
--		Citizen.Wait(0)
--	end

--	Citizen.Wait(5000)

	for k,v in pairs(Config.Zones) do
		if v.Blip ~= nil then
			local blip = AddBlipForCoord(v.Marker.Pos.x, v.Marker.Pos.y, v.Marker.Pos.z)
			SetBlipSprite  (blip, v.Blip.Sprite)
			SetBlipDisplay (blip, v.Blip.Display)
			SetBlipScale   (blip, v.Blip.Scale)
			SetBlipCategory(blip, v.Blip.Category)
			SetBlipColour  (blip, v.Blip.Color)
			SetBlipAsShortRange(blip, v.Blip.ShortRange)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(v.Blip.Name)
			EndTextCommandSetBlipName(blip)
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
			local marker_coords = vector3(v.Marker.Pos.x,v.Marker.Pos.y,v.Marker.Pos.z)
			local dist = #(coords-marker_coords)

			if dist < 100 then
				can_sleep = false
				if v.Marker.Type ~= nil then
					DrawMarker(v.Marker.Type, v.Marker.Pos.x, v.Marker.Pos.y, v.Marker.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Marker.Size.x, v.Marker.Size.y, v.Marker.Size.z, v.Marker.Color.r, v.Marker.Color.g, v.Marker.Color.b, v.Marker.Color.a, false, true, 2, false, false, false, false)
				end

				if dist < v.Marker.Size.x then
					foundMarker = true
					if currentZone == nil then
						currentZone = v
						if currentZone ~= nil then
							currentZone.name = k
							TriggerEvent(currentZone.Events.Enter, currentZone)
							break
						end
					end
				end
			end
		end

		if not foundMarker then
			if currentZone ~= nil then
				TriggerEvent(currentZone.Events.Exit, currentZone)
				currentZone = nil
			end
		end
	end
end)

