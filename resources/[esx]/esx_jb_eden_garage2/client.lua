-- Local
local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local carInstance 				= {}
local Current_Title1 = "shopui_title_ie_modgarage"
local Current_Title2 = "shopui_title_ie_modgarage"
local IsOpening = false
local times 					= 0
-- Fin Local

-- Init ESX
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) 
		ESX = obj 
		end)
	end
end)

_menuPoolGarage = NativeUI.CreatePool()

--Fonction Menu

function AddMenuGarageInsurance(menu, garage, KindOfVehicle)
	local submenu = _menuPoolGarage:AddSubMenu(menu, "Insurance", "Insure your car.", Current_Title1, Current_Title2)
	
	ESX.TriggerServerCallback('eden_garage:getOutVehicles', function(vehicles)
		if not table.empty(vehicles) then
			for _,v in pairs(vehicles) do

				v.vehicle = json.decode(v.vehicle)
				local hashVehicule = v.vehicle.model
				local vehicleName
				local labelvehicle		
				if v.vehiclename == nil then
					vehicleName = GetDisplayNameFromVehicleModel(hashVehicule)
				else
					vehicleName = v.vehiclename
				end

				labelvehicle = vehicleName.. ' - ~b~'..v.plate
				local Item = NativeUI.CreateItem(labelvehicle, "")
				
				Item:SetArray(v)
				submenu.SubMenu:AddItem(Item)

				submenu.SubMenu.OnItemSelect = function(parent, item, index)
					local object = submenu.SubMenu:GetItemAt(index)._Array
					local hashVehicule = object.vehicle.model
					if object.vehiclename == nil then
						vehicleName = GetDisplayNameFromVehicleModel(hashVehicule)
					else
						vehicleName = object.vehiclename
					end

					local iscaronearth = false
						for kk,vv in pairs (carInstance) do
							if ESX.Math.Trim(vv.plate) == ESX.Math.Trim(object.vehicle.plate) then
								if DoesEntityExist(vv.vehicleentity) then
									iscaronearth = true
								else
									table.remove(carInstance, kk)
									iscaronearth = false
								end
							end
						end

						if object.police == 1 then
							TriggerEvent("pNotify:SendNotification", {
								text = '<strong class="red-text">รถของคุณถูกยึดโดยตำรวจ</strong>',
								type = "error",
								timeout = 3000,
								layout = "bottomCenter",
								queue = "global"
							})
						else
							if not iscaronearth then
								ESX.TriggerServerCallback('eden_garage:checkMoney', function(hasEnoughMoney)
									if hasEnoughMoney then
										SpawnPoundDelete(object.vehicle.plate)
										SpawnPoundedVehicle(object.vehicle, object.vehicle.plate, garage)
										_menuPoolGarage:CloseAllMenus()
										TriggerEvent("pNotify:SendNotification", {
											text = '<strong class="green-text">เบิกรถของคุณเรียบร้อยแล้ว จ่าย '..Config.PricePawn..'</strong>',
											type = "success",
											timeout = 3000,
											layout = "bottomCenter",
											queue = "global"
										})
									else
										TriggerEvent("pNotify:SendNotification", {
											text = '<strong class="red-text">คุณไม่มีเงินเพียงพอ</strong>',
											type = "error",
											timeout = 3000,
											layout = "bottomCenter",
											queue = "global"
										})		
									end
								end, Config.PricePawn)
							else
								TriggerEvent("pNotify:SendNotification", {
									text = '<strong class="red-text">คุณไม่สามารถนำยานพาหนะนี้ออกได้</strong>',
									type = "error",
									timeout = 3000,
									layout = "bottomCenter",
									queue = "global"
								})		
								_menuPoolGarage:CloseAllMenus()
							end
						end

					-- if object.fourrieremecano then
					-- 	TriggerEvent("pNotify:SendNotification", {
					-- 		text = '<strong class="red-text">รถของคุณโดนยึดโดยตำรวจ</strong>',
					-- 		type = "error",
					-- 		timeout = 3000,
					-- 		layout = "bottomCenter",
					-- 		queue = "global"
					-- 	})
					-- else
									
					-- end
				end

			end
		else
			local Item = NativeUI.CreateItem("~r~No vehicles", "")
			submenu.SubMenu:AddItem(Item)
		end

		_menuPoolGarage:RefreshIndex()
		
	end)
	-- local Item = NativeUI.CreateItem("Insurance", "Insure your car.")
	-- menu:AddItem(Item)
	-- menu.OnItemSelect = function(menu, item)
	--    if item == Item then
	--    -- Perform your actions here.
	--    end
	-- end
