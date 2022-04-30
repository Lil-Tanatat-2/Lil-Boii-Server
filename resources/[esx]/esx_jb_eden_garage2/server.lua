ESX                = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterServerCallback('eden_garage:getVehicles', function(source, cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local vehicules = {}

	MySQL.Async.fetchAll("SELECT * FROM `owned_vehicles` WHERE `owner`=@identifier AND `properties` = 0",{['@identifier'] = xPlayer.getIdentifier()}, function(data) 
		for _,v in pairs(data) do
			local plate = v.plate
			table.insert(vehicules, {vehicle = v.vehicle, state = v.stored, fourrieremecano = v.fourrieremecano, plate = plate, vehiclename = v.vehiclename, police = v.police, health_engine = v.health_engine, health_body = v.health_body, health_tank = v.health_tank })
		end
		cb(vehicules)
	end)
end)

--Stock les véhicules
ESX.RegisterServerCallback('eden_garage:stockv',function(source,cb, vehicleProps)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local vehplate = vehicleProps.plate
	local vehiclemodel = vehicleProps.model
	MySQL.Async.fetchAll("SELECT * FROM `owned_vehicles` where `plate`=@plate and `owner`=@identifier",{
		['@plate'] = vehplate, 
		['@identifier'] = xPlayer.identifier
	}, function(result)  
		if result[1] ~= nil then
			local veh = json.decode(result[1].vehicle)
			if veh.model == vehiclemodel then
				local vehprop = json.encode(vehicleProps)
				MySQL.Async.execute("UPDATE `owned_vehicles` SET `vehicle`=@vehprop WHERE plate=@plate",{
					['@vehprop'] = vehprop, 
					['@plate'] = vehplate
				})
				cb(true)
			end	
		else
			cb(false)
		end
	end)
end)

--Change le state du véhicule
RegisterServerEvent('eden_garage:modifystate')
AddEventHandler('eden_garage:modifystate', function(plate, state)
	local plate = plate
	MySQL.Async.execute("UPDATE `owned_vehicles` SET `stored` =@state, `properties` = 0 WHERE `plate`=@plate",{['@state'] = state , ['@plate'] = plate})
end)

RegisterServerEvent('eden_garage:modifyDamage')
AddEventHandler('eden_garage:modifyDamage', function(plate, damage, body, tank)
	local plate = plate
	MySQL.Async.execute("UPDATE `owned_vehicles` SET `health_engine`=@damage, `health_body`=@body, `health_tank`=@tank WHERE `plate`=@plate",{
		['@damage'] = damage, 
		['@body'] = body, 
		['@tank'] = tank, 
		['@plate'] = plate
	})
end)	

RegisterServerEvent('eden_garage:modifystateHouse')
AddEventHandler('eden_garage:modifystateHouse', function(data)
	local plate = data.plate
	MySQL.Async.execute("UPDATE `owned_vehicles` SET `stored` =@state, `properties` = @id WHERE `plate`=@plate",{
		['@state'] = data.state, 
		['@plate'] = plate,
		['@id'] = data.id
	})
end)


RegisterServerEvent('eden_garage:renamevehicle')
AddEventHandler('eden_garage:renamevehicle', function(vehicleplate, name)
	local vehicleplate = vehicleplate
	MySQL.Async.execute("UPDATE `owned_vehicles` SET `vehiclename` =@vehiclename WHERE `plate`=@plate",{['@vehiclename'] = name , ['@plate'] = vehicleplate})
end)

ESX.RegisterServerCallback('eden_garage:getOutVehicles',function(source, cb)	
	local _source = source
	local vehicules = {}
	local identifier = GetPlayerIdentifiers(_source)[1]

	MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE `owner`=@identifier AND `stored`=false",{['@identifier'] = identifier}, function(data) 
		for _,v in pairs(data) do
			table.insert(vehicules, {vehicle = v.vehicle, vehiclename =  v.vehiclename, plate = v.plate, vehiclename = v.vehiclename, police = v.police, health_engine = v.health_engine, health_body = v.health_body, health_tank = v.health_tank })
		end
		cb(vehicules)
	end)
end)

--Foonction qui check l'argent
ESX.RegisterServerCallback('eden_garage:checkMoney', function(source, cb, money)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.get('money') >= money then
		xPlayer.removeMoney(money)
		cb(true)
	else
		cb(false)
	end
end)
--Fin Foonction qui check l'argent

-- Fonction qui change les etats sorti en rentré lors d'un restart
-- AddEventHandler('onMySQLReady', function()

	-- MySQL.Async.execute("UPDATE owned_vehicles SET state=true WHERE state=false", {})

-- end)
-- Fin Fonction qui change les etats sorti en rentré lors d'un restart

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