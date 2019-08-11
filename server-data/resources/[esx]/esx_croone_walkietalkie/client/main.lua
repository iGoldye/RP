ESX                 = nil
WalkieOpened        = false
HasLspdWalkie       = false
HasEmsWalkie        = false
HasMechanicWalkie   = false
HasTaxiWalkie       = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustReleased(0, Config.TurnOnOffKey) then
            hasLspdWalkieTalkie(function (haswalkie)
                HasLspdWalkie = haswalkie
            end)

            hasEmsWalkieTalkie(function (haswalkie)
                HasEmsWalkie = haswalkie
            end)

            hasMechanicWalkieTalkie(function (haswalkie)
                HasMechanicWalkie = haswalkie
            end)

            hasTaxiWalkieTalkie(function (haswalkie)
                HasTaxiWalkie = haswalkie
            end)

            ToggleWalkies()
        end
    end
end)

function ToggleWalkies()
    WalkieOpened = not WalkieOpened

    if WalkieOpened then
        if HasLspdWalkie then
            exports.tokovoip_script:addPlayerToRadio(Config.PoliceChannel)
        end

        if HasEmsWalkie then
            exports.tokovoip_script:addPlayerToRadio(Config.EMSChannel)
        end

        if HasMechanicWalkie then
            exports.tokovoip_script:addPlayerToRadio(Config.MechanicChannel)
        end

        if HasTaxiWalkie then
            exports.tokovoip_script:addPlayerToRadio(Config.TaxiChannel)
        end
    else
        exports.tokovoip_script:removePlayerFromRadio(Config.PoliceChannel)
        exports.tokovoip_script:removePlayerFromRadio(Config.EMSChannel)
        exports.tokovoip_script:removePlayerFromRadio(Config.MechanicChannel)
        exports.tokovoip_script:removePlayerFromRadio(Config.TaxiChannel)
    end
end

function hasLspdWalkieTalkie(cb)
    ESX.TriggerServerCallback('croone_walkietalkie:getItemAmount', function(qtty)
        cb(qtty > 0)
    end, 'walkie_lspd')
end

function hasEmsWalkieTalkie(cb)
    ESX.TriggerServerCallback('croone_walkietalkie:getItemAmount', function(qtty)
        cb(qtty > 0)
    end, 'walkie_ems')
end

function hasMechanicWalkieTalkie(cb)
    ESX.TriggerServerCallback('croone_walkietalkie:getItemAmount', function(qtty)
        cb(qtty > 0)
    end, 'walkie_mechanic')
end

function hasTaxiWalkieTalkie(cb)
    ESX.TriggerServerCallback('croone_walkietalkie:getItemAmount', function(qtty)
        cb(qtty > 0)
    end, 'walkie_taxi')
end

function ShowNoWalkieWarning()
    if (ESX == nil) then return end
    ESX.ShowNotification(_U('no_item'))
end