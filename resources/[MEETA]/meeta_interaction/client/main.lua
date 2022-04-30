ESX = nil
local IsHolster = false
local IsRadio = false
local PlayerData = {}
local BeforeWeapon = nil
local SwitchToWeapon = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

-- Police Radio Animation
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local PlayerPed = PlayerPedId()
		if DoesEntityExist(PlayerPed) and not IsEntityDead(PlayerPed) and (PlayerData.job ~= nil and PlayerData.job.name == 'police') then
            if not IsPauseMenuActive() then 

                if IsControlJustPressed(0, Config.Key['LEFTALT']) and (PlayerData.job ~= nil and PlayerData.job.name == 'police') and not IsHolster then -- Left Alt

                    local dict = "random@arrests"
                    local anim = "generic_radio_chatter"
    
                    LoadAnimDict(dict)
                    
                    TaskPlayAnim(PlayerPed, dict, anim, 2.0, 2.0, -1, 50, 2.0, 0, 0, 0 )

                end
                
                if IsControlJustReleased(0, Config.Key['LEFTALT']) and (PlayerData.job ~= nil and PlayerData.job.name == 'police') and not IsHolster then
                    ClearPedTasks(PlayerPed)
                end

                if IsControlJustPressed(0, Config.Key['F1']) and (PlayerData.job ~= nil and PlayerData.job.name == 'police') and not IsHolster then -- Left Alt

                    local dict = "mp_player_int_uppersalute"
                    local anim = "mp_player_int_salute"
    
                    LoadAnimDict(dict)
                    
                    TaskPlayAnim(PlayerPed, dict, anim, 5.0, 5.0, -1, 50, 2.0, 0, 0, 0 )
                end
                
                if IsControlJustReleased(0, Config.Key['F1']) and (PlayerData.job ~= nil and PlayerData.job.name == 'police') and not IsHolster then
                    ClearPedTasks(PlayerPed)
                end

			end 
		end 
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
        local PlayerPed = PlayerPedId()
		if DoesEntityExist(PlayerPed) and not IsEntityDead(PlayerPed) and not IsPedInAnyVehicle(PlayerPedId(), true) and not IsPedInParachuteFreeFall (PlayerPed) then
			LoadAnimDict( "reaction@intimidation@1h" )
			if WeaponIsValid(PlayerPed) then
                if not IsHolster then    
                    Citizen.CreateThread( function()
                        while not IsHolster do
                            Citizen.Wait(0)
                            DisablePlayerFiring(GetPlayerPed(-1),true)
                            DisableControlAction(1, 25, true )
                            DisableControlAction(1, 140, true)
                            DisableControlAction(1, 141, true)
                            DisableControlAction(1, 142, true)
                            DisableControlAction(1, 23, true)
                            DisableControlAction(1, 37, true)
                        end
                    end)
                    TaskPlayAnim(PlayerPed, "reaction@intimidation@1h", "intro", 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
                    SetPedCurrentWeaponVisible(PlayerPed, false)
                    Citizen.Wait(1100)
                    SetPedCurrentWeaponVisible(PlayerPed, true)
                    Citizen.Wait(800)
                    ClearPedTasks(PlayerPed)
                    IsHolster = true
                    BeforeWeapon = GetSelectedPedWeapon(PlayerPed)
				end
            elseif not WeaponIsValid(PlayerPed) then
                if IsHolster then
                    Citizen.CreateThread( function()
                        while not IsHolster do
                            Citizen.Wait(0)
                            DisablePlayerFiring(GetPlayerPed(-1),true)
                            DisableControlAction(1, 25, true )
                            DisableControlAction(1, 140, true)
                            DisableControlAction(1, 141, true)
                            DisableControlAction(1, 142, true)
                            DisableControlAction(1, 23, true)
                            DisableControlAction(1, 37, true)
                        end
                    end)
                    SetCurrentPedWeapon(PlayerPed, BeforeWeapon, true)
                    TaskPlayAnim(PlayerPed, "reaction@intimidation@1h", "outro", 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
                    SetPedCurrentWeaponVisible(PlayerPed, true)
                    Citizen.Wait(1300)
                    SetPedCurrentWeaponVisible(PlayerPed, false)
					
                   
                    Citizen.Wait(700)
                    SetCurrentPedWeapon(PlayerPed, SwitchToWeapon, true)
                    ClearPedTasks(PlayerPed)
                    IsHolster = false
                    SwitchToWeapon = nil
				end
			end
		end
	end
end)

function WeaponIsValid(PlayerPed)
    for i = 1, #Config.Weapon do
        local result, weaponHash = GetCurrentPedWeapon(PlayerPed, false)
        SwitchToWeapon = weaponHash
		if GetHashKey(Config.Weapon[i]) == weaponHash then
			return true
		end
	end
	return false
end

function LoadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(0)
    end
end