Config = {}

-- Базовые патроны
Config.WeaponAmmo = 42

Config.Recipes = {
	-- Рецепты
	["lockpick"] = {
		{item = "bobbypin", quantity = 4 },
		{item = "rubberband", quantity = 1 },
	},

	-- Крафт пушек
	['WEAPON_ASSAULTRIFLE'] = {
		{item = "steel", quantity = 4 },
		{item = "gunpowder", quantity = 2},
	}
}

-- Доступ к меню как к верстаку
Config.Shop = {
	useShop = true,
	shopCoordinates = { x=962.5, y=-1585.5, z=29.6 },
	shopName = "Верстак",
	shopBlipID = 446,
	zoneSize = { x = 2.5, y = 2.5, z = 1.5 },
	zoneColor = { r = 255, g = 0, b = 0, a = 100 }
}

-- Вызов меню
Config.Keyboard = {
	useKeyboard = false,
	keyCode = 303
}