end

function AddMenuGarageSpawn(menu, garage)
	local vehicleName = ""
	ESX.TriggerServerCallback('eden_garage:getVehicles', function(vehicles)
		if not table.empty(vehicles) then
			for _,v in pairs(vehicles) do

				v.vehicle = json.decode(v.vehicle)
				local hashVehicule = v.vehicle.model
				local vehicleName
				local labelvehicle		
				if v.vehiclename == nil then
					vehicleName = GetDisplayNameFromVehicleModel(hashVehicule)
				else
					vehicleName = v.vehiclename
				end

				local Item = nil

				if (v.state) then
					if v.police == 1 then
						labelvehicle = '~r~' ..vehicleName.. ' - '..v.plate..' ~r~(โดนยึด)'
					else
						labelvehicle = vehicleName.. ' - ~b~'..v.plate
					end
					
				else
					labelvehicle = '~r~' ..vehicleName.. ' - '..v.plate
				end

				local submenu = _menuPoolGarage:AddSubMenu(menu, labelvehicle, "", "shopui_title_carmod2", "shopui_title_carmod2")
				
				Item_Spawn = NativeUI.CreateItem("เรียกรถ", "เรียกรถของคุณออกจากการาท.")
				Item_Change = NativeUI.CreateItem("เปลี่ยนชื่อรถ", "เปลี่ยนชื่อรถของคุณ.")

				Item_Spawn:SetArray(v)
				Item_Change:SetArray(v)

				submenu.SubMenu:AddItem(Item_Spawn)
				submenu.SubMenu:AddItem(Item_Change)

				submenu.SubMenu.OnItemSelect = function(parent, item, index)
					local object = submenu.SubMenu:GetItemAt(index)._Array

					if index == 1 then		
						if object.state then
							if v.police == 1 then
								TriggerEvent("pNotify:SendNotification", {
									text = '<strong class="red-text">รถของคุณถูกยึดโดยตำรวจ</strong>',
									type = "error",
									timeout = 3000,
									layout = "bottomCenter",
									queue = "global"
								})
							else
								_menuPoolGarage:CloseAllMenus()
								SpawnVehicle(object.vehicle, garage, KindOfVehicle, object.health_engine, object.health_body, object.health_tank)
							end
                        else
							TriggerEvent("pNotify:SendNotification", {
								text = '<strong class="red-text">ไม่พบยานพาหนะของคุณ หรือ รถของคุณหาย แต่คุณสามารถประกันรถได้ที่ <span class="orange-text">พาวท์</span></strong>',
								type = "error",
								timeout = 3000,
								layout = "bottomCenter",
								queue = "global"
							})
                        end	
					end

					if index == 2 then
						AddTextEntry('FMMC_KEY_TIP8', "Vehicle Name (Max 20)")
						DisplayOnscreenKeyboard(false, "FMMC_KEY_TIP8", "", "", "", "", "", 20)
						while (UpdateOnscreenKeyboard() == 0) do
							DisableAllControlActions(0)
							Wait(0)
						end
						if (GetOnscreenKeyboardResult()) then
							local result = GetOnscreenKeyboardResult()
							if string.len(result) <= 2 then
								TriggerEvent("pNotify:SendNotification", {
									text = '<span class="red-text">ชื่อรถของคุณสั้นเกินไป</span>',
									type = "error",
									timeout = 3000,
									layout = "bottomCenter",
									queue = "global"
								})
							elseif string.len(result) > 20 then
								TriggerEvent("pNotify:SendNotification", {
									text = '<span class="red-text">ชื่อรถของคุณสั้นยาวไป</span>',
									type = "error",
									timeout = 3000,
									layout = "bottomCenter",
									queue = "global"
								})
							else
								_menuPoolGarage:CloseAllMenus()
								TriggerServerEvent('eden_garage:renamevehicle', object.plate, result)
								TriggerEvent("pNotify:SendNotification", {
									text = 'เปลี่ยนชื่อรถเป็น <strong class="green-text">'..result..'</strong> เรียบร้อยแล้ว',
									type = "error",
									timeout = 3000,
									layout = "bottomCenter",
									queue = "global"
								})
							end
						end
					end

				end
				-- Item:SetArray(v)
				-- submenu.SubMenu:AddItem(Item)

			end
		end
		_menuPoolGarage:RefreshIndex()
		
	end)
