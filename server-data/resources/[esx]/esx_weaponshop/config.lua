Config               = {}

Config.DrawDistance  = 100
Config.Size          = { x = 1.5, y = 1.5, z = 0.5 }
Config.Color         = { r = 0, g = 128, b = 255 }
Config.Type          = 1

Config.Locale = 'en'

Config.LicenseEnable = false -- only turn this on if you are using esx_license
Config.LicensePrice  = 2000
Config.EnableClipGunShop		= true
Config.EnableClipBlackWeashop	= true

Config.EnableClip = {
	GunShop = {
		Price = 1000,
		Label = "Обойма"
	},
	BlackWeashop = {
		Price = 2000,
		Label = "Обойма"
	}
}

-- Config.Zones = {

-- 	GunShop = {
-- 		Legal = true,
-- 		Items = {},
-- 		Locations = {
-- 			vector3(-662.1, -935.3, 20.8),
-- 			vector3(810.2, -2157.3, 28.6),
-- 			vector3(1693.4, 3759.5, 33.7),
-- 			vector3(-330.2, 6083.8, 30.4),
-- 			vector3(252.3, -50.0, 68.9),
-- 			vector3(22.0, -1107.2, 28.8),
-- 			vector3(2567.6, 294.3, 107.7),
-- 			vector3(-1117.5, 2698.6, 17.5),
-- 			vector3(842.4, -1033.4, 27.1),
-- 			vector3(-1306.4, -394.01, 35.6)
-- 		}
-- 	},

-- 	BlackWeashop = {
-- 		Legal = false,
-- 		Items = {},
-- 		Locations = {
-- 			vector3(722.93, 4190.25, 40.09)
-- 		}
-- 	}

-- }

Config.Zones = {

	GunShop = {
			legal = 0,
			Items = {},
			Pos   = {
					{ x = -662.180,   y = -934.961,   z = 20.829 },
					{ x = 810.25,     y = -2157.60,   z = 28.62 },
					{ x = 1693.44,    y = 3760.16,    z = 33.71 },
					{ x = -330.24,    y = 6083.88,    z = 30.45 },
					{ x = 252.63,     y = -50.00,     z = 68.94 },
					{ x = 22.09,      y = -1107.28,   z = 28.80 },
					{ x = 2567.69,    y = 294.38,     z = 107.73 },
					{ x = -1117.58,   y = 2698.61,    z = 17.55 },
					{ x = 842.44,     y = -1033.42,   z = 27.19 },
					{ x = -1306.239,   y = -394.018,  z = 35.695 },

			}
	},

	BlackWeashop = {
			legal = 1,
			Items = {},
			Pos   = {
					{ x = 722.9,   y = 4190.25,  z = 40.09 },
			}
	},

}
