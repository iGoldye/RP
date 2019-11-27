Config = {}

Config.Locale = 'en'

Config.Zones = {
	Scrap = {
		Marker = {
			Type  = 1,
			Pos = {x = -486.51, y = -1754.62, z = 17.25 },
			Size  = {x = 1.5, y = 1.5, z = 1.0},
			Color = {r = 224, g = 114, b = 0, a = 100},
		},

		Blip = {
			Name = "Хлам",
			Sprite = 365,
			Display = 4,
			Scale = 1.2,
			Category = 3,
			Color = 31,
			ShortRange = true,
		},

		Events = {
			Enter = 'custom_markers:scrapEnter',
			Exit  = 'custom_markers:scrapExit',
		},
	},
}
