local open = false

-- Open ID card
RegisterNetEvent('94ffa0a9-19e2-4cc5-8377-f6b3be73deee')
AddEventHandler('94ffa0a9-19e2-4cc5-8377-f6b3be73deee', function( data, type )
	open = true
	SendNUIMessage({
		action = "open",
		array  = data,
		type   = type
	})
end)

-- Key events
Citizen.CreateThread(function()
	while true do
		Wait(0)
		if IsControlJustReleased(0, 322) and open or IsControlJustReleased(0, 177) and open then
			SendNUIMessage({
				action = "close"
			})
			open = false
		end
	end
end)
