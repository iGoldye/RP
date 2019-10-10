local pedindex = {}

ESX                             = nil
skills = nil
---------------------------------
------------- CONFIG ------------
---------------------------------

local openKey = 167 -- replace 142 with what button you want

---------------------------------
---------------------------------

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

function round(num, numDecimalPlaces)
	local mult = 10^(2)
	return math.floor(num * mult + 0.5) / mult
end

RegisterNetEvent('stadus_skills:sendPlayerSkills')
AddEventHandler('stadus_skills:sendPlayerSkills', function(newSkills)
	skills = newSkills
	ESX.SetPlayerData('skills', skills)

	if skills ~= nil then
		StatSetInt("MP0_STRENGTH", round(skills.strength), true)
		StatSetInt("MP0_STAMINA", round(skills.stamina), true)
		StatSetInt('MP0_LUNG_CAPACITY', round(skills.stamina), true)
		StatSetInt('MP0_SHOOTING_ABILITY', round(skills.shooting), true)
		StatSetInt('MP0_WHEELIE_ABILITY', round(skills.driving), true)
		StatSetInt('MP0_DRIVING_ABILITY', round(skills.driving), true)
	end
end)

--===============================================
--==                 VARIABLES                 ==
--===============================================
function EnableGui(enable)
	if skills == nil then
		ESX.TriggerServerCallback('stadus_skills:getSkills', function(newSkills)
			skills = newSkills
			if skills ~= nil then
				EnableGui(enable)
			end
		end)
		return
	end

	SetNuiFocus(enable)
	guiEnabled = enable

	SendNUIMessage({
		type = "enableui",
		enable = enable,
		stamina = skills.stamina,
		strength = skills.strength,
		driving = skills.driving,
		shooting = skills.shooting,
		fishing = skills.fishing,
		drugs = skills.drugs
	})
end

--===============================================
--==              Close GUI                    ==
--===============================================
RegisterNUICallback('escape', function(data, cb)
    EnableGui(false)
end)

Faketimer = 0

Citizen.CreateThread(function()

	while true do

        if guiEnabled then

          if IsDisabledControlJustReleased(0, openKey) then

            SendNUIMessage({
              type = "click"
            })

            end
	else
--		if IsDisabledControlJustReleased(17, 11) then
		if IsDisabledControlJustReleased(0, openKey) then
			EnableGui(true)
		end
        end
        if IsPedInAnyVehicle(PlayerPedId(), true) then
          local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
          if Faketimer >= 10 then
            local speedVal = math.floor(GetEntitySpeed(PlayerPedId()) / 8.0)
            if speedVal > 1 and GetPedInVehicleSeat(vehicle, -1) == PlayerPedId() then
	            TriggerServerEvent('stadus_skills:addDriving', GetPlayerServerId(PlayerId()), speedVal* 0.03)
            end
            Faketimer = 0
          end
        end
        if Faketimer >= 180 then
          Faketimer = 0
        end
        Citizen.Wait(0)
    end

end)

Citizen.CreateThread(function() -- Thread for  timer
	while true do
		Citizen.Wait(1000)
    Faketimer = Faketimer + 1
	end
end)
