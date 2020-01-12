local holdingup = false
local hackholdingup = false
local bombholdingup = false
local bank = ""
local savedbank = {}
local secondsRemaining = 0
local dooropen = true
local blipRobbery = nil
globalcoords = nil
globalrotation = nil
globalDoortype = nil
globalbombcoords = nil
globalbombrotation = nil
globalbombDoortype = nil

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if outline then
        SetTextOutline()
    end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

RegisterNetEvent('esx_holdupbank:currentlyrobbing')
AddEventHandler('esx_holdupbank:currentlyrobbing', function(robb)
	holdingup = true
	bank = robb
	secondsRemaining = Config.TimeToBlowtorch
end)

RegisterNetEvent('esx_holdupbank:currentlyhacking')
AddEventHandler('esx_holdupbank:currentlyhacking', function(robb, thisbank)
	hackholdingup = true
	TriggerEvent("mhacking:show")
	TriggerEvent("mhacking:start",7,Config.TimeToHack, opendoors)
	savedbank = thisbank
	bank = robb
	secondsRemaining = Config.TimeToHack
end)

RegisterNetEvent('esx_holdupbank:plantingbomb')
AddEventHandler('esx_holdupbank:plantingbomb', function(robb, thisbank)
	bombholdingup = true

	savedbank = thisbank
	bank = robb
	secondsRemaining = Config.TimeToPlantBomb
	plantBombAnimation()
end)



function opendoors(success, timeremaining)
	if success then
		print('Success with '..timeremaining..'s remaining.')
		TriggerEvent('mhacking:hide')
		TriggerEvent('esx_holdupbank:hackcomplete')
	else
		hackholdingup = false
		TriggerServerEvent('esx_holdupbank:hackfail', bank)
		ESX.ShowNotification(_U('hack_failed'))
		print('Failure')
		TriggerEvent('mhacking:hide')
		secondsRemaining = 0
		incircle = false
	end
end

RegisterNetEvent('esx_holdupbank:killblip')
AddEventHandler('esx_holdupbank:killblip', function()
    RemoveBlip(blipRobbery)
end)

RegisterNetEvent('esx_holdupbank:setblip')
AddEventHandler('esx_holdupbank:setblip', function(position)
    blipRobbery = AddBlipForCoord(position.x, position.y, position.z)
    SetBlipSprite(blipRobbery , 161)
    SetBlipScale(blipRobbery , 2.0)
    SetBlipColour(blipRobbery, 3)
    PulseBlip(blipRobbery)
end)

RegisterNetEvent('esx_holdupbank:toofarlocal')
AddEventHandler('esx_holdupbank:toofarlocal', function(robb)
	holdingup = false
	bombholdingup = false
	ESX.ShowNotification(_U('robbery_cancelled'))
	robbingName = ""
	secondsRemaining = 0
	incircle = false
end)

RegisterNetEvent('esx_holdupbank:toofarlocalhack')
AddEventHandler('esx_holdupbank:toofarlocalhack', function(robb)
	holdingup = false
	ESX.ShowNotification(_U('robbery_cancelled'))
	robbingName = ""
	secondsRemaining = 0
	incircle = false
end)

RegisterNetEvent('esx_holdupbank:closedoor')
AddEventHandler('esx_holdupbank:closedoor', function()
	dooropen = false
end)

RegisterNetEvent('esx_holdupbank:robberycomplete')
AddEventHandler('esx_holdupbank:robberycomplete', function(robb)
	holdingup = false
	ESX.ShowNotification(_U('robbery_complete', ESX.Math.GroupDigits(Banks[bank].reward)))
	TriggerServerEvent('esx_holdupbank:closedoor', Banks[bank].doorid)
	bank = ""
	TriggerEvent('esx_blowtorch:finishclear')
	TriggerEvent('esx_blowtorch:stopblowtorching')
	secondsRemaining = 0
	dooropen = false
	incircle = false
end)

