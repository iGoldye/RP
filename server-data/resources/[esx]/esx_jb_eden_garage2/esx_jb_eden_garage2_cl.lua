local carInstance = {}

ESX = nil
local inMarker = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj)
		ESX = obj
		end)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

function OpenMenuGarage(garage, KindOfVehicle)
	ESX.UI.Menu.CloseAll()

	local elements = {
		{label = "Вернуть транспорт("..Config.Price.."$)", value = 'return_vehicle'},
	}


	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'garage_menu',
		{
			title    = 'Гараж',
			align    = 'top-left',
			elements = elements,
		},
		function(data, menu)

			menu.close()
			if(data.current.value == 'return_vehicle') then
				ReturnVehicleMenu(garage, KindOfVehicle)
			end
		end,
		function(data, menu)
			menu.close()
		end
	)
end
-- Afficher les listes des vehicules
function ListVehiclesMenu(garage, KindOfVehicle)
	local elements, vehiclePropsList = {}, {}

	ESX.TriggerServerCallback('eden_garage:getVehicles', function(vehicles)
		if not table.empty(vehicles) then
			for k,v in ipairs(vehicles) do
				local vehicleProps = json.decode(v.vehicle)
				vehiclePropsList[vehicleProps.plate] = vehicleProps
				local vehicleHash = vehicleProps.model
				local vehicleName, vehicleLabel

				if v.vehiclename == 'voiture' or v.vehiclename == 'car' then
					vehicleName = GetDisplayNameFromVehicleModel(vehicleHash)
				else
					vehicleName = v.vehiclename
				end

				if v.fourrieremecano then
					vehicleLabel = vehicleName..': Машина снаружи'
				elseif v.stored then
					vehicleLabel = vehicleName..': В гараже'
				else
					vehicleLabel = vehicleName..': Вне гаража'
				end

				table.insert(elements, {
					label = vehicleLabel,
					vehicleName = vehicleName,
					stored = v.stored,
					plate = vehicleProps.plate,
					fourrieremecano = v.fourrieremecano,
				})
			end
		else
			table.insert(elements, {label = "В гараже нет машин"})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_vehicle', {
			title    = 'Гараж',
			align    = 'top-left',
			elements = elements,
		}, function(data, menu)
			local vehicleProps = vehiclePropsList[data.current.plate]

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_menu', {
				title    =  data.current.vehicleName,
				align    = 'top-left',
				elements = {
					{label ="Выгнать транспорт" , value = 'get_vehicle_out'},
					{label ="Переименовать транспорт" , value = 'rename_vehicle'}
			}}, function(data2, menu2)
				if data2.current.value == "get_vehicle_out" then
					if data.current.fourrieremecano then
						TriggerEvent('esx:showNotification', 'Ваш транспорт конфискован')
					elseif data.current.stored then
						menu.close()
						menu2.close()
						SpawnVehicle(vehicleProps, garage, KindOfVehicle)
					else
						TriggerEvent('esx:showNotification', 'Этот транспорт где-то в другом месте')
					end
				elseif data2.current.value == "rename_vehicle" then
					ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'rename_vehicle', {
						title = 'Введите название'
					}, function(data3, menu3)
						TriggerServerEvent('eden_garage:renamevehicle', data.current.plate, data3.value)
						menu3.close()
					end, function(data3, menu3)
						menu3.close()
					end)
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end, KindOfVehicle)
end
-- Fin Afficher les listes des vehicules

-- Afficher les listes des vehicules de fourriere
function ListVehiclesFourriereMenu(garage)
	local elements, vehiclePropsList = {}, {}

	ESX.TriggerServerCallback('eden_garage:getVehiclesMecano', function(vehicles)
		if vehicles == nil then
			return
		end

		for k,v in ipairs(vehicles) do
			local vehicleProps = json.decode(v.vehicle)
			vehiclePropsList[vehicleProps.plate] = vehicleProps
			local vehicleHash = vehicleProps.model
			local vehicleName = GetDisplayNameFromVehicleModel(vehicleHash)

			table.insert(elements, {
				label = ('%s | %s %s'):format(vehicleName, v.firstname, v.lastname),
				plate = vehicleProps.plate
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_vehicle_mecano', {
			title    = 'Штрафстоянка',
			align    = 'top-left',
			elements = elements,
		}, function(data, menu)
			local vehicleProps = vehiclePropsList[data.current.plate]
			menu.close()
			TriggerServerEvent('eden_garage:ChangeStoredFromFourriereMecano', vehicleProps, false)
			SpawnVehicleMecano(vehicleProps, garage)
		end, function(data, menu)
			menu.close()
		end)

	end)
