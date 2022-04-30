playerTeams = {}
ESX                 = nil

local teams = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('meeta_police:addPoliceToSquad')
AddEventHandler('meeta_police:addPoliceToSquad',function(squad, siren)
	
	local xPlayer = ESX.GetPlayerFromId(source)
	local identifier = xPlayer.getIdentifier()
	
	if xPlayer.job.name == 'police' or xPlayer.job.name == 'ambulance' then
		local PlayerName = GetPlayerName(source)	

		if siren == true or siren == false then
			for k,v in pairs(playerTeams) do
				if playerTeams[k].i == PlayerName then
					table.remove(playerTeams,k)
					break
				end
			end

			-- for k,v in pairs(playerTeams) do
			-- 	if playerTeams[k].i == PlayerName then
			-- 		playerTeams[k].siren = siren
			-- 		TriggerClientEvent('meeta_police:UpdateSquad', -1, playerTeams, PlayerName)
			-- 		break
			-- 	end
			-- end

			table.insert(playerTeams, {
				i = PlayerName,
				squad = squad,
				siren = siren
			})

			TriggerClientEvent('meeta_police:UpdateSquad', -1, playerTeams, PlayerName)

		elseif siren == nil then
			local continue = true

			for k,v in pairs(playerTeams) do
				if playerTeams[k].i == PlayerName then
					table.remove(playerTeams,k)
					continue = false
					TriggerClientEvent('meeta_police:setTeamID', source, nil)
					break
				end
			end
	
			if continue then
	
				table.insert(playerTeams, {
					i = PlayerName,
					squad = squad,
					siren = siren
				})
	
				TriggerClientEvent('meeta_police:setTeamID', source, squad)
	
			end
	
			TriggerClientEvent('meeta_police:UpdateSquad', -1, playerTeams, PlayerName)
		end

		
	end

end)