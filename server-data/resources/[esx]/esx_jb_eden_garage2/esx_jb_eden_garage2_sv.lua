ESX                = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


--get vehicle list
ESX.RegisterServerCallback('eden_garage:getVehicles', function(source, cb, KindOfVehicle)
	local xPlayer = ESX.GetPlayerFromId(source)
	local vehicules = {}
	local identifier = xPlayer.identifier

	if KindOfVehicle ~= "personal" then
		identifier = KindOfVehicle
	end

	MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner = @identifier AND type = 'car' AND job IS NULL", {
		['@identifier'] = identifier
	}, function(result)
		cb(result)
	end)
end)

--Recupere les véhicules
ESX.RegisterServerCallback('eden_garage:getVehiclesMecano', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if not xPlayer.job or xPlayer.job.name ~= 'police' then
		cb(nil)
		return
	end

	MySQL.Async.fetchAll("SELECT * FROM owned_vehicles INNER JOIN characters ON owned_vehicles.owner = characters.identifier WHERE fourrieremecano = TRUE", {}, function(result)
		cb(result)
	end)
end)
-- Fin --Recupere les véhicules

--Stock les véhicules
ESX.RegisterServerCallback('eden_garage:stockv',function(source,cb, vehicleProps, KindOfVehicle)
	local xPlayer = ESX.GetPlayerFromId(source)
	local identifier = xPlayer.identifier
	local _source = source
	if KindOfVehicle ~= "personal" then
		identifier = KindOfVehicle
	end
	local vehplate = vehicleProps.plate
	local vehiclemodel = vehicleProps.model
	MySQL.Async.fetchAll("SELECT * FROM owned_vehicles where plate=@plate and owner=@identifier",{['@plate'] = vehplate, ['@identifier'] = identifier}, function(result)
		if result[1] ~= nil then
			local vehprop = json.encode(vehicleProps)
			local originalvehprops = json.decode(result[1].vehicle)
			if originalvehprops.model == vehiclemodel then
				MySQL.Async.execute("UPDATE owned_vehicles SET vehicle =@vehprop WHERE plate=@plate",{
					['@vehprop'] = vehprop,
					['@plate'] = vehplate
				}, function(rowsChanged)
					cb(true)
				end)
			else
				DropPlayer(_source, "Kicked from server. Possibly tried to cheat.")
				print("[esx_eden_garage] player "..identifier..' tried to spawn a vehicle with hash:'..vehiclemodel..". his original vehicle: "..originalvehprops.model)
				cb(false)
			end
		else
			cb(false)
		end
	end)
end)
--Fin stock les vehicules

ESX.RegisterServerCallback('eden_garage:stockvmecano',function(source,cb, vehicleProps)
	local _source = source
	local plate = ESX.Math.Trim(vehicleProps.plate)
	local vehiclemodel = vehicleProps.model
	local xPlayer = ESX.GetPlayerFromId(_source)

	if not xPlayer.job or xPlayer.job.name ~= 'police' then
		cb(false)
		return
	end

	MySQL.Async.fetchAll("SELECT * FROM owned_vehicles where plate=@plate",{['@plate'] = plate}, function(result)
		if result[1] ~= nil then
			local vehprop = json.encode(vehicleProps)
			local originalvehprops = json.decode(result[1].vehicle)
			if originalvehprops.model == vehiclemodel then
				MySQL.Async.execute("UPDATE owned_vehicles SET vehicle =@vehprop WHERE plate=@plate",{
					['@vehprop'] = vehprop,
					['@plate'] = plate
				}, function(rowsChanged)
					cb(true)
				end)
			else
				DropPlayer(_source, "Tu es kick du serveur, voilà ce qu'il se passe quand on essaye de cheater.")
				print("[esx_eden_garage] player "..xPlayer.identifier..' tried to spawn a vehicle with hash:'..vehiclemodel..". his original vehicle: "..originalvehprops.model)
				cb(false)
			end
		else
			cb(false)
		end
	end)
end)

--Change vehicle stored state
RegisterServerEvent('eden_garage:modifystored')
AddEventHandler('eden_garage:modifystored', function(plate, stored)
	local plate = plate
	MySQL.Async.execute("UPDATE owned_vehicles SET `stored` =@stored WHERE plate=@plate",{
		['@stored'] = stored,
		['@plate'] = plate
	})
end)

RegisterServerEvent('eden_garage:ChangeStoredFromFourriereMecano')
AddEventHandler('eden_garage:ChangeStoredFromFourriereMecano', function(vehicleProps, vehicleStored)
	local xPlayer = ESX.GetPlayerFromId(source)
	local vehicleplate = ESX.Math.Trim(vehicleProps.plate)

	if not xPlayer.job or xPlayer.job.name ~= 'police' then
		return
	end

	MySQL.Async.execute("UPDATE owned_vehicles SET fourrieremecano =@fourrieremecano WHERE plate=@plate",{
		['@fourrieremecano'] = vehicleStored,
		['@plate'] = vehicleplate
	})
end)


RegisterServerEvent('eden_garage:renamevehicle')
AddEventHandler('eden_garage:renamevehicle', function(vehicleplate, name)
	local vehicleplate = vehicleplate
	MySQL.Async.execute("UPDATE owned_vehicles SET vehiclename =@vehiclename WHERE plate=@plate",{['@vehiclename'] = name , ['@plate'] = vehicleplate})
end)

ESX.RegisterServerCallback('eden_garage:getOutVehicles',function(source, cb, KindOfVehicle)
	local xPlayer = ESX.GetPlayerFromId(source)
	local identifier

	if KindOfVehicle ~= "personal" then
		identifier = KindOfVehicle
	else
		identifier = xPlayer.identifier
	end

	MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner = @identifier AND (`stored` = FALSE OR fourrieremecano = TRUE)",{
		['@identifier'] = identifier
	}, function(result)
		cb(result)
	end)
end)

--Foonction qui check l'argent
ESX.RegisterServerCallback('eden_garage:checkMoney', function(source, cb)
	TriggerEvent('esx_atm:pay', source, "jb_eden_garage2", Config.Price, cb)
end)
--Fin Foonction qui check l'argent

-- Fonction qui change les etats sorti en rentré lors d'un restart

if Config.StoreOnServerStart then
	MySQL.ready(function()
		MySQL.Async.execute("UPDATE owned_vehicles SET `stored`=true WHERE `stored`=false", {})
	end)
end

-- Fin Fonction qui change les etats sorti en rentré lors d'un restart