RegisterNetEvent('esx_holdupbank:hackcomplete')
AddEventHandler('esx_holdupbank:hackcomplete', function()
	hackholdingup = false
	ESX.ShowNotification(_U('hack_complete'))

	TriggerServerEvent('esx_holdupbank:opendoor', Banks[bank].hackposition.x, Banks[bank].hackposition.y, Banks[bank].hackposition.z, Banks[bank].doortype, Banks[bank].doorid)

	bank = ""

	secondsRemaining = 0
	incircle = false
end)
RegisterNetEvent('esx_holdupbank:plantbombcomplete')
AddEventHandler('esx_holdupbank:plantbombcomplete', function(bank)
	bombholdingup = false

	secondsRemaining = 0
	ESX.ShowNotification(_U('bombplanted_run'))
	TriggerServerEvent('esx_holdupbank:plantbombtoall', bank.bombposition.x,  bank.bombposition.y, bank.bombposition.z, bank.bombdoortype)

	incircle = false
end)

RegisterNetEvent('esx_holdupbank:plantedbomb')
AddEventHandler('esx_holdupbank:plantedbomb', function(x,y,z,doortype)
	local coords = {x,y,z}
	local obs, distance = ESX.Game.GetClosestObject(doortype, coords)

    --AddExplosion( bank.bombposition.x,  bank.bombposition.y, bank.bombposition.z , 0, 0.5, 1, 0, 1065353216, 0)
	AddExplosion( x,  y, z , 0, 0.5, 1, 0, 1065353216, 0)
	AddExplosion( x,  y, z , 0, 0.5, 1, 0, 1065353216, 0)
   -- AddExplosion( bank.bombposition.x,  bank.bombposition.y, bank.bombposition.z , 0, 0.5, 1, 0, 1065353216, 0)

	local rotation = GetEntityHeading(obs) + 47.2869
	SetEntityHeading(obs,rotation)
	globalbombcoords = coords
	globalbombrotation = rotation
	globalbombDoortype = doortype
	Citizen.CreateThread(function()
		while dooropen do
			Wait(2000)
			local obs, distance = ESX.Game.GetClosestObject(globalbombDoortype, globalbombcoords)
			SetEntityHeading(obs, globalbombrotation)
			Citizen.Wait(0);
		end
	end)
end)


RegisterNetEvent('esx_holdupbank:opendoors')
AddEventHandler('esx_holdupbank:opendoors', function(x,y,z,doortype)
	dooropen = true

	local coords = {x,y,z}
	local obs, distance = ESX.Game.GetClosestObject(doortype, coords)
	local pos = GetEntityCoords(obs)
	local rotation = GetEntityHeading(obs) + 50

	globalcoords = coords
	globalrotation = rotation
	globalDoortype = doortype

	Citizen.CreateThread(function()
	while dooropen do
		Wait(2000)
		local obs, distance = ESX.Game.GetClosestObject(globalDoortype, globalcoords)
		SetEntityHeading(obs, globalrotation)
	end
	end)
end)


RegisterNetEvent('esx_holdupbank:exit')
AddEventHandler('esx_holdupbank:exit', function(bank)
	SetEntityCoordsNoOffset(GetPlayerPed(-1), bank.hackposition.x , bank.hackposition.y, bank.hackposition.z, 0, 0, 1)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if secondsRemaining > 0 then
			secondsRemaining = secondsRemaining - 1
		end
	end
end)

--[[
Citizen.CreateThread(function()
	for k,v in pairs(Banks)do
		local ve = v.position

		local blip = AddBlipForCoord(ve.x, ve.y, ve.z)
		SetBlipSprite(blip, 255)--156
		SetBlipScale(blip, 0.8)
		SetBlipColour(blip, 75)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(_U('bank_robbery'))
		EndTextCommandSetBlipName(blip)
	end
end)
]]--

incircle = false

