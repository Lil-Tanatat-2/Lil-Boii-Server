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


RegisterServerEvent('loffe_fishing:processsnake')
AddEventHandler('loffe_fishing:processsnake', function()
	if not playersProcessing[source] then
		local _source = source

		playersProcessing[_source] = ESX.SetTimeout(7000, function()
			
			local xPlayer = ESX.GetPlayerFromId(_source)			
			local xMin, xMax = xPlayer.getInventoryItem('snakeheadfish'), xPlayer.getInventoryItem('snakefishfood')
			if xMax.limit ~= 10 and (xMax.count + 1) >= xMax.limit then
				--
			elseif xMin.count < 5 then
				--
			else
				xPlayer.removeInventoryItem('snakeheadfish', 5)		
				xPlayer.addInventoryItem('snakefishfood', 1)
			end

			playersProcessing[_source] = nil
		end)
	end
end)
