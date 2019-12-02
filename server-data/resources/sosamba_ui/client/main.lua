local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local hunger = 0
local thirst = 0
local paused = true
local nuiFocus = false
local inputBoxes = {}
local isBeltOn = nil
local isHidden = false

Citizen.CreateThread(function()
	while true do
		if isHidden then
			for i=1,20 do
				HideHudComponentThisFrame(i)
			end
			HideHudNotificationsThisFrame()
			DisplayAmmoThisFrame(false)
		end

		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		TriggerEvent('seatbelt_lua:isBeltOn', function(res)
			isBeltOn = res
		end)

		Citizen.Wait(1000)
	end
end)

Citizen.CreateThread(function()
	SetNuiFocus(false, false)
	Citizen.Wait(100)
	SetNuiFocus(false, false)
end)


Citizen.CreateThread(function()
while true do
	TriggerEvent('esx_status:getStatus', 'hunger', function(status)
		if status ~= nil then
			hunger = status.val / 1000000
		end
	end)

	TriggerEvent('esx_status:getStatus', 'thirst', function(status)
		if status ~= nil then
			thirst = status.val / 1000000
		end
	end)

	local PlayerHealth = (GetEntityHealth(PlayerPedId()) - 100) / 100.0
	local PlayerArmour = GetPedArmour(PlayerPedId()) / 100.0
	local PlayerStamina = GetPlayerSprintStaminaRemaining(PlayerId()) / 100.0
	local PlayerSeatbelt = 0

	if isBeltOn == false then
		PlayerSeatbelt = 1
	end

	SendNUIMessage({
		action  = 'setNeeds',
		hunger = hunger,
		thirst = thirst,
		health = PlayerHealth,
		armor  = PlayerArmour,
		stamina= PlayerStamina,
		seatbelt= PlayerSeatbelt,
	})

	SendNUIMessage({
		action  = 'status',
		hidden = isHidden,
	})

	Citizen.Wait(1000)
end
end)

--[[
function inventoryAddMoneyItems(elements)
	local playerData = ESX.GetPlayerData()
--	if playerData.money > 0 then
		local formattedMoney = _U('locale_currency', ESX.Math.GroupDigits(playerData.money))

		local item = {}
		item.name = 'money'
		item.extra = {}
		item.amount = playerData.money
		item.droppable = true

--		table.insert(elements, {
--			label     = ('%s: <span style="color:green;">%s</span>'):format(_U('cash'), formattedMoney),
--			value     = item,
--		})
		table.insert(elements, {
			label     = _U("cash"),
                        description = "",
			count     = item.amount,
                        weight    = 0,
			name      = item.name,
			item      = item,
		})

--	end

	for i=1, #playerData.accounts, 1 do
--		if playerData.accounts[i].money > 0 then
			local formattedMoney = _U('locale_currency', ESX.Math.GroupDigits(playerData.accounts[i].money))

			local item = {}
			item.name = 'account_money'
			item.extra = {["account_name"] = playerData.accounts[i].name}

			if playerData.accounts[i].name == "black_money" then
				item.name = "black_money"
				item.extra = {}
			end

			item.amount = playerData.accounts[i].money
			item.droppable = playerData.accounts[i].name ~= 'bank'

--('%s: <span style="color:green;">%s</span>'):format(playerData.accounts[i].label, formattedMoney)
			table.insert(elements, {
				label     = playerData.accounts[i].label,
                                description = "",
				count     = item.amount,
                                weight    = 0,
				name      = item.name,
				item      = item,
				actions	  = {},
			})

--		end
	end
end
]]--
--[[
function inventoryAddWeaponItems(elements)
	local playerPed = PlayerPedId()
	TriggerEvent('esx_inventory:getWeapons', function(weapons)

		for i,weapon in pairs(weapons) do
			local item = {}
			item.name = 'equipped_weapon'
			item.extra = {["weapon"] = weapon, equipped = true}
			item.amount = 1
			item.droppable = false

			local desc = _U("inventory_status_equipped")

			local actions = {}

			table.insert(elements, {
				label     = weapon.label,
                                description = desc,
				count     = 1,
                                weight    = weapon.weight,
				name      = item.name,
				ammo      = weapon.ammo,
				melee     = weapon.melee,
				item      = item,
				actions	  = actions,
			})
		end
	end)
end
]]--

