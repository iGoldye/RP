Citizen.CreateThread(function()
	for i = 1, 14 do
		if i ~= 11 then
			EnableDispatchService(i, EnableDispatch)
		end
	end
	while true do
		-- These natives has to be called every frame.
		SetVehicleDensityMultiplierThisFrame((TrafficAmount/100)+.0)
		SetPedDensityMultiplierThisFrame((PedestrianAmount/100)+.0)
		SetRandomVehicleDensityMultiplierThisFrame((TrafficAmount/100)+.0)
		SetParkedVehicleDensityMultiplierThisFrame((ParkedAmount/100)+.0)
		SetScenarioPedDensityMultiplierThisFrame((PedestrianAmount/100)+.0, (PedestrianAmount/100)+.0)
		Citizen.Wait(0)
	end
end)
