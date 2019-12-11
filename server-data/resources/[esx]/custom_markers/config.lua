Config = {}

Config.Locale = 'en'

Config.Zones = {
	Scrap = {
		Markers = {
			scrap1 = {
				Type  = 1,
				Pos = {x = -486.51, y = -1754.62, z = 17.25 },
				Size  = {x = 1.5, y = 1.5, z = 1.0},
				Color = {r = 224, g = 114, b = 0, a = 100},
			}
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

	Portals = {
		Markers = {
			pr_southls = {
				Type  = 25,
				Pos = {x = 0.57, y = 11.81, z = 0.0 },
				Size  = {x = 1.0, y = 1.0, z = 1.0},
				Color = {r = 224, g = 114, b = 224, a = 100},
				Points = {
					{
						label = "Клуб Vanilla Unicorn (здание напротив)",
						target = {x = 140.0, y = -1337.0, z = 28.2, r = 29.2}
					},
				},
			},

			pr_vespucci = {
				Type  = 25,
				Pos = {x = -1.2, y = 12.2, z = 0.0 },
				Size  = {x = 1.0, y = 1.0, z = 1.0},
				Color = {r = 224, g = 224, b = 112, a = 100},
				Points = {
					{
						label = "Тренажёрный зал (отвель Веспуччи)",
						target = {x = -1183.0, y = -1556.7, z = 4.0, r = 5.0}
					},
				},
			},

			pr_paleto = {
				Type  = 25,
				Pos = {x = 0.2, y = 23.32, z = 0.0 },
				Size  = {x = 1.0, y = 1.0, z = 1.0},
				Color = {r = 214, g = 000, b = 0, a = 100},
				Points = {
					{
						label = "Банк Палето (гостиница  South Seas)",
						target = {x = -153.79, y = 6433.35, z = 30.92, r = 223.38}
					},
				},
			},

			pr_sandy = {
				Type  = 25,
				Pos = {x = 3.65, y = 19.46, z = 0.0 },
				Size  = {x = 1.0, y = 1.0, z = 1.0},
				Color = {r = 0, g = 224, b = 114, a = 100},
			},
			pr_tngvahills = {
				Type  = 25,
				Pos = {x = -2.75, y = 17.0, z = 0.0 },
				Size  = {x = 1.0, y = 1.0, z = 1.0},
				Color = {r = 114, g = 224, b = 0, a = 100},
			},
			pr_downtown = {
				Type  = 25,
				Pos = {x = 0.65, y = 13.0, z = 0.0 },
				Size  = {x = 1.0, y = 1.0, z = 1.0},
				Color = {r = 224, g = 114, b = 0, a = 100},
				Points = {
					{
						label = "Полицейский участок (чёрный ход)",
						target = {x = 478.4, y = -978.64, z = 27.25, r = 14.5}
					},
					{
						label = "Больница Pillbox Hills (лифт)",
						target = {x = 338.1, y = -594.66, z = 28.79, r = 61.96}
					},
				},
			},
			pr_rockford = {
				Type  = 25,
				Pos = {x = -0.685, y = 13.7, z = 0.0 },
				Size  = {x = 1.0, y = 1.0, z = 1.0},
				Color = {r = 0, g = 114, b = 224, a = 100},
				Points = {
					{
						label = "Los Santos Customs (служебная дверь)",
						target = {x = -349.23, y = -113.25, z = 38.43, r = 53.47}
					},
				},
			},
			pr_delperro = {
				Type  = 25,
				Pos = {x = -1.856, y = 13.035, z = 0.0 },
				Size  = {x = 1.0, y = 1.0, z = 1.0},
				Color = {r = 114, g = 224, b = 114, a = 100},
				Points = {
					{
						label = "Пристань (Sharkies)",
						target = {x = -1814.09, y = -1213.15, z = 12.02, r = 47.75}
					},
				},
			},
		},

		Events = {
			Enter = 'custom_markers:portalEnter',
			Exit  = 'custom_markers:portalExit',
		},
	},

}
