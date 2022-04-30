ESX = nil
local playersProcessingGrass = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

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
