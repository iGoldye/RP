-- Script Created by Giant Cheese Wedge (AKA Blü)
-- Script Modified and fixed by Hoopsure

crouchKey = 36 -- CTRL
local currentState = "stand"

function setState(state)
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped, true) and state ~= "stand" then
		return
	end

	if state == currentState then
		return
	end
--	print("Crouch state transition: "..currentState.." -> "..state)

	if state == "crouch" and currentState == "stand" then
		while ( not HasAnimSetLoaded( "move_ped_crouched" ) ) do
			RequestAnimSet( "move_ped_crouched" )
			Citizen.Wait( 100 )
		end

		ResetPedMovementClipset( ped )
		ResetPedStrafeClipset(ped)
		SetPedMovementClipset( ped, "move_ped_crouched", 0.55 )
		SetPedStrafeClipset(ped, "move_ped_crouched_strafing")
		currentState = "crouch"
		return
	end

	if state == "stand" and currentState == "crouch" then
		while ( not HasAnimSetLoaded( "MOVE_M@TOUGH_GUY@" ) ) do
			RequestAnimSet("MOVE_M@TOUGH_GUY@")
			Citizen.Wait( 100 )
		end

		ResetPedMovementClipset( ped )
		ResetPedStrafeClipset(ped)
		SetPedMovementClipset( ped,"MOVE_M@TOUGH_GUY@", 0.5)

		currentState = "stand"
		return
	end

	if state == "stand" and currentState == "prone" then
		while ( not HasAnimSetLoaded( "MOVE_M@TOUGH_GUY@" ) ) do
			RequestAnimSet("MOVE_M@TOUGH_GUY@")
			Citizen.Wait( 100 )
		end

		ResetPedMovementClipset( ped )
		ResetPedStrafeClipset(ped)
		SetPedMovementClipset( ped,"MOVE_M@TOUGH_GUY@", 0.5)

		SetPedToRagdoll(ped, 10, 10, 0, 0, 0, 0)
		Citizen.Wait(1000)
		ClearPedTasks(ped)
		Citizen.Wait( 100 )
		currentState = "stand"
		return
	end

	if state == "prone" and currentState == "crouch" then
		while ( not HasAnimSetLoaded( "move_crawl" ) ) do
			RequestAnimSet("move_crawl")
			Citizen.Wait( 100 )
		end

		while ( not HasAnimSetLoaded( "MOVE_M@TOUGH_GUY@" ) ) do
			RequestAnimSet("MOVE_M@TOUGH_GUY@")
			Citizen.Wait( 100 )
		end

		ResetPedMovementClipset( ped )
		ResetPedStrafeClipset(ped)
		SetPedMovementClipset( ped,"MOVE_M@TOUGH_GUY@", 0.5)

		SetProned()
		currentState = "prone"
		return
	end

	print("Incorrect crouch state transition: "..currentState.." -> "..state)

end


Citizen.CreateThread( function()
	while true do
		Citizen.Wait( 0 )
		local ped = GetPlayerPed( -1 )
		if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then
			ProneMovement()
			DisableControlAction( 0, crouchKey, true )
			if ( not IsPauseMenuActive() ) then
				if currentState == "prone" and IsPedInAnyVehicle(ped, true) then
					setState("stand")
					ClearPedTasks(ped)

				elseif IsControlJustPressed(0, 20) and IsControlPressed(0, 21) and currentState == "stand" and (IsPedSprinting(ped) or IsPedRunning(ped) or GetEntitySpeed(ped) > 5) and (not IsPedInAnyVehicle(ped, true) and not IsPedFalling(ped) and not IsPedDiving(ped) and not IsPedInCover(ped, false) and not IsPedInParachuteFreeFall(ped) and (GetPedParachuteState(ped) == 0 or GetPedParachuteState(ped) == -1) ) then
					ClearPedTasksImmediately(ped)
					TaskPlayAnim(ped, "move_jump", "dive_start_run", 8.0, 1.0, -1, 0, 0.0, 0, 0, 0)
					Citizen.Wait(1200)
					SetPedToRagdoll(PlayerPedId(), 1000, 1000, 0, 0, 0, 0)

				elseif ( IsDisabledControlJustPressed( 0, crouchKey )) then
					if currentState == "stand" then
						setState("crouch")
					elseif currentState == "crouch" then
						setState("prone")
					elseif currentState == "prone" then
						setState("stand")
					end
				elseif IsControlJustPressed(0, 73) then
					setState("stand")
					ClearPedTasks(ped)
				end
			end
		end
	end
end)

function SetProned()
	ped = PlayerPedId()
	ClearPedTasks(ped)

	RequestAnimSet( "move_crawl" )
	while ( not HasAnimSetLoaded( "move_crawl" ) ) do
		Citizen.Wait( 100 )
	end

	TaskPlayAnim(ped, "move_crawl", "onfront_fwd", 	1.0, 0.1, -1, 2, 0)
	Citizen.Wait(1000)
end


function headingChange(ped)
	if IsControlPressed(0, 34) then
		SetEntityHeading(ped, GetEntityHeading(ped)+2.0 )
	elseif IsControlPressed(0, 35) then
		SetEntityHeading(ped, GetEntityHeading(ped)-2.0 )
	end
end

function ProneMovement()
	ped = PlayerPedId()

	if currentState == 'prone' then

		if IsControlPressed(0, 32) then
			TaskPlayAnim(ped, "move_crawl", "onfront_fwd", 	8.0, 0.0, -1, 1, 0)
		        while ( GetEntityAnimCurrentTime( ped, "move_crawl", "onfront_fwd") < 0.99 ) do
				headingChange(ped)
				Citizen.Wait(0)
			end

			while IsControlPressed(0, 32) do
				headingChange(ped)
				Citizen.Wait( 0 )
			end

			TaskPlayAnim(ped, "move_crawl", "onfront_fwd", 	1.0, 0.0, -1, 2, 0)
		elseif IsControlPressed(0, 33) then
			TaskPlayAnim(ped, "move_crawl", "onfront_bwd", 	8.0, 0.0, -1, 1, 0)
		        while ( GetEntityAnimCurrentTime( ped, "move_crawl", "onfront_bwd") < 0.99 ) do
				headingChange(ped)
				Citizen.Wait(0)
			end

			while IsControlPressed(0, 33) do
				headingChange(ped)
				Citizen.Wait( 0 )
			end

			TaskPlayAnim(ped, "move_crawl", "onfront_bwd", 	1.0, 0.0, -1, 2, 0)
		end
	end
end
