
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('meeta_advanced_craft:DeleteItem')
AddEventHandler('meeta_advanced_craft:DeleteItem', function(Items, Counts)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    for i = 1, #Items, 1 do
        local xItem = xPlayer.getInventoryItem(Items[i])
        if xItem.count <= 0 then
            TriggerClientEvent("pNotify:SendNotification", _source, {
                text = '<strong class="red-text">คุณมี '..xItem.label..' ไม่พอ</strong> ',
                type = "success",
                timeout = 3000,
                layout = "bottomCenter",
                queue = "global"
            }) 
        else
            xPlayer.removeInventoryItem(Items[i], Counts[i])
        end
    end
end)

RegisterServerEvent('meeta_advanced_craft:GiveItem')
AddEventHandler('meeta_advanced_craft:GiveItem', function(Items, ConfigItems, Counts)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    for i = 1, #Items, 1 do
        local xItem = xPlayer.getInventoryItem(Items[i])
        if xItem.count <= 0 then
            TriggerClientEvent("pNotify:SendNotification", _source, {
                text = '<strong class="red-text">คุณมี '..xItem.label..' ไม่พอ</strong> ',
                type = "success",
                timeout = 3000,
                layout = "bottomCenter",
                queue = "global"
            }) 
        else

            local Type = ConfigItems.Reward.Type
            local ItemName = ConfigItems.Reward.ItemName
            local count = ConfigItems.Reward.Count
            local Percent = ConfigItems.Percent
            local Random = math.random(1, 100)

            if Type == "Weapon" then

                if Random <= Percent then
                    xPlayer.addWeapon(ItemName, count)
                    for x = 1, #Items, 1 do
                        xPlayer.removeInventoryItem(Items[x], Counts[x])
                    end
                    TriggerClientEvent("meeta_advanced_craft:SetMessage", _source, '<h5 class="green-text">SUCCESS!</h5>')
                else
                    for x = 1, #Items, 1 do
                        xPlayer.removeInventoryItem(Items[x], Counts[x])
                    end
                    TriggerClientEvent("meeta_advanced_craft:SetMessage", _source, '<h5 class="green-text">SUCCESS </h5> <h5 class="red-text"> But you are not lucky!</h5>')
                end

            elseif Type == "Ammo" then
                if xPlayer.hasWeapon(ItemName) then

                    if Random <= Percent then
                        xPlayer.addWeapon(ItemName, count)
                        for k,v in pairs(Items) do
                            xPlayer.removeInventoryItem(v, Counts[k])
                        end
                        TriggerClientEvent("meeta_advanced_craft:SetMessage", _source, '<h5 class="green-text">SUCCESS!</h5>')
                    else
                        for x = 1, #Items, 1 do
                            xPlayer.removeInventoryItem(Items[x], Counts[x])
                        end
                        TriggerClientEvent("meeta_advanced_craft:SetMessage", _source, '<h5 class="green-text">SUCCESS </h5> <h5 class="red-text"> But you are not lucky!</h5>')
                    end

                else
                    TriggerClientEvent("meeta_advanced_craft:SetMessage", _source, '<h5 class="red-text">คุณต้องมี '..ESX.GetWeaponLabel(ItemName)..' ก่อนถึงจะสามารถคราฟกระสุนได้!</h5>')
                end

            elseif Type == "Item" then

                if Random <= Percent then
                    xPlayer.addInventoryItem(ItemName, count)
                    for k,v in pairs(Items) do
                        xPlayer.removeInventoryItem(v, Counts[k])
                    end
                    TriggerClientEvent("meeta_advanced_craft:SetMessage", _source, '<h5 class="green-text">SUCCESS!</h5>')
                else
                    for x = 1, #Items, 1 do
                        xPlayer.removeInventoryItem(Items[x], Counts[x])
                    end
                    TriggerClientEvent("meeta_advanced_craft:SetMessage", _source, '<h5 class="green-text">SUCCESS </h5> <h5 class="red-text"> But you are not lucky!</h5>')
                end

            end

            break

        end

       

    end
end)