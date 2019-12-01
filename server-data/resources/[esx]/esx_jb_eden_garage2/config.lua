Config = {}
Config.Blip			= {sprite= 290, color = 30}
Config.MecanoBlip	= {sprite= 290, color = 20}
Config.Price		= 50

Config.StoreOnServerStart = true -- Store all vehicles in garage on server start?

-- Центральная

Config.Garages = {
	Garage_Centre = {
		Pos = {x=216.800, y=-810.057, z=30.74},
		Distance = 2.5,
		Marker = {t=36, w= 1.0, h= 1.0,r = 255, g = 224, b = 0},
		Name = 'Гараж',
		HelpPrompt = "Нажмите ~INPUT_PICKUP~ чтобы открыть гараж",
		SpawnPoint = {
			Pos = {x=229.700, y= -800.1149, z= 30.58},
			Distance = 2.5,
			Heading = 160.0,
			Marker = {t=36, w= 1.0, h= 1.0,r=60,g=255,b=0},
			HelpPrompt = "Нажмите ~INPUT_PICKUP~ чтобы выгнать транспорт",
		},
		DeletePoint = {
			Pos = {x=215.124, y=-791.377, z=30.78},
			Distance = 2.5,
			Marker = {t=36, w= 1.0, h= 1.0,r=255,g=60,b=0},
			HelpPrompt = "Нажмите ~INPUT_PICKUP~ чтобы припарковать транспорт",
		},
	},

--  2я центральная

	Garage_Centre2 = {
		Pos = {x = -1229.431,y = -662.517,z = 25.896},
		Distance = 2.5,
		Marker = {t=36, w= 1.0, h= 1.0,r = 255, g = 224, b = 0},
		Name = 'Гараж',
		HelpPrompt = "Нажмите ~INPUT_PICKUP~ чтобы открыть гараж",
		SpawnPoint = {
			Pos = {x = -1220.64,y = -654.36,z = 25.942},
			Distance = 2.5,
			Heading = 160.0,
			Marker = {t=36, w= 1.0, h= 1.0,r=60,g=255,b=0},
			HelpPrompt = "Нажмите ~INPUT_PICKUP~ чтобы выгнать транспорт",
		},
		DeletePoint = {
			Pos = {x = -1233.722,y = -654.880,z = 25.942},
			Distance = 2.5,
			Marker = {t=36, w= 1.0, h= 1.0,r=255,g=60,b=0},
			HelpPrompt = "Нажмите ~INPUT_PICKUP~ чтобы припарковать транспорт",
		},
	},


	Garage_Paleto = {
		Pos = {x=90.769, y=6363.176, z=31.2373},
		Distance = 2.5,
		Marker = {t=36, w= 1.0, h= 1.0,r = 254, g = 224, b = 0},
		Name = 'Гараж',
		HelpPrompt = "Нажмите ~INPUT_PICKUP~ чтобы открыть гараж",
		SpawnPoint = {
			Pos = {x=109.12322, y= 6380.6765, z= 31.2328},
			Distance = 2.5,
			Heading = 160.0,
			Marker = {t=36, w= 1.0, h= 1.0,r=60,g=255,b=0},
			HelpPrompt = "Нажмите ~INPUT_PICKUP~ чтобы выгнать транспорт",
		},
		DeletePoint = {
			Pos = {x=77.082, y=6384.5410, z=31.2365},
			Distance = 2.5,
			Marker = {t=36, w= 1.0, h= 1.0,r=255,g=60,b=0},
			HelpPrompt = "Нажмите ~INPUT_PICKUP~ чтобы припарковать транспорт",
		},
	},

	Garage_SandyShore = {
		Pos = {x=1643.419, y=3808.156, z=35.1173},
		Distance = 2.5,
		Marker = {t=36, w= 1.0, h= 1.0,r = 254, g = 224, b = 0},
		Name = 'Гараж',
		HelpPrompt = "Нажмите ~INPUT_PICKUP~ чтобы открыть гараж",
		SpawnPoint = {
			Pos = {x=1638.53322, y= 3795.6265, z= 34.8128},
			Distance = 2.5,
			Heading = 160.0,
			Marker = {t=36, w= 1.0, h= 1.0,r=60,g=255,b=0},
			HelpPrompt = "Нажмите ~INPUT_PICKUP~ чтобы выгнать транспорт",
		},
		DeletePoint = {
			Pos = {x=1626.472, y=3786.1710, z=34.6965},
			Distance = 2.5,
			Marker = {t=36, w= 1.0, h= 1.0,r=255,g=60,b=0},
			HelpPrompt = "Нажмите ~INPUT_PICKUP~ чтобы припарковать транспорт",
		},
	},

-- Форум драйв

	Garage_FotumDrive = {
		Pos = {x=-25.42, y=-1427.94, z=29.70},
		Distance = 2.5,
		Marker = {t=23, w= 1.0, h= 1.0,r = 254, g = 224, b = 0},
		-- Name = 'Гараж',
		HelpPrompt = "Нажмите ~INPUT_PICKUP~ чтобы открыть гараж",
		SpawnPoint = {
			Pos = {x=-24.3, y=-1439.04, z=29.70},
			Distance = 2.5,
			Heading = 160.0,
			Marker = {t=23, w= 1.0, h= 1.0,r=60,g=255,b=0},
			HelpPrompt = "Нажмите ~INPUT_PICKUP~ чтобы выгнать транспорт",
		},
		DeletePoint = {
			Pos = {x=-24.24, y=-1434.79, z=29.70},
			Distance = 2.5,
			Marker = {t=23, w= 1.0, h= 1.0,r=255,g=60,b=0},
			HelpPrompt = "Нажмите ~INPUT_PICKUP~ чтобы припарковать транспорт",
		},
	},

-- Пляж

Garage_Beatch = {
	Pos = {x=-1151.44, y=-1519.75, z=3.40},
	Distance = 2.5,
	Marker = {t=23, w= 1.0, h= 1.0,r = 254, g = 224, b = 0},
	-- Name = 'Гараж',
	HelpPrompt = "Нажмите ~INPUT_PICKUP~ чтобы открыть гараж",
	SpawnPoint = {
		Pos = {x=-1153.7, y=-1526.23, z=3.30},
		Distance = 2.5,
		Heading = 160.0,
		Marker = {t=23, w= 1.0, h= 1.0,r=60,g=255,b=0},
		HelpPrompt = "Нажмите ~INPUT_PICKUP~ чтобы выгнать транспорт",
	},
	DeletePoint = {
		Pos = {x=-1158.1, y=-1529.36, z=3.30},
		Distance = 2.5,
		Marker = {t=23, w= 1.0, h= 1.0,r=255,g=60,b=0},
		HelpPrompt = "Нажмите ~INPUT_PICKUP~ чтобы припарковать транспорт",
	},
},

-- Гараж Вайнвуд Франклин

Garage_VinewoodFrank = {
	Pos = {x=22.6, y=544.38, z=175.10},
	Distance = 2.5,
	Marker = {t=23, w= 1.0, h= 1.0,r = 254, g = 224, b = 0},
	-- Name = 'Гараж',
	HelpPrompt = "Нажмите ~INPUT_PICKUP~ чтобы открыть гараж",
	SpawnPoint = {
		Pos = {x=12.09, y=546.54, z=174.98},
		Distance = 2.5,
		Heading = 160.0,
		Marker = {t=23, w= 1.0, h= 1.0,r=60,g=255,b=0},
		HelpPrompt = "Нажмите ~INPUT_PICKUP~ чтобы выгнать транспорт",
	},
	DeletePoint = {
		Pos = {x=15.99, y=551.11, z=175.60},
		Distance = 2.5,
		Marker = {t=23, w= 1.0, h= 1.0,r=255,g=60,b=0},
		HelpPrompt = "Нажмите ~INPUT_PICKUP~ чтобы припарковать транспорт",
	},
},

-- Гараж ЛАс Лагунас

Garage_Lagoonas = {
	Pos = {x=-85.95, y=-28.57, z=65.38},
	Distance = 2.5,
	Marker = {t=23, w= 1.0, h= 1.0,r = 254, g = 224, b = 0},
	-- Name = 'Гараж',
	HelpPrompt = "Нажмите ~INPUT_PICKUP~ чтобы открыть гараж",
	SpawnPoint = {
		Pos = {x=-77.18, y=-24.85, z=65.20},
		Distance = 2.5,
		Heading = 160.0,
		Marker = {t=23, w= 1.0, h= 1.0,r=60,g=255,b=0},
		HelpPrompt = "Нажмите ~INPUT_PICKUP~ чтобы выгнать транспорт",
	},
	DeletePoint = {
		Pos = {x=-77.51, y=-31.39, z=64.40},
		Distance = 2.5,
		Marker = {t=23, w= 1.0, h= 1.0,r=255,g=60,b=0},
		HelpPrompt = "Нажмите ~INPUT_PICKUP~ чтобы припарковать транспорт",
	},
},

-- Гараж Тревор

Garage_Trevor = {
		Pos = {x=1985.53, y=3823.16, z=31.40},
		Distance = 2.5,
		Marker = {t=23, w= 1.0, h= 1.0,r = 254, g = 224, b = 0},
		-- Name = 'Гараж',
		HelpPrompt = "Нажмите ~INPUT_PICKUP~ чтобы открыть гараж",
		SpawnPoint = {
			Pos = {x=1985.4, y=3831.25, z=31.50},
			Distance = 2.5,
			Heading = 160.0,
			Marker = {t=23, w= 1.0, h= 1.0,r=60,g=255,b=0},
			HelpPrompt = "Нажмите ~INPUT_PICKUP~ чтобы выгнать транспорт",
		},
		DeletePoint = {
			Pos = {x=1977.72, y=3827.42, z=31.42},
			Distance = 2.5,
			Marker = {t=23, w= 1.0, h= 1.0,r=255,g=60,b=0},
			HelpPrompt = "Нажмите ~INPUT_PICKUP~ чтобы припарковать транспорт",
		},
	},

-- Гараж Майкла

	Garage_Trevor = {
		Pos = {x=-811.72, y=187.61, z=71.52},
		Distance = 2.5,
		Marker = {t=23, w= 1.0, h= 1.0,r = 254, g = 224, b = 0},
		-- Name = 'Гараж',
		HelpPrompt = "Нажмите ~INPUT_PICKUP~ чтобы открыть гараж",
		SpawnPoint = {
			Pos = {x=-827.62, y=176.91, z=70.15},
			Distance = 2.5,
			Heading = 160.0,
			Marker = {t=23, w= 1.0, h= 1.0,r=60,g=255,b=0},
			HelpPrompt = "Нажмите ~INPUT_PICKUP~ чтобы выгнать транспорт",
		},
		DeletePoint = {
			Pos = {x=-820.9, y=184.1, z=71.12},
			Distance = 2.5,
			Marker = {t=23, w= 1.0, h= 1.0,r=255,g=60,b=0},
			HelpPrompt = "Нажмите ~INPUT_PICKUP~ чтобы припарковать транспорт",
		},
	},

-- Гараж LESTER

Garage_Trevor = {
	Pos = {x=1283.58, y=-1721.01, z=53.70},
	Distance = 2.5,
	Marker = {t=23, w= 1.0, h= 1.0,r = 254, g = 224, b = 0},
	-- Name = 'Гараж',
	HelpPrompt = "Нажмите ~INPUT_PICKUP~ чтобы открыть гараж",
	SpawnPoint = {
		Pos = {x=1274.49, y=-1736.09, z=50.86},
		Distance = 2.5,
		Heading = 51.83,
		Marker = {t=23, w= 1.0, h= 1.0,r=60,g=255,b=0},
		HelpPrompt = "Нажмите ~INPUT_PICKUP~ чтобы выгнать транспорт",
	},
	DeletePoint = {
		Pos = {x=1272.95, y=-1733.15, z=50.86},
		Distance = 2.5,
		Marker = {t=23, w= 1.0, h= 1.0,r=255,g=60,b=0},
		HelpPrompt = "Нажмите ~INPUT_PICKUP~ чтобы припарковать транспорт",
	},
},

-- Гараж Текилла

	-- Garage_tequila = {
	-- 	Pos = {x = -570.92272949219,y = 313.41049194336,z = 84.493560791016 },
	-- 	Marker = {t=1, w= 1.5, h= 1.0,r = 204, g = 204, b = 0},
	-- 	Name = 'Гараж',
	-- 	HelpPrompt = "Нажмите ~INPUT_PICKUP~ чтобы открыть гараж",
	-- 	SpawnPoint = {
	-- 		Pos = {x = -569.47564697266,y = 323.53549194336,z = 84.474433898926 },
	-- 		Heading = 22.52,
	-- 		Marker = {t=1, w= 1.5, h= 1.0,r=0,g=255,b=0},
	-- 		HelpPrompt = "Нажмите ~INPUT_PICKUP~ чтобы выгнать транспорт",
	-- 	},
	-- 	DeletePoint = {
	-- 		Pos = {x = -560.84375,y = 322.41586303711,z = 84.402587890625 },
	-- 		Marker = {t=1, w= 1.5, h= 1.0,r=255,g=0,b=0},
	-- 		HelpPrompt = "Нажмите ~INPUT_PICKUP~ чтобы припарковать транспорт",
	-- 	},
	-- },

--  Гараж сзади банка

	-- Garage_banque = {
	-- 	Pos = {x = 363.48370361328,y = 296.83682250977,z = 103.50011444092 },
	-- 	Marker = {t=1, w= 1.5, h= 1.0,r = 204, g = 204, b = 0},
	-- 	Name = 'Гараж',
	-- 	HelpPrompt = "Нажмите ~INPUT_PICKUP~ чтобы открыть гараж",
	-- 	SpawnPoint = {
	-- 		Pos = {x = 378.00622558594,y = 288.13024902344,z = 103.1661529541 },
	-- 		Heading = 62.22,
	-- 		Marker = {t=1, w= 1.5, h= 1.0,r=0,g=255,b=0},
	-- 		HelpPrompt = "Нажмите ~INPUT_PICKUP~ чтобы выгнать транспорт",
	-- 	},
	-- 	DeletePoint = {
	-- 		Pos = {x = 364.76132202148,y = 285.18911743164,z = 103.37410736084 },
	-- 		Marker = {t=1, w= 1.5, h= 1.0,r=255,g=0,b=0},
	-- 		HelpPrompt = "Нажмите ~INPUT_PICKUP~ чтобы припарковать транспорт",
	-- 	},
	-- },

	-- Гарраж Миррор Парк

	-- Garage_mirrorpark = {
	-- 	Pos = {x = 1033.9229736328,y = -767.10662841797,z = 58.003326416016 },
	-- 	Marker = {t=1, w= 1.5, h= 1.0,r = 204, g = 204, b = 0},
	-- 	Name = 'Гараж',
	-- 	HelpPrompt = "Нажмите ~INPUT_PICKUP~ чтобы открыть гараж",
	-- 	SpawnPoint = {
	-- 		Pos = {x = 1040.6834716797,y = -778.18170166016,z = 58.022853851318 },
	-- 		Heading = 359.92,
	-- 		Marker = {t=1, w= 1.5, h= 1.0,r=0,g=255,b=0},
	-- 		HelpPrompt = "Нажмите ~INPUT_PICKUP~ чтобы выгнать транспорт",
	-- 	},
	-- 	DeletePoint = {
	-- 		Pos = {x = 1022.7816772461,y = -763.78955078125,z = 57.961227416992 },
	-- 		Marker = {t=1, w= 1.5, h= 1.0,r=255,g=0,b=0},
	-- 		HelpPrompt = "Нажмите ~INPUT_PICKUP~ чтобы припарковать транспорт",
	-- 	}
	-- }
}

