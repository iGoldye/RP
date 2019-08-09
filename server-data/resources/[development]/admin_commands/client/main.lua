function loadAnimDict(dict)
	RequestAnimDict(dict)

	for i=1,100 do
		if HasAnimDictLoaded(dict) then
			break
		end

		Citizen.Wait(0)
	end
end

RegisterNetEvent('admin_commands:emote')
AddEventHandler('admin_commands:emote', function(args)
	if #args < 2 then
		return
	end

	local dict = args[1]
	local anim = args[2]

	loadAnimDict(dict)
	TaskPlayAnim(PlayerPedId(), dict, anim, 3.0, -1, -1, flag, 0, false, false, false)
	
end)
