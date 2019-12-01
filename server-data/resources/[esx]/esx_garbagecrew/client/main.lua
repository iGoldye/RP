--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- ORIGINAL SCRIPT BY Marcio FOR CFX-ESX
-- Script serveur No Brain
-- www.nobrain.org
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
ESX = nil



--------------------------------------------------------------------------------
-- NE RIEN MODIFIER
--------------------------------------------------------------------------------
local work_state = ""
local completepaytable = nil
local tableupdate = false
local temppaytable =  nil
local totalbagpay = 0
local lastpickup = nil
local platenumb = nil
local iscurrentboss = false
local work_truck = nil
local truckdeposit = false
local trashcollection = false
local trashcollectionpos = nil
local bagsoftrash = nil
local currentbag = nil
local namezone = "Delivery"
local namezonenum = 0
local namezoneregion = 0
local MissionRegion = 0
local viemaxvehicle = 1000
local argentretire = 0
local livraisonTotalPaye = 0
local livraisonnombre = 0
local MissionNum = 0
local isInService = false
local PlayerData              = nil
local GUI                     = {}
GUI.Time                      = 0
local hasAlreadyEnteredMarker = false
local lastZone                = nil
local Blips                   = {}
local MainBlip = nil
local playervehicle = ""
local playervehiclecurrent = ""
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
--------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	PlayerData = ESX.GetPlayerData()
	updateMainBlip()
end)

function setState(newState)
--	print(work_state.." -> "..newState)
	work_state = newState
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	TriggerServerEvent('esx_garbagejob:setconfig')
end)

RegisterNetEvent('esxgarbagejob:configset')
AddEventHandler('esxgarbagejob:configset', function(trucknumber)
	Config.TruckPlateNumb = trucknumber
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	updateMainBlip()
end)

RegisterNetEvent('esx_garbagejob:setbin')
AddEventHandler('esx_garbagejob:setbin', function(binpos, platenumber,  bags)
	if isInService then
		if GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), false)) == platenumber then
			iscurrentboss = false
			platenumb = platenumber
			trashcollectionpos = binpos
			bagsoftrash = bags
			currentbag = bagsoftrash
			trashcollection = true
			CurrentActionMsg = ''
			CollectionAction = 'collection'
			work_truck = GetVehiclePedIsIn(GetPlayerPed(-1), false)
			setState("bin_selected")
		end
	end
end)

RegisterNetEvent('esx_garbagejob:addbags')
AddEventHandler('esx_garbagejob:addbags', function(platenumber, bags, crewmember)
	if isInService then
		if platenumb == platenumber then
			if iscurrentboss then
				totalbagpay = totalbagpay + bags
				addcremember = true
				if temppaytable == nil then
					temppaytable = {}
				 end

				for i, v in pairs(temppaytable) do

					if temppaytable[i] == crewmember then
						addcremember = false
					end
				end
				if addcremember then
					table.insert(temppaytable, crewmember)
				end
			end
		end
	end
end)

RegisterNetEvent('esx_garbagejob:startpayrequest')
AddEventHandler('esx_garbagejob:startpayrequest', function(platenumber, amount)
	if isInService then
		if platenumb == platenumber then
			TriggerServerEvent('esx_garbagejob:pay', amount)
			platenumb = nil
		end
	end
end)

RegisterNetEvent('esx_garbagejob:removedbag')
AddEventHandler('esx_garbagejob:removedbag', function(platenumber)
	if isInService then
		if platenumb == platenumber then
			currentbag = currentbag - 1
		end
	end
end)

RegisterNetEvent('esx_garbagejob:countbagtotal')
AddEventHandler('esx_garbagejob:countbagtotal', function(platenumber)
	if isInService then
		if platenumb == platenumber then
			if not iscurrentboss then
			TriggerServerEvent('esx_garbagejob:bagsdone', platenumb, totalbagpay)
			totalbagpay = 0
			end
		end
	end
end)

RegisterNetEvent('esx_garbagejob:clearjob')
AddEventHandler('esx_garbagejob:clearjob', function(platenumber)
	if platenumb == platenumber then
		trashcollectionpos = nil
		bagsoftrash = nil
		work_truck = nil
		trashcollection = false
		truckdeposit = false
		CurrentAction = nil
		CollectionAction = nil
		setState("")
	end

end)