end
-- Fin Afficher les listes des vehicules de fourriere

-- Fonction qui permet de rentrer un vehicule
function StockVehicleMenu(KindOfVehicle)
	local playerPed  = PlayerPedId()
	if IsPedInAnyVehicle(playerPed,  false) then
		local vehicle =GetVehiclePedIsIn(playerPed,false)
		if GetPedInVehicleSeat(vehicle, -1) == playerPed then
			local GotTrailer, TrailerHandle = GetVehicleTrailerVehicle(vehicle)
			if GotTrailer then
				local trailerProps  = ESX.Game.GetVehicleProperties(TrailerHandle)
				ESX.TriggerServerCallback('eden_garage:stockv',function(valid)
					if(valid) then
						for k,v in pairs (carInstance) do
							if ESX.Math.Trim(v.plate) == ESX.Math.Trim(trailerProps.plate) then
								table.remove(carInstance, k)
							end
						end
						DeleteEntity(TrailerHandle)
						TriggerServerEvent('eden_garage:modifystored', trailerProps.plate, true)
						TriggerEvent('esx:showNotification', 'Автомобиль припаркован')
					else
						TriggerEvent('esx:showNotification', 'Вы не можете оставить этот автомобиль')
					end
				end,trailerProps, KindOfVehicle)
			else
				local vehicleProps  = ESX.Game.GetVehicleProperties(vehicle)
				ESX.TriggerServerCallback('eden_garage:stockv',function(valid)
					if(valid) then
						for k,v in pairs (carInstance) do
							if ESX.Math.Trim(v.plate) == ESX.Math.Trim(vehicleProps.plate) then
								table.remove(carInstance, k)
							end
						end
						DeleteEntity(vehicle)
						TriggerServerEvent('eden_garage:modifystored', vehicleProps.plate, true)
						TriggerEvent('esx:showNotification', 'Ваш транспорт припаркован')
					else
						TriggerEvent('esx:showNotification', 'Вы не можете оставить этот транспорт здесь')
					end
				end,vehicleProps, KindOfVehicle)
			end
		else
			TriggerEvent('esx:showNotification', 'Вы должны быть за рулем!')
		end
	else
		TriggerEvent('esx:showNotification', 'Вы должны быть в автомобиле!')
	end
end
-- Fin fonction qui permet de rentrer un vehicule

-- Fonction qui permet de rentrer un vehicule dans fourriere
function StockVehicleFourriereMenu()
	local playerPed  = PlayerPedId()
	if IsPedInAnyVehicle(playerPed,  false) then
		local vehicle =GetVehiclePedIsIn(playerPed,false)
		if GetPedInVehicleSeat(vehicle, -1) == playerPed then
			local GotTrailer, TrailerHandle = GetVehicleTrailerVehicle(vehicle)
			if GotTrailer then
				local trailerProps  = ESX.Game.GetVehicleProperties(TrailerHandle)
				ESX.TriggerServerCallback('eden_garage:stockvmecano',function(valid)
					if(valid) then
						DeleteVehicle(TrailerHandle)
						TriggerServerEvent('eden_garage:ChangeStoredFromFourriereMecano', trailerProps, true)
						-- TriggerEvent('esx:showNotification', 'La remorque est rentré dans la fourrière')
					else
						-- TriggerEvent('esx:showNotification', 'Vous ne pouvez pas stocker cette remorque dans la fourrière')
					end
				end,trailerProps)
			else
				local vehicleProps  = ESX.Game.GetVehicleProperties(vehicle)
				ESX.TriggerServerCallback('eden_garage:stockvmecano',function(valid)
					if(valid) then
						DeleteVehicle(vehicle)
						TriggerServerEvent('eden_garage:ChangeStoredFromFourriereMecano', vehicleProps, true)
						-- TriggerEvent('esx:showNotification', 'Le véhicule est rentré dans la fourrière')
					else
						-- TriggerEvent('esx:showNotification', 'Vous ne pouvez pas stocker ce véhicule dans la fourrière')
					end
				end,vehicleProps)
			end
		else
			-- TriggerEvent('esx:showNotification', 'Vous etes pas conducteur du vehicule')
		end
	else
		-- TriggerEvent('esx:showNotification', 'Il n\' y a pas de vehicule à rentrer')
	end
