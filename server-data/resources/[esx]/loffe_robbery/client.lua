local robbing = false
local cops = 2
local pickups = {}
local myPeds = {}

RegisterNetEvent('loffe_robbery:loadStore')
AddEventHandler('loffe_robbery:loadStore', function(store, id)
	print(store, id)
	if id then
			Config.Shops[store].id = id
	else
			ClearAreaOfPeds(Config.Shops[store].coords.x, Config.Shops[store].coords.y, Config.Shops[store].coords.z, 5.0, 1)
			local ped = createPed(Config.Shopkeeper, Config.Shops[store].coords, Config.Shops[store].heading)
			myPeds[store] = ped
			NetworkRegisterEntityAsNetworked(ped)
			local networkId = NetworkGetNetworkIdFromEntity(ped)
			if networkId then
					TriggerServerEvent('loffe_robbery:setStoreNetworkId', store, networkId)
			end
	end
end)

RegisterNetEvent('loffe_robbery:setPedNetworkId')
AddEventHandler('loffe_robbery:setPedNetworkId', function(store, id)
	Config.Shops[store].id = id
end)

RegisterNetEvent('loffe_robbery:setCops')
AddEventHandler('loffe_robbery:setCops', function(cops)
	cops = cops
end)

RegisterNetEvent('loffe_robbery:deleteSpawnedPed')
AddEventHandler('loffe_robbery:deleteSpawnedPed', function(store, realId)
	if DoesEntityExist(myPeds[store]) then
			DeleteEntity(myPeds[store])
			Config.Shops[store].id = realId
	end
end)

RegisterNetEvent('loffe_robbery:notify')
AddEventHandler('loffe_robbery:notify', function(text, length)
	notify(text, length)
end)

RegisterNetEvent('loffe_robbery:removePickup')
AddEventHandler('loffe_robbery:removePickup', function(pickupid)
	for i = 1, #pickups do
			if pickups[i]['id'] == pickupid then
					DeleteObject(pickups[i]['object'])
					table.remove(pickups, i)
			end
	end
end)

RegisterNetEvent('loffe_robbery:createPickup')
AddEventHandler('loffe_robbery:createPickup', function(coords, pickupid)
	local model = GetHashKey('prop_poly_bag_01')
	RequestModel(model)
	while not HasModelLoaded(model) do Wait(0) end
	local bag = CreateObject(model, coords, false, false)
	table.insert(pickups, {['object'] = bag, ['id'] = pickupid})
end)