end

-- Fonction qui permet de rentrer un vehicule
function StockVehicleMenu(KindOfVehicle)
	local playerPed  = GetPlayerPed(-1)
	if IsPedInAnyVehicle(playerPed,  false) then
		local vehicle =GetVehiclePedIsIn(playerPed,false)
		if GetPedInVehicleSeat(vehicle, -1) == playerPed then
			local GotTrailer, TrailerHandle = GetVehicleTrailerVehicle(vehicle)
			if GotTrailer then
				local trailerProps  = ESX.Game.GetVehicleProperties(TrailerHandle)
				ESX.TriggerServerCallback('eden_garage:stockv',function(valid)
					if(valid) then
						for k,v in pairs (carInstance) do
							if v.plate == trailerplate then
								table.remove(carInstance, k)
							end
						end
						DeleteEntity(TrailerHandle)
						TriggerServerEvent('eden_garage:modifystate', trailerProps.plate, true)
						--TriggerEvent('esx:showNotification', 'Votre remorque est dans le garage')
						TriggerEvent("pNotify:SendNotification", {
							text = '<strong class="red-text">รถของคุณอยู่ในโรงรถ</strong>',
							type = "error",
							timeout = 3000,
							layout = "bottomCenter",
							queue = "global"
						})
					else
						--TriggerEvent('esx:showNotification', 'Vous ne pouvez pas stocker ce véhicule')
						TriggerEvent("pNotify:SendNotification", {
							text = '<strong class="red-text">คุณไม่สามารถจัดเก็บยานพาหนะนี้ได้ เนื่องจากคุณไม่ใช่เจ้าของ</strong>',
							type = "error",
							timeout = 3000,
							layout = "bottomCenter",
							queue = "global"
						})
					end
				end,trailerProps, KindOfVehicle)
			else
				local vehicleProps  = ESX.Game.GetVehicleProperties(vehicle)
				ESX.TriggerServerCallback('eden_garage:stockv',function(valid)
					if(valid) then
						ESX.TriggerServerCallback('eden_garage:checkMoney', function(hasEnoughMoney)
							if hasEnoughMoney then
								for k,v in pairs (carInstance) do
									if v.plate == vehicleplate then
										table.remove(carInstance, k)
									end
								end
								TriggerServerEvent('eden_garage:modifyDamage', vehicleProps.plate, GetVehicleEngineHealth(vehicle), GetVehicleBodyHealth(vehicle), GetVehiclePetrolTankHealth(vehicle))
								DeleteEntity(vehicle)
								TriggerServerEvent('eden_garage:modifystate', vehicleProps.plate, true)
								TriggerEvent("pNotify:SendNotification", {
									text = '<strong class="green-text">เก็บรถของคุณเรียบร้อยแล้ว จ่าย '..Config.Price..'</strong>',
									type = "success",
									timeout = 3000,
									layout = "bottomCenter",
									queue = "global"
								})
							else
								TriggerEvent("pNotify:SendNotification", {
									text = '<strong class="red-text">คุณไม่มีเงินเพียงพอ</strong>',
									type = "error",
									timeout = 3000,
									layout = "bottomCenter",
									queue = "global"
								})		
							end
						end, Config.Price)
						
					else
						--TriggerEvent('esx:showNotification', 'Vous ne pouvez pas stocker ce véhicule')
						TriggerEvent("pNotify:SendNotification", {
							text = '<strong class="red-text">คุณไม่สามารถจัดเก็บยานพาหนะนี้ได้ เนื่องจากคุณไม่ใช่เจ้าของ</strong>',
							type = "error",
							timeout = 3000,
							layout = "bottomCenter",
							queue = "global"
						})
					end
				end,vehicleProps, KindOfVehicle)
			end
		else
			--TriggerEvent('esx:showNotification', 'Vous etes pas conducteur du vehicule')
			TriggerEvent("pNotify:SendNotification", {
				text = '<strong class="red-text">คุณไม่ได้เป็นคนขับยานพาหนะ</strong>',
				type = "error",
				timeout = 3000,
				layout = "bottomCenter",
				queue = "global"
			})
		end
	else
		--TriggerEvent('esx:showNotification', 'Il n\' y a pas de vehicule à rentrer')
		TriggerEvent("pNotify:SendNotification", {
			text = '<strong class="red-text">ไม่มียานพาหนะ</strong>',
			type = "error",
			timeout = 3000,
			layout = "bottomCenter",
			queue = "global"
		})
	end
