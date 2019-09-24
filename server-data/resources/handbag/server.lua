ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
--[[
RegisterCommand("bag", function(source, args, raw)
    local src = source
    TriggerClientEvent("Bag:ToggleBag", src)
end)
]]--
ESX.RegisterUsableItem('suitcase', function(source)
    local src = source
    TriggerClientEvent("Bag:ToggleBag", src)
end)
