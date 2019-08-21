Config                            = {}

Config.DrawDistance               = 100.0

Config.Marker                     = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }

Config.ReviveReward               = 50 -- revive reward, set to 0 if you don't want it enabled
Config.AntiCombatLog              = true -- enable anti-combat logging?
Config.LoadIpl                    = false -- disable if you're using fivem-ipl or other IPL loaders

Config.Locale = 'en'

local second = 1000
local minute = 60 * second

Config.EarlyRespawnTimer          = 1 * minute  -- Time til respawn is available
Config.BleedoutTimer              = 15 * minute -- Time til the player bleeds out

Config.EnablePlayerManagement     = true

Config.RemoveWeaponsAfterRPDeath  = false
Config.RemoveCashAfterRPDeath     = false
Config.RemoveItemsAfterRPDeath    = false

Config.EnableMoneyWash            = true -- allow medics to wash black money

-- Let the player pay for respawning early, only if he can afford it.
Config.EarlyRespawnFine           = true
Config.EarlyRespawnFineAmount     = 1

Config.RespawnPoint = { coords = vector3(356.69, -567.15, 28.79), heading = 67.5 }

Config.Hospitals = {

	CentralLosSantos = {

		Blip = {
			coords = vector3(360.8, -590.96, 29.9),
			sprite = 61,
			scale  = 1.2,
			color  = 2
		},

		AmbulanceActions = {
			vector3(336.05, -580.0, 27.9)
		},

		BossActions = {
			vector3(327.15, -595.62, 28.00)
		},

		Pharmacies = {
			vector3(331.09, -580.48, 27.9)
		},

		Vehicles = {
			{
				Spawner = vector3(334.27, -560.99, 28.74),
				InsideShop = vector3(327.16, -548.1, 28.74),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 255, g = 0, b = 0, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(323.68, -547.94, 28.74), heading = 265.64, radius = 4.0 },
					{ coords = vector3(323.68, -547.94, 28.74), heading = 265.6, radius = 4.0 },
					{ coords = vector3(323.68, -547.94, 28.74), heading = 265.6, radius = 6.0 }
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(345.0, -579.38, 74.0),
				InsideShop = vector3(351.99, -587.37, 74.0),
				Marker = { type = 34, x = 1.5, y = 1.5, z = 1.5, r = 255, g = 0, b = 0, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(351.85, -588.01, 74.0), heading = 142.7, radius = 10.0 },
					{ coords = vector3(351.85, -588.02, 74.0), heading = 142.7, radius = 10.0 }
				}
			}
		},
 ---------------------------------------------Костыль телепорты-----------------------------------
		FastTravels = {
			-- ТЕЛЕПОРТЫ PILLBOX HILL
			-- тп на верхний этаж
			{
				From = vector3(340.46, -595.33, 27.59),
				To = { coords = vector3(322.3, -597.96, 43.29), heading = 70.0 },
				Marker = { type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},
-- тп на нижний этаж
			{
				From = vector3(324.99, -598.66, 42.25),
				To = { coords = vector3(337.16, -594.03, 28.79), heading = 352.0 },
				Marker = { type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},
-- тп на крышу
			{
				From = vector3(340.05, -592.75, 42.25),
				To = { coords = vector3(341.73, -585.18, 74.17), heading = 250.0 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},
-- тп с крыши вниз
			{
				From = vector3(339.33, -584.08, 73.20),
				To = { coords = vector3(337.94, -591.92, 43.28), heading = 62.0 },
				Marker = { type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},
-- ===========================================================================================================
-- Телепорты в Федеральной тюрьме
-- Вход внутрь
-- 			{
-- 				From = vector3(1690.84, 2591.98, 44.50),
-- 				To = { coords = vector3(1722.48, 2493.45, -78.02), heading = 359.0 },
-- 				Marker = { type = 1, x = 1.5, y = 1.5, z = 1.0, r = 102, g = 0, b = 102, a = 100, rotate = false }
-- 			},
-- -- Выход из тюрьмы
-- 			{
-- 				From = vector3(1722.48, 2491.86, -79.5),
-- 				To = { coords = vector3(1690.82, 2594.72, 45.5), heading = 356.0 },
-- 				Marker = { type = 1, x = 1.5, y = 1.5, z = 1.0, r = 102, g = 0, b = 102, a = 100, rotate = false }
-- 			},
-- Выход во двор из камер
			{
				From = vector3(1692.71, 2496.71, -79.5),
				To = { coords = vector3(1625.06, 2502.97, 45.52), heading = 302.0 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 1.0, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},
-- Вход в камеры из двора
			{
				From = vector3(1622.59, 2502.83, 44.50),
				To = { coords = vector3(1692.55, 2500.16, -79.5), heading = 270.0 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 1.0, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},
-- Выход на крышу (охранники)
--			{
-- 				From = vector3(1727.66, 2491.71, -79.5),
-- 				To = { coords = vector3(1625.06, 2502.97, 45.52), heading = 302.0 },
-- 				Marker = { type = 1, x = 1.5, y = 1.5, z = 1.0, r = 102, g = 0, b = 102, a = 100, rotate = false }
-- 			},
-- Спуск с крыши (охранники)
-- 			{
-- 				From = vector3(1622.59, 2502.83, 44.50),
-- 				To = { coords = vector3(1692.55, 2500.16, -79.5), heading = 270.0 },
-- 				Marker = { type = 1, x = 1.5, y = 1.5, z = 1.0, r = 102, g = 0, b = 102, a = 100, rotate = false }
-- 			},
-- Разное
			{
				From = vector3(254.2, -1372.4, 23.5),
				To = { coords = vector3(393.2, -1434.6, 28.8), heading = 0.0 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 1.0, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},

			{
				From = vector3(391.3, -1433.1, 28.5),
				To = { coords = vector3(252.2, -1370.8, 23.5), heading = 0.0 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 1.0, r = 102, g = 0, b = 102, a = 100, rotate = false }
			}
		},

		FastTravelsPrompt = {
			{
				From = vector3(237.4, -1373.8, 26.0),
				To = { coords = vector3(251.9, -1363.3, 38.5), heading = 0.0 },
				Marker = { type = 23, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false },
				Prompt = _U('fast_travel')
			},

			{
				From = vector3(256.5, -1357.7, 36.0),
				To = { coords = vector3(235.4, -1372.8, 26.3), heading = 0.0 },
				Marker = { type = 23, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false },
				Prompt = _U('fast_travel')
			}
		}

	}
}

Config.AuthorizedVehicles = {

	ambulance = {
		{ model = 'ambulance', label = 'Ambulance Van', price = 200}
	},

	doctor = {
		{ model = 'ambulance', label = 'Ambulance Van', price = 200}
	},

	chief_doctor = {
		{ model = 'ambulance', label = 'Ambulance Van', price = 200}
	},

	boss = {
		{ model = 'ambulance', label = 'Ambulance Van', price = 200}
	}

}

Config.AuthorizedHelicopters = {

	ambulance = {},

	doctor = {
		{ model = 'polmav', label = 'Медицинский Maverick', livery = 1, price = 200000 }
	},

	chief_doctor = {
		{ model = 'polmav', label = 'Медицинский Maverick', livery = 1, price = 200000 }
	},

	boss = {
		{ model = 'polmav', label = 'Медицинский Maverick', livery = 1, price = 200000 }
	}

}
