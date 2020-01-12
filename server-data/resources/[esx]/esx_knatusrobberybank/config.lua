Config = {}
Config.Locale = 'en'
Config.NumberOfCopsRequired = 3
Config.TimeToHack = 100
Config.TimeToPlantBomb = 20
Config.TimeToBlowtorch = 120
Config.TimeBetweenRobs = 600

Banks = {
	["fleeca"] = {
		position = { ['x'] = 148.91908752441, ['y'] = -1050.7448242188, ['z'] = 29.36802482605 }, -- position of robbery, when you have tu use the item "blowtorch"
		hackposition = { ['x'] = 147.04908752441, ['y'] = -1044.9448242188, ['z'] = 29.36802482605 }, -- position where you have to do hack with the minigame to open a door
		--hackteleport = { ['x'] = 148.79908752441, ['y'] = -1045.5748242188, ['z'] = 29.36802482605 }, -- ignore this
		reward = math.random(15000,25000), -- the random range of amount of money you will get for robbery this site
		nameofbank = "Fleeca Bank", --Visual Name that will be the site
		doortype = 'V_ILEV_GB_VAULDR' -- Name or ID of the gameobject that will be rotate to make the open efect, you can check what id or name you need here: https://objects.gt-mp.net/ if you dont find it, contact with you developer, he will know how to get it in game
	},
	["fleeca2"] = {
		position = { ['x'] = -2954.2874804688, ['y'] = 486.14476367188, ['z'] = 15.697026252747 },
		hackposition = { ['x'] = -2957.6674804688, ['y'] = 481.45776367188, ['z'] = 15.697026252747 },

		reward = math.random(15000,25000),
		nameofbank = "Fleeca Bank (Highway)",
		doortype = 'hei_prop_heist_sec_door'
	},
	["fleeca3"] = {
		position = { ['x'] = 312.64, ['y'] = -288.35, ['z'] = 54.17 },
		hackposition = { ['x'] = 310.99, ['y'] = -283.13, ['z'] = 54.17 },

		reward = math.random(15000,25000),
		nameofbank = "Сейф (Fleeca Meteor st.)",
		doortype = 'V_ILEV_GB_VAULDR'
	},
	["fleeca4"] = {
		position = { ['x'] = -352.4974804688, ['y'] = -59.4576367188, ['z'] = 49.057026252747 },
		hackposition = { ['x'] = -354.01, ['y'] = -53.95, ['z'] = 49.05 },

		reward = math.random(15000,25000),
		nameofbank = "Сейф (Fleeca Hevick ave.)",
		doortype = 'V_ILEV_GB_VAULDR'
	},
	["fleeca5"] = {
		position = { ['x'] = 1173.22, ['y'] = 2716.29, ['z'] = 38.1 },
		hackposition = { ['x'] = 1176.85, ['y'] = 2711.77, ['z'] = 38.1 },

		reward = math.random(15000,25000),
		nameofbank = "Сейф (Fleeca Grand Senora.)",
		doortype = 'V_ILEV_GB_VAULDR'
	},
	["fleeca6"] = {
		position = { ['x'] = -1206.6, ['y'] = -338.09, ['z'] = 37.76 },
		hackposition = { ['x'] = -1211.62, ['y'] = -335.71, ['z'] = 37.79 },

		reward = math.random(15000,25000),
		nameofbank = "Сейф (Fleeca Grand Senora.)",
		doortype = 'V_ILEV_GB_VAULDR'
	},
	["blainecounty"] = {
		position = { ['x'] = -103.6905584717, ['y'] = 6477.7912695313, ['z'] = 31.62670135498 },
		hackposition = { ['x'] = -105.42505584717, ['y'] = 6471.7512695313, ['z'] = 31.62670135498 },
		reward = math.random(15000,25000),
		nameofbank = "Blaine County Savings",
		doortype = 'v_ilev_cbankvaulgate01',
		doorid = 'bank_blane_vault',
	},
	["Pacific Standard"] = {
		position = { ['x'] = 264.99899291992, ['y'] = 213.50576782227, ['z'] = 101.68346405029 },
		hackposition = { ['x'] = 261.49499291992, ['y'] = 223.06776782227, ['z'] = 106.28346405029 },
		bombposition = { ['x'] = 254.12199291992, ['y'] = 225.50576782227, ['z'] = 101.87346405029 }, -- if this var is set will appear a site to plant a bomb which will open the door defined at var "bombdoortype"
		reward = math.random(150000,350000),
		nameofbank = "Pacific Standard",
	        bombdoortype = 'v_ilev_bk_vaultdoor', -- If this var is set you will need set the var "bombposition" to work properly , you can find the name or id here: https://objects.gt-mp.net/  if you dont find it, contact with your devs
	        doortype = 'hei_v_ilev_bk_gate2_pris',
		doorid = 'bank_pacific_vault',
    },

}