end

function SpawnVehicle(vehicle, garage, KindOfVehicle, engine, body, tank)
	ESX.Game.SpawnVehicle(vehicle.model, {
		x = garage.SpawnPoint.Pos.x,
		y = garage.SpawnPoint.Pos.y,
		z = garage.SpawnPoint.Pos.z + 1											
	},garage.SpawnPoint.Heading, function(callback_vehicle)
		ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
		SetVehicleEngineHealth(callback_vehicle, engine+0.0)
		SetVehicleBodyHealth(callback_vehicle, body+0.0)
		SetVehiclePetrolTankHealth(callback_vehicle, tank+0.0)
		SetVehicleEngineOn(callback_vehicle, false, false, true)
		TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
		local carplate = GetVehicleNumberPlateText(callback_vehicle)
		table.insert(carInstance, {vehicleentity = callback_vehicle, plate = carplate})
		if KindOfVehicle == 'brewer' or KindOfVehicle == 'joaillerie' or KindOfVehicle == 'fermier' or KindOfVehicle == 'fisherman' or KindOfVehicle == 'fuel' or KindOfVehicle == 'johnson' or KindOfVehicle == 'miner' or KindOfVehicle == 'reporter' or KindOfVehicle == 'vignerons' or KindOfVehicle == 'tabac' then
			TriggerEvent('esx_jobs1:addplate', carplate)
			TriggerEvent('esx_jobs2:addplate', carplate)
		end	
	end)
	TriggerServerEvent('eden_garage:modifystate', vehicle.plate, false)
end

function SpawnPoundDelete(plate)
	local _plate = plate:gsub("^%s*(.-)%s*$", "%1")
	local playerPed  = PlayerPedId()
	if IsPedInAnyVehicle(playerPed,  false) then
		local coords    = GetEntityCoords(playerPed)
		local vehicle =GetVehiclePedIsIn(playerPed,false)
		local vehicleProps  = ESX.Game.GetVehicleProperties(vehicle)
		local usedPlate = vehicleProps.plate:gsub("^%s*(.-)%s*$", "%1")
		if usedPlate == _plate then
			ESX.Game.DeleteVehicle(vehicle)
		end
	end
end

function SpawnPoundedVehicle(vehicle, plate, garage)
	
	ESX.Game.SpawnVehicle(vehicle.model, {
		x = garage.SpawnPoint.Pos.x ,
		y = garage.SpawnPoint.Pos.y,
		z = garage.SpawnPoint.Pos.z + 1											
		}, garage.SpawnPoint.Heading, function(callback_vehicle)
			ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
			SetVehicleEngineOn(callback_vehicle, false, false, true)
		end)
	
	TriggerServerEvent('eden_garage:modifystate', plate, true)
	
	ESX.SetTimeout(10000, function()
		TriggerServerEvent('eden_garage:modifystate', plate, false)
	end)

end

