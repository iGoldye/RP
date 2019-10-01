
ESX = nil
car_db = {}

TriggerEvent('esx:getSharedObject', function(obj) 
	ESX = obj 
end)

function loadCars()
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE `stored` = false and fourrieremecano = false', {
	}, function(results)
	                
		for i=1,#results do

			local res = results[i]

			if res.position ~= nil then
				local pos = json.decode(res.position)
				local props = json.decode(res.vehicle)
				local plate = res.plate

				if plate ~= nil and car_db[plate] == nil and pos ~= nil and props ~= nil then
					car_db[plate] = {}
					car_db[plate].spawned = false
					car_db[plate].props = props
					car_db[plate].coords = vector3(pos.x,pos.y,pos.z)
					car_db[plate].heading = pos.r*1.0
				end
			end
		end
	end)
end

function spawnCars(playerId, xPlayer)
	if xPlayer == nil then
		print('esx_carsync: loaded nil xPlayer!')
		return
	end

	local haveNotSpawned = false
	
	for plate,car in pairs(car_db) do

		if car.coords ~= nil then
			if car.spawned ~= true then
				haveNotSpawned = true
--				local mindist = getPlayersDistance(car.coords)
--				print(mindist)
--				if mindist > 50.0 then
--				print("Spawning!")
				TriggerClientEvent('esx_carsync:spawnCar', xPlayer.source, car.props, car.coords, car.heading)
--				end
			end
		end
	end

	return haveNotSpawned

end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
	while spawnCars(playerId, xPlayer) == true do
-- spawn again
--		print('Unable to spawn. Retry.')
		Citizen.Wait(1000)
	end
end)

RegisterServerEvent('esx_carsync:carSpawned')
AddEventHandler('esx_carsync:carSpawned', function(plate)
	if car_db[plate] == nil then
		car_db[plate] = {}
	end

	car_db[plate].spawned = true
end)

RegisterServerEvent('esx_carsync:updateCarPos')
AddEventHandler('esx_carsync:updateCarPos', function(plate, coords, heading)

	if car_db[plate] == nil then
		car_db[plate] = {}
		car_db[plate].pos_changed = false
		car_db[plate].health_changed = false
	end

	car_db[plate].coords = coords
	car_db[plate].heading = heading
	car_db[plate].pos_changed = true
end)

RegisterServerEvent('esx_carsync:updateCarHealth')
AddEventHandler('esx_carsync:updateCarHealth', function(plate, health, props)

	if car_db[plate] == nil then
		car_db[plate] = {}
		car_db[plate].pos_changed = false
		car_db[plate].health_changed = false
	end

	car_db[plate].health = health
	car_db[plate].props = props
	car_db[plate].health_changed = true
end)

AddEventHandler('esx:playerDropped', function(source)
	syncdb()
	Citizen.Wait(100)
	local xPlayers = ESX.GetPlayers()
	if #xPlayers == 0 then
		print('Server empty! Despawn all cars.')
		for plate,car in pairs(car_db) do
			car_db[plate].spawned = false
		end
		
	end

end)

function syncdb()
		for plate,car in pairs(car_db) do
			if car.pos_changed == true then
--				print("Pos changed: "..plate)
				car.pos_changed = false
				local pos = { ["x"] = math.floor(car.coords.x*100)/100.0, ["y"] = math.floor(car.coords.y*100)/100.0, ["z"] = math.floor(car.coords.z*100)/100.0, ["r"] = math.floor(car.heading*100)/100.0}

				MySQL.Sync.execute('UPDATE IGNORE owned_vehicles SET position = @position WHERE plate = @plate', {
					['@plate'] = plate,
					['@position'] = json.encode(pos),
				})
			end

			if car.health_changed == true then
--				print("Health changed: "..plate)
				car.health_changed = false
				local foundProps = nil

				local result = MySQL.Sync.fetchAll('SELECT vehicle FROM owned_vehicles WHERE plate = @plate', {
					['@plate'] = plate,
				})

				if result[1] then
					foundProps = result[1].vehicle
				end

				if foundProps ~= nil and car.props ~= nil then
					foundProps = json.decode(foundProps)

					if car.props.health ~= nil then
						foundProps.health = math.floor(car.props.health)
					end

					if car.props.engineHealth ~= nil then
						foundProps.engineHealth = math.floor(car.props.engineHealth)
					end

					if car.props.bodyHealth ~= nil then
						foundProps.bodyHealth = math.floor(car.props.bodyHealth)
					end

					MySQL.Sync.execute('UPDATE IGNORE owned_vehicles SET `vehicle` = @vehicle WHERE plate = @plate', {
						['@plate'] = plate,
						['@vehicle'] = json.encode(foundProps),
					})
				end
			end
		end
end


Citizen.CreateThread(function()
	while true do
		syncdb()
		Citizen.Wait(60000)
	end
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		loadCars()
		Citizen.CreateThread(function()
			local xPlayers = ESX.GetPlayers()

			for i=1, #xPlayers, 1 do
				Citizen.Wait(10000)
				local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
				if xPlayer ~= nil then
					if not spawnCars(xPlayer.source, xPlayer) then
						break
					end
				end
			end
		end)
	end
end)
