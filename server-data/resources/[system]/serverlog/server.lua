logname = "logs/"..os.date("%Y-%m-%d %H%M")..".txt"
logdata = LoadResourceFile(GetCurrentResourceName(), logname)

AddEventHandler('serverlog:log', function(text, source)
	writeLog(text, source)
end)

function writeLog(text, source)
	local time = os.date("%Y-%m-%d %X")

	local data = time .. ' :: ' .. text

	if source ~= nil then
		local name = GetPlayerName(source)
		local identifier = GetPlayerIdentifiers(source)
		data = time .. ' : ' .. name .. ' - ' .. identifier[1] .. ' : ' .. text
	end

	if logdata == nil then
		logdata = ""
	end

	logdata = logdata .. '\r\n' .. data
	SaveResourceFile(GetCurrentResourceName(), logname, logdata, -1)
end

writeLog("SERVER STARTED")