-- Create Blips
Citizen.CreateThread(function()
	for k,v in pairs(Config.Garages) do
		local blip = AddBlipForCoord(v.SpawnPoint.Pos.x, v.SpawnPoint.Pos.y, v.SpawnPoint.Pos.z)
		SetBlipSprite (blip, Config.Blip.sprite)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 1.0)
		SetBlipColour (blip, Config.Blip.color)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Garage")
		EndTextCommandSetBlipName(blip)
	end

	for k,v in pairs(Config.Pawn) do
		local blip = AddBlipForCoord(v.PawnPoint.Pos.x, v.PawnPoint.Pos.y, v.PawnPoint.Pos.z)
		SetBlipSprite (blip, 225)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 1.0)
		SetBlipColour (blip, 47)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Pound")
		EndTextCommandSetBlipName(blip)
	end
end)


-- Display markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local coords = GetEntityCoords(GetPlayerPed(-1))

		if IsPedInAnyVehicle(PlayerPedId(), true) == false then
			-- Pawn
			for k,v in pairs(Config.Pawn) do
				if(GetDistanceBetweenCoords(coords, v.PawnPoint.Pos.x, v.PawnPoint.Pos.y, v.PawnPoint.Pos.z, true) < Config.DrawDistance) then
					DrawMarker(24, v.PawnPoint.Pos.x, v.PawnPoint.Pos.y, v.PawnPoint.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 2.0, 1.0, v.Marker.r, v.Marker.g, v.Marker.b, 200, false, true, 2, false, false, false, false)
				end
			end
			-- Call Car
			for k,v in pairs(Config.Garages) do
				if(GetDistanceBetweenCoords(coords, v.SpawnPoint.Pos.x, v.SpawnPoint.Pos.y, v.SpawnPoint.Pos.z, true) < Config.DrawDistance) then
					DrawMarker(36, v.SpawnPoint.Pos.x, v.SpawnPoint.Pos.y, v.SpawnPoint.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 2.0, 1.0, v.SpawnPoint.Marker.r, v.SpawnPoint.Marker.g, v.SpawnPoint.Marker.b, 100, false, true, 2, false, false, false, false)
				end
			end
		else

			-- Delete
			for k,v in pairs(Config.Garages) do
				if v.DeletePoint then
					if(GetDistanceBetweenCoords(coords, v.DeletePoint.Pos.x, v.DeletePoint.Pos.y, v.DeletePoint.Pos.z, true) < Config.DrawDistance) then
						DrawMarker(20, v.DeletePoint.Pos.x, v.DeletePoint.Pos.y, v.DeletePoint.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 2.0, 1.0, v.DeletePoint.Marker.r, v.DeletePoint.Marker.g, v.SpawnPoint.Marker.b, 100, false, true, 2, false, false, false, false)
					end
				end
			end

		end
	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		_menuPoolGarage:ProcessMenus()
		_menuPoolGarage:ControlDisablingEnabled(false)
		_menuPoolGarage:MouseControlsEnabled(false)
		if not _menuPoolGarage:IsAnyMenuOpen() then
			IsOpening = false
		end
		local coords      = GetEntityCoords(GetPlayerPed(-1))
		local IsInMarker  = false
		local MessageBox = nil
		local CurrentZone = nil
		local CurrentMenu = "Pawn"

		if IsPedInAnyVehicle(PlayerPedId(), true) == false then
			for k,v in pairs(Config.Pawn) do
				if(GetDistanceBetweenCoords(coords, v.PawnPoint.Pos.x, v.PawnPoint.Pos.y, v.PawnPoint.Pos.z, true) < Config.Size.x) and IsPedInAnyVehicle(PlayerPedId(), true) == false then
					IsInMarker  = true
					MessageBox = v.HelpPrompt
					CurrentZone = v
					CurrentMenu = "Pawn"
				end
			end

			for k,v in pairs(Config.Garages) do
				if(GetDistanceBetweenCoords(coords, v.SpawnPoint.Pos.x, v.SpawnPoint.Pos.y, v.SpawnPoint.Pos.z, true) < Config.Size.x) and IsPedInAnyVehicle(PlayerPedId(), true) == false then
					IsInMarker  = true
					MessageBox = v.SpawnPoint.HelpPrompt
					CurrentZone = v
					CurrentMenu = "Spawn"
				end
			end

		else

			for k,v in pairs(Config.Garages) do
				if v.DeletePoint then
					if(GetDistanceBetweenCoords(coords, v.DeletePoint.Pos.x, v.DeletePoint.Pos.y, v.DeletePoint.Pos.z, true) < Config.Size.x) then
						IsInMarker  = true
						MessageBox = v.DeletePoint.HelpPrompt
						CurrentZone = v
						CurrentMenu = "Delete"
					end
				end
			end

		end

		--print(IsInMarker)
		if IsInMarker and IsOpening == false then
			ESX.ShowHelpNotification(MessageBox)
			if IsControlJustPressed(0, Keys['E']) and IsOpening == false then
				if CurrentMenu == "Spawn" then
					_mainMenuGarage = NativeUI.CreateMenu("", "GARAGE", 10.0, 10.0, "shopui_title_carmod2", "shopui_title_carmod2")
					_menuPoolGarage:Add(_mainMenuGarage)
					AddMenuGarageSpawn(_mainMenuGarage,CurrentZone)
					_menuPoolGarage:RefreshIndex()
				
					_mainMenuGarage:Visible(not _mainMenuGarage:Visible()) -- Open Menu
					_menuPoolGarage:ControlDisablingEnabled(false)
					_menuPoolGarage:MouseControlsEnabled(false)

					IsOpening = true
					--ListVehiclesMenu(CurrentZone, "personal")
				elseif CurrentMenu == "Delete" then
					StockVehicleMenu("personal")
				else
					--OpenMenuGarage(CurrentZone, "personal")

					_mainMenuGarage = NativeUI.CreateMenu("", "CAR INSURANCE", 10.0, 10.0, Current_Title1, Current_Title2)
					_menuPoolGarage:Add(_mainMenuGarage)
					AddMenuGarageInsurance(_mainMenuGarage,CurrentZone, "personal")
					_menuPoolGarage:RefreshIndex()
				
					_mainMenuGarage:Visible(not _mainMenuGarage:Visible()) -- Open Menu
					_menuPoolGarage:ControlDisablingEnabled(false)
					_menuPoolGarage:MouseControlsEnabled(false)

					IsOpening = true
					
				end
				
			end
		end

		if not IsInMarker and IsOpening then
			_menuPoolGarage:CloseAllMenus()
		end
	end