--[[
function inventoryAddESXItems(elements)
	local playerData = ESX.GetPlayerData()
	for i=1, #playerData.inventory, 1 do
		if playerData.inventory[i].count > 0 then
			local item = {}
			item.name = "esx_item"
			item.extra = {
				["name"]=playerData.inventory[i].name,
				["label"]=playerData.inventory[i].label,
				["usable"] = playerData.inventory[i].usable,
				["rare"] = playerData.inventory[i].rare,
				["canRemove"] = playerData.inventory[i].canRemove,
			}
			item.amount = playerData.inventory[i].count
			item.droppable = playerData.inventory[i].canRemove

			table.insert(elements, {
				label     = playerData.inventory[i].label,
                                description = "",
				count     = item.amount,
                                weight    = 0,
				name      = item.name,
				item      = item,
			})

		end
	end
end
]]--

function inventoryAddNativeItems(elements, inventory)
	if inventory == nil or inventory.items == nil then
		return
	end

	for k,v in pairs(inventory.items) do
		local itemlabel = v.name
		if v.label ~= nil then
			itemlabel = v.label
		end

		local itemdesc = v.description or ''

		local melee = false
		local ammo = 0
		local skip_item = false

		if (v.name == "weapon" or v.name == "equipped_weapon") and v.extra ~= nil then
			ammo = v.extra.ammo
			melee = v.extra.melee
			if v.name == "equipped_weapon" then
				itemdesc = "Экипировано"
				if not HasPedGotWeapon(PlayerPedId(), GetHashKey(v.extra.weapon_name:upper()), false) then
					skip_item = true
				end
			end
		end

		if not skip_item then
		table.insert(elements, {
			label = itemlabel,
			description = itemdesc,
			count = v.amount,
			melee = melee,
			ammo = ammo,
			weight = (v.weight or 0)*v.amount,
			name = v.name,
			item = v,
			actions = {},
		})
		end
	end
end

function generateInventoryElements(inventory)
	local elements = {}

--	inventoryAddMoneyItems(elements)
	inventoryAddNativeItems(elements, inventory)
--	inventoryAddESXItems(elements)
--	inventoryAddWeaponItems(elements)

	for i,elem in pairs(elements) do
		local actions = exports['esx_inventory']:getItemActions(elem.name)
--		print(json.encode(actions))
		if actions == nil then
			actions = {}
		end

		if elements[i].actions == nil then
			elements[i].actions = {}
		end

               for name,act in pairs(actions) do
                       if act.condition == nil or act.condition(elem.item) == true then
                               table.insert(elements[i].actions, {
                                       key = name,
                                       label = act.label,
                                       priority = act.priority,
                               })
                       end
		end
--[[
		for j,act in pairs(actions) do
			table.insert(elements[i].actions, {
				key = act.name,
				label = act.label,
				priority = act.priority,
			})
		end
]]--
		table.insert(elements[i].actions, {
			key = "return",
			icon = "keyboard-return",
			label = _U("inventory_action_return"),
		})
	end

	return elements

end

function showInventoryMenu(inventory)
	SendNUIMessage({
		action  = 'showInventory',
		value = true,
	})

	nuiFocus = true
	SetNuiFocus(true, true);
	local elements = generateInventoryElements(inventory)

	SendNUIMessage({
		action  = 'updateInventory',
		items = elements,
		weight = inventory.weight,
	})

end

--[[
function showPaper(text)
	SendNUIMessage({
		action  = 'showPaper',
		value = text,
	})
	nuiFocus = true
	SetNuiFocus(true, true)
end
]]--

function hideInventoryMenu()

	SendNUIMessage({
		action  = 'showInventory',
		value = false,
	})
	nuiFocus = false
	SetNuiFocus(false, false)
end


RegisterNetEvent('sosamba_ui:hideInventoryMenu')
AddEventHandler('sosamba_ui:hideInventoryMenu', function()
	hideInventoryMenu()
end)

RegisterNetEvent('sosamba_ui:showInventoryMenu')
AddEventHandler('sosamba_ui:showInventoryMenu', function(inventory)
--	print("BBB showInventoryMenu")
	showInventoryMenu(inventory)
end)

