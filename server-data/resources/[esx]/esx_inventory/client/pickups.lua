pickups = {}

-- pickups
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		for id,v in pairs(pickups) do
			local distance = GetDistanceBetweenCoords(coords, v.coords.x, v.coords.y, v.coords.z, true)
--			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
--		 	print("Pickup distance: "..closestDistance)

			if distance <= 5.0 then
				ESX.Game.Utils.DrawText3D({
					x = v.coords.x,
					y = v.coords.y,
					z = v.coords.z + 0.25
				}, v.label .. ' ['..v.item.amount..']')
			end

			if distance <= 1.0 and not v.inRange and IsPedOnFoot(playerPed) then
				TriggerServerEvent('esx_inventory:onPickup', id)
				PlaySoundFrontend(-1, 'PICK_UP', 'HUD_FRONTEND_DEFAULT_SOUNDSET', false)
				v.inRange = true

				TriggerEvent('esx_inventory:updateInventory', "pocket", false)
			end

			if v.inRange and distance > 1.2 then
				v.inRange = false
			end
		end
	end
end)

RegisterNetEvent('esx_inventory:createPickup')
AddEventHandler('esx_inventory:createPickup', function(id, pickup)
	local ped     = PlayerPedId()
	local player_coords  = GetEntityCoords(ped)
--	local forward = GetEntityForwardVector(ped)
--	local x, y, z = table.unpack(coords)
--	local coords = pickup.coords + forward * -2.0
	local dist = #(player_coords - pickup.coords)
	local rotation = vector3(0,0,0)

	local propName = 'prop_money_bag_01'

	if pickup.item.name == "weapon" then
		local weaponConfig = GetWeaponConfig(pickup.item.extra.weapon_name)
		if weaponConfig ~= nil and weaponConfig.prop ~= nil then
			propName = weaponConfig.prop
		end

		rotation = vector3(90,0,0)
	end

	if pickup.item.name == "money" or pickup.item.name == "black_money" then
		propName = "prop_cash_pile_02"
		if pickup.item.amount >= 10000 then
			propName = "prop_cash_case_02"
		elseif pickup.item.amount >= 1000 then
			propName = "prop_poly_bag_money"
		end
	end

	local propHash = GetHashKey(propName)
	ESX.Streaming.RequestModel(propHash)
	local obj = CreateObject(propHash, pickup.coords.x, pickup.coords.y, pickup.coords.z, false, false, false)

	SetEntityCollision(obj, false, false)
	SetEntityAsMissionEntity(obj, true, false)
	PlaceObjectOnGroundProperly(obj)
	SetEntityRotation(obj, rotation, 2, true)

	pickups[id] = {
		item = pickup.item,
		label = pickup.label,
		coords = pickup.coords,
		source = pickup.source,
		obj = obj,
		inRange = true,
	}
end)

RegisterNetEvent('esx_inventory:removePickup')
AddEventHandler('esx_inventory:removePickup', function(id)
	if pickups[id] == nil then
		return
	end

	if pickups[id].obj ~= nil then
		ESX.Game.DeleteObject(pickups[id].obj)
	end

	pickups[id] = nil
end)
