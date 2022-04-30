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


Citizen.CreateThread(function()
SetNuiFocus(false, false)
end)


RegisterNetEvent('errormessage2')
AddEventHandler('errormessage2', function()

end)


RegisterNetEvent('spinit2')
AddEventHandler('spinit2', function()
	
	
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




RegisterNUICallback('payforplayer', function(winnings, cb)
	
	TriggerServerEvent('payforplayer2',winnings)
end)


RegisterNUICallback('playerpays', function(bet, cb)
	TriggerServerEvent('playerpays2',bet)
end)

local moneymachine_slot = {
	{ ['x'] = 929.4, ['y'] = -946.96, ['z'] = 43.46 },
	{ ['x'] = 929.4, ['y'] = -948.65, ['z'] = 43.46 },
	{ ['x'] = 929.4, ['y'] = -950.21, ['z'] = 43.46 },
	{ ['x'] = 929.4, ['y'] = -955.3, ['z'] = 43.46 },
	{ ['x'] = 929.4, ['y'] = -956.9, ['z'] = 43.46 },
	{ ['x'] = 929.4, ['y'] = -958.5, ['z'] = 43.46 },
	{ ['x'] = 929.4, ['y'] = -951.93, ['z'] = 43.46 },
	{ ['x'] = 929.4, ['y'] = -953.55, ['z'] = 43.46 },
}



Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local pos = GetEntityCoords(GetPlayerPed(-1), false)
		for k,v in ipairs(moneymachine_slot) do
			if(Vdist(v.x, v.y, v.z, pos.x, pos.y, pos.z) < 20.0)then
				DrawMarker(1, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 0, 25, 165, 165, 0,0, 0,0)
				if(Vdist(v.x, v.y, v.z, pos.x, pos.y, pos.z) < 1.0)then
						DisplayHelpText("Press ~INPUT_CONTEXT~ ~y~start Slot!")
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