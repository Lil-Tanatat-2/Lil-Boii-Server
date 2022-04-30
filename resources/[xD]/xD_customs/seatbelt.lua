local speedBuffer  = {}
local velBuffer    = {}
local beltOn       = false
local wasInCar     = false

Cfg             = {}
Cfg.DiffTrigger = 0.255 
Cfg.MinSpeed    = 19.25 --THIS IS IN m/s
Cfg.Strings     = { belt_on = 'Seat belt closed.', belt_off = 'Seat belt open.' }

IsCar = function(veh)
	local vc = GetVehicleClass(veh)
	return (vc >= 0 and vc <= 7) or (vc >= 9 and vc <= 12) or (vc >= 17 and vc <= 20)
end	

Fwv = function (entity)
	local hr = GetEntityHeading(entity) + 90.0
	if hr < 0.0 then hr = 360.0 + hr end
	hr = hr * 0.0174533
	return { x = math.cos(hr) * 2.0, y = math.sin(hr) * 2.0 }
end

function DrawAdvancedText(x,y ,w,h,sc, text, r,g,b,a,font,jus)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(sc, sc)
	N_0x4e096588b13ffeca(jus)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x - 0.1+w, y - 0.02+h)
end

Citizen.CreateThread(function()
	Citizen.Wait(500)
	while true do
		
		local ped = PlayerPedId()
		local car = GetVehiclePedIsIn(ped)
		
		if car ~= 0 and (wasInCar or IsCar(car)) then
		
			wasInCar = true

			local xx = 0.01135
			local yy = 0.002

			if beltOn then
				DrawAdvancedText(0.362 - xx, 0.90 - yy, 0.015, 0.0028, 0.6, "~g~BELT", 255, 255, 255, 255, 6, 1)
			else
				DrawAdvancedText(0.362 - xx, 0.90 - yy, 0.015, 0.0028, 0.6, "~w~BELT", 255, 255, 255, 255, 6, 1)
			end
			
			if beltOn then DisableControlAction(0, 75) end
			
			speedBuffer[2] = speedBuffer[1]
			speedBuffer[1] = GetEntitySpeed(car)
			
			if speedBuffer[2] ~= nil 
			   and not beltOn
			   and GetEntitySpeedVector(car, true).y > 1.0  
			   and speedBuffer[1] > Cfg.MinSpeed 
			   and (speedBuffer[2] - speedBuffer[1]) > (speedBuffer[1] * Cfg.DiffTrigger) then
			   
				local co = GetEntityCoords(ped)
				local fw = Fwv(ped)
				SetEntityCoords(ped, co.x + fw.x, co.y + fw.y, co.z - 0.47, true, true, true)
				SetEntityVelocity(ped, velBuffer[2].x, velBuffer[2].y, velBuffer[2].z)
				Citizen.Wait(1)
				SetPedToRagdoll(ped, 1000, 1000, 0, 0, 0, 0)
			end
				
			velBuffer[2] = velBuffer[1]
			velBuffer[1] = GetEntityVelocity(car)
				
			if IsControlJustReleased(0, 182) then
				beltOn = not beltOn				  
				if beltOn then 
					TriggerEvent("pNotify:SendNotification",{
						text = Cfg.Strings.belt_on,
						type = "success",
						timeout = (3000),
						layout = "bottomcenter",
						queue = "global"
					})
				else 
					TriggerEvent("pNotify:SendNotification",{
						text = Cfg.Strings.belt_off,
						type = "error",
						timeout = (3000),
						layout = "bottomcenter",
						queue = "global"
					})
				end 
			end
			
		elseif wasInCar then
			wasInCar = false
			beltOn = false
			speedBuffer[1], speedBuffer[2] = 0.0, 0.0
		end
		Citizen.Wait(0)
	end
end)