Citizen.CreateThread(function()
while true do
--[[
	if IsControlJustPressed(0,84) then
		showPaper("My cool text")
	end
]]--
	if isHidden and IsControlJustPressed(0, Keys['~']) then
		isHidden = false
		TriggerEvent('sosamba_ui:setHidden', isHidden)
	end

	if IsControlJustPressed(0, 57) then -- F10
		isHidden = not isHidden
		TriggerEvent('sosamba_ui:setHidden', isHidden)
	end

	if nuiFocus then
		local playerPed = PlayerPedId()

		DisableAllControlActions(0)
--[[
		DisableControlAction(0, 1, true) -- LookLeftRight
		DisableControlAction(0, 2, true) -- LookUpDown
		DisablePlayerFiring(playerPed, true) -- Disable weapon firing
		DisableControlAction(0, 142, true) -- MeleeAttackAlternate
		DisableControlAction(0, 106, true) -- VehicleMouseControlOverride

		DisableControlAction(0, 12, true) -- WeaponWheelUpDown
		DisableControlAction(0, 14, true) -- WeaponWheelNext
		DisableControlAction(0, 15, true) -- WeaponWheelPrev
		DisableControlAction(0, 16, true) -- SelectNextWeapon
		DisableControlAction(0, 17, true) -- SelectPrevWeapon
]]--
--	else
--		if IsControlJustPressed(1, 10) then
--			TriggerEvent('sosamba_ui:toggleweb')
--			TriggerServerEvent('esx_inventory:getInventory', "pocket", false, 'sosamba_ui:showInventoryMenu')
--		end
	end

	Citizen.Wait(0)
end
end)

Citizen.CreateThread(function()
while true do
	if menuActive then
		local playerPed = PlayerPedId()

		DisableAllControlActions(0)
--[[
		DisableControlAction(0, 1, true) -- LookLeftRight
		DisableControlAction(0, 2, true) -- LookUpDown
		DisablePlayerFiring(playerPed, true) -- Disable weapon firing
		DisableControlAction(0, 142, true) -- MeleeAttackAlternate
		DisableControlAction(0, 106, true) -- VehicleMouseControlOverride

		DisableControlAction(0, 12, true) -- WeaponWheelUpDown
		DisableControlAction(0, 14, true) -- WeaponWheelNext
		DisableControlAction(0, 15, true) -- WeaponWheelPrev
		DisableControlAction(0, 16, true) -- SelectNextWeapon
		DisableControlAction(0, 17, true) -- SelectPrevWeapon
]]--
--	else
--		if IsControlJustPressed(1, 10) then
--			TriggerEvent('sosamba_ui:toggleweb')
--			TriggerServerEvent('esx_inventory:getInventory', "pocket", false, 'sosamba_ui:showInventoryMenu')
--		end
	end

	Citizen.Wait(0)
end
end)

Citizen.CreateThread(function()
while true do
	if menuActive then
		local playerPed = PlayerPedId()

		DisableAllControlActions(0)
--[[
		DisableControlAction(0, 1, true) -- LookLeftRight
		DisableControlAction(0, 2, true) -- LookUpDown
		DisablePlayerFiring(playerPed, true) -- Disable weapon firing
		DisableControlAction(0, 142, true) -- MeleeAttackAlternate
		DisableControlAction(0, 106, true) -- VehicleMouseControlOverride

		DisableControlAction(0, 12, true) -- WeaponWheelUpDown
		DisableControlAction(0, 14, true) -- WeaponWheelNext
		DisableControlAction(0, 15, true) -- WeaponWheelPrev
		DisableControlAction(0, 16, true) -- SelectNextWeapon
		DisableControlAction(0, 17, true) -- SelectPrevWeapon
]]--
--	else
--		if IsControlJustPressed(1, 10) then
--			TriggerEvent('sosamba_ui:toggleweb')
--			TriggerServerEvent('esx_inventory:getInventory', "pocket", false, 'sosamba_ui:showInventoryMenu')
--		end
	end

	Citizen.Wait(0)
end
end)

Citizen.CreateThread(function()

	while GetIsLoadingScreenActive() do
		Citizen.Wait(1000)
	end

	while GetIsLoadingScreenActive() do
		Citizen.Wait(1000)
	end

	while GetIsLoadingScreenActive() do
		Citizen.Wait(1000)
	end

	while GetIsLoadingScreenActive() do
		Citizen.Wait(1000)
	end

	while true do
		local pauseMenuActive = IsPauseMenuActive()

		if pauseMenuActive ~= paused then
			paused = pauseMenuActive
			SendNUIMessage({
				action  = 'setPause',
				paused = paused
			})
		end
		Citizen.Wait(100)
	end
end)

