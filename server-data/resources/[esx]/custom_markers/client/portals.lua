function teleport(target)
	local ped = PlayerPedId()
	NetworkFadeOutEntity(ped, 1, 0)
	Citizen.Wait(300)

	ESX.Game.Teleport(ped, { x = target.x, y = target.y, z = target.z }, function()
		if target.r ~= nil then
			SetEntityHeading(ped, target.r)	
		end

		Citizen.Wait(300)
		NetworkFadeInEntity(ped, 0)
	end)
end

function OpenPortalList(marker)
		local plist = marker.Points
		if plist == nil then
			return
		end

		local elements = {}
		for _,v in pairs(plist) do
			table.insert(elements, {label = v.label, value = v.label})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'portal_list', {
			title    = "Телепорт",
			align    = 'top-right',
			elements = elements
		}, function(data, menu)
			local cmd = data.current.value
			menu.close()

			for _,v in pairs(plist) do
				if cmd == v.label then
					teleport(v.target)
					break
				end
			end

		end, function(data, menu)
			menu.close()
		end)
end


AddEventHandler('custom_markers:portalPress', function(zone, marker)
	if not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'portal_list') then
		OpenPortalList(marker)
	end
end)
