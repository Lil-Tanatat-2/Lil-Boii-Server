local blips = {}
local blips2 = {}
local PlayerData                = {}
local GUI                       = {}
local sData 					= false
local playerCanSee 				= false
local PlayerData                = {}
ESX                             = nil
local teamID


Citizen.CreateThread(function()
  while ESX == nil do
   TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
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

RegisterNetEvent('meeta_police:squadMenu')
AddEventHandler('meeta_police:squadMenu',function()
	SquadMenu()
end)

RegisterNetEvent('meeta_police:setTeamID')
AddEventHandler('meeta_police:setTeamID',function(teamId)
	teamID = teamId
end)

function SquadMenu()

	local SquadA = "Squad A"

	if teamID == '1' then
		SquadA = SquadA..' <span class="green-text">ON</span>'
	else
		SquadA = SquadA..' <span class="red-text">OFF</span>'
	end
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'squad_interaction',
	{
		title    = "Squad",
		align    = 'top-left',
		elements = {
			{label = SquadA,		value = '1'},
		}
	}, function(data2, menu2)

		TriggerServerEvent('meeta_police:addPoliceToSquad', data2.current.value, nil)
		menu2.close()

	end, function(data2, menu2)
		menu2.close()
	end)
end

-- UpdateSquad
RegisterNetEvent('meeta_police:UpdateSquad')
AddEventHandler('meeta_police:UpdateSquad', function(playertable, name)

	if PlayerData.job ~= nil and PlayerData.job.name == 'police' then

		for i = 0, Config.PlayerMax do
			RemoveBlip(blips[i])
			RemoveBlip(blips2[i])
		end

		for i = 0, Config.PlayerMax do
			for k,v in pairs(playertable) do
				local playerPed = GetPlayerPed(i)
				local playerName = GetPlayerName(i)
				
				if playerName == playertable[k].i and teamID == playertable[k].squad then
			
					local new_blip = AddBlipForEntity(playerPed)
					BeginTextCommandSetBlipName("STRING")
					AddTextComponentString(playertable[k].i)
					EndTextCommandSetBlipName(new_blip)
					
					
					SetBlipCategory(new_blip, 2)
					SetBlipAsShortRange(new_blip, true)

					if playertable[k].siren == true then
						SetBlipSprite(new_blip, 161)
						SetBlipScale(new_blip, 150)
						SetBlipScale(new_blip, 2.0)
						SetBlipColour(new_blip, 1)
						
						local new_blip2 = AddBlipForEntity(playerPed)
						BeginTextCommandSetBlipName("STRING")
						AddTextComponentString(playertable[k].i .. " : Siren On")
						EndTextCommandSetBlipName(new_blip2)
						SetBlipSprite(new_blip2, 1)
						SetBlipScale(new_blip2, 1.0)
						SetBlipColour(new_blip2, 1)
						blips2[k] = new_blip2
						
					else
						SetBlipSprite(new_blip, 1)
						SetBlipScale(new_blip, 1.0)
						SetBlipColour(new_blip, 3)
					end

					blips[k] = new_blip
				end
			end
		end

	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		
		if IsControlJustPressed(1, Config.Key["E"]) and teamID then
			local playerPed = GetPlayerPed(-1)
			local vehicle = GetVehiclePedIsIn(playerPed, false)

			if vehicle ~= 0 then
				local siren = not IsVehicleSirenOn(vehicle)
				TriggerServerEvent('meeta_police:addPoliceToSquad', teamID, siren)
			end
		end
	end
end)