function convertNotificationMessage(msg)
	local function count(base, pattern)
	    return select(2, string.gsub(base, pattern, ""))
	end

	local function convert_color_to_html(str, from ,to, endtag)
		local result = str
		result = result:gsub(from, to)
		for i=1,count(str,from) do
			result = result .. endtag
		end
		return result
	end

	local str = msg;
	str = str:gsub("&", "&amp;")
	str = str:gsub("<", "&lt;")
	str = str:gsub(">", "&gt;")
	str = str:gsub("\"", "&quot;")
	str = str:gsub("~n~","<br>")
	str = convert_color_to_html(str, "~r~", "<span class='notify-red'>", "</span>")
	str = convert_color_to_html(str, "~b~", "<span class='notify-blue'>", "</span>")
	str = convert_color_to_html(str, "~g~", "<span class='notify-green'>", "</span>")
	str = convert_color_to_html(str, "~y~", "<span class='notify-yellow'>", "</span>")
	str = convert_color_to_html(str, "~p~", "<span class='notify-purple'>", "</span>")
	str = convert_color_to_html(str, "~o~", "<span class='notify-orange'>", "</span>")
	str = convert_color_to_html(str, "~c~", "<span class='notify-gray'>", "</span>")
	str = convert_color_to_html(str, "~m~", "<span class='notify-darkgray'>", "</span>")
	str = convert_color_to_html(str, "~u~", "<span class='notify-black'>", "</span>")
	str = convert_color_to_html(str, "~w~", "<span class='notify-white'>", "</span>")
	str = convert_color_to_html(str, "~s~", "<span class='notify-default'>", "</span>")
	str = convert_color_to_html(str, "~h~", "<span class='notify-bold'>", "</span>")

	return str
end

RegisterNetEvent('sosamba_ui:showNotification')
AddEventHandler('sosamba_ui:showNotification', function(args)

	SendNUIMessage({
		action  = 'showNotification',
		text = convertNotificationMessage(args.text),
	})
end)

RegisterNetEvent('sosamba_ui:toggleweb')
AddEventHandler('sosamba_ui:toggleweb', function()
--[[
	menuActive = true
	if menuActive then
		SendNUIMessage({
			action  = 'showInventory',
			items = {

			},
		})
	else
		SendNUIMessage({
			action  = 'hideInventory',
			data = '',
		})
	end
]]--
end)

RegisterNetEvent('esx_inventory:onInventoryUpdate')
AddEventHandler('esx_inventory:onInventoryUpdate', function(inventory)
	local elements = generateInventoryElements(inventory)
	SendNUIMessage({
		action  = 'updateInventory',
		items = elements,
		weight = inventory.weight,
	})
end)

RegisterNUICallback('close', function(data)
	hideInventoryMenu()
end)

RegisterNUICallback('inputbox', function(data)
--	print("inputbox return")
--	print(json.encode(data))

	if data.id ~= nil and inputBoxes[data.id] ~= nil then
		inputBoxes[data.id](data.text)
		inputBoxes[data.id] = nil
	end
end)

function showInputBox(id, title, hint, cb)
	inputBoxes[id] = cb
	SendNUIMessage({
		action  = 'showInputBox',
		id = id,
		title = title,
		hint = hint,
	})
end

RegisterNUICallback('do_action', function(act)
--	print(json.encode(act))
--[[
	if act.key == "drop" then
		if act.item ~= nil and act.item.amount > 1 then
			showInputBox("drop-box", "Сколько выбросить?", "Введите количество предметов", function(text)
				local val = tonumber(text)
				if val ~= nil then
					act.item.amount = tonumber(text)
				end
				TriggerEvent('esx_inventory:itemAction', act)
			end)
		else
			TriggerEvent('esx_inventory:itemAction', act)
		end
	else
	end
]]--
	TriggerEvent('esx_inventory:itemAction', act)

end)


RegisterNetEvent('sosamba_ui:showInputBox')
AddEventHandler('sosamba_ui:showInputBox', function(id, title, hint, cb)
	showInputBox(id, title, hint, cb)
end)