end)

-- Fin controle touche
function dump(o, nb)
  if nb == nil then
    nb = 0
  end
   if type(o) == 'table' then
      local s = ''
      for i = 1, nb + 1, 1 do
        s = s .. "    "
      end
      s = '{\n'
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
          for i = 1, nb, 1 do
            s = s .. "    "
          end
         s = s .. '['..k..'] = ' .. dump(v, nb + 1) .. ',\n'
      end
      for i = 1, nb, 1 do
        s = s .. "    "
      end
      return s .. '}'
   else
      return tostring(o)
   end
end

function table.empty (self)
    for _, _ in pairs(self) do
        return false
    end
    return true
end

--- garage societe

RegisterNetEvent('esx_eden_garage:ListVehiclesMenu')
AddEventHandler('esx_eden_garage:ListVehiclesMenu', function(garage, society)
	ListVehiclesMenu(garage, society)
end)

RegisterNetEvent('esx_eden_garage:OpenMenuGarage')
AddEventHandler('esx_eden_garage:OpenMenuGarage', function(garage, society)
	OpenMenuGarage(garage, society)
end)

RegisterNetEvent('esx_eden_garage:StockVehicleMenu')
AddEventHandler('esx_eden_garage:StockVehicleMenu', function(society)
	StockVehicleMenu(society)
end)

RegisterNetEvent('esx_eden_garage:SpawnVehicle')
AddEventHandler('esx_eden_garage:SpawnVehicle', function(vehicle, property)
	ESX.Game.SpawnVehicle(vehicle.model, {
		x = property.garage.Exit.x,
		y = property.garage.Exit.y,
		z = property.garage.Exit.z + 1											
	}, property.garage.Exit.h, function(callback_vehicle)
		ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
		TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
		local carplate = GetVehicleNumberPlateText(callback_vehicle)
		table.insert(carInstance, {vehicleentity = callback_vehicle, plate = carplate})
	end)
	--TriggerServerEvent('eden_garage:modifystate', vehicle.plate, false)
	local data = {
		plate = vehicle.plate,
		state = false,
		id = 0
	}
	TriggerServerEvent('eden_garage:modifystateHouse',data)
end)

