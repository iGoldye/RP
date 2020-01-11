
Citizen.CreateThread(function()
	local last_health = -1

	while true do
		Citizen.Wait(100)
		local ped = PlayerPedId()
		local health = GetEntityHealth(ped)
--		print(health)
		if health ~= last_health then
			local damage_amount = last_health - health

			if IsPedInMeleeCombat(ped) and damage_amount > 20 and damage_amount < 30 and last_health > 126 and health < 126 and health > 0 then
				Citizen.Wait(100)
				SetPedToRagdoll(ped, 2000, 2000, 0, 0, 0, 0)
				Citizen.Wait(100)
			end

			last_health = health
		end
	end
end)
