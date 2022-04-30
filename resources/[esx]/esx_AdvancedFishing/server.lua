ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function CheckPolice()
	local cops = 0
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			cops = cops + 1
		end
	end
	return cops
end


ESX.RegisterUsableItem('turtlebait', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer then
		if xPlayer.getInventoryItem('fishingrod').count > 0 then
			TriggerClientEvent('fishing:setbait', _source, "turtle")
			
			xPlayer.removeInventoryItem('turtlebait', 1)
			TriggerClientEvent('fishing:message', _source, "~g~You attach the turtle bait onto your fishing rod")
		else
			TriggerClientEvent('fishing:message', _source, "~r~You dont have a fishing rod")
		end
	end
end)

ESX.RegisterUsableItem('fishbait', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer then
		if xPlayer.getInventoryItem('fishingrod').count > 0 then
			TriggerClientEvent('fishing:setbait', _source, "fish2")
			
			xPlayer.removeInventoryItem('fishbait', 1)
			TriggerClientEvent('fishing:message', _source, "~g~You attach the fish bait onto your fishing rod")
			
		else
			TriggerClientEvent('fishing:message', _source, "~r~You dont have a fishing rod")
		end
	end
end)

ESX.RegisterUsableItem('turtle', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer then
		if xPlayer.getInventoryItem('fishingrod').count > 0 then
			TriggerClientEvent('fishing:setbait', _source, "shark")
			
			xPlayer.removeInventoryItem('turtle', 1)
			TriggerClientEvent('fishing:message', _source, "~g~You attach the turtle meat onto the fishing rod")
		else
			TriggerClientEvent('fishing:message', _source, "~r~You dont have a fishing rod")
		end
	end
end)

ESX.RegisterUsableItem('fishingrod', function(source)
	local _source = source
	if _source then
		TriggerClientEvent('fishing:fishstart', _source)
	end	
end)


				
RegisterNetEvent('fishing:catch')
AddEventHandler('fishing:catch', function(bait)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if CheckPolice() < 5 then
		TriggerClientEvent('esx:showNotification', source, 'there must be at least ~b~ 5 cops~s~ in town')
		return
	end
	
	
	if xPlayer then
		local weight = 2
		local rnd = math.random(1,100)
		if bait == "turtle" then
			if rnd >= 78 then
				if rnd >= 94 then
					TriggerClientEvent('fishing:setbait', _source, "none")
					TriggerClientEvent('fishing:message', _source, "~r~It was huge and it broke your fishing rod!")
					TriggerClientEvent('fishing:break', _source)
					xPlayer.removeInventoryItem('fishingrod', 1)
				else
					TriggerClientEvent('fishing:setbait', _source, "none")
					if xPlayer.getInventoryItem('turtle').count > 4 then
						TriggerClientEvent('fishing:message', _source, "~r~You cant hold more turtles")
					else
						TriggerClientEvent('fishing:message', _source, "~g~You caught a turtle\n~r~These are endangered species and are illegal to posses")
						TriggerClientEvent("notifyd", source)
						xPlayer.addInventoryItem('turtle', 1)
					end
				end
			else
				if rnd >= 75 then
					if xPlayer.getInventoryItem('fish2').count > 100 then
						TriggerClientEvent('fishing:message', _source, "~r~You cant hold more fish")
					else
						weight = math.random(1,4)
						TriggerClientEvent('fishing:message', _source, "~g~You caught a fish: ~y~~h~" .. weight .. "kg")
						xPlayer.addInventoryItem('fish2', weight)
					end
					
				else
					if xPlayer.getInventoryItem('fish2').count > 100 then
						TriggerClientEvent('fishing:message', _source, "~r~You cant hold more fish")
					else
						weight = math.random(1,4)
						TriggerClientEvent('fishing:message', _source, "~g~You caught a fish: ~y~~h~" .. weight .. "kg")
						xPlayer.addInventoryItem('fish2', weight)
					end
				end
			end
		else
			if bait == "fish2" then
				if rnd >= 75 then
					TriggerClientEvent('fishing:setbait', _source, "none")
					if xPlayer.getInventoryItem('fish2').count > 100 then
						TriggerClientEvent('fishing:message', _source, "~r~You cant hold more fish")
					else
						weight = math.random(1,4)
						TriggerClientEvent('fishing:message', _source, "~g~You caught a fish: ~y~~h~" .. weight .. "kg")
						xPlayer.addInventoryItem('fish2', weight)
					end
					
				else
					if xPlayer.getInventoryItem('fish2').count > 100 then
						TriggerClientEvent('fishing:message', _source, "~r~You cant hold more fish")
					else
						weight = math.random(1,4)
						TriggerClientEvent('fishing:message', _source, "~g~You caught a fish: ~y~~h~" .. weight .. "kg")
						xPlayer.addInventoryItem('fish2', weight)
					end
				end
			end
			if bait == "none" then
				if rnd >= 70 then
					TriggerClientEvent('fishing:message', _source, "~y~You are currently fishing without any equipped bait")
					if  xPlayer.getInventoryItem('fish2').count > 100 then
							TriggerClientEvent('fishing:message', _source, "~r~You cant hold more fish")
						else
							weight = math.random(1,2)
							TriggerClientEvent('fishing:message', _source, "~g~You caught a fish: ~y~~h~" .. weight .. "kg")
							xPlayer.addInventoryItem('fish2', weight)
						end
						
					else
					TriggerClientEvent('fishing:message', _source, "~y~You are currently fishing without any equipped bait")
					if xPlayer.getInventoryItem('fish2').count > 100 then
						TriggerClientEvent('fishing:message', _source, "~r~You cant hold more fish")
					else
						weight = math.random(1,2)
						TriggerClientEvent('fishing:message', _source, "~g~You caught a fish: ~y~~h~" .. weight .. "kg")
						xPlayer.addInventoryItem('fish2', weight)
					end
				end
			end
			if bait == "shark" then
				if rnd >= 82 then
					if rnd >= 91 then
						TriggerClientEvent('fishing:setbait', _source, "none")
						TriggerClientEvent('fishing:message', _source, "~r~It was huge and it broke your fishing rod!")
						TriggerClientEvent('fishing:break', _source)
						xPlayer.removeInventoryItem('fishingrod', 1)
					else
						if xPlayer.getInventoryItem('shark').count > 3  then
							TriggerClientEvent('fishing:setbait', _source, "none")
							TriggerClientEvent('fishing:message', _source, "~r~You cant hold more sharks")
						else
							TriggerClientEvent('fishing:message', _source, "~g~You caught a shark!\n~r~These are endangered species and are illegal to posses")
							TriggerClientEvent('fishing:spawnPed', _source)
							TriggerClientEvent("notifyd", source)
							xPlayer.addInventoryItem('shark', 1)
						end
					end	
				else
					if xPlayer.getInventoryItem('fish2').count > 100 then
						TriggerClientEvent('fishing:message', _source, "~r~You cant hold more fish")
					else
						weight = math.random(1,4)
						TriggerClientEvent('fishing:message', _source, "~g~You caught a fish: ~y~~h~" .. weight .. "kg")
						xPlayer.addInventoryItem('fish2', weight)
					end				
				end
			end	
		end
	end
end)