-- MENUS
function MenuCloakRoom()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'cloakroom',
		{
			title    = _U('cloakroom'),
			elements = {
				{label = _U('job_wear'), value = 'job_wear'},
				{label = _U('citizen_wear'), value = 'citizen_wear'}
			}
		},
		function(data, menu)
			if data.current.value == 'citizen_wear' then
				setState("")
				isInService = false
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
					  local model = nil

					  if skin.sex == 0 then
						model = GetHashKey("mp_m_freemode_01")
					  else
						model = GetHashKey("mp_f_freemode_01")
					  end

					  RequestModel(model)
					  while not HasModelLoaded(model) do
						RequestModel(model)
						Citizen.Wait(1)
					  end

					  SetPlayerModel(PlayerId(), model)
					  SetModelAsNoLongerNeeded(model)

					  TriggerEvent('skinchanger:loadSkin', skin)
					  TriggerEvent('esx:restoreLoadout')
        end)
      end
			if data.current.value == 'job_wear' then
				setState("start")
				isInService = true
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
	    			if skin.sex == 0 then
	    				TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
					else
	    				TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)

					RequestModel(model)
					while not HasModelLoaded(model) do
					RequestModel(model)
					Citizen.Wait(0)
					end

				SetPlayerModel(PlayerId(), model)
				SetModelAsNoLongerNeeded(model)
					end

				end)

			end
			menu.close()
		end,
		function(data, menu)
			menu.close()
		end
	)
end

function MenuVehicleSpawner()
	local elements = {}

	for i=1, #Config.Trucks, 1 do
		table.insert(elements, {label = GetLabelText(GetDisplayNameFromVehicleModel(Config.Trucks[i])), value = Config.Trucks[i]})
	end


	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'vehiclespawner',
		{
			title    = _U('vehiclespawner'),
			elements = elements
		},
		function(data, menu)
			ESX.Game.SpawnVehicle(data.current.value, Config.Zones.VehicleSpawnPoint.Pos, 270.0, function(vehicle)
				local trucknumber = Config.TruckPlateNumb + 1
				if trucknumber <=9 then
					SetVehicleNumberPlateText(vehicle, 'TCREW00'..trucknumber)
					playervehicle =   'TCREW00'..trucknumber
				elseif trucknumber <=99 then
					SetVehicleNumberPlateText(vehicle, 'TCREW0'..trucknumber)
					playervehicle =   'TCREW0'..trucknumber
				else
					SetVehicleNumberPlateText(vehicle, 'TCREW'..trucknumber)
					playervehicle =   'TCREW'..trucknumber
				end


				TriggerServerEvent('esxgarbagejob:movetruckcount')
                MissionDeliverySelect()
				if data.current.value == 'phantom3' then
					ESX.Game.SpawnVehicle("trailers2", Config.Zones.VehicleSpawnPoint.Pos, 270.0, function(trailer)
					    AttachVehicleToTrailer(vehicle, trailer, 1.1)
					end)
				end
				TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
			end)

			menu.close()
		end,
		function(data, menu)
			menu.close()
		end
	)
end

function IsATruck()
	local isATruck = false
	local playerPed = GetPlayerPed(-1)
	for i=1, #Config.Trucks, 1 do
		if IsVehicleModel(GetVehiclePedIsUsing(playerPed), Config.Trucks[i]) then
			isATruck = true
			break
		end
	end
	return isATruck
end

function IsJobgarbage()
	if PlayerData ~= nil then
		local isJobgarbage = false
		if PlayerData.job.name ~= nil and PlayerData.job.name == 'garbage' then
			isJobgarbage = true
		end
		return isJobgarbage
	end
end

