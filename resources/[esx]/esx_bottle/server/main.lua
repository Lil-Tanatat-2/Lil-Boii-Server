ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx-ecobottles:sellBottles')
AddEventHandler('esx-ecobottles:sellBottles', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    local currentBottles = xPlayer.getInventoryItem('bottle').count
	local currentPlastic = xPlayer.getInventoryItem('plasticbag').count
    local randomMoney = math.random(3, 7)

    if currentBottles > 0 then
        xPlayer.removeInventoryItem('bottle', currentBottles)
        xPlayer.addMoney(randomMoney * currentBottles)
        TriggerClientEvent('esx:showNotification', src, 'You gave the store ' .. currentBottles .. ' bottles and recieved $' .. randomMoney * currentBottles .. '!')
    else
        TriggerClientEvent('esx:showNotification', src, 'You don\'t have enough bottles!')
    end
	
	 if currentPlastic > 0 then
        xPlayer.removeInventoryItem('plasticbag', currentPlastic)
        xPlayer.addMoney(randomMoney * currentPlastic)
        TriggerClientEvent('esx:showNotification', src, 'You gave the store ' .. currentPlastic .. ' Plastic Bag and recieved $' .. randomMoney * currentPlastic .. '!')
    else
        TriggerClientEvent('esx:showNotification', src, 'You don\'t have enough Plastic Bag!')
    end
	
end)


RegisterServerEvent('esx-ecobottles:retrieveBottle')
AddEventHandler('esx-ecobottles:retrieveBottle', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    local luck = math.random(0, 69)
    local randomBottle = math.random(1, 7)
	local itemAmount = itemamount
	local rnd = math.random(1,100)	

    if luck >= 0 and luck <= 29 then
        TriggerClientEvent('esx:showNotification', src, 'No bottle where found')
    else
        xPlayer.addInventoryItem('bottle', randomBottle)
        TriggerClientEvent('esx:showNotification', src, 'You found ' .. randomBottle .. ' bottles')
    end
	
	if rnd >= 99 then
	xPlayer.addInventoryItem('spring', 1)

	end
		
	if rnd >= 20 then
	xPlayer.addInventoryItem('plasticbag', math.random(1, 3))
	
	end
		
	if rnd >= 10 then
	xPlayer.addInventoryItem('wetshit', 1)
	
	end
		
	
	
end)