end
-- Fin fonction qui permet de rentrer un vehicule dans fourriere
--Fin fonction Menu

function SpawnVehicle(vehicle, garage, KindOfVehicle)
	ESX.Game.SpawnVehicle(vehicle.model, {
		x = garage.SpawnPoint.Pos.x,
		y = garage.SpawnPoint.Pos.y,
		z = garage.SpawnPoint.Pos.z + 1
		},garage.SpawnPoint.Heading, function(callback_vehicle)
			ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
			TaskWarpPedIntoVehicle(PlayerPedId(), callback_vehicle, -1)
			local carplate = GetVehicleNumberPlateText(callback_vehicle)
			table.insert(carInstance, {vehicleentity = callback_vehicle, plate = carplate})
			if KindOfVehicle == 'brewer' or KindOfVehicle == 'joaillerie' or KindOfVehicle == 'fermier' or KindOfVehicle == 'fisherman' or KindOfVehicle == 'fuel' or KindOfVehicle == 'johnson' or KindOfVehicle == 'miner' or KindOfVehicle == 'reporter' or KindOfVehicle == 'vignerons' or KindOfVehicle == 'tabac' then
				TriggerEvent('esx_jobs1:addplate', carplate)
				TriggerEvent('esx_jobs2:addplate', carplate)
			end
		end)
	TriggerServerEvent('eden_garage:modifystored', vehicle.plate, false)
end
--Fin fonction pour spawn vehicule

--Fonction pour spawn vehicule fourriere mecano
function SpawnVehicleMecano(vehicle, garage)
	ESX.Game.SpawnVehicle(vehicle.model, {
		x = garage.SpawnPoint.Pos.x,
		y = garage.SpawnPoint.Pos.y,
		z = garage.SpawnPoint.Pos.z + 1
		},garage.SpawnPoint.Heading, function(callback_vehicle)
			ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
			TaskWarpPedIntoVehicle(PlayerPedId(), callback_vehicle, -1)
		end)
	TriggerServerEvent('eden_garage:ChangeStoredFromFourriereMecano', vehicle, false)
end
--Fin fonction pour spawn vehicule fourriere mecano

