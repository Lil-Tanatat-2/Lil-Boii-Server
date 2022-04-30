for _, info in pairs(Config.MarkerZones) do
	info.blip = AddBlipForCoord(info.x, info.y, info.z)
	SetBlipSprite(info.blip, 431)
	SetBlipDisplay(info.blip, 4)
	SetBlipScale(info.blip, 1.0)
	SetBlipColour(info.blip, 70)
	SetBlipAsShortRange(info.blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Casino")
	EndTextCommandSetBlipName(info.blip)
end