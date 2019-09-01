CurrentWeather = 'EXTRASUNNY'
local lastWeather = ''
local serverTime = 0
local clientTime = 0
local freezeTime = false
local blackout = false

SetBlackout(blackout)

RegisterNetEvent('es_wsync:updateWeather')
AddEventHandler('es_wsync:updateWeather', function(NewWeather, newblackout)
	if newblackout ~= blackout then
		SetBlackout(newblackout)
		blackout = newblackout
	end

	CurrentWeather = NewWeather
end)

function changeWeather(weather)
	if lastWeather == weather then
		return
	end

	SetWeatherTypeOverTime(weather, 15.0)
	local timer_start = GetGameTimer()
	local timer_last_frame = timer_start
	local timer_delta = 50

	-- strange, but 5 secs works best
	while ((GetGameTimer()-timer_start) < (5000-timer_delta)) and (GetGameTimer() >= timer_start) do
		timer_delta = GetGameTimer()-timer_last_frame

		if timer_delta < 50 then
			timer_delta = 50
		end
		if timer_delta > 100 then
			timer_delta = 100
		end

		timer_last_frame = GetGameTimer()
		Citizen.Wait(0)
	end

	SetOverrideWeather(weather)

	if CurrentWeather == 'XMAS' then
		SetForceVehicleTrails(true)
		SetForcePedFootstepsTracks(true)
	else
		SetForceVehicleTrails(false)
		SetForcePedFootstepsTracks(false)
	end

	lastWeather = weather
end

Citizen.CreateThread(function()
	while true do
		changeWeather(CurrentWeather)
		Citizen.Wait(100)
	end
end)

RegisterNetEvent('es_wsync:updateTime')
AddEventHandler('es_wsync:updateTime', function(base, offset, freeze)
	freezeTime = freeze
	serverTime = base+offset
end)

Citizen.CreateThread(function()
	local hour = 0
	local minute = 0
	local second = 0
	local timer = GetGameTimer()
	local currentTimeScale = Config.DayTimeScale

	while serverTime == 0 do
		Citizen.Wait(100)
	end

	while true do
		Citizen.Wait(0)
		local deltaTime = 0
		local spd = 1

		if GetGameTimer() > timer and not freezeTime then
			deltaTime = ((GetGameTimer() - timer)/1000.0) * currentTimeScale
			timer = GetGameTimer()
		end

		serverTime = serverTime + deltaTime

		-- instant change for large amounts of time
		if math.abs(serverTime - clientTime) > 10.0 then
			clientTime = serverTime
		end

		spd = 1-(clientTime-serverTime)*0.02

		if spd < 0.5 then
			spd = 0.5
		end
		if spd > 2.0 then
			spd = 2.0
		end

		clientTime = clientTime + deltaTime*spd

		hour, minute, second = timeToHMS(clientTime)
		if hour >= 6 and hour < 22 then
			currentTimeScale = Config.DayTimeScale
		else
			currentTimeScale = Config.NightTimeScale
		end

--		print(string.format("%02i:%02i:%02i x%.2f",hour,minute,second,spd))
		NetworkOverrideClockTime(hour, minute, second)
	end
end)

AddEventHandler('playerSpawned', function()
	TriggerServerEvent('es_wsync:requestSync')
end)
