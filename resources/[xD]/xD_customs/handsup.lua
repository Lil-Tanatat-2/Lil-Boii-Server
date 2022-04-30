Citizen.CreateThread(function()
	local handsup = false
	while true do
		Citizen.Wait(10)
		if IsControlJustReleased(1, 323) and IsInputDisabled(0) then
			if DoesEntityExist(PlayerPedId()) and not IsPedSittingInAnyVehicle(PlayerPedId()) and IsPedOnFoot(PlayerPedId()) then
				Citizen.CreateThread(function()
					RequestAnimDict("random@mugging3")
					while not HasAnimDictLoaded("random@mugging3") do
						Citizen.Wait(100)
					end
					
					if not handsup then
						handsup = true
						TaskPlayAnim(PlayerPedId(), "random@mugging3", "handsup_standing_base", 8.0, -8, -1, 49, 0, 0, 0, 0)
					else 
						handsup = false
					end
				end)
			end
		end
	end
end)