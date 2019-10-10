function unequip_weapon(weaponName, amount)

	local playerPed = PlayerPedId()
	local weaponHash = GetHashKey(weaponName)
	local current_ammo = GetAmmoInPedWeapon(playerPed, weaponHash)

	if HasPedGotWeapon(playerPed, weaponHash, false) and current_ammo >= amount then
		if GetSelectedPedWeapon(playerPed) == weaponHash then
			SetCurrentPedWeapon(playerPed, GetHashKey("WEAPON_UNARMED"), true)
		end

		SetPedAmmo(playerPed, weaponHash, current_ammo - amount)
		RemoveWeaponFromPed(playerPed, weaponHash)

		TriggerServerEvent('esx_inventory:unequipWeapon', weaponName, amount)
		return true
	end

	return false
end

function equip_weapon(item)
	local weaponName = item.extra.weapon_name
	local playerPed = PlayerPedId()
	local weaponHash = GetHashKey(weaponName)

	if HasPedGotWeapon(playerPed, weaponHash, false) then
		ESX.ShowNotification(_U('already_equipped'))
	else
		GiveWeaponToPed(playerPed, weaponHash, item.extra.ammo, false, true)
		TriggerEvent('esx_inventory:updateInventory', "pocket", false)
	end
end

RegisterNetEvent('esx_inventory:unequipWeapon')
AddEventHandler('esx_inventory:unequipWeapon', function(weaponName, amount)
	unequip_weapon(weaponName, amount)
end)

RegisterNetEvent('esx_inventory:equipWeapon')
AddEventHandler('esx_inventory:equipWeapon', function(item)
	equip_weapon(item)
end)

