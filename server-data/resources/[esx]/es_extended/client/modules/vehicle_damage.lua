--[[
function GetDamageMap(vehicle)
	local angleMap = {}


	for x=-1,1,0.1 do
	for y=-1,1,0.1 do
	for z=-1,1,0.1 do

		local deg = Atan2(y, x)
--		local deg = rad * (180.0 / math.pi)
		local an = math.floor(deg*0.1)

		local d = GetVehicleDeformationAtPos(vehicle, x*0.1,y*0.1,z)

		if angleMap[an] == nil or #d > angleMap[an] then
			angleMap[an] = #d
		end
	end
	end
	end

	return angleMap
end
]]--

function ApplyDamageMap(vehicle, angleMap)
	for k,v in pairs(angleMap) do
		local angle = k*10 / 57.2958
		local x = math.cos(angle) * 1.2
		local y = math.sin(angle) * 1.2
		local force = v * 350000.0
		if force > 1 then
--			print(tostring(x).." "..tostring(y).." "..tostring(force))
			SetVehicleDamage(vehicle, x, y, 0.0, force, force, 1)
		end
	end

end

function ApplyDamageRandom(vehicle, bodyHealth)
	for angle=-180,180,10 do
		local angle2 = angle / 57.2958
		local x = math.cos(angle2) * 1.2
		local y = math.sin(angle2) * 1.2

		local force = (0.8+0.2*math.random())*(1000-bodyHealth)*0.5
		if force > 0.01 then
			SetVehicleDamage(vehicle, x, y, 0.0, force, force, 1)
		end
	end
end
