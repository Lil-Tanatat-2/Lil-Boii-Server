local input = {["E"] = 38,["DOWN"] = 173,["TOP"] = 27,["NENTER"] =  201}
ESX                           = nil
local PlayerData                = {}



Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(1)
  end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)

RegisterNetEvent('errormessage')
	AddEventHandler('errormessage', function()
	
end)


RegisterNetEvent('spinit')
AddEventHandler('spinit', function()
	
	
	SendNUIMessage({
				canspin = true
			})
	Citizen.Wait(100)
	
		SendNUIMessage({
				canspin = false
			})

end)


RegisterNUICallback('close', function(data, cb)

	SetNuiFocus(false, false)
	SendNUIMessage({
		show = false
	})
	cb("ok")
	
end)


Citizen.CreateThread(function()

SetNuiFocus(false, false)
end)



RegisterNUICallback('payforplayer', function(winnings, cb)
	
	TriggerServerEvent('payforplayer',winnings)
end)

RegisterNUICallback('playerpays', function(bet, cb)
	TriggerServerEvent('playerpays',bet)
end)

local moneymachine_slot = {
	{ ['x'] = 924.49, ['y'] = -946.98, ['z'] = 43.47 },
	{ ['x'] = 924.24, ['y'] = -954.49, ['z'] = 43.46 },
}



Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local pos = GetEntityCoords(GetPlayerPed(-1), false)
		for k,v in ipairs(moneymachine_slot) do
			if(Vdist(v.x, v.y, v.z, pos.x, pos.y, pos.z) < 20.0)then
				DrawMarker(1, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 0, 25, 165, 165, 0,0, 0,0)
				if(Vdist(v.x, v.y, v.z, pos.x, pos.y, pos.z) < 1.0)then
						DisplayHelpText("Press ~INPUT_CONTEXT~~y~ to play roulette.")
					if IsControlJustPressed(1,input["E"]) then
							SendNUIMessage({
								show = true
							})
								
								SetNuiFocus(true,true)
					end
				end
			end
		end
	end
end)

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
