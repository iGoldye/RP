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

	["obed1"] = {
		{item = "spices", quantity = 2 },
		{item = "fish", quantity = 1 },
		{item = "potato", quantity = 1 },
	},

	["obed2"] = {
		{item = "spices", quantity = 2 },
		{item = "packaged_chicken", quantity = 1 },
		{item = "potato", quantity = 1 },
	},

	["obed3"] = {
		{item = "spices", quantity = 2 },
		{item = "packaged_chicken", quantity = 1 },
		{item = "potato", quantity = 1 },
		{item = "сabbage", quantity = 1 },
		{item = "water", quantity = 1 },
		{item = "carrot", quantity = 1 },
	},

	["chocodrink"] = {
		{item = "water", quantity = 1 },
		{item = "candy2", quantity = 1 },
	},

	["chocodrink"] = {
		{item = "milk", quantity = 1 },
		{item = "candy2", quantity = 1 },
	},

	["sendwich1"] = {
		{item = "spices", quantity = 1 },
		{item = "packaged_chicken", quantity = 1 },
		{item = "сheese", quantity = 1 },
		{item = "сabbage", quantity = 1 },
	},

	["cake"] = {
		{item = "milk", quantity = 1 },
		{item = "flour", quantity = 1 },
		{item = "sugar", quantity = 1 },
	},

	["coocie"] = {
		{item = "milk", quantity = 1 },
		{item = "flour", quantity = 1 },
		{item = "sugar", quantity = 1 },
		{item = "candy2", quantity = 1 },
	},

	["cakebig"] = {
		{item = "milk", quantity = 1 },
		{item = "flour", quantity = 2 },
		{item = "sugar", quantity = 1 },
		{item = "candy2", quantity = 1 },
		{item = "strawberry", quantity = 1 },
		{item = "banana", quantity = 1 },
		{item = "slivki", quantity = 1 },
	},

	["puree"] = {
		{item = "potato", quantity = 1 },
		{item = "milk", quantity = 1 },
	},

	["meats"] = {
		{item = "packaged_chicken", quantity = 1 },
		{item = "spices", quantity = 1 },
	},

	["patao"] = {
		{item = "potato", quantity = 1 },
		{item = "spices", quantity = 1 },
	},

	["pureemeat"] = {
		{item = "puree", quantity = 1 },
		{item = "meats", quantity = 1 },
	},

	["spagettimeat"] = {
		{item = "spagetti", quantity = 1 },
		{item = "water", quantity = 1 },
		{item = "saucisson", quantity = 1 },
	},

	["glint"] = {
		{item = "spices", quantity = 1 },
		{item = "vine", quantity = 1 },
	},

	-- Крафт пушек
	['WEAPON_ASSAULTRIFLE'] = {
		{item = "steel", quantity = 4 },
		{item = "gunpowder", quantity = 2},
	}
}

-- Доступ к меню как к верстаку
-- Config.Shop = {
-- 	useShop = true,
-- 	shopCoordinates = { x=962.5, y=-1585.5, z=29.6 },
-- 	shopName = "Верстак",
-- 	shopBlipID = 446,
-- 	zoneSize = { x = 2.5, y = 2.5, z = 1.5 },
-- 	zoneColor = { r = 255, g = 0, b = 0, a = 100 }
-- }

-- Вызов меню
Config.Keyboard = {
	useKeyboard = false,
	keyCode = 311
}
