Config = {}
Config.Blip			= {sprite= 290, color = 38}
Config.MecanoBlip	= {sprite= 290, color = 20}
Config.Price		= 25
Config.PricePawn		= 100
Config.DrawDistance = 100
Config.Size         = {x = 3.0, y = 3.0, z = 0.8}

Config.Pawn = {
	Pawn_CapitalBlvd = {	
		Marker = { w= 1.5,h= 1.0,r = 63, g = 81, b = 181, alpha = 80},
		Name = 'Capital BLVD Pound',
		HelpPrompt = "Press ~INPUT_PICKUP~ to open the pound",
		SpawnPoint = {
			Pos = {x=492.84, y=-1331.65, z=29.34},
			Heading = 211.22,
			Marker = { w= 1.5,h= 1.0,r=0,g=255,b=0, alpha = 80}
		},
		PawnPoint = {
			Pos = {x=496.83, y=-1338.23, z=29.32},
			Marker = { w= 1.5,h= 1,r=255,g=0,b=0, alpha = 80},
			HelpPrompt = "Press ~INPUT_PICKUP~ to enter your vehicle",
		}, 	
	},
	Pawn_CapitalBlvd2 = {	
		Marker = { w= 1.5,h= 1.0,r = 63, g = 81, b = 181, alpha = 80},
		Name = 'Sandy Shores Pound',
		HelpPrompt = "Press ~INPUT_PICKUP~ to open the pound",
		SpawnPoint = {
			Pos = {x=1692.35, y=3605.5, z=35.4},
			Heading = 206.5,
			Marker = { w= 1.5,h= 1.0,r=0,g=255,b=0, alpha = 80}
		},
		PawnPoint = {
			Pos = {x=1695.68, y=3611.13, z=35.32},
			Marker = { w= 1.5,h= 1,r=255,g=0,b=0, alpha = 80},
			HelpPrompt = "Press ~INPUT_PICKUP~ to enter your vehicle",
		}, 	
	},
	Pawn_CapitalBlvd3 = {	
		Marker = { w= 1.5,h= 1.0,r = 63, g = 81, b = 181, alpha = 80},
		Name = 'San Andreas Pound',
		HelpPrompt = "Press ~INPUT_PICKUP~ to open the pound",
		SpawnPoint = {
			Pos = {x=-200.79, y=6274.77, z=31.49},
			Heading = 302.36,
			Marker = { w= 1.5,h= 1.0,r=0,g=255,b=0, alpha = 80}
		},
		PawnPoint = {
			Pos = {x=-194.2, y=6268.6, z=31.49},
			Marker = { w= 1.5,h= 1,r=255,g=0,b=0, alpha = 80},
			HelpPrompt = "Press ~INPUT_PICKUP~ to enter your vehicle",
		}, 	
	},
}