Citizen.CreateThread(function()
	while true do
		local pos = GetEntityCoords(GetPlayerPed(-1), true)

		for k,v in pairs(Banks)do
			local pos2 = v.position
			local dist = Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z)

			if dist < 15.0 then
				if not holdingup then
					DrawMarker(1, v.position.x, v.position.y, v.position.z - 1, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.5, 1555, 0, 0,255, 0, 0, 0,0)

					if dist < 1.0 then
						if (incircle == false) then
							DisplayHelpText(_U('press_to_rob'))
						end
						incircle = true
						if IsControlJustReleased(1, 51) then
							TriggerServerEvent('esx_holdupbank:rob', k)
						end
					else
						incircle = false
					end
				end
			end
		end

		if holdingup then

			if secondsRemaining > 0 then
				drawTxt(0.66, 1.44, 1.0,1.0,0.4, _U('robbery_of') .. secondsRemaining .. _U('seconds_remaining'), 255, 255, 255, 255)
			end

			DisplayHelpText(_U('press_to_cancel'))

			local pos2 = Banks[bank].position


			if IsControlJustReleased(1, 51) then
				TriggerServerEvent('esx_holdupbank:toofar', bank)
				TriggerEvent('esx_blowtorch:stopblowtorching')
			end

			if Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 7.5 then
				TriggerServerEvent('esx_holdupbank:toofar', bank)
			end
		end

		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		local pos = GetEntityCoords(GetPlayerPed(-1), true)

		for k,v in pairs(Banks)do
			local pos2 = v.hackposition
			local dist = Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z)

			if dist < 15.0 then
				if not hackholdingup then
					DrawMarker(1, v.hackposition.x, v.hackposition.y, v.hackposition.z - 1, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.5, 1555, 0, 0,255, 0, 0, 0,0)

					if dist < 1.0 then
						if (incircle == false) then
							DisplayHelpText(_U('press_to_hack'))
						end
						incircle = true
						if IsControlJustReleased(1, 51) then
							TriggerServerEvent('esx_holdupbank:hack', k)
						end
					else
						incircle = false
					end
				end
			end
		end

		if hackholdingup then

			if secondsRemaining > 0 then
				drawTxt(0.66, 1.44, 1.0,1.0,0.4, _U('hack_of') .. secondsRemaining .. _U('seconds_remaining'), 255, 255, 255, 255)
			end

			local pos2 = Banks[bank].hackposition

			if Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 7.5 then
				TriggerServerEvent('esx_holdupbank:toofarhack', bank)
			end
		end

		Citizen.Wait(0)
	end
end)


Citizen.CreateThread(function()
	while true do
		local pos = GetEntityCoords(GetPlayerPed(-1), true)

		for k,v in pairs(Banks)do
			local pos2 = v.bombposition
			if pos2 ~= nil then
				local dist = Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z)
				if dist < 15.0 then
					if not bombholdingup then
						DrawMarker(1, v.bombposition.x, v.bombposition.y, v.bombposition.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 1555, 0, 0,255, 0, 0, 0,0)

						if dist < 1.0 then
							if (incircle == false) then
								DisplayHelpText(_U('press_to_bomb'))
							end
							incircle = true
							if IsControlJustReleased(1, 51) then
								TriggerServerEvent('esx_holdupbank:plantbomb', k)
							end
						else
							incircle = false
						end
					end
				end
			end
		end

		if bombholdingup then

			if secondsRemaining > 0 then
				drawTxt(0.66, 1.44, 1.0,1.0,0.4, _U('bomb_of') .. secondsRemaining .. _U('seconds_remaining'), 255, 255, 255, 255)
			end
			DisplayHelpText(_U('press_to_cancel'))

			local pos2 = Banks[bank].bombposition

			if IsControlJustReleased(1, 51) then
				TriggerServerEvent('esx_holdupbank:toofar', bank)
			end

			if Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 7.5 then
				TriggerServerEvent('esx_holdupbank:toofar', bank)
			end
		end

		Citizen.Wait(0)
	end
end)
function plantBombAnimation()
	Citizen.CreateThread(function()
		while secondsRemaining > 2 do
			Citizen.Wait(1000)
			TaskStartScenarioInPlace(PlayerPedId(), "CODE_HUMAN_MEDIC_KNEEL", 0, true)
		end
		ClearPedTasksImmediately(PlayerPedId())
	end)
end
