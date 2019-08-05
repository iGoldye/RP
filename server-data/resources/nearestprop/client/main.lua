ESX = nil


function getNearestObject(coords1)

	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end

	local objs = ESX.Game.GetObjects()
	local mindist = 1000000
	local minobj = -1

	for i=1,#objs do
		local obj = objs[i]
		local hash = GetEntityModel(obj)
--		local name = exports["ObjectNameFromHash"]:HashToName(hash)

		local coords2 = GetEntityCoords(obj)
		local dist = GetDistanceBetweenCoords(coords2.x, coords2.y, coords2.z, coords1.x, coords1.y, coords1.z, true)
		if dist < mindist then
			mindist = dist
			minobj = obj
		end
	end

	return minobj

end

function DrawText3Ds(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())

	SetTextScale(0.35, 0.35)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
end


Citizen.CreateThread(function()

	while true do
	local coords1 = GetEntityCoords(PlayerPedId())
	local obj = getNearestObject(coords1)
	if obj ~= nil then
		local hash = GetEntityModel(obj)
		local coords2 = GetEntityCoords(obj)
		local name = exports["ObjectNameFromHash"]:HashToName(hash)
		if name == nil then
			name = tostring(hash)
		end
		nearestObject_coords = coords2
		nearestObject_name = name
	end

	Citizen.Wait(100)	
	end
end)

Citizen.CreateThread(function()
	while true do
	local coords2 = nearestObject_coords
	local name = nearestObject_name
	if nearestObject_coords ~= nil then
		DrawText3Ds(coords2.x,coords2.y,coords2.z, name)
	end

	Citizen.Wait(0)
	end
end)
