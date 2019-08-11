ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("Darkzy:PayDeManPlz")
AddEventHandler("Darkzy:PayDeManPlz", function(price)

	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addMoney(price)
	TriggerClientEvent("chatMessage", source, tostring("^4Разборка авто^0: вы получили ^2$"..price.."^0 за разборку автомобиля^0"))
end)
