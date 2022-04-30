ESX = nil
local Worek = nil
local wait_bag = 600
local HaveBagOnHead = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		local ped = GetPlayerPed(-1)

		if HaveBagOnHead then
				if wait_bag <= 0 then
					DeleteEntity(Worek)
          SetEntityAsNoLongerNeeded(Worek)
          SendNUIMessage({type = 'closeAll'})
          HaveBagOnHead = false
				else
					wait_bag = wait_bag -1
				end

			end
		end
end)

function NajblizszyGracz() --This function send to server closestplayer

  local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
  local player = GetPlayerPed(-1)

  if closestPlayer == -1 or closestDistance > 2.0 then 
      ESX.ShowNotification('~r~There is no player nearby')
  else
    if not HaveBagOnHead then
      TriggerServerEvent('esx_worek:sendclosest', GetPlayerServerId(closestPlayer))
      ESX.ShowNotification('~g~You put the head bag on ~w~' .. GetPlayerName(closestPlayer))
      TriggerServerEvent('esx_worek:closest')
    else
      ESX.ShowNotification('~r~This player already have a bag on head')
    end
  end

end

RegisterNetEvent('esx_worek:naloz') --This event open menu
AddEventHandler('esx_worek:naloz', function()
  TriggerEvent('esx_inventoryhud:closeHud')
    OpenBagMenu()
end)

RegisterNetEvent('esx_worek:nalozNa') --This event put head bag on nearest player
AddEventHandler('esx_worek:nalozNa', function(gracz)
    local playerPed = GetPlayerPed(-1)
    Worek = CreateObject(GetHashKey("prop_money_bag_01"), 0, 0, 0, true, true, true) -- Create head bag object!
    AttachEntityToEntity(Worek, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 12844), 0.2, 0.04, 0, 0, 270.0, 60.0, true, true, false, true, 1, true) -- Attach object to head
    SetNuiFocus(false,false)
    SendNUIMessage({type = 'openGeneral'})
    HaveBagOnHead = true
end)    

AddEventHandler('playerSpawned', function() --This event delete head bag when player is spawn again
DeleteEntity(Worek)
SetEntityAsNoLongerNeeded(Worek)
SendNUIMessage({type = 'closeAll'})
HaveBagOnHead = false
end)

RegisterNetEvent('esx_worek:zdejmijc') --This event delete head bag from player head
AddEventHandler('esx_worek:zdejmijc', function(gracz)
    ESX.ShowNotification('~g~Someone removed the bag from your head!')
    DeleteEntity(Worek)
    SetEntityAsNoLongerNeeded(Worek)
    SendNUIMessage({type = 'closeAll'})
    HaveBagOnHead = false
end)

function OpenBagMenu() --This function is menu function

    local elements = {
          {label = 'Put bag on head', value = 'puton'},
          {label = 'Remove bag from head', value = 'putoff'},
          
        }
  
    ESX.UI.Menu.CloseAll()
  
    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'headbagging',
      {
        title    = 'HEAD BAG MENU',
        align    = 'top-left',
        elements = elements
        },
  
            function(data2, menu2)
  
  
              local player, distance = ESX.Game.GetClosestPlayer()
  
              if distance ~= -1 and distance <= 2.0 then
  
                if data2.current.value == 'puton' then
                    NajblizszyGracz()
                end
  
                if data2.current.value == 'putoff' then
                  TriggerServerEvent('esx_worek:zdejmij')
                end
              else
                ESX.ShowNotification('~r~There is no player nearby.')
              end
            end,
      function(data2, menu2)
        menu2.close()
      end
    )
  
  end