RegisterServerEvent("fishing:lowmoney")
AddEventHandler("fishing:lowmoney", function(money)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer then
		xPlayer.removeMoney(money)
	end	
end)

RegisterServerEvent('fishing:startSelling')
AddEventHandler('fishing:startSelling', function(item)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
    if CheckPolice() < 5 then
		TriggerClientEvent('esx:showNotification', source, 'there must be at least ~b~ 5 cops~s~ in town')
		return
	end
	

	if xPlayer then
		if item == "fish2" then
			local FishQuantity = xPlayer.getInventoryItem('fish2').count
			if FishQuantity <= 4 then
				TriggerClientEvent('esx:showNotification', source, '~r~You dont have enough~s~ fish')			
			else   
				xPlayer.removeInventoryItem('fish2', 5)
				local payment = Config.FishPrice.a
				payment = math.random(Config.FishPrice.a, Config.FishPrice.b) 
				xPlayer.addMoney(payment)	
			end	
		end
		if item == "turtle" then
			local FishQuantity = xPlayer.getInventoryItem('turtle').count
			if FishQuantity <= 0 then
				TriggerClientEvent('esx:showNotification', source, '~r~You dont have enough~s~ turtles')			
			else   
				xPlayer.removeInventoryItem('turtle', 1)
				local payment = Config.TurtlePrice.a
				payment = math.random(Config.TurtlePrice.a, Config.TurtlePrice.b) 
				xPlayer.addAccountMoney('black_money', payment)
			end
		end
		if item == "shark" then
			local FishQuantity = xPlayer.getInventoryItem('shark').count
			if FishQuantity <= 0 then
				TriggerClientEvent('esx:showNotification', source, '~r~You dont have enough~s~ sharks')			
			else   
				xPlayer.removeInventoryItem('shark', 1)
				local payment = Config.SharkPrice.a
				payment = math.random(Config.SharkPrice.a, Config.SharkPrice.b)
				xPlayer.addAccountMoney('black_money', payment)	
			end
		end
	end
end)