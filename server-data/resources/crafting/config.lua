Config = {}

-- Колличество патронов при крафте
Config.WeaponAmmo = 42

Config.Recipes = {
	-- Рецепты
	["lockpick"] = {
		{item = "scarb", quantity = 2 },
	},

	["slivstraw"] = {
		{item = "strawberry", quantity = 4 },
		{item = "slivki", quantity = 1 },
	},

	["fruitpot"] = {
		{item = "strawberry", quantity = 1 },
		{item = "banana", quantity = 1 },
		{item = "apple", quantity = 1 },
	},

	["hotdog"] = {
		{item = "bread", quantity = 1 },
		{item = "saucisson", quantity = 1 },
	},

	["3adic"] = {
		{item = "adicalone", quantity = 3 },
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