function ReturnVehicleMenu(garage, KindOfVehicle)

	ESX.TriggerServerCallback('eden_garage:getOutVehicles', function(vehicles)
		local elements, vehiclePropsList = {}, {}

		if not table.empty(vehicles) then
			for k,v in ipairs(vehicles) do
				local vehicleProps = json.decode(v.vehicle)
				vehiclePropsList[vehicleProps.plate] = vehicleProps
				local vehicleHash = vehicleProps.model
				local vehicleName, vehicleLabel

				if v.vehiclename == 'voiture' or v.vehiclename == 'car' then
					vehicleName = GetDisplayNameFromVehicleModel(vehicleHash)
				else
					vehicleName = v.vehiclename
				end

				if v.fourrieremecano then
					vehicleLabel = vehicleName..': Штрафстоянка'
					table.insert(elements, {label = vehicleLabel, action = 'fourrieremecano'})
				else
					vehicleLabel = vehicleName..': Вернуть'
					table.insert(elements, {
						label = vehicleLabel,
						plate = vehicleProps.plate,
						action = 'store'
					})
				end
			end
		else
			table.insert(elements, {label = "Нет транспорта", action = 'nothing'})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'return_vehicle', {
			title    = 'Гараж',
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			local vehicleProps = vehiclePropsList[data.current.plate]

			if data.current.action == 'fourrieremecano' then
				ESX.ShowNotification("Проконсультируйтесь с полицией")
			elseif data.current.action == 'store' then
				local doesVehicleExist = false

				for k,v in pairs(carInstance) do
					if ESX.Math.Trim(v.plate) == ESX.Math.Trim(data.current.plate) then
						if DoesEntityExist(v.vehicleentity) then
							doesVehicleExist = true
						else
							table.remove(carInstance, k)
							doesVehicleExist = false
						end
					end
				end

				for _,v in pairs(ESX.Game.GetVehicles()) do
					if DoesEntityExist(veh) then
						if ESX.Math.Trim(v.plate) == ESX.Math.Trim(data.current.plate) then
							doesVehicleExist = true
							break
						end
					end
				end

				if not doesVehicleExist then
					ESX.TriggerServerCallback('eden_garage:checkMoney', function(hasEnoughMoney)
						if hasEnoughMoney then
							menu.close()
							SpawnVehicle(vehicleProps, garage, KindOfVehicle)
						else
							ESX.ShowNotification('Вам не хватает денег')
						end
					end)
				else
					ESX.ShowNotification("Транспорт уже снаружи!")
				end
			end
		end, function(data, menu)
			menu.close()
		end)
	end, KindOfVehicle)

end

function drawMarkerData(marker, pos)
	DrawMarker(marker.t, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, marker.w, marker.w, marker.h, marker.r, marker.g, marker.b, marker.a or 128, false, true, 2, false, false, false, false)
end

