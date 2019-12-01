Config              = {}
Config.MarkerType   = 1 -- Marker visible or not. -1 = hiden  Set to 1 for a visible marker. To have a list of avaible marker go to https://docs.fivem.net/game-references/markers/
Config.DrawDistance = 100.0 --Distance where the marker be visible from
Config.ZoneSize     = {x = 2.0, y = 2.0, z = 1.0} -- Size of the marker
Config.MarkerColor  = {r = 0, g = 255, b = 0} --Color of the marker

Config.RequiredCopsCoke  = 0 --Ammount of cop that need to be online to be able to harvest/process/sell coke
Config.RequiredCopsMeth  = 0 --Ammount of cop that need to be online to be able to harvest/process/sell meth
Config.RequiredCopsWeed  = 0 --Ammount of cop that need to be online to be able to harvest/process/sell weed
Config.RequiredCopsOpium = 0 --Ammount of cop that need to be online to be able to harvest/process/sell opium

Config.TimeToFarmWeed     = 2  * 1000 -- Ammount of time to harvest weed
Config.TimeToProcessWeed  = 4  * 1000 -- Ammount of time to process weed
Config.TimeToSellWeed     = 1  * 1000 -- Ammount of time to sell weed

Config.TimeToFarmOpium    = 4  * 1000 -- Ammount of time to harvest coke
Config.TimeToProcessOpium = 6  * 1000 -- Ammount of time to process coke
Config.TimeToSellOpium    = 1  * 1000 -- Ammount of time to sell coke

Config.TimeToFarmCoke     = 6  * 1000 -- Ammount of time to harvest coke
Config.TimeToProcessCoke  = 8  * 1000 -- Ammount of time to process coke
Config.TimeToSellCoke     = 1  * 1000 -- Ammount of time to sell coke

Config.TimeToFarmMeth     = 8  * 1000 -- Ammount of time to harvest meth
Config.TimeToProcessMeth  = 10 * 1000 -- Ammount of time to process meth
Config.TimeToSellMeth     = 1  * 1000 -- Ammount of time to sell meth

Config.Locale = 'en'

Config.Zones = {
	CokeField = {
		x=901.11, y=-959.37, z=38.28,
		MarkerColor  = {r = 230, g = 187, b = 0},
	},
	CokeProcessing = {
		x=-332.14, y=-2444.37, z=6.36,
		MarkerColor  = {r = 117, g = 230, b = 0},
	},
	CokeDealer = {
		x=3373.087, y= 5183.625, z=0.463,
		MarkerColor  = {r = 0, g = 255, b = 0},
	},
	MethField = {
		x=1950.61,  y=5178.73,  z=46.98,
		MarkerColor  = {r = 230, g = 187, b = 0},
	},
	MethProcessing = {
		x=-1368.72,  y=-317.69,  z=38.52,
		MarkerColor  = {r = 117, g = 230, b = 0},
	},
	MethDealer = {
		x=1339.66,     y=4225.28,   z=32.92,
		MarkerColor  = {r = 0, g = 255, b = 0},
	},
	WeedField = {
		x=1057.448,  y=-3196.996,  z=-39.938,
		MarkerColor  = {r = 230, g = 187, b = 0},
	},
	WeedProcessing = {
		x=1037.297,  y=-3204.968,  z=-38.87,
		MarkerColor  = {r = 117, g = 230, b = 0},
	},
	WeedDealer = {
		x = -283.68,   y= 6628.26,  z= 6.13,
		MarkerColor  = {r = 0, g = 255, b = 0},
	},
	OpiumField = {
		x=2433.804,  y=4969.196,   z=41.358,
		MarkerColor  = {r = 230, g = 187, b = 0},
	},
	OpiumProcessing = {
		x=2434.43,   y=4964.18,    z=41.348,
		MarkerColor  = {r = 117, g = 230, b = 0},
	},
	OpiumDealer = {
		x=-96.18, y=-2768.18,   z=5.08,
		MarkerColor  = {r = 0, g = 255, b = 0},
	},
	-- ScrapField = {
	-- 	x=-585.55, y=-1659.78,   z=18.36,
	-- 	MarkerColor  = {r = 0, g = 255, b = 0},
	-- },
}

Config.DisableBlip = true -- Set to true to disable blips. False to enable them.
Config.Map = {

  {name="Coke Farm Entrance",    color=4, scale=0.8, id=501, x=47.842,     y=3701.961,   z=40.722},
  {name="Coke Farm",             color=4, scale=0.8, id=501, x=1093.139,   y=-3195.673,  z=-39.131},
  {name="Coke Processing",       color=4, scale=0.8, id=501, x=1101.837,   y=-3193.732,  z=-38.993},
  {name="Coke Sales",            color=3, scale=0.8, id=501, x=959.117,    y=-121.055,   z=74.963},
  {name="Meth Farm Entrance",    color=6, scale=0.8, id=499, x=1386.659,   y=3622.805,   z=35.012},
  {name="Meth Farm",             color=6, scale=0.8, id=499, x=1005.721,   y=-3200.301,  z=-38.519},
  {name="Meth Processing",       color=6, scale=0.8, id=499, x=1014.878,   y=-3194.871,  z=-38.993},
  {name="Meth Sales",            color=3, scale=0.8, id=499, x=7.981,      y=6469.067,   z=31.528},
  {name="Opium Farm Entrance",   color=6, scale=0.8, id=403, x=2433.804,   y=4969.196,   z=43.358},
  {name="Opium Farm",            color=6, scale=0.8, id=403, x=2433.804,   y=4969.196,   z=43.358},
  {name="Opium Processing",      color=6, scale=0.8, id=403, x=2434.43,    y=4964.18,    z=42.348},
  {name="Opium Sales",           color=3, scale=0.8, id=403, x=-3155.608,  y=1125.368,   z=20.858},
  {name="Weed Farm Entrance",    color=2, scale=0.8, id=140, x=930.79,   y=-1546.99,    z=30.85},
  {name="Weed Farm",             color=2, scale=0.8, id=140, x=1057.448,   y=-3197.646,  z=-39.138},
  {name="Weed Processing",       color=2, scale=0.8, id=140, x=1037.527,   y=-3205.368,  z=-38.17},
  {name="Weed Sales",            color=3, scale=0.8, id=140, x=85.58,      y=-1959.34,   z=20.13}

}
