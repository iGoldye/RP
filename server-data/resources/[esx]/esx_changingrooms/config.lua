Config                      = {}

Config.DrawDistance         = 100.00
Config.MarkerType           = 1
Config.MarkerSize           = {x = 1.5, y = 1.5, z = 0.5}
Config.MarkerColor          = {r = 102, g = 204, b = 102}

Config.Zones = {}

Config.ChangingRooms = {
		{x = -1145.2,   y = -1514.93,   z = 9.7}, -- Пляж
		{x = -18.26,   y = -1438.82,   z = 30.1},-- Гетто
		{x = 8.51,   y = 528.48,   z = 169.64}, --Вайнвуд
		{x = 1969.76,   y = 3815.13,   z = 32.43}, -- Тревор
		{x = -811.8,   y = 175.16,   z = 75.75}, -- Майкл
		{x = -109.95,   y = -13.08,   z = 70.52}, --Центр
		{x = 1272.53,   y = -1714.83,   z = 53.80}, --Центр


}

for i=1, #Config.ChangingRooms, 1 do
	Config.Zones['Changing_Rooms' .. i] = {
		Pos   = Config.ChangingRooms[i],
		Size  = Config.MarkerSize,
		Color = Config.MarkerColor,
		Type  = Config.MarkerType
	}
end
