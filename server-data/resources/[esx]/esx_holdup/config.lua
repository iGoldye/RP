Config = {}
Config.Locale = 'en'

Config.Marker = {
	r = 250, g = 0, b = 0, a = 100,  -- red color
	x = 1.0, y = 1.0, z = 1.5,       -- tiny, cylinder formed circle
	DrawDistance = 15.0, Type = 1    -- default circle type, low draw distance due to indoors area
}

Config.PoliceNumberRequired = 3
Config.TimerBeforeNewRob    = 1800 -- The cooldown timer on a store after robbery was completed / canceled, in seconds

Config.MaxDistance    = 20   -- max distance from the robbary, going any longer away from it will to cancel the robbary
Config.GiveBlackMoney = true -- give black money? If disabled it will give cash instead

Stores = {
	["paleto_twentyfourseven"] = {
		position = { x = 1736.32, y = 6419.47, z = 35.03 },
		reward = math.random(5000, 35000),
		nameOfStore = "24/7. (Paleto Bay)",
		secondsRemaining = 120, -- seconds
		lastRobbed = 0
	},
	["sandyshores_twentyfoursever"] = {
		position = { x = 1961.24, y = 3749.46, z = 32.34 },
		reward = math.random(3000, 20000),
		nameOfStore = "24/7. (Sandy Shores)",
		secondsRemaining = 90, -- seconds
		lastRobbed = 0
	},
	["littleseoul_twentyfourseven"] = {
		position = { x = -709.17, y = -904.21, z = 19.21 },
		reward = math.random(3000, 20000),
		nameOfStore = "24/7. (Little Seoul)",
		secondsRemaining = 90, -- seconds
		lastRobbed = 0
	},
	["bar_one"] = {
		position = { x = 1990.57, y = 3044.95, z = 47.21 },
		reward = math.random(5000, 35000),
		nameOfStore = "Yellow Jack. (Sandy Shores)",
		secondsRemaining = 300, -- seconds
		lastRobbed = 0
	},
	["ocean_liquor"] = {
		position = { x = -2959.33, y = 388.21, z = 14.00 },
		reward = math.random(3000, 30000),
		nameOfStore = "Robs Liquor. (Great Ocean Highway)",
		secondsRemaining = 90, -- seconds
		lastRobbed = 0
	},
	["rancho_liquor"] = {
		position = { x = 1126.80, y = -980.40, z = 45.41 },
		reward = math.random(3000, 50000),
		nameOfStore = "Robs Liquor. (El Rancho Blvd)",
		secondsRemaining = 90, -- seconds
		lastRobbed = 0
	},
	["sanandreas_liquor"] = {
		position = { x = -1219.85, y = -916.27, z = 11.32 },
		reward = math.random(3000, 30000),
		nameOfStore = "Robs Liquor. (San Andreas Avenue)",
		secondsRemaining = 90, -- seconds
		lastRobbed = 0
	},
	["grove_ltd"] = {
		position = { x = -43.40, y = -1749.20, z = 29.42 },
		reward = math.random(3000, 15000),
		nameOfStore = "LTD Gasoline. (Grove Street)",
		secondsRemaining = 90, -- seconds
		lastRobbed = 0
	},
	["mirror_ltd"] = {
		position = { x = 1160.67, y = -314.40, z = 69.20 },
		reward = math.random(3000, 15000),
		nameOfStore = "LTD Gasoline. (Mirror Park Boulevard)",
		secondsRemaining = 90, -- seconds
		lastRobbed = 0
	},
	["strowbery_twentyfourseven"] = {
		position = { x = 28.17, y = -1339.21, z = 29.21 },
		reward = math.random(3000, 20000),
		nameOfStore = "24/7. (Strowbery)",
		secondsRemaining = 90, -- seconds
		lastRobbed = 0
	},
	["vinewood_twentyfourseven"] = {
		position = { x = 378.17, y = 333.21, z = 103.21 },
		reward = math.random(3000, 20000),
		nameOfStore = "24/7. (Vinewood)",
		secondsRemaining = 90, -- seconds
		lastRobbed = 0
	},
	["richman_twentyfourseven"] = {
		position = { x = -1828.97, y = 798.71, z = 138.21 },
		reward = math.random(3000, 20000),
		nameOfStore = "24/7. (Richman Glen)",
		secondsRemaining = 90, -- seconds
		lastRobbed = 0
	},
	["morningwood_twentyfourseven"] = {
		position = { x = -1479.27, y = -375.01, z = 39.21 },
		reward = math.random(3000, 20000),
		nameOfStore = "24/7. (Morningwood)",
		secondsRemaining = 90, -- seconds
		lastRobbed = 0
	},
	["banham_twentyfourseven"] = {
		position = { x = -3047.37, y = 585.71, z = 7.21 },
		reward = math.random(3000, 20000),
		nameOfStore = "24/7. (Banhem Canion)",
		secondsRemaining = 90, -- seconds
		lastRobbed = 0
	},
	["chumash_twentyfourseven"] = {
		position = { x = -3249.57, y = 1004.31, z = 12.81 },
		reward = math.random(3000, 20000),
		nameOfStore = "24/7. (Chumash)",
		secondsRemaining = 90, -- seconds
		lastRobbed = 0
	},
	["harmony_twentyfourseven"] = {
		position = { x = 546.37, y = 2663.21, z = 42.16 },
		reward = math.random(3000, 20000),
		nameOfStore = "24/7. (Harmony)",
		secondsRemaining = 90, -- seconds
		lastRobbed = 0
	},
	["grandsenora_twentyfourseven"] = {
		position = { x = 1168.57, y = 2717.89, z = 37.16 },
		reward = math.random(3000, 20000),
		nameOfStore = "24/7. (Grand Senora)",
		secondsRemaining = 90, -- seconds
		lastRobbed = 0
	},
	["senoraroad_twentyfourseven"] = {
		position = { x = 2673.17, y = 3286.4, z = 55.26 },
		reward = math.random(3000, 20000),
		nameOfStore = "24/7. (Road Senora)",
		secondsRemaining = 90, -- seconds
		lastRobbed = 0
	},
	["graypsid_twentyfourseven"] = {
		position = { x = 1707.53, y = 4920.05, z = 42.06 },
		reward = math.random(3000, 20000),
		nameOfStore = "24/7. (Graypsid)",
		secondsRemaining = 90, -- seconds
		lastRobbed = 0
	},
	["pacific_standard"] = {
		position = { x = 254.06, y = 225.37, z = 101.88 },
		reward = math.random(50000, 150000),
		nameOfStore = "Сейф (Pacific Standard)",
		secondsRemaining = 200, -- seconds
		lastRobbed = 0
	},
	["blaine_county"] = {
		position = { x = -103.68, y = 6477.91, z = 31.63 },
		reward = math.random(30000, 90000),
		nameOfStore = "Сейф (Blaine County Paleto .)",
		secondsRemaining = 200, -- seconds
		lastRobbed = 0
	},
	["fleeca_bank"] = {
		position = { x = 1176.85, y = 2711.77, z = 38.1 },
		reward = math.random(30000, 90000),
		nameOfStore = "Сейф (Fleeca Grand Senora.)",
		secondsRemaining = 200, -- seconds
		lastRobbed = 0
	},
	["fleeca_bank"] = {
		position = { x = 310.99, y = -283.13, z = 54.17 },
		reward = math.random(30000, 90000),
		nameOfStore = "Сейф (Fleeca Meteor st.)",
		secondsRemaining = 200, -- seconds
		lastRobbed = 0
	},
	["fleeca_bank"] = {
		position = { x = -354.01, y = -53.95, z = 49.05 },
		reward = math.random(30000, 90000),
		nameOfStore = "Сейф (Fleeca Hevick ave.)",
		secondsRemaining = 200, -- seconds
		lastRobbed = 0
	},
	["fleeca_bank"] = {
		position = { x = 146.75, y = -1044.69, z = 29.38 },
		reward = math.random(30000, 90000),
		nameOfStore = "Сейф (Fleeca Englin ave.)",
		secondsRemaining = 200, -- seconds
		lastRobbed = 0
	},
	["fleeca_bank"] = {
		position = { x = -2957.71, y = 481.41, z = 15.7 },
		reward = math.random(30000, 90000),
		nameOfStore = "Сейф (Fleeca Great Ocean.)",
		secondsRemaining = 200, -- seconds
		lastRobbed = 0
	},




}
