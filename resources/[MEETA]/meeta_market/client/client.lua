-- CREATE BY THANAWUT PROMRAUNGDET

ESX = nil
local IsOpenMenu = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

-- Create Blips
Citizen.CreateThread(function()
	
	for k,v in pairs(Config.Zone) do
		if v.Blips then
			local blip = AddBlipForCoord(v.Marker.Pos.x, v.Marker.Pos.y, v.Marker.Pos.z)
			SetBlipSprite (blip, v.Blips.Id)
			SetBlipDisplay(blip, 3)
			SetBlipScale  (blip, v.Blips.Size)
			SetBlipColour (blip, v.Blips.Color)
			SetBlipAsShortRange(blip, true)
			AddTextEntry('BLIP_MARKET', v.Blips.Text)
			BeginTextCommandSetBlipName("BLIP_MARKET")
			EndTextCommandSetBlipName(blip)
		end
	end

end)

-- สร้างจุดขาย
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		local coords = GetEntityCoords(GetPlayerPed(-1))
		local IsInMarkerSelling  = false
		local CurrentZone = nil

		for k,v in pairs(Config.Zone) do

            if(v.Marker.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Marker.Pos.x, v.Marker.Pos.y, v.Marker.Pos.z, true) < v.Marker.DrawDistance) then
				DrawMarker(v.Marker.Type, v.Marker.Pos.x, v.Marker.Pos.y, v.Marker.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Marker.Size.x, v.Marker.Size.y, v.Marker.Size.z, v.Marker.Color.r, v.Marker.Color.g, v.Marker.Color.b, v.Marker.Color.a, false, true, 2, false, false, false, false)
            end

			if(GetDistanceBetweenCoords(coords, v.Marker.Pos.x, v.Marker.Pos.y, v.Marker.Pos.z, true) < v.Marker.Size.x) then
				IsInMarkerSelling = true
				CurrentZone = v
            end
            
        end


		if IsInMarkerSelling and not IsOpenMenu then
			ESX.ShowHelpNotification(CurrentZone.Text.TextHelper)
			if IsControlJustPressed(0, Config.Key['E']) then
				IsOpenMenu = true
				OpenMenu(CurrentZone)				
			end
		end

	end
end)

function OpenMenu(CurrentZone)
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'market_menu',
	{
		title    = "ตลาด",
		align    = 'top-left',
		elements = {
            {label = "ซื้อ",		value = 'buy'},
            {label = "ขาย",		value = 'sell'},
		}
	}, function(data, menu)
        if data.current.value == "buy" then
            OpenBuyMenu(CurrentZone)
        elseif data.current.value == "sell" then
            OpenSellMenu(CurrentZone)
        end
	end, function(data, menu)
        menu.close()
        IsOpenMenu = false
	end)
end

function OpenBuyMenu(CurrentZone)
    ESX.TriggerServerCallback("meeta_market:getMarketData", function(data)
        if data ~= nil then

            local elements = {}

            for k,v in pairs(data) do
                if v.count <= 0 then
                    table.insert(elements, {
                        label     = v.label .." <span class='red-text'>ไม่มีสินค้า</span>",
                        name      = nil
                    })
                else
                    table.insert(elements, {
                        label     = v.label .." <span class='green-text'>ราคา $"..v.price.." </span> เหลือ <span class='blue-text'>x"..v.count.." </span>",
                        name      = v.item,
                        value     = 1,
                        min       = 1,
                        max       = v.count,
                        type      = 'slider'
                    })
                end
                
            end

            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'market_buy_dialog', {
                title    = "ซื้อวัตถุดิบทำอาหาร",
                align    = 'top-left',
                elements = elements
            }, function(data2, menu2) -- OnEnter

                if data2.current.name ~= nil then
                    ESX.TriggerServerCallback("meeta_market:buyMarketData", function(result)

                    end, data2.current.name, data2.current.value)
                end
                
                menu2.close()
                IsOpenMenu = false

            end, function(data2, menu2)
                menu2.close()
                IsOpenMenu = false
            end, function(data2, value)
    
            end)
            
        end
    end)
end

function OpenSellMenu(CurrentZone)
    ESX.TriggerServerCallback("meeta_market:getPlayerInventory", function(data)
		local elements = {}
		inventory = data.inventory
		for i=1, #CurrentZone.Item, 1 do
			Count = 0
			if inventory ~= nil then
				for key, value in pairs(inventory) do
					if inventory[key].name == CurrentZone.Item[i].ItemName then
						Count = inventory[key].count
						break
					end
				end

				if Count > 0 then 

					local ListCount = {}
    
					for i = 1, Count do ListCount[i] = i end
					
					if CurrentZone.Item[i].ListItem then
						local data = {
							label     = CurrentZone.Item[i].Text_TH .." <span class='green-text'>ราคา $"..CurrentZone.Item[i].Price.." </span>",
							name      = i,
							value     = Count,
							min       = 1,
							max       = Count,
							zone 	 = CurrentZone,
							type      = 'slider'
						}
						table.insert(elements, data)
					end
				else
					table.insert(elements, {
						label = CurrentZone.Item[i].Text_NotHave
					})
				end
			end
		end
		
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'market_sell_dialog', {
			title    = CurrentZone.Text.SubTitle,
			align    = 'top-left',
			elements = elements
		}, function(data2, menu2) -- OnEnter
			if data2.current.zone then
				if data2.current.type == "slider" then
					TriggerServerEvent('meeta_market:sellFunction', data2.current.name, data2.current.zone, data2.current.value)
					menu2.close()
					IsOpenMenu = false
				else
					menu2.close()
					if data2.current.zone.Animation.Scenario then
						TaskStartScenarioInPlace(playerPed, data2.current.zone.Animation.AnimationScene, 0, false)
					else
						ESX.Streaming.RequestAnimDict(data2.current.zone.Animation.AnimationDirect, function()
							TaskPlayAnim(GetPlayerPed(-1), data2.current.zone.Animation.AnimationDirect, data2.current.zone.Animation.AnimationScene, 8.0, -8.0, -1, 0, 0, false, false, false)
						end)							
					end
					ESX.ShowHelpNotification(data2.current.zone.Text.ProcessText)
					Wait(10000)
					TriggerServerEvent('meeta_market:sellFunction', data2.current.name, data2.current.zone, 0)
					ClearPedTasks(playerPed)
				end
			else
				menu2.close()
				IsOpenMenu = false
			end
		end, function(data2, menu2)
			menu2.close()
			IsOpenMenu = false
		end, function(data2, menu2)

		end)

	end, GetPlayerServerId(PlayerId()))
end