Citizen.CreateThread(function()
	while not NetworkIsSessionStarted() do Wait(50) end
	TriggerServerEvent('loffe_robbery:loadAllStores')
	while true do
			for i = 1, #Config.Shops do
					if Config.Shops[i].id then
							local ped = NetworkGetEntityFromNetworkId(Config.Shops[i].id)re
							local me = PlayerPedId()
							if DoesEntityExist(ped) and not IsPedDeadOrDying(ped, true) and IsPedArmed(me, 7) and IsPlayerFreeAiming(PlayerId()) and HasEntityClearLosToEntityInFront(me, ped, 19) and GetDistanceBetweenCoords(GetEntityCoords(me), GetEntityCoords(ped), true) <= 5.0  and not robbing then
									if not IsEntityPlayingAnim(ped, 'missheist_agency2ahands_up', 'handsup_anxious', 3) and not IsEntityPlayingAnim(ped, 'mp_am_hold_up', 'holdup_victim_20s', 3) and not IsEntityPlayingAnim(ped, 'mp_am_hold_up', 'cower_loop', 3) then
											TriggerServerEvent('loffe_robbery:getCops')
											if cops >= Config.Shops[i].cops then
													loadDict('missheist_agency2ahands_up')
													TaskPlayAnim(ped, 'missheist_agency2ahands_up', 'handsup_anxious', 8.0, -8.0, -1, 1, 0, false, false, false)

													local scared = 0
													while scared < 100 and not IsPedDeadOrDying(ped) and GetDistanceBetweenCoords(GetEntityCoords(me), GetEntityCoords(ped), true) <= 7.5 do
															local sleep = 600
															SetEntityAnimSpeed(ped, "missheist_agency2ahands_up", "handsup_anxious", 1.0)
															if IsPlayerFreeAiming(PlayerId()) then
																	sleep = 250
																	SetEntityAnimSpeed(ped, "missheist_agency2ahands_up", "handsup_anxious", 1.3)
															end
															if IsPedArmed(me, 4) and GetAmmoInClip(me, GetSelectedPedWeapon(me)) > 0 and IsControlPressed(0, 24) then
																	sleep = 50
																	SetEntityAnimSpeed(ped, "missheist_agency2ahands_up", "handsup_anxious", 1.7)
															end
															sleep = GetGameTimer() + sleep
															while sleep >= GetGameTimer() and not IsPedDeadOrDying(ped) do
																	Wait(0)
																	-- DrawRect(0.5, 0.5, 0.2, 0.03, 75, 75, 75, 200)
																	local draw = scared/500
																	-- DrawRect(0.5, 0.5, draw, 0.03, 0, 221, 255, 200)
															end
															scared = scared + 1
													end
													if GetDistanceBetweenCoords(GetEntityCoords(me), GetEntityCoords(ped), true) <= 7.5 then
															if not IsPedDeadOrDying(ped) then
																	SetEntityCoords(ped, Config.Shops[i].coords)
																	SetEntityHeading(ped, Config.Shops[i].heading)
																	loadDict('mp_am_hold_up')
																	TaskPlayAnim(ped, "mp_am_hold_up", "holdup_victim_20s", 8.0, -8.0, -1, 2, 0, false, false, false)
																	while not IsEntityPlayingAnim(ped, "mp_am_hold_up", "holdup_victim_20s", 3) do Wait(0) end
																	local timer = GetGameTimer() + 10800
																	while timer >= GetGameTimer() do
																			if IsPedDeadOrDying(ped) then
																					break
																			end
																			Wait(0)
																	end

																	if not IsPedDeadOrDying(ped) then
																			local cashRegister = GetClosestObjectOfType(GetEntityCoords(ped), 5.0, GetHashKey('prop_till_01'))
																			if DoesEntityExist(cashRegister) then
																					CreateModelSwap(GetEntityCoords(cashRegister), 0.5, GetHashKey('prop_till_01'), GetHashKey('prop_till_01_dam'), false)
																			end

																			timer = GetGameTimer() + 200
																			while timer >= GetGameTimer() do
																					if IsPedDeadOrDying(ped) then
																							break
																					end
																					Wait(0)
																			end

																			local model = GetHashKey('prop_poly_bag_01')
																			RequestModel(model)
																			while not HasModelLoaded(model) do Wait(0) end
																			local bag = CreateObject(model, GetEntityCoords(ped), true, false)

																			AttachEntityToEntity(bag, ped, GetPedBoneIndex(ped, 60309), 0.1, -0.11, 0.08, 0.0, -75.0, -75.0, 1, 1, 0, 0, 2, 1)
																			timer = GetGameTimer() + 10000
																			while timer >= GetGameTimer() do
																					if IsPedDeadOrDying(ped) then
																							break
																					end
																					Wait(0)
																			end
																			if not IsPedDeadOrDying(ped) then
																					DetachEntity(bag, true, false)
																					timer = GetGameTimer() + 75
																					while timer >= GetGameTimer() do
																							if IsPedDeadOrDying(ped) then
																									break
																							end
																							Wait(0)
																					end
																					SetEntityHeading(bag, Config.Shops[i].heading)
																					ApplyForceToEntity(bag, 3, vector3(0.0, 50.0, 0.0), 0.0, 0.0, 0.0, 0, true, true, false, false, true)
																					while GetEntityHeightAboveGround(bag) >= 0.2 do Wait(0) end
																					local bagCoords = GetEntityCoords(bag)
																					DeleteObject(bag)
																					TriggerServerEvent('loffe_robbery:createPickup', i, bagCoords)
																			else
																					DeleteObject(bag)
																			end
																	end
																	loadDict('mp_am_hold_up')
																	TaskPlayAnim(ped, "mp_am_hold_up", "cower_intro", 8.0, -8.0, -1, 0, 0, false, false, false)
																	timer = GetGameTimer() + 2500
																	while timer >= GetGameTimer() do Wait(0) end
																	TaskPlayAnim(ped, "mp_am_hold_up", "cower_loop", 8.0, -8.0, -1, 1, 0, false, false, false)
																	local stop = GetGameTimer() + 120000
																	while stop >= GetGameTimer() do
																			Wait(50)
																	end
																	if IsEntityPlayingAnim(ped, "mp_am_hold_up", "cower_loop", 3) then
																			ClearPedTasks(ped)
																	end
															end
													else
															ClearPedTasks(ped)
															notify(Translation[Config.Locale]['walked_too_far'], 5)
															robbing = false
													end
											else
													notify(Translation[Config.Locale]['no_cops'], 5)
											end
									end
							end
					end
			end
			Wait(0)
	end
end)

notify = function(text, length)
	local wait = GetGameTimer()+length*1000
	while wait >= GetGameTimer() do
			Wait(0)
			drawText3D(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.5, 0.4), text)
	end
end

Citizen.CreateThread(function()
	while true do
			Wait(5)
			for i = 1, #pickups do
					local bag = pickups[i]['object']
					if DoesEntityExist(bag) then
							if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(bag), true) <= 3 then
									-- PlaySoundFrontend(-1, 'ROBBERY_MONEY_TOTAL', 'HUD_FRONTEND_CUSTOM_SOUNDSET', true)
									print(pickups[i]['id'])
									TriggerServerEvent('loffe_robbery:pickUpPickup', pickups[i]['id'])
							end
					end
			end
	end
end)

loadDict = function(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do Wait(10) end
end

createPed = function(hash, coords, heading)
	RequestModel(hash)
	while not HasModelLoaded(hash) do
			Wait(5)
	end

	local ped = CreatePed(4, hash, coords, true, true)
	SetEntityHeading(ped, heading)
	SetEntityAsMissionEntity(ped, true, true)
	SetPedHearingRange(ped, 0.0)
	SetPedSeeingRange(ped, 0.0)
	SetPedAlertness(ped, 0.0)
	SetPedFleeAttributes(ped, 0, 0)
	SetBlockingOfNonTemporaryEvents(ped, true)
	SetPedCombatAttributes(ped, 46, true)
	SetPedFleeAttributes(ped, 0, 0)
	return ped
end

drawText3D = function(coords, text)
	local onScreen, _x, _y = World3dToScreen2d(coords.x, coords.y, coords.z)
	local pX, pY, pZ = table.unpack(GetGameplayCamCoords())

	SetTextScale(0.4, 0.4)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextEntry("STRING")
	SetTextCentre(1)
	SetTextColour(255, 255, 255, 255)
	SetTextOutline()

	AddTextComponentString(text)
	DrawText(_x, _y)
end
