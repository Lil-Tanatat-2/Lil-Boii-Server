Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        NetworkClearVoiceChannel()
        NetworkSetVoiceActive(true)
    end
end)

local oneSyncCount = 0
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if NetworkGetTalkerProximity() > 1000000000 or NetworkGetTalkerProximity() < 1.0 or NetworkGetTalkerProximity() == 0 then
			NetworkSetTalkerProximity(5.0)
			oneSyncCount = oneSyncCount + 1
			if oneSyncCount > 100 then
				return
			end
		end
	end
end)