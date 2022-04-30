ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

--===========================================================================================================================
-- 'Event Functions' You can use to trigger events/actions on your server/gamemode
--===========================================================================================================================
function OnPlayerBoardAnimal()
	-- You could use these calls to for example save stats of players on how many times they
	-- have ridden animals or so. 
	-- NOTE: I WILL NOT make such scripts or help with them, since those heavily depend on what
	-- YOU need or want, and also on your type of data(base) storage. 
end

function OnPlayerLeaveAnimal()
	-- You could use these calls to for example save stats of players on how many times they
	-- have ridden animals or so. 
	-- NOTE: I WILL NOT make such scripts or help with them, since those heavily depend on what
	-- YOU need or want, and also on your type of data(base) storage. 

	-- The reason I have a OnPlayerBOARDAnimal AND a OnPlayerLeaveAnimal is because we also
	-- keep track of riding time(s), and we do checks for when a farmer for example has 'exit' his
	-- cow to put it in the barn(s)
end

function OnPlayerRequestToRideAnimal()
	-- Check for 'own conditions' on our server if the player is allowed at that time to
	-- even ride/board animals. You could also use that function for example to 'exclude' wanted
	-- players from riding/boarding animals.
	
	-- We for example use it to check if the player has obtained a special perk which makes him/her able
	-- to ride these animals.
	return true
end

--===========================================================================================================================
-- ONE simple setting to allow other players to ride on other players IF they are animals
-- NOTE: you CAN NOT control the other player though!
--===========================================================================================================================
local AllowRidingAnimalPlayers = false

--===========================================================================================================================
-- Here you can set if you used certain mods to replace animal in the game
-- DO NOTE: that you OBVIOUSLY can only replace a certain animal with ONE mod at a time!
-- So you can not replace the deer with two other animals at the same time.
--
-- NOTE: I DO NOT offer support for these mods! I was just a bit more helpful in adding the correct
-- animations and offsets for you guys! You will need to install the mod your self, figure out how
-- to stream it and how to get it to work! These mods are NOT MINE and so I can't (and won't) afford the
-- time to give 'extra support' on mods from other people ;)
--
-- How ever I did decided to add "some mod support" for requested mods, BUT that I support one or two doesn'table
-- mean i will keep adding others endlessly! Since I will have to install them on MY server everytime to test and
-- get the offset right. So: EXTERNAL MOD SUPPORT IS: AS-IS with NO support for installation or whatever.
--
-- **********************************************************************************************
-- Supported Mod(s):
-- **********************************************************************************************
-- Mod Numer one (1):
-- https://www.gta5-mods.com/misc/horse-mod
-- This one replaces the Deer in game, to enable support for this replacement change:
-- IhaveReplacedMyDeerWithModNumber1 = false to: IhaveReplacedMyDeerWithModNumber1 = true
-- **********************************************************************************************
--===========================================================================================================================
IhaveReplacedMyDeerWithModNumber1 = true

--===========================================================================================================================
-- (Global) Script Declarations
--===========================================================================================================================
local HelperMessageID = 0
AnimalControlStatus =  0.05
XNL_IsRidingAnimal = false		-- This one is used so the script knows if it need to run the entire code in
								-- it's main thread or not (and thus performance increasing on idle (not riding))

local Animal = {
	Handle = nil,
	Invincible = false,
	Ragdoll = false,
	Marker = false,
	InControl = false,
	IsFleeing = false,
	Speed = {
		Walk = 2.0,
		Run = 3.0,
	},
}

--===========================================================================================================================
-- Enitiy Enumerator Section
--===========================================================================================================================
local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end
		enum.destructor = nil
		enum.handle = nil
	end
}

function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end
	
		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, entityEnumerator)
	
		local next = true
		repeat
			coroutine.yield(id)
			next, id = moveFunc(iter)
		until not next
	
		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

function EnumeratePeds()
    return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

function GetNearbyPeds(X, Y, Z, Radius)
	local NearbyPeds = {}
	for Ped in EnumeratePeds() do
		if DoesEntityExist(Ped) then
			local PedPosition = GetEntityCoords(Ped, false)
			if Vdist(X, Y, Z, PedPosition.x, PedPosition.y, PedPosition.z) <= Radius then
				table.insert(NearbyPeds, Ped)
			end
		end
	end
	return NearbyPeds
end

