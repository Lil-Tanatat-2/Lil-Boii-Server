-- CREATE BY THANAWUT PROMRAUNGDET
Config = {}

Config.Key = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118, ["Enter"] = 191
}

Config.Discount = 0.9
Config.MaxCount = 300

Config.SellZone = {
	DiamonSell = {
		Text = {
			Title = "DIAMOND STORE",
			SubTitle = "Diamon Store",
			TextHelper = 'Press ~INPUT_DETONATE~ to Sell ~p~Diamond.',
			ProcessText = 'Negotiating with buyers...',
		},
		Animation = {
			Scenario = true,
			AnimationDirect = nil,
			AnimationScene = "WORLD_HUMAN_HANG_OUT_STREET",
		},
		NPC = {
			Model = "u_f_y_jewelass_01",
			Pos = {
				x = -621.69,   
				y = -231.79,  
				z = 38.06,
				h = 121.0
			},
		},
		Blips = {
			Id = 439,
			Color = 56,
			Size = 0.6,
			Text = "Sell Diamond"
		},
		Marker = {
			Type = 25,
			Pos = {
				x = -623.35,   
				y = -233.27,  
				z = 37.06,
			},
			Color = {
				r = 0,
				g = 100,
				b = 200,
				a = 0
			},
			DrawDistance = 100,
			Size = {x = 1.5, y = 1.5, z = 1.5}
		},
		Item = {
			{
				Text = "Diamond",
				Text_TH = "เพชร",
				Unit = "อัน",
				ItemName = "diamond",
				Text_NotHave = "คุณไม่มี <strong class='red-text'>เพชร.</strong>",
				Text_NotHave_Desc = "คุณไม่มี <strong class='red-text'>เพชร.</strong>",
				ListItem = false,
				ItemCount = 1,
				Negotiating = true,
				RandomPrice = true,
				Price = { 2400, 4800},
				Eco_Max = 300,
				Eco_Price = { 2400, 2460, 4800, 4860},
			}
		}
	},
	GoldSell = {
		Text = {
			Title = "BANK",
			SubTitle = "Bank",
			TextHelper = 'Press ~INPUT_DETONATE~ to Sell ~r~Copper Bar ~w~or ~y~Gold Bar.',
			ProcessText = 'Negotiating with buyers...',
		},
		Animation = {
			Scenario = true,
			AnimationDirect = nil,
			AnimationScene = "WORLD_HUMAN_HANG_OUT_STREET",
		},
		NPC = {
			Model = "u_m_m_bankman",
			Pos = {
				x = 253.24,   
				y = 223.18,  
				z = 106.29,
				h = 165.33
			},
		},
		Blips = {
			Id = 439,
			Color = 56,
			Size = 0.6,
			Text = "Sell Copper Bar or Gold Bar"
		},
		Marker = {
			Type = 25,
			Pos = {
				x = 253.49,   
				y = 220.66,  
				z = 105.29,
			},
			Color = {
				r = 0,
				g = 100,
				b = 200,
				a = 0
			},
			DrawDistance = 100,
			Size = {x = 1.5, y = 1.5, z = 1.5}
		},
		Item = {
			{
				Text = "ทองคำแท่ง",
				Text_TH = "ทองคำแท่ง",
				Unit = "อัน",
				ItemName = "gold_bar",
				Text_NotHave = "คุณไม่มี <strong class='red-text'>ทองคำแท่ง.</strong>",
				Text_NotHave_Desc = "คุณไม่มี <strong class='red-text'>ทองคำแท่ง.</strong>",
				ListItem = true,
				ItemCount = 0,
				Negotiating = false,
				RandomPrice = false,
				Price = 800,
				Eco_Max = 300,
				Eco_Price = { 800, 850},
			},
			{
				Text = "แท่งทองแดง",
				Text_TH = "แท่งทองแดง",
				Unit = "อัน",
				ItemName = "copper_bar",
				Text_NotHave = "คุณไม่มี <strong class='red-text'>แท่งทองแดง.</strong>",
				Text_NotHave_Desc = "คุณไม่มี <strong class='red-text'>แท่งทองแดง.</strong>",
				ListItem = true,
				ItemCount = 0,
				Negotiating = false,
				RandomPrice = false,
				Price = 136,
				Eco_Max = 300,
				Eco_Price = { 136, 146},
			}
		}
	},
	StoneSell = {
		Text = {
			Title = "STONE STORE",
			SubTitle = "โรงงานหิน",
			TextHelper = 'Press ~INPUT_DETONATE~ to Sell Stone.',
			ProcessText = 'Negotiating with buyers...',
		},
		Animation = {
			Scenario = true,
			AnimationDirect = nil,
			AnimationScene = "WORLD_HUMAN_HANG_OUT_STREET",
		},
		NPC = {
			Model = "s_m_y_airworker",
			Pos = {
				x = 304.25,   
				y = 2821.75,  
				z = 43.44,
				h = 27.1
			},
		},
		Blips = {
			Id = 318,
			Color = 28,
			Size = 0.6,
			Text = "Sell Stone"
		},
		Marker = {
			Type = 25,
			Pos = {
				x = 303.88,   
				y = 2822.43,  
				z = 42.44,
			},
			Color = {
				r = 0,
				g = 100,
				b = 200,
				a = 0
			},
			DrawDistance = 100,
			Size = {x = 1.5, y = 1.5, z = 1.5}
		},
		Item = {
			{
				Text = "หิน",
				Text_TH = "หิน",
				Unit = "อัน",
				ItemName = "stone",
				Text_NotHave = "คุณไม่มี <strong class='red-text'>หิน.</strong>",
				Text_NotHave_Desc = "คุณไม่มี <strong class='red-text'>หิน.</strong>",
				ListItem = true,
				ItemCount = 0,
				Negotiating = false,
				RandomPrice = false,
				Price = 0.5,
				Eco_Max = 0,
				Eco_Price = { 0.5, 0.5},
			}
		}
	},
	BeltSell = {
		Text = {
			Title = "Bikersuit Sell",
			SubTitle = "ร้านขายเสื้อผ้า",
			TextHelper = 'Press ~INPUT_DETONATE~ to Sell Bikersuit.',
			ProcessText = 'Negotiating with buyers...',
		},
		Animation = {
			Scenario = true,
			AnimationDirect = nil,
			AnimationScene = "WORLD_HUMAN_HANG_OUT_STREET",
		},
		NPC = {},
		Blips = {
			Id = 366,
			Color = 27,
			Size = 0.6,
			Text = "Bikersuit Sell"
		},
		Marker = {
			Type = 25,
			Pos = {
				x = -823.26, 
				y = -1069.33, 
				z = 10.33
			},
			Color = {
				r = 50,
				g = 0,
				b = 200,
				a = 100
			},
			DrawDistance = 100,
			Size = {x = 1.5, y = 1.5, z = 1.5}
		},
		Item = {
			{
				Text = "Gucci Belt",
				Text_TH = "Gucci Belt เข็มขัดหนัง",
				Unit = "อัน",
				ItemName = "bikersuit",
				Text_NotHave = "คุณไม่มี <strong class='red-text'>เข็มขัดหนัง.</strong>",
				Text_NotHave_Desc = "คุณไม่มี <strong class='red-text'>เข็มขัดหนัง.</strong>",
				ListItem = true,
				ItemCount = 0,
				Negotiating = false,
				RandomPrice = false,
				Price = 200,
				Eco_Max = 300,
				Eco_Price = { 200, 250},
			}
		}
	},
	TreeSapSell = {
		Text = {
			Title = "Tree Sap Selling",
			SubTitle = "ร้านแต่งรถ",
			TextHelper = 'Press ~INPUT_DETONATE~ to Sell Tree Sap.',
			ProcessText = 'Negotiating with buyers...',
		},
		Animation = {
			Scenario = true,
			AnimationDirect = nil,
			AnimationScene = "WORLD_HUMAN_HANG_OUT_STREET",
		},
		NPC = {},
		Blips = {
			Id = 238,
			Color = 81,
			Size = 0.6,
			Text = "Tree Sap Sell"
		},
		Marker = {
			Type = 25,
			Pos = {
				x = -226.98,
				y = -1329.22, 
				z = 29.89
			},
			Color = {
				r = 50,
				g = 0,
				b = 200,
				a = 100
			},
			DrawDistance = 100,
			Size = {x = 1.5, y = 1.5, z = 1.5}
		},
		Item = {
			{
				Text = "ยางรถยนต์",
				Text_TH = "ยางรถยนต์",
				Unit = "อัน",
				ItemName = "pro_wood",
				Text_NotHave = "คุณไม่มี <strong class='red-text'>ยางรถยนต์.</strong>",
				Text_NotHave_Desc = "คุณไม่มี <strong class='red-text'>ยางรถยนต์.</strong>",
				ListItem = true,
				ItemCount = 0,
				Negotiating = false,
				RandomPrice = false,
				Price = 200,
				Eco_Max = 300,
				Eco_Price = { 200, 250},
			}
		}
	},
	CrabSell = {
		Text = {
			Title = "Crab Selling",
			SubTitle = "ร้านอาหาร",
			TextHelper = 'Press ~INPUT_DETONATE~ to Sell Crab.',
			ProcessText = 'Negotiating with buyers...',
		},
		Animation = {
			Scenario = true,
			AnimationDirect = nil,
			AnimationScene = "WORLD_HUMAN_HANG_OUT_STREET",
		},
		NPC = {},
		Blips = {
			Id = 181,
			Color = 64,
			Size = 0.6,
			Text = "Crab Sell"
		},
		Marker = {
			Type = 25,
			Pos = {
				x = -602.06,
				y = -1135.55, 
				z = 24.86
			},
			Color = {
				r = 50,
				g = 0,
				b = 200,
				a = 100
			},
			DrawDistance = 100,
			Size = {x = 1.5, y = 1.5, z = 1.5}
		},
		Item = {
			{
				Text = "ปูไขดอง",
				Text_TH = "ปูไขดอง",
				Unit = "จาน",
				ItemName = "glass",
				Text_NotHave = "คุณไม่มี <strong class='red-text'>ปูไขดอง.</strong>",
				Text_NotHave_Desc = "คุณไม่มี <strong class='red-text'>ปูไขดอง.</strong>",
				ListItem = true,
				ItemCount = 0,
				Negotiating = false,
				RandomPrice = false,
				Price = 100,
				Eco_Max = 300,
				Eco_Price = { 100, 150},
			}
		}
	},
	GrassSell = {
		Text = {
			Title = "ขายกาแฟ",
			SubTitle = "ขายกาแฟ",
			TextHelper = 'Press ~INPUT_DETONATE~ to Sell.',
			ProcessText = 'Negotiating with buyers...',
		},
		Animation = {
			Scenario = true,
			AnimationDirect = nil,
			AnimationScene = "WORLD_HUMAN_HANG_OUT_STREET",
		},
		NPC = {},
		Blips = {
			Id = 89,
			Color = 1,
			Size = 0.6,
			Text = "Coffee Dealer"
		},
		Marker = {
			Type = 25,
			Pos = {
				x = 2415.55,
				y = 4993.28, 
				z = 45.23
			},
			Color = {
				r = 50,
				g = 255,
				b = 0,
				a = 100
			},
			DrawDistance = 100,
			Size = {x = 1.5, y = 1.5, z = 1.5}
		},
		Item = {
			{
				Text = "กาแฟขี้วัว",
				Text_TH = "กาแฟขี้วัว",
				Unit = "อัน",
				ItemName = "grass_pack",
				Text_NotHave = "คุณไม่มี <strong class='red-text'>กาแฟขี้วัว.</strong>",
				Text_NotHave_Desc = "คุณไม่มี <strong class='red-text'>กาแฟขี้วัว.</strong>",
				ListItem = true,
				ItemCount = 0,
				Negotiating = false,
				RandomPrice = false,
				Price = 2,
				Eco_Max = 300,
				Eco_Price = { 2, 4},
			}
		}
	},
}