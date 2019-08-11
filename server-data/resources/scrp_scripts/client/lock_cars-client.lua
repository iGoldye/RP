Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		local pos = GetEntityCoords(PlayerPedId())

		local vehicle = GetClosestVehicle(pos, 5.0, 0, 71)
		if DoesEntityExist(vehicle) then
			if not DecorExistOn(vehicle, "NPCLOCKED") then
				local locked = math.random()<0.95

				DecorSetBool(vehicle, "NPCLOCKED", locked)
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
end)