Citizen.CreateThread(function()
	local dist
	local canSleep = false

	for k,v in pairs (Config.Garages) do
		if v.Name ~= nil then
				local blip = AddBlipForCoord(v.Pos.x, v.Pos.y, v.Pos.z)
				SetBlipSprite(blip, Config.Blip.sprite)
				SetBlipColour(blip, Config.Blip.color)
				SetBlipScale(blip, 1.0)
				SetBlipAsShortRange(blip, true)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(v.Name)
				EndTextCommandSetBlipName(blip)
		end
end
--[[
	for k,v in pairs (Config.GaragesMecano) do
		local blip = AddBlipForCoord(v.SpawnPoint.Pos.x, v.SpawnPoint.Pos.y, v.SpawnPoint.Pos.z)
		SetBlipSprite(blip, Config.MecanoBlip.sprite)
		SetBlipColour(blip, Config.MecanoBlip.color)
		SetBlipScale(blip, 1.0)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(v.Name)
		EndTextCommandSetBlipName(blip)
	end
]]--
	while true do
		Citizen.Wait(0)
		local coords = GetEntityCoords(PlayerPedId())

		if canSleep then
			Citizen.Wait(1000)
		end
		canSleep = true

		local prevInMarker = inMarker

		inMarker = false

		for k,v in pairs (Config.Garages) do
			dist = #(coords - vector3(v.Pos.x,v.Pos.y,v.Pos.z))
			if dist < 100 then
				drawMarkerData(v.Marker, v.Pos)
				canSleep = false
			end
			if dist < v.Distance then
				inMarker = true
		                ESX.ShowHelpNotification(v.HelpPrompt)
				if IsControlJustReleased(0, 38) and IsInputDisabled(0) and not IsPedInAnyVehicle(PlayerPedId()) then
					OpenMenuGarage(v, "personal")
				end
			end

			dist = #(coords - vector3(v.SpawnPoint.Pos.x,v.SpawnPoint.Pos.y,v.SpawnPoint.Pos.z))
			if dist < 100 then
				drawMarkerData(v.SpawnPoint.Marker, v.SpawnPoint.Pos)
				canSleep = false
			end
			if dist < v.SpawnPoint.Distance then
				inMarker = true
		                ESX.ShowHelpNotification(v.SpawnPoint.HelpPrompt)
				if IsControlJustReleased(0, 38) and IsInputDisabled(0) and not IsPedInAnyVehicle(PlayerPedId()) then
					ListVehiclesMenu(v, "personal")
				end
			end

			dist = #(coords - vector3(v.DeletePoint.Pos.x,v.DeletePoint.Pos.y,v.DeletePoint.Pos.z))
			if dist < 100 then
				drawMarkerData(v.DeletePoint.Marker, v.DeletePoint.Pos)
				canSleep = false
			end
			if dist < v.DeletePoint.Distance then
				inMarker = true
		                ESX.ShowHelpNotification(v.DeletePoint.HelpPrompt)
				if IsControlJustReleased(0, 38) and IsInputDisabled(0) and IsPedInAnyVehicle(PlayerPedId()) then
					StockVehicleMenu("personal")
				end
			end
		end

		if ESX.PlayerData ~= nil and ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
		    for k,v in pairs (Config.GaragesMecano) do
			dist = #(coords - vector3(v.SpawnPoint.Pos.x,v.SpawnPoint.Pos.y,v.SpawnPoint.Pos.z))
			if dist < 100 then
				drawMarkerData(v.SpawnPoint.Marker, v.SpawnPoint.Pos)
				canSleep = false
			end
			if dist < v.SpawnPoint.Distance then
				inMarker = true
				local inVeh = IsPedInAnyVehicle(PlayerPedId())

				if inVeh then
			                ESX.ShowHelpNotification(v.DeletePoint.HelpPrompt)
					if IsControlJustReleased(0, 38) and IsInputDisabled(0) then
						StockVehicleFourriereMenu()
					end
				else
			                ESX.ShowHelpNotification(v.SpawnPoint.HelpPrompt)
					if IsControlJustReleased(0, 38) and IsInputDisabled(0) then
						ListVehiclesFourriereMenu(v)
					end
				end
			end
--[[
			dist = #(coords - vector3(v.DeletePoint.Pos.x,v.DeletePoint.Pos.y,v.DeletePoint.Pos.z))
			if dist < 100 then
				drawMarkerData(v.DeletePoint.Marker, v.DeletePoint.Pos)
				canSleep = false
			end
			if dist < v.DeletePoint.Distance then
				inMarker = true
		                ESX.ShowHelpNotification(v.DeletePoint.HelpPrompt)
				if IsControlJustReleased(0, 38) and IsInputDisabled(0) and IsPedInAnyVehicle(PlayerPedId()) then
					StockVehicleFourriereMenu()
				end
			end
]]--
		    end
		end

		if prevInMarker and not inMarker then
			ESX.UI.Menu.CloseAll()
		end
	end
end)

function table.empty(parsedTable)
	for _, _ in pairs(parsedTable) do
		return false
	end

	return true
end

--[[
function dump(o, nb)
  if nb == nil then
    nb = 0
  end
   if type(o) == 'table' then
      local s = ''
      for i = 1, nb + 1, 1 do
        s = s .. "    "
      end
      s = '{\n'
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
          for i = 1, nb, 1 do
            s = s .. "    "
          end
         s = s .. '['..k..'] = ' .. dump(v, nb + 1) .. ',\n'
      end
      for i = 1, nb, 1 do
        s = s .. "    "
      end
      return s .. '}'
   else
      return tostring(o)
   end
end
]]--

--- garage societe

RegisterNetEvent('esx_eden_garage:ListVehiclesMenu')
AddEventHandler('esx_eden_garage:ListVehiclesMenu', function(garage, society)
	if not IsPedInAnyVehicle(PlayerPedId()) then
		ListVehiclesMenu(garage, society)
	end
end)

RegisterNetEvent('esx_eden_garage:OpenMenuGarage')
AddEventHandler('esx_eden_garage:OpenMenuGarage', function(garage, society)
	if not IsPedInAnyVehicle(PlayerPedId()) then
		OpenMenuGarage(garage, society)
	end
end)

RegisterNetEvent('esx_eden_garage:StockVehicleMenu')
AddEventHandler('esx_eden_garage:StockVehicleMenu', function(society)
	StockVehicleMenu(society)
end)