AddEventHandler('esx_garbagejob:hasEnteredMarker', function(zone)

	local playerPed = GetPlayerPed(-1)

	if zone == 'CloakRoom' then
		MenuCloakRoom()
	end

	if zone == 'VehicleSpawner' then
		if isInService and IsJobgarbage() then
			if work_state == "return_truck" or work_state == "delivery" then
				CurrentAction = 'hint'
                CurrentActionMsg  = _U('already_have_truck')
			else
				MenuVehicleSpawner()
			end
		end
	end

	if zone == namezone then
		if isInService and work_state == "delivery" and MissionNum == namezonenum and MissionRegion == namezoneregion and IsJobgarbage() then
			if IsPedSittingInAnyVehicle(playerPed) and IsATruck() then
				CheckPlayerVehicleCurrent()

				if playervehicle == playervehiclecurrent then
					if Blips['delivery'] ~= nil then
						RemoveBlip(Blips['delivery'])
						Blips['delivery'] = nil
					end

					CurrentAction     = 'delivery'
                    CurrentActionMsg  = _U('delivery')
				else
					CurrentAction = 'hint'
                    CurrentActionMsg  = _U('not_your_truck')
				end
			else
				CurrentAction = 'hint'
                CurrentActionMsg  = _U('not_your_truck2')
			end
		end
	end

	if zone == 'CancelMission' then

		if isInService and IsJobgarbage() then
			if IsPedSittingInAnyVehicle(playerPed) and IsATruck() then
				CheckPlayerVehicleCurrent()
				if playervehicle == playervehiclecurrent then
                    CurrentAction     = 'returntruckcancelmission'
                    CurrentActionMsg  = _U('cancel_mission')
				else
					CurrentAction = 'hint'
                    CurrentActionMsg  = _U('not_your_truck')
				end
			else
                CurrentAction     = 'returntrucklostcancelmission'
			end
		end
	end

	if zone == 'ReturnTruck' then
		if isInService and work_state == "return_truck" and IsJobgarbage() then
			if IsPedSittingInAnyVehicle(playerPed) and IsATruck() then
				CheckPlayerVehicleCurrent()

				if playervehicle == playervehiclecurrent then
                    CurrentAction     = 'returntruck'
                    CurrentActionMsg  = _U('cancel_mission')
				else
                    CurrentAction     = 'returntruckcancelmission'
                    CurrentActionMsg  = _U('not_your_truck')
				end
			else
                CurrentAction     = 'returntrucklost'
			end
		end
	end

end)

AddEventHandler('esx_garbagejob:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
    CurrentAction = nil
	CurrentActionMsg = ''
end)

function nouvelledestination()
	livraisonnombre = livraisonnombre+1
	local count = 0
	local multibagpay = 0
		for i, v in pairs(temppaytable) do
		count = count + 1
	end

	if Config.MulitplyBags then
	multibagpay = totalbagpay * (count + 1)
	else
	multibagpay = totalbagpay
	end
	local temppayamount =  (destination.Paye + multibagpay) / (count + 1)
	TriggerServerEvent('esx_garbagejob:requestpay', platenumb,  temppayamount)
	TriggerServerEvent('esx_garbagejob:endcollection', platenumb)
	livraisonTotalPaye = 0
	totalbagpay = 0
	temppayamount = 0
	temppaytable = nil
	multibagpay = 0
	iscurrentboss = false
	setState("truck")
	if livraisonnombre >= Config.MaxDelivery then
		MissionDeliveryStopReturnDepot()
	else

		livraisonsuite = math.random(0, 100)

		if livraisonsuite <= 10 then
			MissionDeliveryStopReturnDepot()
		elseif livraisonsuite <= 99 then
			MissionDeliverySelect()
		elseif livraisonsuite <= 100 then
			if MissionRegion == 1 then
				MissionRegion = 2
			elseif MissionRegion == 2 then
				MissionRegion = 1
			end
			MissionDeliverySelect()
		end
	end
end

function returntruck_yes()
	if Blips['delivery'] ~= nil then
		RemoveBlip(Blips['delivery'])
		Blips['delivery'] = nil
	end

	if Blips['cancelmission'] ~= nil then
		RemoveBlip(Blips['cancelmission'])
		Blips['cancelmission'] = nil
	end

	setState("start")
	livraisonnombre = 0
	MissionRegion = 0

	donnerlapaye()
end

function returntruck_no()

	if livraisonnombre >= Config.MaxDelivery then
		ESX.ShowNotification(_U('need_it'))
	else
		ESX.ShowNotification(_U('ok_work'))
		nouvelledestination()
	end
end

