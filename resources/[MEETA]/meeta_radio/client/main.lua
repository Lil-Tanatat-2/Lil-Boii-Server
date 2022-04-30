local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil
local IsOpenMenu = false
local IsRadio = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	Citizen.Wait(5000)

end)


function ShowRadio()
	IsOpenMenu = true
	TriggerEvent('esx_inventoryhud:closeHud')
    SendNUIMessage({
		action = "display"
	})
    SetNuiFocus(true, true)
end

function CloseHUD()
	IsOpenMenu = false
    SendNUIMessage(
        {
            action = "hide"
        }
	)
	SetNuiFocus(false, false)
	local PlayerPed = PlayerPedId()
	ClearPedTasks(PlayerPed)
end

RegisterNUICallback("NUIFocusOff",function()
    CloseHUD()
end)

RegisterNUICallback("Disconnect",function()
	CloseHUD()
	ShowRadio()
end)

RegisterNUICallback("RadioOn",function()
	IsRadio = true
end)

RegisterNUICallback("RadioOff",function()
	IsRadio = false
end)

-- RegisterNetEvent("meeta_radio:onDisconnect")
-- AddEventHandler("meeta_radio:onDisconnect", function()
-- 	CloseHUD()
-- 	ShowRadio()
-- end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if IsControlJustPressed(0, Keys['Z']) then
			if IsOpenMenu then
				CloseHUD()
			else
				ESX.TriggerServerCallback("meeta_radio:checkItem", function(result)
					if result == true then 

						ShowRadio()

						local PlayerPed = PlayerPedId()
						local dict = "random@arrests"
						local anim = "generic_radio_chatter"
		
						LoadAnimDict(dict)
						
						TaskPlayAnim(PlayerPed, dict, anim, 2.0, 2.0, -1, 50, 2.0, 0, 0, 0 )
					
					end
				end, "radio")
			end
		end

		if IsControlJustPressed(0, Config.Key['N']) and IsRadio then
			local PlayerPed = PlayerPedId()
			local dict = "random@arrests"
			local anim = "generic_radio_chatter"

			LoadAnimDict(dict)
			
			TaskPlayAnim(PlayerPed, dict, anim, 2.0, 2.0, -1, 50, 2.0, 0, 0, 0 )

			SendNUIMessage({
				action = "unmute"
			})
			SetNuiFocus(false, false)

		end
		
		if IsControlJustReleased(0, Config.Key['N']) and IsRadio then
			local PlayerPed = PlayerPedId()
			ClearPedTasks(PlayerPed)
			SendNUIMessage({
				action = "onmute"
			})
			SetNuiFocus(false, false)
		end
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		CloseHUD()
	end
end)

function LoadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(0)
    end
end