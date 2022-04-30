-- CREATE BY THANAWUT PROMRAUNGDET
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('es:addGroupCommand', 'airdrop_on', 'admin', function(source, args, user)
    local Location = Config.DropZone
    local random_location = math.random(#Location)
    TriggerClientEvent("meeta_airdrop:crateDrop", source, false, 400.0)
    --TriggerClientEvent("meeta_airdrop:sendBlips", -1, Location[random_location].x, Location[random_location].y, Location[random_location].z)
end)

RegisterServerEvent('meeta_airdrop:blips')
AddEventHandler('meeta_airdrop:blips', function(dropCoords)
	print(dropCoords.x)
    TriggerClientEvent("meeta_airdrop:sendBlips", -1, dropCoords.x, dropCoords.y, dropCoords.z)
end)

RegisterServerEvent('meeta_airdrop:dropItemTest')
AddEventHandler('meeta_airdrop:dropItemTest', function(Location, Items)
    ESX.CreatePickupLocation('item_standard', Items.ItemName, Items.ItemCount, Items.ItemLabel, Location)
end)

-- Announcing
TriggerEvent('es:addGroupCommand', 'ประกาศ', "admin", function(source, args, user)
	TriggerClientEvent('chat:addMessage', -1, {
		args = {"^1นายก", table.concat(args, " ")}
	})
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Insufficienct permissions!"} })
end, {help = "Announce a message to the entire server", params = {{name = "announcement", help = "The message to announce"}}})

AddEventHandler('explosionEvent', function(sender, ev)
    if ev.posX > 2000.0 and ev.posY > 2000.0 and ev.posX < 3000.0 and ev.posY < 3000.0 then
        CancelEvent()
    end
end)