function returntrucklost_yes()
	if Blips['delivery'] ~= nil then
		RemoveBlip(Blips['delivery'])
		Blips['delivery'] = nil
	end

	if Blips['cancelmission'] ~= nil then
		RemoveBlip(Blips['cancelmission'])
		Blips['cancelmission'] = nil
	end
	livraisonnombre = 0
	MissionRegion = 0
	iscurrentboss = false
	setState("start")
	donnerlapayesanstruck()
end

function returntrucklost_no()
	ESX.ShowNotification(_U('scared_me'))
end

function returntruckcancelmission_yes()
	if Blips['delivery'] ~= nil then
		RemoveBlip(Blips['delivery'])
		Blips['delivery'] = nil
	end

	if Blips['cancelmission'] ~= nil then
		RemoveBlip(Blips['cancelmission'])
		Blips['cancelmission'] = nil
	end

	livraisonnombre = 0
	MissionRegion = 0
	iscurrentboss = false
	setState("start")
	donnerlapaye()
end

function returntruckcancelmission_no()
	ESX.ShowNotification(_U('resume_delivery'))
end

function returntrucklostcancelmission_yes()
	if Blips['delivery'] ~= nil then
		RemoveBlip(Blips['delivery'])
		Blips['delivery'] = nil
	end

	if Blips['cancelmission'] ~= nil then
		RemoveBlip(Blips['cancelmission'])
		Blips['cancelmission'] = nil
	end

	livraisonnombre = 0
	MissionRegion = 0
	iscurrentboss = false
	setState("start")
	donnerlapayesanstruck()
end

function returntrucklostcancelmission_no()
	ESX.ShowNotification(_U('resume_delivery'))
end

function round(num, numDecimalPlaces)
    local mult = 5^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

function donnerlapaye()
	ped = GetPlayerPed(-1)
	vehicle = GetVehiclePedIsIn(ped, false)
	vievehicle = GetVehicleEngineHealth(vehicle)
	calculargentretire = round(viemaxvehicle-vievehicle)

	if calculargentretire <= 0 then
		argentretire = 0
	else
		argentretire = calculargentretire
	end

    ESX.Game.DeleteVehicle(vehicle)

	local amount = livraisonTotalPaye-argentretire

	if vievehicle >= 1 then
		if livraisonTotalPaye == 0 then
			livraisonTotalPaye = 0
		else
			if argentretire <= 0 then

				livraisonTotalPaye = 0
			else

				livraisonTotalPaye = 0
			end
		end
	else
		if livraisonTotalPaye ~= 0 and amount <= 0 then

			livraisonTotalPaye = 0
		else
			if argentretire <= 0 then

				livraisonTotalPaye = 0
			else


				livraisonTotalPaye = 0
			end
		end
	end
end

function donnerlapayesanstruck()
	ped = GetPlayerPed(-1)
	argentretire = Config.TruckPrice

	-- donne paye
	local amount = livraisonTotalPaye-argentretire

	if livraisonTotalPaye == 0 then

		livraisonTotalPaye = 0
	else
		if amount >= 1 then

			livraisonTotalPaye = 0
		else

			livraisonTotalPaye = 0
		end
	end
end

function SelectBinandCrew()
	work_truck = GetVehiclePedIsIn(GetPlayerPed(-1), true)
	bagsoftrash = math.random(3, 8)
	local NewBin, NewBinDistance = ESX.Game.GetClosestObject(Config.DumpstersAvailable)
	trashcollectionpos = GetEntityCoords(NewBin)
	platenumb = GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), true))
	TriggerServerEvent("esx_garbagejob:binselect", trashcollectionpos, platenumb, bagsoftrash)
end


