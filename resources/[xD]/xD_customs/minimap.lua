Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsPedInAnyVehicle(PlayerPedId(), true) then
			DisplayRadar(true)
		else
			DisplayRadar(false)
		end
	end
end)