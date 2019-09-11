ESX = nil
local FuelInfo = {}

if Config.UseESX then
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

	RegisterServerEvent('fuel:pay')
	AddEventHandler('fuel:pay', function(price)
		local xPlayer = ESX.GetPlayerFromId(source)
		local amount = ESX.Math.Round(price)

		if price > 0 then
			xPlayer.removeMoney(amount)
		end
	end)

ESX.RegisterServerCallback('legacyfuel:getFuel', function(source, cb, plate)
--	local xPlayer = ESX.GetPlayerFromId(source)
	if FuelInfo[plate] == nil then
		FuelInfo[plate] = math.random(200, 800) / 10
	end

--	print("getFuel "..tostring(FuelInfo[plate]))
	cb(FuelInfo[plate])
end)

RegisterServerEvent('legacyfuel:setFuel')
AddEventHandler('legacyfuel:setFuel', function(plate, amount)
--	print("setFuel "..tostring(amount))
	FuelInfo[plate] = amount
end)


end