--===========================================================================================================================
-- Animal Related Fuctions
--===========================================================================================================================
function Animal.Attach()
	local Ped = PlayerPedId()

	FreezeEntityPosition(Animal.Handle, true)
	FreezeEntityPosition(Ped, true)

	local AnimalPosition = GetEntityCoords(Animal.Handle, false)
	SetEntityCoords(Ped, AnimalPosition.x, AnimalPosition.y, AnimalPosition.z)

	AnimalName = "Deer"
	AnimalType = 1
	XAminalOffSet = 0.0 -- Default DEER offset
	AnimalOffSet  = 0.2  -- Default DEER offset
	--if GetEntityModel(Animal.Handle) == GetHashKey('a_c_cow') then AnimalOffSet = 0.2 end

	if GetEntityModel(Animal.Handle) == GetHashKey('a_c_deer') and IhaveReplacedMyDeerWithModNumber1 then 
		AnimalName = "Horse"
		AnimalType = 1
		AnimalOffSet  = 0.12
		XAminalOffSet = -0.2
	end
	
	
	if GetEntityModel(Animal.Handle) == GetHashKey('a_c_cow') then 
		AnimalName = "Cow"
		AnimalType = 2
		AnimalOffSet  = 0.1
		XAminalOffSet = 0.1
	end
	
	if GetEntityModel(Animal.Handle) == GetHashKey('a_c_boar') then 
		AnimalName = "Boar"
		AnimalOffSet = 0.3
		AnimalType = 3
		XAminalOffSet = -0.0
	end

	if NetworkGetPlayerIndexFromPed(Animal.Handle) == -1 then
		if (HelperMessageID > 2 or HelperMessageID < 2) and not Animal.InControl then
			ESX.ShowHelpNotification('Keep tapping ~INPUT_VEH_ACCELERATE~ to get control of the ' .. AnimalName)
			HelperMessageID = 2
			AnimalControlStatus = 0.05
		end
	end
	
	SetCurrentPedWeapon(Ped, "weapon_unarmed", true)	-- Sets the player to unarmed (no weapons), 
														-- it could "freak out" Peds or Feds, and 'space the weapon' through the animal
	AttachEntityToEntity(Ped, Animal.Handle, GetPedBoneIndex(Animal.Handle, 24816), XAminalOffSet, 0.0, AnimalOffSet, 0.0, 0.0, -90.0, false, false, false, true, 2, true)

	if AnimalType == 1  then
		RequestAnimDict("amb@prop_human_seat_chair@male@generic@base")
		while not HasAnimDictLoaded("amb@prop_human_seat_chair@male@generic@base") do
			Citizen.Wait(250)
		end
		TaskPlayAnim(Ped, "amb@prop_human_seat_chair@male@generic@base", "base", 8.0, 1, -1, 1, 1.0, 0, 0, 0)
	elseif AnimalType == 2 or AnimalType == 3 then
		RequestAnimDict("amb@prop_human_seat_chair@male@elbows_on_knees@idle_a")
		while not HasAnimDictLoaded("amb@prop_human_seat_chair@male@elbows_on_knees@idle_a") do
			Citizen.Wait(250)
		end

		TaskPlayAnim(Ped, "amb@prop_human_seat_chair@male@elbows_on_knees@idle_a", "idle_a", 8.0, 1, -1, 1, 1.0, 0, 0, 0)
	end
	--TaskPlayAnim(Ped, "rcmjosh2", "josh_sitting_loop", 8.0, 1, -1, 2, 1.0, 0, 0, 0)

	
	FreezeEntityPosition(Animal.Handle, false)
	FreezeEntityPosition(Ped, false)
	OnPlayerBoardAnimal() -- Used to do some 'extra stuff' on our server when a player has boarded an animal
						  -- you can also use it to for example save stats like: Ridden Animals: [number of times]
	XNL_IsRidingAnimal = true
end