-- Key Controls
Citizen.CreateThread(function()
    while true do

		Citizen.Wait(0)
		plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
		if CurrentAction ~= nil or CollectionAction ~= nil then

        	SetTextComponentFormat('STRING')
        	AddTextComponentString(CurrentActionMsg)
       		DisplayHelpTextFromStringLabel(0, 0, 1, -1)

			if IsControlJustReleased(0, 38) then

				if CollectionAction == 'collection' then
					if not HasAnimDictLoaded("anim@heists@narcotics@trash") then
					RequestAnimDict("anim@heists@narcotics@trash")
					end
					while not HasAnimDictLoaded("anim@heists@narcotics@trash") do
					Citizen.Wait(0)
					end
					plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
					dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, trashcollectionpos.x, trashcollectionpos.y, trashcollectionpos.z)
					if dist <= 3.5 then
						if currentbag > 0 then
							TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
							TriggerServerEvent('esx_garbagejob:bagremoval', platenumb)
							trashcollection = false
							Citizen.Wait(4000)
							ClearPedTasks(PlayerPedId())
							local randombag = math.random(0,2)
							if randombag == 0 then
								garbagebag = CreateObject(GetHashKey("prop_cs_street_binbag_01"), 0, 0, 0, true, true, true) -- creates object
								AttachEntityToEntity(garbagebag, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 57005), 0.4, 0, 0, 0, 270.0, 60.0, true, true, false, true, 1, true) -- object is attached to right hand
							elseif randombag == 1 then
								garbagebag = CreateObject(GetHashKey("bkr_prop_fakeid_binbag_01"), 0, 0, 0, true, true, true) -- creates object
								AttachEntityToEntity(garbagebag, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 57005), .65, 0, -.1, 0, 270.0, 60.0, true, true, false, true, 1, true) -- object is attached to right hand
							elseif randombag == 2 then
								garbagebag = CreateObject(GetHashKey("hei_prop_heist_binbag"), 0, 0, 0, true, true, true) -- creates object
								AttachEntityToEntity(garbagebag, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 57005), 0.12, 0.0, 0.00, 25.0, 270.0, 180.0, true, true, false, true, 1, true) -- object is attached to right hand
							end
							TaskPlayAnim(PlayerPedId(-1), 'anim@heists@narcotics@trash', 'walk', 1.0, -1.0,-1,49,0,0, 0,0)
							truckdeposit = true
							CollectionAction = 'deposit'
						else
							if iscurrentboss then
								TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_BUM_WASH", 0, true)
								if temppaytable == nil then
									temppaytable = {}
								end
								TriggerServerEvent('esx_garbagejob:reportbags', platenumb)
								Citizen.Wait(4000)
								ClearPedTasks(PlayerPedId())
        	        	        setring = false
            	        	    bagsoftrash = math.random(2,10)
								currentbag = bagsoftrash
								CurrentAction = nil
								trashcollection = false
								truckdeposit = false
								ESX.ShowNotification("Сбор окончен, возвращайтесь в транспорт!")
								while not IsPedInVehicle(GetPlayerPed(-1), work_truck, false) do
									Citizen.Wait(0)
								end
								TriggerServerEvent('esx_garbagejob:endcollection', platenumb)
								SetVehicleDoorShut(work_truck,5,false)
								Citizen.Wait(2000)
								nouvelledestination()
							end
						end
					end

				elseif CollectionAction == 'deposit'  then
					local trunk = GetWorldPositionOfEntityBone(work_truck, GetEntityBoneIndexByName(work_truck, "platelight"))
 					plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
					dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, trunk.x, trunk.y, trunk.z)
					if dist <= 2.0 then
						Citizen.Wait(5)
						ClearPedTasksImmediately(GetPlayerPed(-1))
						TaskPlayAnim(PlayerPedId(-1), 'anim@heists@narcotics@trash', 'throw_b', 1.0, -1.0,-1,2,0,0, 0,0)
 						Citizen.Wait(800)
						local garbagebagdelete = DeleteEntity(garbagebag)
						totalbagpay = totalbagpay+Config.BagPay
						Citizen.Wait(100)
						ClearPedTasksImmediately(GetPlayerPed(-1))
						CollectionAction = 'collection'
						truckdeposit = false
						trashcollection = true
					end
				end

				if CurrentAction == 'delivery' then
					SelectBinandCrew()
					while work_state ~= "bin_selected" do
						Citizen.Wait(100)
					end
					while not iscurrentboss do
					Citizen.Wait(250)
					iscurrentboss = true
					end
					SetVehicleDoorOpen(work_truck,5,false, false)

                end

                if CurrentAction == 'returntruck' then
                    returntruck_yes()
                end

                if CurrentAction == 'returntrucklost' then
                    returntrucklost_yes()
                end

                if CurrentAction == 'returntruckcancelmission' then
                    returntruckcancelmission_yes()
                end

                if CurrentAction == 'returntrucklostcancelmission' then
                    returntrucklostcancelmission_yes()
                end

                CurrentAction = nil
            end

        end

    end
