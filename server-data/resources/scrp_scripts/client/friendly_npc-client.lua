-- https://forum.fivem.net/t/how-to-disable-aggressive-npcs-in-sandy-shores/62822/2

--[[
local relationshipTypes = {
	'GANG_1',
	'GANG_2',
	'GANG_9',
	'GANG_10',
	'AMBIENT_GANG_LOST',
	'AMBIENT_GANG_MEXICAN',
	'AMBIENT_GANG_FAMILY',
	'AMBIENT_GANG_BALLAS',
	'AMBIENT_GANG_MARABUNTE',
	'AMBIENT_GANG_CULT',
	'AMBIENT_GANG_SALVA',
	'AMBIENT_GANG_WEICHENG',
	'AMBIENT_GANG_HILLBILLY',
	'DEALER',
	'COP',
	'PRIVATE_SECURITY',
	'SECURITY_GUARD',
	'ARMY',
	'MEDIC',
	'FIREMAN',
	'HATES_PLAYER',
	'NO_RELATIONSHIP',
	'SPECIAL',
	'MISSION2',
	'MISSION3',
	'MISSION4',
	'MISSION5',
	'MISSION6',
	'MISSION7',
	'MISSION8'
}
]]--

function setRelationships(roleName)
	local relationships = Config.RoleRelationships[roleName]

	if relationships == nil then
		return false
	end

	local ph = GetHashKey('PLAYER')

	for group,v in pairs(relationships) do
		SetRelationshipBetweenGroups(v, GetHashKey(group), ph)
	end

	return true
end

RegisterNetEvent('scrp_scripts:setRelationships')
AddEventHandler('scrp_scripts:setRelationships', function(roles)
	for _,v in ipairs(roles) do
		setRelationships(v)
	end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		TriggerServerEvent('scrp_scripts:updateRelationships')
	end
end)