RegisterNetEvent('esx_eden_garage:StockVehicleMenuToHouse')
AddEventHandler('esx_eden_garage:StockVehicleMenuToHouse', function(houseId)
	StockVehicleToHouse("personal", houseId)
end)

function StockVehicleToHouse(KindOfVehicle, houseId)
	local playerPed  = GetPlayerPed(-1)
	if IsPedInAnyVehicle(playerPed,  false) then
		local vehicle =GetVehiclePedIsIn(playerPed,false)
		if GetPedInVehicleSeat(vehicle, -1) == playerPed then
			local GotTrailer, TrailerHandle = GetVehicleTrailerVehicle(vehicle)
			if GotTrailer then
				local trailerProps  = ESX.Game.GetVehicleProperties(TrailerHandle)
				ESX.TriggerServerCallback('eden_garage:stockv',function(valid)
					if(valid) then
						for k,v in pairs (carInstance) do
							if v.plate == trailerplate then
								table.remove(carInstance, k)
							end
						end
						DeleteEntity(TrailerHandle)
						local data = {
							plate = trailerProps.plate,
							state = true,
							id = houseId
						}
						TriggerServerEvent('eden_garage:modifystateHouse', data)
						TriggerEvent("pNotify:SendNotification", {
							text = '<strong class="red-text">รถของคุณอยู่ในโรงรถ</strong>',
							type = "error",
							timeout = 3000,
							layout = "bottomCenter",
							queue = "global"
						})
					else
						TriggerEvent("pNotify:SendNotification", {
							text = '<strong class="red-text">คุณไม่สามารถจัดเก็บยานพาหนะนี้ได้ เนื่องจากคุณไม่ใช่เจ้าของ</strong>',
							type = "error",
							timeout = 3000,
							layout = "bottomCenter",
							queue = "global"
						})
					end
				end,trailerProps, KindOfVehicle)
			else
				local vehicleProps  = ESX.Game.GetVehicleProperties(vehicle)
				ESX.TriggerServerCallback('eden_garage:stockv',function(valid)
					if(valid) then
						for k,v in pairs (carInstance) do
							if v.plate == vehicleplate then
								table.remove(carInstance, k)
							end
						end
						DeleteEntity(vehicle)
						local data = {
							plate = vehicleProps.plate,
							state = true,
							id = houseId
						}
						TriggerServerEvent('eden_garage:modifystateHouse', data)
						TriggerEvent("pNotify:SendNotification", {
							text = '<strong class="green-text">เก็บรถของคุณเรียบร้อยแล้ว</strong>',
							type = "success",
							timeout = 3000,
							layout = "bottomCenter",
							queue = "global"
						})
					else
						TriggerEvent("pNotify:SendNotification", {
							text = '<strong class="red-text">คุณไม่สามารถจัดเก็บยานพาหนะนี้ได้ เนื่องจากคุณไม่ใช่เจ้าของ</strong>',
							type = "error",
							timeout = 3000,
							layout = "bottomCenter",
							queue = "global"
						})
					end
				end,vehicleProps, KindOfVehicle)
			end
		else
			TriggerEvent("pNotify:SendNotification", {
				text = '<strong class="red-text">คุณไม่ได้เป็นคนขับยานพาหนะ</strong>',
				type = "error",
				timeout = 3000,
				layout = "bottomCenter",
				queue = "global"
			})
		end
	else
		--TriggerEvent('esx:showNotification', 'Il n\' y a pas de vehicule à rentrer')
		TriggerEvent("pNotify:SendNotification", {
			text = '<strong class="red-text">ไม่มียานพาหนะ</strong>',
			type = "error",
			timeout = 3000,
			layout = "bottomCenter",
			queue = "global"
		})
	end
end