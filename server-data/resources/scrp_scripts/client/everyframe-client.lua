local PICKUP_WEAPON_CARBINERFILE = GetHashKey('PICKUP_WEAPON_CARBINERIFLE')
local PICKUP_WEAPON_PISTOL = GetHashKey('PICKUP_WEAPON_PISTOL')
local PICKUP_WEAPON_PUMPSHOTGUN = GetHashKey('PICKUP_WEAPON_PUMPSHOTGUN')

Citizen.CreateThread(function()
	while true do
		local playerId = PlayerId()

		SetVehicleDensityMultiplierThisFrame(0.5) -- fixing traffic
		HideHudComponentThisFrame(14) -- hide crosshair
		DisablePlayerVehicleRewards(playerId) -- no vehicle rewards

		-- remove drop from npc
		RemoveAllPickupsOfType(PICKUP_WEAPON_CARBINERFILE)
		RemoveAllPickupsOfType(PICKUP_WEAPON_PISTOL)
		RemoveAllPickupsOfType(PICKUP_WEAPON_PUMPSHOTGUN)

		Citizen.Wait(0)
	end
end)