function Animal.Ride()
	local Ped = PlayerPedId()
	local PedPosition = GetEntityCoords(Ped, false)
	if IsPedSittingInAnyVehicle(Ped) or IsPedGettingIntoAVehicle(Ped) then
		return
	end

	local AttachedEntity = GetEntityAttachedTo(Ped)

	if (IsEntityAttached(Ped)) and (GetEntityModel(AttachedEntity) == GetHashKey("a_c_deer") or GetEntityModel(AttachedEntity) == GetHashKey("a_c_cow") 
	    or GetEntityModel(AttachedEntity) == GetHashKey("a_c_boar")) then
		local SideCoordinates = GetCoordsInfrontOfEntityWithDistance(AttachedEntity, 1.0, 90.0)
		local SideHeading = GetEntityHeading(AttachedEntity)

		SideCoordinates.z = GetGroundZ(SideCoordinates.x, SideCoordinates.y, SideCoordinates.z)

		Animal.Handle = nil
		Animal.InControl = false
		DetachEntity(Ped, true, false)
		ClearPedSecondaryTask(Ped)
		ClearPedTasksImmediately(Ped)

		AminD2 = "amb@prop_human_seat_chair@male@elbows_on_knees@react_aggressive"
		RequestAnimDict(AminD2)
		while not HasAnimDictLoaded(AminD2) do
			Citizen.Wait(0)
		end
		TaskPlayAnim(Ped, AminD2, "exit_left", 8.0, 1, -1, 0, 1.0, 0, 0, 0)
		Wait(100)
		SetEntityCoords(Ped, SideCoordinates.x, SideCoordinates.y, SideCoordinates.z)
		SetEntityHeading(Ped, SideHeading)
		ClearPedSecondaryTask(Ped)
		ClearPedTasksImmediately(Ped)
		RemoveAnimDict(AminD2)
		OnPlayerLeaveAnimal() -- Used on our server to do 'stuff' when the player got of the animal
		if HelperMessageID > 0 then
			HelperMessageID = 0
			ClearAllHelpMessages()				
		end

	else
		for _, Ped in pairs(GetNearbyPeds(PedPosition.x, PedPosition.y, PedPosition.z, 2.0)) do
			if not IsPedFalling(Ped) and not IsPedFatallyInjured(Ped) and not IsPedDeadOrDying(Ped) 
			   and not IsPedDeadOrDying(Ped) and not IsPedGettingUp(Ped) and not IsPedRagdoll(Ped) then
				if (GetEntityModel(Ped) == GetHashKey("a_c_deer") or GetEntityModel(Ped) == GetHashKey("a_c_cow")
					or GetEntityModel(Ped) == GetHashKey("a_c_boar")) then
					
					if NetworkGetPlayerIndexFromPed(Ped) > -1 and not AllowRidingAnimalPlayers then
						return
					end
					
					
					-- Here we do a simple scan to see if there are other Peds in the radius of the animal
					-- (although for 'all safety' I've made this scan a bit bigger)
					-- If it turns out if there is a player nearby it will then compare if that Entity (The other player)
					-- if attached to the 'just detected entity (the animal)'. If this is the case we will NOT allow the
					-- player to "also" board the animal
					for _, Ped2 in pairs(GetNearbyPeds(PedPosition.x, PedPosition.y, PedPosition.z, 4.0)) do
						if IsEntityAttachedToEntity(Ped2, Ped) then
							return
						end
					end

					-- Check for 'own conditions' on our server if the player is allowed at that time to
					-- even ride/board animals. You could also use that function for example to 'exclude' wanted
					-- players from riding/boarding animals
					if OnPlayerRequestToRideAnimal() then
						Animal.Handle = Ped
						Animal.Attach()
					end
					break
				end
			end
		end
	end
end

function DropPlayerFromAnimal()
	local Ped = PlayerPedId()
	Animal.Handle = nil
	DetachEntity(Ped, true, false)
	ClearPedTasksImmediately(Ped)
	ClearPedSecondaryTask(Ped)
	Animal.InControl = false
	AminD2 = "amb@prop_human_seat_chair@male@elbows_on_knees@react_aggressive"
	RequestAnimDict(AminD2)
	while not HasAnimDictLoaded(AminD2) do
		Citizen.Wait(0)
	end
	TaskPlayAnim(Ped, AminD2, "exit_left", 8.0, 1, -1, 0, 1.0, 0, 0, 0)
	Wait(100)
	ClearPedSecondaryTask(Ped)
	ClearPedTasksImmediately(Ped)
	Wait(100)
	SetPedToRagdoll(Ped, 1500, 1500, 0, 0, 0, 0)
	AnimalControlStatus = 0
	OnPlayerLeaveAnimal() -- Used on our server to do 'stuff' when the player got of the animal
	XNL_IsRidingAnimal = false
end

--===========================================================================================================================
-- Main 'Helper' functions
--===========================================================================================================================
function GetCoordsInfrontOfEntityWithDistance(Entity, Distance, Heading)
	local Coordinates = GetEntityCoords(Entity, false)
	local Head = (GetEntityHeading(Entity) + (Heading or 0.0)) * math.pi / 180.0
	return {x = Coordinates.x + Distance * math.sin(-1.0 * Head), y = Coordinates.y + Distance * math.cos(-1.0 * Head), z = Coordinates.z}
end

function GetGroundZ(X, Y, Z)
	if tonumber(X) and tonumber(Y) and tonumber(Z) then
		local _, GroundZ = GetGroundZFor_3dCoord(X + 0.0, Y + 0.0, Z + 0.0, Citizen.ReturnResultAnyway())
		return GroundZ
	else
		return 0.0
	end
end

--===========================================================================================================================
-- Controling Threads
--===========================================================================================================================
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(50)
		if AnimalControlStatus > 0 then
			AnimalControlStatus = AnimalControlStatus - 0.001
		end
	end

end)