end)

-- DISPLAY MISSION MARKERS AND MARKERS
Citizen.CreateThread(function()
	while true do
		Wait(0)

		if truckdeposit then
			local trunk = GetWorldPositionOfEntityBone(work_truck, GetEntityBoneIndexByName(work_truck, "platelight"))
			plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
			DrawMarker(27, trunk.x , trunk.y, trunk.z, 0, 0, 0, 0, 0, 0, 1.25, 1.25, 1.0001, 0, 128, 0, 200, 0, 0, 0, 0)
			dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, trunk.x , trunk.y, trunk.z)
			if dist <= 2.0 then
			ESX.Game.Utils.DrawText3D(vector3(trunk.x , trunk.y ,trunk.z + 0.50), "[~g~E~s~] Закинуть в кузов.", 1.0)
			end
		end

		if trashcollection then
			DrawMarker(1, trashcollectionpos.x, trashcollectionpos.y, trashcollectionpos.z, 0, 0, 0, 0, 0, 0, 3.001, 3.0001, 1.0001, 255, 0, 0, 200, 0, 0, 0, 0)
			plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
			dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, trashcollectionpos.x, trashcollectionpos.y, trashcollectionpos.z)
			if dist <= 5.0 then
				if currentbag <= 0 then
					if iscurrentboss then
					ESX.Game.Utils.DrawText3D(trashcollectionpos + vector3(0.0, 0.0, 1.0), "[~g~E~s~] Очистите контейнер", 1.0)
					else
					ESX.Game.Utils.DrawText3D(trashcollectionpos + vector3(0.0, 0.0, 1.0), "Сбор окончен.. Садитесь в транспорт..", 1.0)
					end
				else
					ESX.Game.Utils.DrawText3D(trashcollectionpos + vector3(0.0, 0.0, 1.0), "[~g~E~s~] Собрать мешок мусора ["..currentbag.."/"..bagsoftrash.."]", 1.0)
				end
			end
		end
		if isInService then
			DrawMarker(Config.Delivery.CancelMission.Type, Config.Delivery.CancelMission.Pos.x, Config.Delivery.CancelMission.Pos.y, Config.Delivery.CancelMission.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Delivery.CancelMission.Size.x, Config.Delivery.CancelMission.Size.y, Config.Delivery.CancelMission.Size.z, Config.Delivery.CancelMission.Color.r, Config.Delivery.CancelMission.Color.g, Config.Delivery.CancelMission.Color.b, 100, false, true, 2, false, false, false, false)
		end

		if work_state == "delivery" then
			DrawMarker(destination.Type, destination.Pos.x, destination.Pos.y, destination.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, destination.Size.x, destination.Size.y, destination.Size.z, destination.Color.r, destination.Color.g, destination.Color.b, 100, false, true, 2, false, false, false, false)
		elseif work_state == "return_truck" then
			DrawMarker(destination.Type, destination.Pos.x, destination.Pos.y, destination.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, destination.Size.x, destination.Size.y, destination.Size.z, destination.Color.r, destination.Color.g, destination.Color.b, 100, false, true, 2, false, false, false, false)
		end

		local coords = GetEntityCoords(GetPlayerPed(-1))

		for k,v in pairs(Config.Zones) do

			if isInService and (IsJobgarbage() and v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
				DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
			end

		end

		for k,v in pairs(Config.Cloakroom) do

			if(IsJobgarbage() and v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
				DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
			end

		end

	end
end)

-- Activate menu when player is inside marker
Citizen.CreateThread(function()
	while true do

		Wait(0)

			if IsJobgarbage() then

				local coords      = GetEntityCoords(GetPlayerPed(-1))
				local isInMarker  = false
				local currentZone = nil

				for k,v in pairs(Config.Zones) do
					if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
						isInMarker  = true
						currentZone = k
					end
				end

				for k,v in pairs(Config.Cloakroom) do
					if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
						isInMarker  = true
						currentZone = k
					end
				end

				for k,v in pairs(Config.Delivery) do
					if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
						isInMarker  = true
						currentZone = k
					end
				end

				if isInMarker and not hasAlreadyEnteredMarker then
					hasAlreadyEnteredMarker = true
					lastZone                = currentZone
					TriggerEvent('esx_garbagejob:hasEnteredMarker', currentZone)
				end

				if not isInMarker and hasAlreadyEnteredMarker then
					hasAlreadyEnteredMarker = false
					TriggerEvent('esx_garbagejob:hasExitedMarker', lastZone)
				end
			end
	end
end)

-- CREATE BLIPS
function updateMainBlip()

	if MainBlip ~= nil then
		RemoveBlip(MainBlip)
		MainBlip = nil
	end

	if IsJobgarbage() == true then

		MainBlip = AddBlipForCoord(Config.Cloakroom.CloakRoom.Pos.x, Config.Cloakroom.CloakRoom.Pos.y, Config.Cloakroom.CloakRoom.Pos.z)

		SetBlipSprite (MainBlip, 318)
		SetBlipDisplay(MainBlip, 4)
		SetBlipScale  (MainBlip, 1.2)
		SetBlipColour (MainBlip, 5)
		SetBlipAsShortRange(MainBlip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(_U('blip_job'))
		EndTextCommandSetBlipName(MainBlip)
	end
end

-------------------------------------------------
-- Fonctions
-------------------------------------------------
-- Fonction selection nouvelle mission livraison
function MissionDeliverySelect()
	if MissionRegion == 0 then
		MissionRegion = math.random(1,2)
	end

	local regionSuffix = "LS"
	if MissionRegion == 2 then
		regionSuffix = "BC"
	end

	MissionNum = math.random(1, 10)
	while lastpickup == MissionNum do
		Citizen.Wait(50)
		MissionNum = math.random(1, 10)
	end

	namezone = "Delivery"..tostring(MissionNum)..regionSuffix
	destination = Config.Delivery[namezone]
	namezonenum = MissionNum
	namezoneregion = MissionRegion


	lastpickup = MissionNum
	MissionDeliveryLetsGo()
end

-- Fonction active mission livraison
function MissionDeliveryLetsGo()
	if Blips['delivery'] ~= nil then
		RemoveBlip(Blips['delivery'])
		Blips['delivery'] = nil
	end

	if Blips['cancelmission'] ~= nil then
		RemoveBlip(Blips['cancelmission'])
		Blips['cancelmission'] = nil
	end

	Blips['delivery'] = AddBlipForCoord(destination.Pos.x,  destination.Pos.y,  destination.Pos.z)
	SetBlipRoute(Blips['delivery'], true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(_U('blip_delivery'))
	EndTextCommandSetBlipName(Blips['delivery'])

	Blips['cancelmission'] = AddBlipForCoord(Config.Delivery.CancelMission.Pos.x,  Config.Delivery.CancelMission.Pos.y,  Config.Delivery.CancelMission.Pos.z)
	SetBlipColour(Blips['cancelmission'], 6)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(_U('blip_goal'))
	EndTextCommandSetBlipName(Blips['cancelmission'])

	if MissionRegion == 1 then -- Los santos
		ESX.ShowNotification(_U('meet_ls'))
	elseif MissionRegion == 2 then -- Blaine County
		ESX.ShowNotification(_U('meet_bc'))
	elseif MissionRegion == 0 then -- au cas ou
		ESX.ShowNotification(_U('meet_del'))
	end

	work_state = "delivery"
end

--Fonction return au depot
function MissionDeliveryStopReturnDepot()
	destination = Config.Delivery.ReturnTruck

	Blips['delivery'] = AddBlipForCoord(destination.Pos.x,  destination.Pos.y,  destination.Pos.z)
	SetBlipRoute(Blips['delivery'], true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(_U('blip_depot'))
	EndTextCommandSetBlipName(Blips['delivery'])

	if Blips['cancelmission'] ~= nil then
		RemoveBlip(Blips['cancelmission'])
		Blips['cancelmission'] = nil
	end

	ESX.ShowNotification(_U('return_depot'))

	MissionRegion = 0
	work_state = "return_truck"
	MissionNum = 0
end


function CheckPlayerVehicleCurrent()
	playervehiclecurrent = GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), false))
end
