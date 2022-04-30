ESX = nil
local playersProcessing = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('loffe_fishing:getItems', function(source, cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local fishingRod = xPlayer.getInventoryItem('lrod').count
	local fishingBait = xPlayer.getInventoryItem('lbait').count
	local ultrafishingBait = xPlayer.getInventoryItem('lUbait').count
	local extremefishingBait = xPlayer.getInventoryItem('lEbait').count
	cb(fishingRod, fishingBait, ultrafishingBait, extremefishingBait)
end)

RegisterServerEvent('loffe_fishing:caught')
AddEventHandler('loffe_fishing:caught', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	
	local rnd = math.random(1,100)	
	
		if rnd >= 99 then
		xPlayer.addInventoryItem('broken_gun', 1)
		end		
				
		if rnd >= 20 then
		xPlayer.addInventoryItem('snakeheadfish', 1)
		end
		
		if rnd >= 1 then
		xPlayer.addInventoryItem('catfish', 1)
		end
end)

RegisterServerEvent('loffe_fishing:bait')
AddEventHandler('loffe_fishing:bait', function(item, amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	
	xPlayer.removeInventoryItem(item, amount)
end)

RegisterServerEvent('loffe_fishing:processcat')
AddEventHandler('loffe_fishing:processcat', function()
	if not playersProcessing[source] then
		local _source = source

		playersProcessing[_source] = ESX.SetTimeout(7000, function()
			
			local xPlayer = ESX.GetPlayerFromId(_source)
			local xMin, xMax = xPlayer.getInventoryItem('catfish'), xPlayer.getInventoryItem('catfishfood')
		
			if xMax.limit ~= 20 and (xMax.count + 1) >= xMax.limit then
				--
			elseif xMin.count < 5 then
				--
			else
				xPlayer.removeInventoryItem('catfish', 5)								
				xPlayer.addInventoryItem('catfishfood', 1)
				
			end

			playersProcessing[_source] = nil
		end)
	end
end)

RegisterServerEvent('loffe_fishing:processsnake')
AddEventHandler('loffe_fishing:processsnake', function()
	if not playersProcessing[source] then
		local _source = source

		playersProcessing[_source] = ESX.SetTimeout(7000, function()
			
			local xPlayer = ESX.GetPlayerFromId(_source)
			local xMin, xMax = xPlayer.getInventoryItem('snakeheadfish'), xPlayer.getInventoryItem('snakefishfood')
			if xMax.limit ~= -1 and (xMax.count + 1) >= xMax.limit then
				--
			elseif xMin.count < 1 then
				--
			else
				xPlayer.removeInventoryItem('snakeheadfish', 5)
				xPlayer.addInventoryItem('snakefishfood', 1)
			end

			playersProcessing[_source] = nil
		end)
	end
end)

RegisterServerEvent('loffe_fishing:processriver')
AddEventHandler('loffe_fishing:processriver', function()
	if not playersProcessing[source] then
		local _source = source

		playersProcessing[_source] = ESX.SetTimeout(7000, function()
			
			local xPlayer = ESX.GetPlayerFromId(_source)
			local xMin, xMax = xPlayer.getInventoryItem('rivershrimp'), xPlayer.getInventoryItem('shrimpfood')
			if xMax.limit ~= -1 and (xMax.count + 1) >= xMax.limit then
				--
			elseif xMin.count < 1 then
				--
			else
				xPlayer.removeInventoryItem('rivershrimp', 5)
				xPlayer.addInventoryItem('shrimpfood', 1)
			end

			playersProcessing[_source] = nil
		end)
	end
end)

function CancelProcessing(playerID)
	if playersProcessing[playerID] then
		ESX.ClearTimeout(playersProcessing[playerID])
		playersProcessing[playerID] = nil
	end
end

RegisterServerEvent('loffe_fishing::cancelProcessing')
AddEventHandler('loffe_fishing::cancelProcessing', function()
	CancelProcessing(source)
end)


ESX.RegisterUsableItem('lrod', function(source)
    local xPlayer  = ESX.GetPlayerFromId(source)
    local baitquantity = xPlayer.getInventoryItem('lbait').count
    local ultrabaitquantity = xPlayer.getInventoryItem('lUbait').count
    local extremebaitquantity = xPlayer.getInventoryItem('lEbait').count
    if baitquantity > 0 or ultrabaitquantity > 0 or extremebaitquantity > 0 then
        TriggerClientEvent('loffe-fishing:boatFishing', source)
    else
        TriggerClientEvent('esx:showNotification', source, _U('no_equipment'))
    end
end)

RegisterServerEvent('loffe_fishing:sell')
AddEventHandler('loffe_fishing:sell', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	local itemAmount = xPlayer.getInventoryItem('lfish').count
	if itemAmount > 0 then
		xPlayer.removeInventoryItem('lfish', itemAmount)
		local price = itemAmount*math.random(Config.SellPrice)
		xPlayer.addMoney(price)
		TriggerClientEvent('loffe_fishing:notify', _source, _U('sold') .. price .. ':-')
	end
end)

RegisterServerEvent('loffe_fishing:buyEquipment')
AddEventHandler('loffe_fishing:buyEquipment', function(item, price, amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local itemAmount = xPlayer.getInventoryItem(item).count
	if(xPlayer.getMoney() >= price) then
		if (item == 'lrod' and itemAmount > 0) or (item == 'lbait' and itemAmount >= 200) or (item == 'lUbait' and itemAmount >= 200) or (item == 'lEbait' and itemAmount >= 200) then
			TriggerClientEvent('loffe_fishing:notify', _source, _U('too_much'))
		else
			xPlayer.removeMoney(price)
			xPlayer.addInventoryItem(item, amount)			
		end
	else
		TriggerClientEvent('loffe_fishing:notify', _source, _U('not_enough'))
	end
end)

--[[
]]
