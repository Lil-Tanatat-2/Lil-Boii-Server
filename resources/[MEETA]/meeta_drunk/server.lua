ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('beer', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    TriggerClientEvent("meeta_drunk:drink", _source)
end)

ESX.RegisterUsableItem('energy_drink', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    TriggerClientEvent("meeta_drunk:drinkEnergy", _source)
end)

ESX.RegisterUsableItem('hookah', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xItem = xPlayer.getInventoryItem("weed")
    if xItem.count < 1 then
        TriggerClientEvent("pNotify:SendNotification", source, {
			text = '<strong class="red-text">คุณมี Weed ไม่พอ</strong>',
			type = "success",
			timeout = 3000,
			layout = "bottomCenter",
			queue = "global"
		}) 
    else
        TriggerClientEvent("meeta_drunk:hookah", source)
    end
    
end)

RegisterServerEvent('meeta_drunk:DeleteBeer')
AddEventHandler('meeta_drunk:DeleteBeer', function(amount)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.removeInventoryItem("beer", 1)

end)

RegisterServerEvent('meeta_drunk:DeleteEnergy')
AddEventHandler('meeta_drunk:DeleteEnergy', function(amount)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.removeInventoryItem("energy_drink", 1)

end)

RegisterServerEvent('meeta_drunk:DeleteWeed')
AddEventHandler('meeta_drunk:DeleteWeed', function(amount)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.removeInventoryItem("weed", 1)

end)

ESX.RegisterUsableItem('smoke', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.removeInventoryItem("smoke", 1)
end)