local group = "user"
RegisterNetEvent('46e4402d-2e6d-4fc1-a97e-70874c8aed85')
AddEventHandler('46e4402d-2e6d-4fc1-a97e-70874c8aed85', function(g)
	group = g
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
			-- This is (BY DEFAULT HOWEVER!) the [E] key
			if IsControlJustPressed(1, 51) then
				Animal.Ride()
			end

			if XNL_IsRidingAnimal then
				local Ped = PlayerPedId()
				local AttachedEntity = GetEntityAttachedTo(Ped)
				if (not IsPedSittingInAnyVehicle(Ped) or not IsPedGettingIntoAVehicle(Ped)) and IsEntityAttached(Ped) and AttachedEntity == Animal.Handle then
					if DoesEntityExist(Animal.Handle) then
						AnimalChecksOkay = true 		-- We set the 'animal state' default to true
						
						-- Here we check if the animal is 'okay' (not dead, tripped, run over etc etc),
						-- if the animal is 'not okay' we'll make the player fall off/ragdoll.
						-- same goes for when the player is 'not okay' anymore 
						if IsPedFalling(AttachedEntity) or IsPedFatallyInjured(AttachedEntity) or IsPedDeadOrDying(AttachedEntity) 
						   or IsPedDeadOrDying(AttachedEntity) or IsPedDeadOrDying(Ped) or IsPedGettingUp(AttachedEntity) or IsPedRagdoll(AttachedEntity) then
							Animal.IsFleeing = false
							Animal.InControl = false
							AnimalChecksOkay = false
							DropPlayerFromAnimal()
						end
					
						-- If the animal checks out all okay, we'll resume riding it
						if AnimalChecksOkay then
							local LeftAxisXNormal, LeftAxisYNormal = GetControlNormal(2, 218), GetControlNormal(2, 219)
							local Speed, Range = Animal.Speed.Walk, 4.0
			
							-- Make the animal 'run', however this is 'kinda buggy' and not totally satisfactory,
							-- so you could disable the following four lines of code to 'disable animal running'
							if IsControlPressed(0, 21) then
								Speed = Animal.Speed.Run
								Range = 8.0
							end
			
							if Animal.InControl then
								Animal.IsFleeing = false
								local GoToOffset = GetOffsetFromEntityInWorldCoords(Animal.Handle, LeftAxisXNormal * Range, LeftAxisYNormal * -1.0 * Range, 0.0)
				
								TaskLookAtCoord(Animal.Handle, GoToOffset.x, GoToOffset.y, GoToOffset.z, 0, 0, 2)
								TaskGoStraightToCoord(Animal.Handle, GoToOffset.x, GoToOffset.y, GoToOffset.z, Speed, 20000, 40000.0, 0.5)
				
								if Animal.Marker then
									DrawMarker(6, GoToOffset.x, GoToOffset.y, GoToOffset.z, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 255, 255, 255, 0, 0, 2, 0, 0, 0, 0)
								end
							else
								if NetworkGetPlayerIndexFromPed(Animal.Handle) == -1 then
									-- Tapping (Default) the [W] key to gain control of the animal
									if IsControlJustPressed(1, 71) then
										if AnimalControlStatus < 0.1 then
											AnimalControlStatus = AnimalControlStatus + 0.005
											if AnimalControlStatus > 0.1 then 
												AnimalControlStatus = 0.1 
												if HelperMessageID > 4 or HelperMessageID < 4 then
													ESX.ShowHelpNotification("You've gained control of the animal.")
													HelperMessageID = 4
													AnimalControlStatus = 0
													Animal.InControl = true
												end
											end
										end
									end
								
									if AnimalControlStatus <= 0.001 and not Animal.InControl then
										if HelperMessageID > 3 or HelperMessageID < 3 then
											ESX.ShowHelpNotification("You've the lost your grip and fell off.")
											HelperMessageID = 3
										end
										DropPlayerFromAnimal()
									end
									
									if not Animal.IsFleeing then
										Animal.IsFleeing = true
										TaskSmartFleePed(Animal.Handle, Ped, 9000.0, -1, false, false)
									end
								end
							end
						end
					end
				end
				-- PKS.in.TH
				if not IsEntityAttached(Ped) or AttachedEntity == -1 then
					DropPlayerFromAnimal()
				end
			end
	end
end)