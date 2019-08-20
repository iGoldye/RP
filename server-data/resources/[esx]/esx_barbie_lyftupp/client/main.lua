-- Barbie was here --
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

local PlayerData              = {}
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local Blips                   = {}

local isCarry 				  = false

ESX                     = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)


function LiftUp(target)
		local xPlayer = ESX.GetPlayerData()

		ESX.ShowNotification('Вы поднимаете этого человека...')
		TriggerServerEvent('esx_barbie_lyftupp:lyfteruppn', target)
		local dict = "anim@heists@box_carry@"

		RequestAnimDict(dict)
		while not HasAnimDictLoaded(dict) do
			Citizen.Wait(1)
		end

		TriggerServerEvent('esx_barbie_lyftupp:lyfter', target)

		TaskPlayAnim(GetPlayerPed(-1), dict, "idle", 8.0, 8.0, -1, 50, 0, false, false, false)
		isCarry = true
end

function LiftUpRequest()
		local target, distance = ESX.Game.GetClosestPlayer()
--		target = PlayerId(-1)
--		distance = 1

		if distance ~= -1 and distance <= 3.0 then
			local xPlayer = ESX.GetPlayerData()
			local targetid = GetPlayerServerId(target)

			TriggerServerEvent('esx_barbie_lyftupp:startRequest', targetid, "разрешение поднять вас на руки", 'esx_barbie_lyftupp:liftupp_afterRequest')
		else
			ESX.ShowNotification("Рядом никого нет...")
		end

end

--[[
function OpenActionMenuInteraction(target)

	local elements = {}

	table.insert(elements, {label = ('Lyft upp'), value = 'drag'})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'action_menu',
		{
			title    = ('Поднять'),
			align    = 'top-left',
			elements = elements
		},
    function(data, menu)


		ESX.UI.Menu.CloseAll()

		if data.current.value == 'drag' then
			LiftUpRequest()
			menu.close()
		end

  end)

end
]]--

function LoadAnimationDictionary(animationD)
	while(not HasAnimDictLoaded(animationD)) do
		RequestAnimDict(animationD)
		Citizen.Wait(1)
	end
end

RegisterNetEvent('esx_barbie_lyftupp:upplyft')
AddEventHandler('esx_barbie_lyftupp:upplyft', function(target)
--	print('esx_barbie_lyftupp:upplyft '..tostring(target))
	local playerPed = GetPlayerPed(-1)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
	local dict = "anim@amb@clubhouse@boss@female@"
	local anim = "base"

	if isCarry == false then
		LoadAnimationDictionary(dict)
		TaskPlayAnim(playerPed, dict, anim, 8.0, -8, -1, 33, 0, 0, 40, 0)

		AttachEntityToEntity(playerPed, targetPed, 9816, -0.315, 0.18, 0.08, 0.9, 0.30, -80.0, false, false, false, false, 2, false)

		isCarry = true
		Citizen.Wait(0)

		while IsEntityPlayingAnim(GetPlayerPed(-1), dict, anim, 3) do
			Citizen.Wait(0)
		end
	end

	DetachEntity(playerPed, true, false)
	ClearPedTasksImmediately(targetPed)
	ClearPedTasksImmediately(playerPed)

	isCarry = false
end)

--[[
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if IsControlJustReleased(0, Keys['G']) and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'action_menu') then
			OpenActionMenuInteraction()
    end
  end
end)
]]--

--[[
RegisterNetEvent('esx_barbie_lyftupp')
AddEventHandler('esx_barbie_lyftupp', function()
  OpenActionMenuInteraction()
end)
]]--

RegisterNetEvent('esx_barbie_lyftupp:liftupp_afterRequest')
AddEventHandler('esx_barbie_lyftupp:liftupp_afterRequest', function(player)
--	print("esx_barbie_lyftupp:liftupp_afterRequest "..tostring(player))
	LiftUp(player)
end)

AddEventHandler('esx_barbie_lyftupp:liftUp', function()
	LiftUpRequest()
end)
