ESX = nil
local license_types = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

MySQL.ready(function()
	MySQL.Async.fetchAll('SELECT * FROM licenses', {}, function(result)
		for i=1,#result do
			local row = result[i]
			license_types[row.type] = row.label
		end
	end)
end)

function AddLicense(target, type, cb)
	local identifier = GetPlayerIdentifier(target, 0)

	MySQL.Async.execute('INSERT INTO user_licenses (type, owner) VALUES (@type, @owner)', {
		['@type']  = type,
		['@owner'] = identifier
	}, function(rowsChanged)
		if cb ~= nil then
			cb()
		end
	end)
end

function RemoveLicense(target, type, cb)
	local identifier = GetPlayerIdentifier(target, 0)

	MySQL.Async.execute('DELETE FROM user_licenses WHERE type = @type AND owner = @owner', {
		['@type']  = type,
		['@owner'] = identifier
	}, function(rowsChanged)
		if cb ~= nil then
			cb()
		end
	end)
end

function GetLicense(type, cb)
	if license_types[type] ~= nil then
		cb({ type  = type, label = license_types[type] })
	end
end

function GetLicenses(target, cb)
	local identifier = GetPlayerIdentifier(target, 0)

	MySQL.Async.fetchAll('SELECT * FROM user_licenses WHERE owner = @owner', {
		['@owner'] = identifier
	}, function(result)
		local licenses   = {}

		for i=1, #result, 1 do
			if license_types[result[i].type] ~= nil then
				table.insert(licenses, {
					type = result[i].type,
					label = license_types[result[i].type]
				})
			end
		end
		cb(licenses)
	end)
end

function CheckLicense(target, type, cb)
	local identifier = GetPlayerIdentifier(target, 0)

	MySQL.Async.fetchAll('SELECT COUNT(*) as count FROM user_licenses WHERE type = @type AND owner = @owner', {
		['@type']  = type,
		['@owner'] = identifier
	}, function(result)
		if tonumber(result[1].count) > 0 then
			cb(true)
		else
			cb(false)
		end

	end)
end

function GetLicensesList(cb)
	local licenses = {}
	for k,v in pairs(license_types) do
		table.insert(licenses, {
			type  = k,
			label = v
		})
	end
	cb(licenses)
end

RegisterNetEvent('esx_license:addLicense')
AddEventHandler('esx_license:addLicense', function(target, type, cb)
	AddLicense(target, type, cb)
end)

RegisterNetEvent('esx_license:removeLicense')
AddEventHandler('esx_license:removeLicense', function(target, type, cb)
	RemoveLicense(target, type, cb)
end)

AddEventHandler('esx_license:getLicense', function(type, cb)
	GetLicense(type, cb)
end)

AddEventHandler('esx_license:getLicenses', function(target, cb)
	GetLicenses(target, cb)
end)

AddEventHandler('esx_license:checkLicense', function(target, type, cb)
	CheckLicense(target, type, cb)
end)

AddEventHandler('esx_license:getLicensesList', function(cb)
	GetLicensesList(cb)
end)

ESX.RegisterServerCallback('esx_license:getLicense', function(source, cb, type)
	GetLicense(type, cb)
end)

ESX.RegisterServerCallback('esx_license:getLicenses', function(source, cb, target)
	GetLicenses(target, cb)
end)

ESX.RegisterServerCallback('esx_license:checkLicense', function(source, cb, target, type)
	CheckLicense(target, type, cb)
end)

ESX.RegisterServerCallback('esx_license:getLicensesList', function(source, cb)
	GetLicensesList(cb)
end)