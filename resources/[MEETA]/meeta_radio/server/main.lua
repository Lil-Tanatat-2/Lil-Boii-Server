ESX             = nil
local ShopItems = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('meeta_radio:checkItem', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(item)

	if xItem.count >= 1 then
		cb(true)
	else
		cb(false)
	end
end)