Config        = {}
Config.Locale = 'en'

Config.RoleRelationships = {
--[[
-- 0 = Companion
-- 1 = Respect
-- 2 = Like
-- 3 = Neutral
-- 4 = Dislike
-- 5 = Hate
-- 255 = Pedestrians
]]--

	ballas = {
		AMBIENT_GANG_BALLAS = 1,
		AMBIENT_GANG_FAMILIES = 5,
		AMBIENT_GANG_MEXICAN = 5,
		AMBIENT_GANG_LOST = 5,
	},
	families = {
		AMBIENT_GANG_BALLAS = 5,
		AMBIENT_GANG_FAMILIES = 1,
		AMBIENT_GANG_MEXICAN = 5,
		AMBIENT_GANG_LOST = 5,
	},
	mexican = {
		AMBIENT_GANG_BALLAS = 5,
		AMBIENT_GANG_FAMILIES = 5,
		AMBIENT_GANG_MEXICAN = 1,
		AMBIENT_GANG_LOST = 5,
	},
	biker = {
		AMBIENT_GANG_BALLAS = 5,
		AMBIENT_GANG_FAMILIES = 5,
		AMBIENT_GANG_LOST = 1,
	},
	redneck = {
		AMBIENT_GANG_HILLBILLY = 1,
		AMBIENT_GANG_CULT = 1,
	},

-- jobs always have higher priority over roles, be careful

	job_ambulance = {
		AMBIENT_GANG_HILLBILLY = 3,
		AMBIENT_GANG_CULT = 3,
		HATES_PLAYER = 3,
		PRIVATE_SECURITY = 2,
		SECURITY_GUARD = 2,
		ARMY = 1,
		MEDIC = 1,
		FIREMAN = 1,
	},
	job_police = {
		AMBIENT_GANG_BALLAS = 4,
		AMBIENT_GANG_FAMILIES = 4,
		AMBIENT_GANG_MEXICAN = 4,
		AMBIENT_GANG_LOST = 4,

		AMBIENT_GANG_HILLBILLY = 3,
		AMBIENT_GANG_CULT = 3,
		HATES_PLAYER = 3,
		PRIVATE_SECURITY = 2,
		SECURITY_GUARD = 2,
		ARMY = 1,
		MEDIC = 1,
		FIREMAN = 1,
	},
}
