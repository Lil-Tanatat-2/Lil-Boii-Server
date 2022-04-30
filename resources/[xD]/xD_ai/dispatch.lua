Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		for i = 1, 256 do
			EnableDispatchService(i, false)
		end
	end	
end)