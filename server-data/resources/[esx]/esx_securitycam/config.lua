Config = {}
Config.DrawDistance = 20.0
Config.HideRadar = true -- Hide HUD?
Config.AnimTime = 60 -- Animation for the hacking in seconds. 60 = 1 minute / 60 seconds!

Config.Locale = 'ru'
Config.pNotify = false -- Only enable this if you have pNotify (https://github.com/Nick78111/pNotify)
Config.Hacking = true -- Only enable if you have mhacking (https://github.com/GHMatti/FiveM-Scripts/tree/master/mhacking)

Config.CameraMaxDistance = 100 -- meters to check camera broken
Config.CameraBreakTimer = 600 -- seconds to autofix camera

-- Connect to the cameras
-- Place: In the polices armory room
Config.Zones = {
	Cameras = {
		Pos   = {x = 440.38, y = -975.35, z = 29.72},
		Size  = {x = 1.7, y = 1.7, z = 0.5},
		Color = {r = 26, g = 55, b = 186},
		Type = 27,
	}
}

-- Keep these the same
-- Place: Behind the polices desk in the policestation
-- Screenshot: https://i.imgur.com/f5WNrRj.jpg

Config.HackingPolice = {
	HackingPolice = {
		Pos   = {x = 454.77, y = -979.484, z = 29.69},
		Size  = {x = 1.7, y = 1.7, z = 0.5},
		Color = {r = 26, g = 55, b = 186},
		Type = 27,
	}
}

Config.UnHackPolice = {
	UnHackPolice = {
		Pos   = {x = 454.77, y = -979.484, z = 29.69},
		Size  = {x = 1.7, y = 1.7, z = 0.5},
		Color = {r = 26, g = 55, b = 186},
		Type = 27,
	}
}

-- Keep these the same
-- Place: Down at the bank vault
-- Screenshot: https://i.imgur.com/nvcFUhu.jpg
Config.HackingBank = {
	HackingBank = {
		Pos   = {x = 264.87, y = 219.93, z = 100.68},
		Size  = {x = 1.7, y = 1.7, z = 0.5},
		Color = {r = 26, g = 55, b = 186},
		Type = 27,
	}
}

Config.UnHackBank = {
	UnHackBank = {
		Pos   = {x = 264.87, y = 219.93, z = 100.68},
		Size  = {x = 1.7, y = 1.7, z = 0.5},
		Color = {r = 26, g = 55, b = 186},
		Type = 27,
	}
}

-- Cameras. You could add more cameras for other banks, apartments, houses, buildings etc. (Remember the "," after each row)
Config.Locations = {
	["bank"] = {
		label = _U('pacific_standard_bank'),
		Cameras = {
			{label = _U('bcam'), x = 232.68, y = 221.86, z = 108.45, r = {x = -25.0, y = 0.0, z = -140.91}, canRotate = true},
			{label = _U('bcam2'), x = 257.45, y = 210.07, z = 109.08, r = {x = -25.0, y = 0.0, z = 28.05}, canRotate = true},
			{label = _U('bcam3'), x = 266.86, y = 216.04, z = 108.55, r = {x = -25.0, y = 0.0, z = -220.49}, canRotate = true},
			{label = _U('bcam4'), x = 241.64, y = 233.83, z = 111.48, r = {x = -35.0, y = 0.0, z = 120.46}, canRotate = true},
			{label = _U('bcam5'), x = 269.66, y = 223.67, z = 114.60, r = {x = -30.0, y = 0.0, z = 111.29}, canRotate = true},
			{label = _U('bcam6'), x = 261.90, y = 218.28, z = 113.85, r = {x = -40.0, y = 0.0, z = -159.49}, canRotate = true},
			{label = _U('bcam7'), x = 258.70, y = 204.40, z = 113.85, r = {x = -30.0, y = 0.0, z = 10.50}, canRotate = true},
			{label = _U('bcam8'), x = 235.33, y = 227.67, z = 113.75, r = {x = -35.0, y = 0.0, z = -160.29}, canRotate = true},
			{label = _U('bcam9'), x = 255.12, y = 205.67, z = 113.78, r = {x = -35.0, y = 0.0, z = 44.70}, canRotate = true},
			{label = _U('bcam10'), x = 269.89, y = 223.76, z = 108.30, r = {x = -35.0, y = 0.0, z = 112.62}, canRotate = true},
			{label = _U('bcam11'), x = 251.77, y = 225.42, z = 104.50, r = {x = -35.0, y = 0.0, z = -74.87}, canRotate = true},
		},
	},

	["police"] = {
		label = _U('police_station'),
		Cameras = {
			{label = _U('pcam'), x = 424.194, y = -996.460, z = 33.78, r = {x = -25.0, y = 0.0, z = 118.05}, canRotate = true},
			{label = _U('pcam2'), x = 465.151, y = -994.266, z = 26.85, r = {x = -30.0, y = 0.0, z = 100.29}, canRotate = true},
			{label = _U('pcam3'), x = 465.344, y = -997.877, z = 26.85, r = {x = -35.0, y = 0.0, z = 90.46}, canRotate = true},
			{label = _U('pcam4'), x = 465.344, y = -1001.7, z = 26.85, r = {x = -25.0, y = 0.0, z = 90.01}, canRotate = true},
			{label = _U('pcam5'), x = 421.721, y = -1032.010, z = 31.30, r = {x = -25.0, y = 0.0, z = -30.95}, canRotate = true},
			{label = _U('pcam8'), x = 483.58, y = -990.046, z = 26.90, r = {x = -30.0, y = 0.0, z = 90.29}, canRotate = true},
			{label = _U('pcam9'), x = 474.94, y = -992.076, z = 26.90, r = {x = -30.0, y = 0.0, z = 220.29}, canRotate = true},
			{label = _U('pcam10'), x = 475.4, y = -983.256, z = 26.50, r = {x = -30.0, y = 0.0, z = 220.29}, canRotate = true},
			{label = _U('pcam6'), x = 433.54, y = -978.100, z = 33.304, r = {x = -40.0, y = 0.0, z = 100.49}, canRotate = true},
			{label = _U('pcam7'), x = 449.520, y = -988.719, z = 33.00, r = {x = -30.0, y = 0.0, z = 50.50}, canRotate = true},
		},
	},

	["ambulance"] = {
		label = _U('ambulance'),
		Cameras = {
			{label = _U('acam'), x = 370.510, y = -575.329, z = 32.80, r = {x = -30.0, y = 0.0, z = 150.50}, canRotate = true},
			{label = _U('acam2'), x = 292.43, y = -566.519, z = 46.09, r = {x = -30.0, y = 0.0, z = 170.50}, canRotate = true},
			{label = _U('acam3'), x = 344.59, y = -594.359, z = 30.53, r = {x = -30.0, y = 0.0, z = 30.50}, canRotate = true},
			{label = _U('acam4'), x = 312.42, y = -546.159, z = 39.73, r = {x = -40.0, y = 0.0, z = -90.50}, canRotate = true},

		},
	},
}
