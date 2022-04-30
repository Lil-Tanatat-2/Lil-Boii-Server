ESX = nil
local playersProcessingGrass = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('3585d93f-f329-4e6f-9f9a-c7fc12ef2f71')
AddEventHandler('3585d93f-f329-4e6f-9f9a-c7fc12ef2f71', function(itemName, amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer then
		if xPlayer.job ~= nil and xPlayer.job.name == "plowman" then
			local price = Config.GrassDealerItems[itemName]
			local xItem = xPlayer.getInventoryItem(itemName)
			
			if not price then
				--print(('pk_farmer: %s attempted to sell an invalid grass!'):format(xPlayer.identifier))
				return
			end

			if xItem.count < amount then
				TriggerClientEvent('c887068e-8236-45c1-82cf-a60264ca5448', _source, _U('dealer_notenough'))
				return
			end

			price = ESX.Math.Round(price * amount)
			if xPlayer.getGroup() == 'vip' or xPlayer.getGroup() == 'mod' or xPlayer.getGroup() == 'superadmin' then
				xPlayer.addMoney(price * 2)
			else
				xPlayer.addMoney(price)
			end
			xPlayer.removeInventoryItem(xItem.name, amount)

			TriggerClientEvent('c887068e-8236-45c1-82cf-a60264ca5448', _source, _U('dealer_sold', amount, xItem.label, ESX.Math.GroupDigits(price)))
		end	
	end	
end)

RegisterServerEvent('ccf1c87c-df5d-4ef4-991f-45bf47ec2576')
AddEventHandler('ccf1c87c-df5d-4ef4-991f-45bf47ec2576', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer then
		if xPlayer.job ~= nil and xPlayer.job.name == "plowman" then
			local xItem = xPlayer.getInventoryItem('grass')
			local recv_array = math.random(1, 15)
			local recv = 0
			if recv_array > 10 then
				recv = 10
			elseif recv_array < 10 then
				recv = 5
			else
				recv = 15
			end
			if xItem.limit ~= -1 and (xItem.count + recv) > xItem.limit then
				TriggerClientEvent('c887068e-8236-45c1-82cf-a60264ca5448', _source, _U('grass_inventoryfull'))
			else
				xPlayer.addInventoryItem(xItem.name, recv)
			end
		end	
	end	
end)

ESX.RegisterServerCallback('9816ac66-69b5-4f9a-8a17-193b830b4ba5', function(source, cb, item)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer then
		if xPlayer.job ~= nil and xPlayer.job.name == "plowman" then
			local xItem = xPlayer.getInventoryItem(item)

			if xItem.limit ~= -1 and xItem.count >= xItem.limit then
				cb(false)
			else
				cb(true)
			end
		end	
	end	
end)

local function TransformGrass(source)

	SetTimeout(Config.Delays.GrassProcessing, function()
		if playersProcessingGrass[source] == true then
	
			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)
			
			if xPlayer ~= nil then
				local xCannabis, xMarijuana = xPlayer.getInventoryItem('grass'), xPlayer.getInventoryItem('grass_pack')

				if xMarijuana.limit ~= -1 and (xMarijuana.count + 1) > xMarijuana.limit then
					TriggerClientEvent('c887068e-8236-45c1-82cf-a60264ca5448', _source, _U('grass_processingfull'))
					CancelProcessing(source)
				elseif xCannabis.count < 9 then
					TriggerClientEvent('c887068e-8236-45c1-82cf-a60264ca5448', _source, _U('grass_processingenough'))
					CancelProcessing(source)
				else
					xPlayer.removeInventoryItem('grass', 50)
					xPlayer.addInventoryItem('grass_pack', 50)
										
					TransformGrass(source)
				end
			end
		end
	end)	
end

RegisterServerEvent('1666dc4c-4a0c-4b9e-a211-f1277d589ab3')
AddEventHandler('1666dc4c-4a0c-4b9e-a211-f1277d589ab3', function()
	local _source = source

	playersProcessingGrass[_source] = true

	TriggerClientEvent('c887068e-8236-45c1-82cf-a60264ca5448', _source, _U('grass_processed'))
	
	TransformGrass(_source)	
end)


function CancelProcessing(playerID)
	--[[if playersProcessingGrass[playerID] then
		ESX.ClearTimeout(playersProcessingGrass[playerID])
		playersProcessingGrass[playerID] = nil
	end]]--
	playersProcessingGrass[playerID] = false
end

RegisterServerEvent('a25b15f2-e2c4-4b4b-9e70-bbd0809c3554')
AddEventHandler('a25b15f2-e2c4-4b4b-9e70-bbd0809c3554', function()
	CancelProcessing(source)
end)

AddEventHandler('2e1c0a5428282a16171c1c36241f020b3c', function(playerID, reason)
	CancelProcessing(playerID)
end)

RegisterServerEvent('e120b2a4-7136-4137-b0f0-2b25dbdc0937')
AddEventHandler('e120b2a4-7136-4137-b0f0-2b25dbdc0937', function(data)
	CancelProcessing(source)
end)
