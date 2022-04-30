ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('rag', function(source)
    local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)

	TriggerClientEvent('meeta_advanced_vehicle:washCar', _source)
end)

ESX.RegisterUsableItem('fixkit', function(source)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)

	TriggerClientEvent('meeta_advanced_vehicle:onFixkit', _source)
end)


RegisterServerEvent('meeta_advanced_vehicle:DeleteItem')
AddEventHandler('meeta_advanced_vehicle:DeleteItem', function(Item)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.removeInventoryItem(Item, 1)

end)