Config.GaragesMecano = {
--[[
	Bennys = {
		Name = 'Штрафстоянка',
		SpawnPoint = {
			Pos = {x = 477.729,y = -1888.856,z = 26.094},
			Heading = 303.0,
			Marker = {t=1, w= 1.5, h= 1.0,r=0,g=255,b=0},
			HelpPrompt = "Нажмите ~INPUT_PICKUP~ чтобы вернуть транспорт",
		},
		DeletePoint = {
			Pos = {x = 459.733,y = -1890.335,z = 25.776},
			Marker = {t=1, w= 1.5, h= 1.0,r=255,g=0,b=0},
			HelpPrompt = "Нажмите ~INPUT_PICKUP~ чтобы конфисковать транспорт",
		},
	},
]]--
	police = {
		Name = 'Штрафстоянка',
		SpawnPoint = {
			Pos = {x = 449.253,y = -1024.322,z = 28.60},
			Distance = 2.5,
			Heading = 100.0,
			Marker = {t=36, w= 1.0, h= 1.0,r=255,g=60,b=0},
			HelpPrompt = "Нажмите ~INPUT_PICKUP~ чтобы вернуть транспорт",
		},
		DeletePoint = {
			Pos = {x = 459.733,y = -1890.335,z = 25.776},
			Distance = 2.5,
			Marker = {t=0, w= 1.5, h= 1.0,r=255,g=0,b=0},
			HelpPrompt = "Нажмите ~INPUT_PICKUP~ чтобы конфисковать транспорт",
		},
	}
}
