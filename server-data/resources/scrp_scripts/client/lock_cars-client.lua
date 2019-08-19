function lock_cars()
		local pos = GetEntityCoords(PlayerPedId())

		local vehicle = GetClosestVehicle(pos, 5.0, 0, 71)
		if DoesEntityExist(vehicle) then
			if DecorGetBool(vehicle, "NPCLOCKED") == false then
				local locked = math.random()<0.95
				DecorSetBool(vehicle, "NPCLOCKED", true)

				if locked then
					local driver = GetPedInVehicleSeat(vehicle, -1)
					local npcIsDriving = DoesEntityExist(driver) and not IsPedAPlayer(driver)
					local toBeStealed = IsVehicleAlarmSet(vehicle) or IsVehicleNeedsToBeHotwired(vehicle) --or IsVehiclePreviouslyOwnedByPlayer(vehicle) == false

					if toBeStealed or npcIsDriving  then
						SetVehicleDoorsLocked(vehicle, 2)
					end
				end
			end
		end

end

Citizen.CreateThread(function()
	if not DecorIsRegisteredAsType("NPCLOCKED", 2) then -- BOOL
		DecorRegister("NPCLOCKED", 2)
	end

	while true do
		Citizen.Wait(1000)
		pcall(function()
			lock_cars()
		end)
	end
end)
