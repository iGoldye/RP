ESX = nil

Wrapper.TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Wrapper.RegisterNetEvent('blargleambulance:finishLevel')
Wrapper.AddEventHandler('blargleambulance:finishLevel', function(levelFinished)
	-- ESX.GetPlayerFromId(source).addMoney(Config.Formulas.moneyPerLevel(levelFinished))
	local xPlayer = ESX.GetPlayerFromId(source)
	local total = Config.Formulas.moneyPerLevel(levelFinished)

	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ambulance', function(account)
		local societyAccount = account

		if societyAccount then
			local playerMoney  = ESX.Math.Round(total / 100 * 30)
			local societyMoney = ESX.Math.Round(total / 100 * 70)

			xPlayer.addMoney(playerMoney)
			societyAccount.addMoney(societyMoney)

			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('comp_earned', societyMoney, playerMoney))
		else
			xPlayer.addMoney(total)
		end
	end)
end)