AddEventHandler('esx_inventory:registerActions', function()

TriggerEvent('esx_inventory:registerItemAction', "esx_item", "heal_target", "Вылечить другого", 1, function(item)

	if item.extra == nil then
		TriggerEvent('esx:showNotification', "Что-то пошло не так")
		return
	end

	if item.extra.name ~= 'medikit' then
		return
	end

	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
--	closestPlayer = PlayerId()
--	closestDistance = 0.1

	if closestPlayer ~= -1 and closestDistance < 1.0 then
		TriggerEvent('esx_ambulancejob:useMedikit', closestPlayer)
	else
		ESX.ShowNotification("Некого лечить!")
	end

end, function(item)
	if item.extra == nil then
		return false
	end

	if item.extra.name ~= 'medikit' then
		return false
	end

	return true
end)

TriggerEvent('esx_inventory:registerItemAction', "equipped_weapon", "unequip", _U("inventory_action_unequip"), 0, function(item)

	if item.extra == nil then
		TriggerEvent('esx:showNotification', "Что-то пошло не так")
		return
	end

	if item.extra.ammo > 0 then
		TriggerEvent("sosamba_ui:showInputBox", "unequip-box", "Сколько разэкипировать?", "Введите количество патронов", function(text)
			local val = tonumber(text)
			if val ~= nil and val >= 0 and val <= item.extra.ammo then
				unequip_weapon(item.extra.weapon_name, val)
			else
				ESX.ShowNotification(_U('amount_invalid'))
			end
		end)
	else
		unequip_weapon(item.extra.weapon_name, 0)
	end
end)

TriggerEvent('esx_inventory:registerItemAction', "weapon", "equip", _U("inventory_action_equip"), 0, function(item)
	TriggerServerEvent('esx_inventory:equipWeapon', item)
end)

TriggerEvent('esx_inventory:registerItemAction', "esx_item", "esx_use", _U("inventory_action_use"), 1, function(item)
	TriggerServerEvent('esx:useItem', item.extra.name)
	TriggerEvent('esx_inventory:updateInventory', "pocket", false)
end, function(item)
	if item.extra == nil then
		return false
	end
-- FIXME: Разобраться, почему usable не обновляется для напитков из basicneeds

	if item.extra.name == "icetea" then
		return true
	elseif item.extra.name == "limonade" then
		return true
	elseif item.extra.name == "drpepper" then
		return true
	elseif item.extra.name == "energy" then
		return true
	elseif item.extra.name == "mixapero" then
		return true
	elseif item.extra.name == "vodka" then
		return true
	elseif item.extra.name == "jager" then
		return true
	elseif item.extra.name == "rhum" then
		return true
	elseif item.extra.name == "whisky" then
		return true
	elseif item.extra.name == "martini" then
		return true
	elseif item.extra.name == "vodkaenergy" then
		return true
	end

	return item.extra.usable == true
end)

TriggerEvent('esx_inventory:registerItemAction', "money_pack", "unpack", _U("inventory_action_unpack"), 1, function(item)
	TriggerServerEvent('esx_inventory:actionUnpackMoney', item)
end)

TriggerEvent('esx_inventory:registerItemAction', "passport", "show", "Просмотреть", 1, function(item)
	hideInventoryMenu()
	TriggerServerEvent('sosamba_ui:actionShowPassport', item)
end)


TriggerEvent('esx_inventory:registerItemAction', "@shared", "drop", "Выбросить", -1, function(item) -- action
	local amount = 0

	if item == nil or item.amount == nil or item.amount < 1 then
		TriggerEvent('esx:showNotification', "Нельзя выбросить")
		return
	end

	if item.amount == 1 then
		TriggerServerEvent('esx_inventory:dropItem', "pocket", false, json.encode(duplicateItem(item, { ["amount"] = 1 })))
		TriggerEvent('esx_inventory:updateInventory', "pocket", false)
		TaskPlayAnim(PlayerPedId(), 'pickup_object', 'pickup_low', 8.0, -8.0, -1, 48, 0, false, false, false)
	else
		TriggerEvent("sosamba_ui:showInputBox", "drop-box", "Сколько выбросить?", "Введите количество предметов", function(text)
			local val = tonumber(text)
			if val ~= nil then
				amount = tonumber(text)
			end

			if amount ~= nil and amount > 0 then
				TriggerServerEvent('esx_inventory:dropItem', "pocket", false, duplicateItem(item, { ["amount"] = amount }))
				TriggerEvent('esx_inventory:updateInventory', "pocket", false)
				TaskPlayAnim(PlayerPedId(), 'pickup_object', 'pickup_low', 8.0, -8.0, -1, 48, 0, false, false, false)
			end
		end)
	end

end, function(item) -- condition
	if item ~= nil and item.droppable ~= nil then
		return item.droppable
	end

	return true
end)

TriggerEvent('esx_inventory:registerItemAction', "@shared", "giveitemto", "Передать", 0, function(item)
	local amount = item.amount

	if item == nil then
		TriggerEvent('esx:showNotification', "Неверный предмет для передачи")
		return
	end

	if amount == nil then
		TriggerEvent('esx:showNotification', "Неверное количество предметов для передачи")
		return
	end

	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
--	closestPlayer = PlayerId()
--	closestDistance = 1.0

	if closestPlayer < 1 or closestDistance > 3.0 then
		TriggerEvent('esx:showNotification', "Рядом никого нет")
		return
	end

        if amount < 2 then
		local ditem = duplicateItem(item, { ["amount"] = amount })
		ESX.TriggerServerCallback('esx_inventory:giveItemTo', function(success)
			if success then
				TaskPlayAnim(PlayerPedId(), 'mp_common', 'givetake1_a', 8.0, -8.0, -1, 48, 0, false, false, false)
				TriggerEvent('esx:showNotification', "Предмет передан")
			end
		end, GetPlayerServerId(closestPlayer), ditem)
	else
		TriggerEvent("sosamba_ui:showInputBox", "giveto-box", "Сколько передать?", "Введите количество предметов", function(text)
			amount = tonumber(text)

			if amount ~= nil and amount > 0 then
				local ditem = duplicateItem(item, { ["amount"] = amount })

				ESX.TriggerServerCallback('esx_inventory:giveItemTo', function(success)
					if success then
						TaskPlayAnim(PlayerPedId(), 'mp_common', 'givetake1_a', 8.0, -8.0, -1, 48, 0, false, false, false)
						TriggerEvent('esx:showNotification', "Предмет передан")
					end
				end, GetPlayerServerId(closestPlayer), ditem)
			else
				TriggerEvent('esx:showNotification', "Неверное количество предметов для передачи")
			end
		end)
	end
end, function(item) -- condition
	if item ~= nil and item.name ~= nil then
		return item.name ~= 'account_money' and item.name ~= 'equipped_weapon'
	end

	return true
end)

end)
