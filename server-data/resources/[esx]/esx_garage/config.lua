Config                      = {}
Config.DrawDistance         = 100.0
Config.MarkerType           = 1
Config.MarkerSize           = {x = 2.0, y = 2.0, z = 1.0}
Config.MarkerColor          = {r = 25, g = 25, b = 112}
Config.ParkingMarkerSize    = {x = 3.0, y = 3.0, z = 2.0}
Config.ParkingMarkerColor   = {r = 102, g = 102, b = 204}
Config.ZDiff                = 0.5
Config.EnableOwnedVehicles  = true
Config.MinimumHealthPercent = 0

Config.Locale = 'en'

Config.Zones = {}

Config.Garages = {

	MiltonDrive = {

		IsClosed = true,
		NeedProperty = 'MiltonDrive',

		ExteriorEntryPoint = {
			Pos = {x= -796.542, y = 318.137, z = 84.673},
		},

		ExteriorSpawnPoint = {
			Pos     = {x = -796.501, y = 302.271, z = 85.000},
			Heading = 180.0
		},

		InteriorSpawnPoint = {
			Pos     = {x = 228.930, y = -1000.698, z = -100.000},
			Heading = 0.0
		},

		InteriorExitPoint = {
			Pos = {x = 224.613, y = -1004.769, z = -100.000},
		},

		Parkings = {
			{
				Pos     = {x = 224.500, y = -998.695, z = -100.000},
				Heading = 225.0
			},
			{
				Pos     = {x = 224.500, y = -994.630, z = -100.000},
				Heading = 225.0
			},
			{
				Pos     = {x = 224.500, y = -990.255, z = -100.000},
				Heading = 225.0
			},
			{
				Pos     = {x = 224.500, y = -986.628, z = -100.000},
				Heading = 225.0
			},
			{
				Pos     = {x = 224.500, y = -982.496, z = -100.000},
				Heading = 225.0
			},
			{
				Pos     = {x = 232.500, y = -982.496, z = -100.000},
				Heading = 135.0
			},
			{
				Pos     = {x = 232.500, y = -986.628, z = -100.000},
				Heading = 135.0
			},
			{
				Pos     = {x = 232.500, y = -990.255, z = -100.000},
				Heading = 135.0
			},
			{
				Pos     = {x = 232.500, y = -994.630, z = -100.000},
				Heading = 135.0
			},
			{
				Pos     = {x = 232.500, y = -998.695, z = -100.000},
				Heading = 135.0
			},
		}

	},

	IntegrityWay = {

		IsClosed = true,

		ExteriorEntryPoint = {
			Pos = {x= -37.01, y = -702.82, z = 31.34},
		},

		ExteriorSpawnPoint = {
			Pos     = {x = -34.79, y = -697.73, z = 32.34},
			Heading = 350.42
		},

		InteriorSpawnPoint = {
			Pos     = {x = 228.930, y = -1000.698, z = -100.000},
			Heading = 0.0
		},

		InteriorExitPoint = {
			Pos = {x = 224.613, y = -1004.769, z = -100.000},
		},

		Parkings = {
			{
				Pos     = {x = 224.500, y = -998.695, z = -100.000},
				Heading = 225.0
			},
			{
				Pos     = {x = 224.500, y = -994.630, z = -100.000},
				Heading = 225.0
			},
			{
				Pos     = {x = 224.500, y = -990.255, z = -100.000},
				Heading = 225.0
			},
			{
				Pos     = {x = 224.500, y = -986.628, z = -100.000},
				Heading = 225.0
			},
			{
				Pos     = {x = 224.500, y = -982.496, z = -100.000},
				Heading = 225.0
			},
			{
				Pos     = {x = 232.500, y = -982.496, z = -100.000},
				Heading = 135.0
			},
			{
				Pos     = {x = 232.500, y = -986.628, z = -100.000},
				Heading = 135.0
			},
			{
				Pos     = {x = 232.500, y = -990.255, z = -100.000},
				Heading = 135.0
			},
			{
				Pos     = {x = 232.500, y = -994.630, z = -100.000},
				Heading = 135.0
			},
			{
				Pos     = {x = 232.500, y = -998.695, z = -100.000},
				Heading = 135.0
			},
		}

	},

	DidionWay = {

		IsClosed = true,

		ExteriorEntryPoint = {
			Pos = {x= -259.88, y = 395.19, z = 109.02},
		},

		ExteriorSpawnPoint = {
			Pos     = {x = -259.82, y = 397.33, z = 109.01},
			Heading = 12.15
		},

		InteriorSpawnPoint = {
			Pos     = {x = 202.27, y = -1004.1, z =-100.00},
			Heading = 0.0
		},

		InteriorExitPoint = {
			Pos = {x = 196.69, y = -1006.26, z = -100.000},
		},

		Parkings = {
			{
				Pos     = {x = 193.06, y = -995.95, z = -100.000},
				Heading = 225.0
			},
			{
				Pos     = {x = 192.61, y = -1000.16, z = -100.000},
				Heading = 225.0
			},
			{
				Pos     = {x = 192.06, y = -1003.64, z = -100.000},
				Heading = 225.0
			},
			{
				Pos     = {x = 205.85, y = -1002.17, z = -100.000},
				Heading = 105.0
			},
			{
				Pos     = {x =201.98, y = -996.98, z = -100.000},
				Heading = 175.0
			},
			{
				Pos     = {x = 198.33, y = -996.42, z = -100.000},
				Heading = 175.0
			},
		}

	},

	Police = {

		IsClosed = true,
		NeedJob = 'police',

		ExteriorEntryPoint = {
			Pos = {x= 452.5, y = -1009.26, z = 27.0},
		},

		ExteriorSpawnPoint = {
			Pos     = {x = 435.26, y = -1007.67, z = 27.72},
			Heading = 179.29
		},

		InteriorSpawnPoint = {
			Pos     = {x = 228.930, y = -1000.698, z = -100.000},
			Heading = 0.0
		},

		InteriorExitPoint = {
			Pos = {x = 224.613, y = -1004.769, z = -100.000},
		},

		Parkings = {
			{
				Pos     = {x = 224.500, y = -998.695, z = -100.000},
				Heading = 225.0
			},
			{
				Pos     = {x = 224.500, y = -994.630, z = -100.000},
				Heading = 225.0
			},
			{
				Pos     = {x = 224.500, y = -990.255, z = -100.000},
				Heading = 225.0
			},
			{
				Pos     = {x = 224.500, y = -986.628, z = -100.000},
				Heading = 225.0
			},
			{
				Pos     = {x = 224.500, y = -982.496, z = -100.000},
				Heading = 225.0
			},
			{
				Pos     = {x = 232.500, y = -982.496, z = -100.000},
				Heading = 135.0
			},
			{
				Pos     = {x = 232.500, y = -986.628, z = -100.000},
				Heading = 135.0
			},
			{
				Pos     = {x = 232.500, y = -990.255, z = -100.000},
				Heading = 135.0
			},
			{
				Pos     = {x = 232.500, y = -994.630, z = -100.000},
				Heading = 135.0
			},
			{
				Pos     = {x = 232.500, y = -998.695, z = -100.000},
				Heading = 135.0
			},
		}

	},

	ImaginationCt265 = {

		IsClosed = true,

		ExteriorEntryPoint = {
			Pos = {x=-1129.65, y = -1072.38, z = 1.15},
		},

		ExteriorSpawnPoint = {
			Pos     = {x = -1126.48, y =-1069.065, z =1.1},
			Heading = 15.87
		},

		InteriorSpawnPoint = {
			Pos     = {x = 174.11, y = -1007.15, z = -100.000},
			Heading = 0.0
		},

		InteriorExitPoint = {
			Pos = {x = 171.71, y = -1007.4, z = -100.000},
		},

		Parkings = {
			{
				Pos     = {x = 176.07, y = -1001.51, z = -100.000},
				Heading = 173.03
			},
			{
				Pos     = {x = 170.73, y = -1002.39, z = -100.000},
				Heading = 173.03
			},
		}

	},

	SteeleWay1150 = {

		IsClosed = true,

		ExteriorEntryPoint = {
			Pos = {x= -924.81, y = 211.54, z = 66.46},
		},

		ExteriorSpawnPoint = {
			Pos     = {x =-931.5, y = 210.98, z = 66.46},
			Heading = 12.15
		},

		InteriorSpawnPoint = {
			Pos     = {x = 202.27, y = -1004.1, z =-100.00},
			Heading = 0.0
		},

		InteriorExitPoint = {
			Pos = {x = 196.69, y = -1006.26, z = -100.000},
		},

		Parkings = {
			{
				Pos     = {x = 193.06, y = -995.95, z = -100.000},
				Heading = 225.0
			},
			{
				Pos     = {x = 192.61, y = -1000.16, z = -100.000},
				Heading = 225.0
			},
			{
				Pos     = {x = 192.06, y = -1003.64, z = -100.000},
				Heading = 225.0
			},
			{
				Pos     = {x = 205.85, y = -1002.17, z = -100.000},
				Heading = 105.0
			},
			{
				Pos     = {x =201.98, y = -996.98, z = -100.000},
				Heading = 175.0
			},
			{
				Pos     = {x = 198.33, y = -996.42, z = -100.000},
				Heading = 175.0
			},
		}

	},

	Ambulance = {

		IsClosed = true,
		NeedJob = 'ambulance',

		ExteriorEntryPoint = {
			Pos = {x= 340.67, y = -562.26, z = 27.5},
		},

		ExteriorSpawnPoint = {
			Pos     = {x = 343.84, y = -554.16, z = 28.72},
			Heading = 322.00
		},

		InteriorSpawnPoint = {
			Pos     = {x = 228.930, y = -1000.698, z = -100.000},
			Heading = 0.0
		},

		InteriorExitPoint = {
			Pos = {x = 224.613, y = -1004.769, z = -100.000},
		},

		Parkings = {
			{
				Pos     = {x = 224.500, y = -998.695, z = -100.000},
				Heading = 225.0
			},
			{
				Pos     = {x = 224.500, y = -994.630, z = -100.000},
				Heading = 225.0
			},
			{
				Pos     = {x = 224.500, y = -990.255, z = -100.000},
				Heading = 225.0
			},
			{
				Pos     = {x = 224.500, y = -986.628, z = -100.000},
				Heading = 225.0
			},
			{
				Pos     = {x = 224.500, y = -982.496, z = -100.000},
				Heading = 225.0
			},
			{
				Pos     = {x = 232.500, y = -982.496, z = -100.000},
				Heading = 135.0
			},
			{
				Pos     = {x = 232.500, y = -986.628, z = -100.000},
				Heading = 135.0
			},
			{
				Pos     = {x = 232.500, y = -990.255, z = -100.000},
				Heading = 135.0
			},
			{
				Pos     = {x = 232.500, y = -994.630, z = -100.000},
				Heading = 135.0
			},
			{
				Pos     = {x = 232.500, y = -998.695, z = -100.000},
				Heading = 135.0
			},
		}

	},

}
