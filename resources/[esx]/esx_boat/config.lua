Config               = {}

Config.Locale = 'en'

Config.LicenseEnable = true -- enable boat license? Requires esx_license
Config.LicensePrice  = 100000

Config.MarkerType    = 1
Config.DrawDistance  = 100.0

Config.Marker = {
	r = 100, g = 204, b = 100, -- blue-ish color
	x = 1.5, y = 1.5, z = 1.0  -- standard size circle
}

Config.StoreMarker = {
	r = 255, g = 0, b = 0,     -- red color
	x = 5.0, y = 5.0, z = 1.0  -- big circle for storing boat
}

Config.Zones = {

	Garages = {

		{ -- Shank St, nearby campaign boat garage
			GaragePos  = vector3(1531.31, 3913.26, 30.5),
			SpawnPoint = vector4(1525.14, 3876.17, 32.0, 96.28),
			StorePos   = vector3(1510.57, 3881.85, 30.61),
			StoreTP    = vector4(1578.05, 3905.11, 31.87, 152.55)
		},


	},

	BoatShops = {

		{ -- Shank St, nearby campaign boat garage
			Outside = vector3(1544.42, 3910.52, 31.0),
			Inside = vector4(1517.79, 3890.01, 30.61, 96.28)
		}

	}

}

Config.Vehicles = {
	{model = 'dinghy', label = 'Dinghy 2 (Random Color)', price = 10000},
	
}