Config.Garages = {
	Garage_Centre1 = {	
		Name = 'Sandy Shores Garage',
		SpawnPoint = {
			Pos = {x=1719.22, y= 3772.92, z= 34.33},
			Heading = 23.0,
			Marker = { w= 1.5,h= 1.0,r=0,g=255,b=0, alpha = 80},
			HelpPrompt = "Press ~INPUT_PICKUP~ to exit your vehicle",
		},
		DeletePoint = {
			Pos = {x=1714.9, y=3763.02, z=34.21},
			Marker = { w= 1.5,h= 1,r=255,g=0,b=0, alpha = 80},
			HelpPrompt = "Press ~INPUT_PICKUP~ to enter your vehicle",
		}, 	
	},
	Garage_Centre2 = {	
		Name = 'North Garage',
		HelpPrompt = "Press ~INPUT_PICKUP~ to open the garage",
		SpawnPoint = {
			Pos = {x=111.59, y=6605.83, z= 31.59},
			Heading = 226.0,
			Marker = { w= 1.5,h= 1.0,r=0,g=255,b=0, alpha = 80},
			HelpPrompt = "Press ~INPUT_PICKUP~ to exit your vehicle",
		},
		DeletePoint = {
			Pos = {x=118.83, y=6616.88, z=31.84},
			Marker = { w= 1.5,h= 1,r=255,g=0,b=0, alpha = 80},
			HelpPrompt = "Press ~INPUT_PICKUP~ to enter your vehicle",
		}, 	
	},
	Garage_Centre3 = {	
		Name = 'Centre Garage',
		HelpPrompt = "Press ~INPUT_PICKUP~ to open the garage",
		SpawnPoint = {
			Pos = {x = 229.92,y = -798.27,z = 30.58},
			Heading = 160.0,
			Marker = { w= 1.5,h= 0.5,r=0,g=255,b=0, alpha = 80},
			HelpPrompt = "Press ~INPUT_PICKUP~ to exit your vehicle",
		},
		DeletePoint = {
			Pos = {x = 216.99,y = -785.49,z = 30.842},
			Marker = { w= 1.5,h= 0.5,r=255,g=0,b=0, alpha = 80},
			HelpPrompt = "Press ~INPUT_PICKUP~ to enter your vehicle",
		}, 	
	},		
	Garage_Centre4 = {	
		Name = 'Bottom Garage',
		HelpPrompt = "Press ~INPUT_PICKUP~ to open the garage",
		SpawnPoint = {
			Pos = {x = -50.53,y = -1843.72,z = 26.36},
			Heading = 45.0,
			Marker = { w= 1.5,h= 0.5,r=0,g=255,b=0, alpha = 80},
			HelpPrompt = "Press ~INPUT_PICKUP~ to exit your vehicle",
		},
		-- DeletePoint = {
		-- 	Pos = {x = -70.15,y = -1822.98,z = 26.94},
		-- 	Marker = { w= 1.5,h= 0.5,r=255,g=0,b=0, alpha = 80},
		-- 	HelpPrompt = "Press ~INPUT_PICKUP~ to enter your vehicle",
		-- }, 	
	},	
	Garage_Centre5 = {	
		Name = 'Beach Garage',
		HelpPrompt = "Press ~INPUT_PICKUP~ to open the garage",
		SpawnPoint = {
			Pos = {x = -1277.05,y = -1352.88,z = 4.3},
			Heading = 290.0,
			Marker = { w= 1.5,h= 0.5,r=0,g=255,b=0, alpha = 80},
			HelpPrompt = "Press ~INPUT_PICKUP~ to exit your vehicle",
		},
		-- DeletePoint = {
		-- 	Pos = {x = -1273.76,y = -1364.09,z = 4.3},
		-- 	Marker = { w= 1.5,h= 0.5,r=255,g=0,b=0, alpha = 80},
		-- 	HelpPrompt = "Press ~INPUT_PICKUP~ to enter your vehicle",
		-- }, 	
	},	
	Garage_Centre6 = {	
		Name = 'Vine Wood Garage',
		HelpPrompt = "Press ~INPUT_PICKUP~ to open the garage",
		SpawnPoint = {
			Pos = {x = 609.97,y = 95.32,z = 92.53},
			Heading = 159.0,
			Marker = { w= 1.5,h= 0.5,r=0,g=255,b=0, alpha = 80},
			HelpPrompt = "Press ~INPUT_PICKUP~ to exit your vehicle",
		},
		-- DeletePoint = {
		-- 	Pos = {x = 623.4,y = 129.07,z = 92.87},
		-- 	Marker = { w= 1.5,h= 0.5,r=255,g=0,b=0, alpha = 80},
		-- 	HelpPrompt = "Press ~INPUT_PICKUP~ to enter your vehicle",
		-- }, 	
	},
	Garage_Centre7 = {	
		Name = 'Americano Garage',
		HelpPrompt = "Press ~INPUT_PICKUP~ to open the garage",
		SpawnPoint = {
			Pos = {x = -1655.97,y = 73.44,z = 63.4},
			Heading = 166.63,
			Marker = { w= 1.5,h= 0.5,r=0,g=255,b=0, alpha = 80},
			HelpPrompt = "Press ~INPUT_PICKUP~ to exit your vehicle",
		},
		-- DeletePoint = {
		-- 	Pos = {x = -1673.07,y = 68.32,z = 63.73},
		-- 	Marker = { w= 1.5,h= 0.5,r=255,g=0,b=0, alpha = 80},
		-- 	HelpPrompt = "Press ~INPUT_PICKUP~ to enter your vehicle",
		-- }, 	
	},		
	Garage_Centre8 = {	
		Name = 'Mirror Park Garage',
		HelpPrompt = "Press ~INPUT_PICKUP~ to open the garage",
		SpawnPoint = {
			Pos = {x = 1040.95,y = -777.78,z = 58.02},
			Heading = 1.55,
			Marker = { w= 1.5,h= 0.5,r=0,g=255,b=0, alpha = 80},
			HelpPrompt = "Press ~INPUT_PICKUP~ to exit your vehicle",
		},
		-- DeletePoint = {
		-- 	Pos = {x = 1031.55,y = -761.47,z = 57.95},
		-- 	Marker = { w= 1.5,h= 0.5,r=255,g=0,b=0, alpha = 80},
		-- 	HelpPrompt = "Press ~INPUT_PICKUP~ to enter your vehicle",
		-- }, 	
	},	
	Garage_Centre9 = {	
		Name = 'Alta Garage',
		HelpPrompt = "Press ~INPUT_PICKUP~ to open the garage",
		SpawnPoint = {
			Pos = {x = 290.77,y = -337.61,z = 44.96},
			Heading = 160.78,
			Marker = { w= 1.5,h= 0.5,r=0,g=255,b=0, alpha = 80},
			HelpPrompt = "Press ~INPUT_PICKUP~ to exit your vehicle",
		},
		-- DeletePoint = {
		-- 	Pos = {x = 1031.55,y = -761.47,z = 57.95},
		-- 	Marker = { w= 1.5,h= 0.5,r=255,g=0,b=0, alpha = 80},
		-- 	HelpPrompt = "Press ~INPUT_PICKUP~ to enter your vehicle",
		-- }, 	
	},

	-- garage
	Garage_Centre10 = {	
		Name = 'Alta Garage',
		HelpPrompt = "Press ~INPUT_PICKUP~ to open the garage",
		SpawnPoint = {
			Pos = {x = -306.970,y = -951.26,z = 31.08},
			Heading = 250.78,
			Marker = { w= 1.5,h= 0.5,r=0,g=255,b=0, alpha = 80},
			HelpPrompt = "Press ~INPUT_PICKUP~ to exit your vehicle",
		},
		DeletePoint = {
			Pos = {x = -355.22,y = -959.19,z = 31.08},
			Marker = { w= 1.5,h= 0.5,r=255,g=0,b=0, alpha = 80},
			HelpPrompt = "Press ~INPUT_PICKUP~ to enter your vehicle",
		}, 	
	},
	Garage_Centre11 = {	
		Name = 'Alta Garage',
		HelpPrompt = "Press ~INPUT_PICKUP~ to open the garage",
		SpawnPoint = {
			Pos = {x = -308.21,y = -954.69,z = 31.08},
			Heading = 250.78,
			Marker = { w= 1.5,h= 0.5,r=0,g=255,b=0, alpha = 80},
			HelpPrompt = "Press ~INPUT_PICKUP~ to exit your vehicle",
		},
		-- DeletePoint = {
		-- 	Pos = {x = 1031.55,y = -761.47,z = 57.95},
		-- 	Marker = { w= 1.5,h= 0.5,r=255,g=0,b=0, alpha = 80},
		-- 	HelpPrompt = "Press ~INPUT_PICKUP~ to enter your vehicle",
		-- }, 	
	},
	Garage_Centre12 = {	
		Name = 'Alta Garage',
		HelpPrompt = "Press ~INPUT_PICKUP~ to open the garage",
		SpawnPoint = {
			Pos = {x = -309.472,y = -958.266,z = 31.08},
			Heading = 250.78,
			Marker = { w= 1.5,h= 0.5,r=0,g=255,b=0, alpha = 80},
			HelpPrompt = "Press ~INPUT_PICKUP~ to exit your vehicle",
		},
		-- DeletePoint = {
		-- 	Pos = {x = 1031.55,y = -761.47,z = 57.95},
		-- 	Marker = { w= 1.5,h= 0.5,r=255,g=0,b=0, alpha = 80},
		-- 	HelpPrompt = "Press ~INPUT_PICKUP~ to enter your vehicle",
		-- }, 	
	},
	Garage_Centre13 = {	
		Name = 'Alta Garage',
		HelpPrompt = "Press ~INPUT_PICKUP~ to open the garage",
		SpawnPoint = {
			Pos = {x = -310.711,y = -961.685,z = 31.080},
			Heading = 250.78,
			Marker = { w= 1.5,h= 0.5,r=0,g=255,b=0, alpha = 80},
			HelpPrompt = "Press ~INPUT_PICKUP~ to exit your vehicle",
		},
		-- DeletePoint = {
		-- 	Pos = {x = 1031.55,y = -761.47,z = 57.95},
		-- 	Marker = { w= 1.5,h= 0.5,r=255,g=0,b=0, alpha = 80},
		-- 	HelpPrompt = "Press ~INPUT_PICKUP~ to enter your vehicle",
		-- }, 	
	},
	Garage_Centre14 = {	
		Name = 'Alta Garage',
		HelpPrompt = "Press ~INPUT_PICKUP~ to open the garage",
		SpawnPoint = {
			Pos = {x = -312.019,y = -964.944,z = 31.080},
			Heading = 250.78,
			Marker = { w= 1.5,h= 0.5,r=0,g=255,b=0, alpha = 80},
			HelpPrompt = "Press ~INPUT_PICKUP~ to exit your vehicle",
		},
		-- DeletePoint = {
		-- 	Pos = {x = 1031.55,y = -761.47,z = 57.95},
		-- 	Marker = { w= 1.5,h= 0.5,r=255,g=0,b=0, alpha = 80},
		-- 	HelpPrompt = "Press ~INPUT_PICKUP~ to enter your vehicle",
		-- }, 	
	},
	Garage_Centre15 = {	
		Name = 'Alta Garage',
		HelpPrompt = "Press ~INPUT_PICKUP~ to open the garage",
		SpawnPoint = {
			Pos = {x = -252.95,y = -696.774,z = 33.635},
			Heading = 315.0,
			Marker = { w= 1.5,h= 0.5,r=0,g=255,b=0, alpha = 80},
			HelpPrompt = "Press ~INPUT_PICKUP~ to exit your vehicle",
		},
		-- DeletePoint = {
		-- 	Pos = {x = 1031.55,y = -761.47,z = 57.95},
		-- 	Marker = { w= 1.5,h= 0.5,r=255,g=0,b=0, alpha = 80},
		-- 	HelpPrompt = "Press ~INPUT_PICKUP~ to enter your vehicle",
		-- }, 	
	},
}
