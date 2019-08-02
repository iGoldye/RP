RegisterServerEvent("Darkzy:PayDeManPlz")
AddEventHandler("Darkzy:PayDeManPlz", function(price)
    local src = source
    if config.esxpayment or config.vrppayment or config.isrppayment then
        if config.esxpayment then 
            print("Вы выбрали оплату ESX!")
        elseif config.vrppayment then
            print("Вы выбрали оплату VRP!")
        elseif config.isrppayment then
            print("Вы выбрали оплату ISRP!")
        end
    else
        print("Варианты оплаты не выбраны, вы продолжите без способа оплаты!")
    end
    -- Add your eco pay player event or function here or whatever :shrug:
	TriggerClientEvent("chatMessage", src, tostring("^4Chop Shop^0: you recieved ^2$"..price.."^0 for Chopping this Vehicle^0"))
end)