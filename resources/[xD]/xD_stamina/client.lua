Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)  
		local cStamina = 100-GetPlayerSprintStaminaRemaining(PlayerId())
		if not IsPauseMenuActive() then
			if cStamina == 100.0 then
				SendNUIMessage({
					show = true,
					stamina = cStamina
				})
			else
				SendNUIMessage({
					show = false,
					stamina = cStamina
				})
			end
		end	
    end
end)

Citizen.CreateThread(function()
	local isInjured = false
	while true do
		Citizen.Wait(0)
		local cStamina = 100-GetPlayerSprintStaminaRemaining(PlayerId())
		if cStamina < 40.0 and not isInjured then
			isInjured = true
			SetPedMovementClipset(PlayerPedId(), "move_m@injured", true)
		elseif cStamina < 1.0 then
			SetPedToRagdoll(PlayerPedId(), 2000, 2000, 0, 0, 0, 0)
			Citizen.Wait(3000)
			ClearPedSecondaryTask(PlayerPedId())
		end
		
		if isInjured and cStamina > 40.0 then
			isInjured = false
			ResetPedMovementClipset(PlayerPedId())
			ResetPedWeaponMovementClipset(PlayerPedId())
			ResetPedStrafeClipset(PlayerPedId())
		end
	end
end)