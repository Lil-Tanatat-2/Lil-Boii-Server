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
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

Config.Zone = {
	Market = {
		Text = {
			Title = "MARKET",
			SubTitle = "Market",
			TextHelper = 'Press ~INPUT_PICKUP~ to open ~b~Menu.'
		},
		Blips = {
			Id = 59,
			Color = 3,
			Size = 0.8,
			Text = "Selling Vegetables"
		},
		Marker = {
			Type = 29,
			Pos = {
				x = -1236.29,
				y = -289.88, 
				z = 37.61
			},
			Color = {
				r = 0,
				g = 255,
				b = 0,
				a = 100
			},
			DrawDistance = 20,
			Size = {x = 1.5, y = 1.5, z = 1.5}
		},
		Item = {
			{
				Text = "ข้าวโพด",
				Text_TH = "ข้าวโพด",
				Unit = "อัน",
				ItemName = "cook_corn",
				Text_NotHave = "คุณไม่มี <strong class='red-text'>ข้าวโพด.</strong>",
				Text_NotHave_Desc = "คุณไม่มี <strong class='red-text'>ข้าวโพด.</strong>",
				ListItem = true,
				ItemCount = 0,
				RandomPrice = false,
				Price = 1,
			},
			{
				Text = "แป้งข้าวโพด",
				Text_TH = "แป้งข้าวโพด",
				Unit = "กก",
				ItemName = "cook_cornflour",
				Text_NotHave = "คุณไม่มี <strong class='red-text'>แป้งข้าวโพด.</strong>",
				Text_NotHave_Desc = "คุณไม่มี <strong class='red-text'>แป้งข้าวโพด.</strong>",
				ListItem = true,
				ItemCount = 0,
				RandomPrice = false,
				Price = 2,
			},
			{
				Text = "ผักกาด",
				Text_TH = "ผักกาด",
				Unit = "กก",
				ItemName = "cook_lettuce",
				Text_NotHave = "คุณไม่มี <strong class='red-text'>ผักกาด.</strong>",
				Text_NotHave_Desc = "คุณไม่มี <strong class='red-text'>ผักกาด.</strong>",
				ListItem = true,
				ItemCount = 0,
				RandomPrice = false,
				Price = 1,
			},
			{
				Text = "ต้นข้าว",
				Text_TH = "ต้นข้าว",
				Unit = "กก",
				ItemName = "cook_ride_plant",
				Text_NotHave = "คุณไม่มี <strong class='red-text'>ต้นข้าว.</strong>",
				Text_NotHave_Desc = "คุณไม่มี <strong class='red-text'>ต้นข้าว.</strong>",
				ListItem = true,
				ItemCount = 0,
				RandomPrice = false,
				Price = 1,
			},
			{
				Text = "ข้าว",
				Text_TH = "ข้าว",
				Unit = "กก",
				ItemName = "cook_ride_plant_process",
				Text_NotHave = "คุณไม่มี <strong class='red-text'>ข้าว.</strong>",
				Text_NotHave_Desc = "คุณไม่มี <strong class='red-text'>ข้าว.</strong>",
				ListItem = true,
				ItemCount = 0,
				RandomPrice = false,
				Price = 1,
			},
			{
				Text = "มะเขือเทศ",
				Text_TH = "มะเขือเทศ",
				Unit = "กก",
				ItemName = "cook_tomato",
				Text_NotHave = "คุณไม่มี <strong class='red-text'>มะเขือเทศ.</strong>",
				Text_NotHave_Desc = "คุณไม่มี <strong class='red-text'>มะเขือเทศ.</strong>",
				ListItem = true,
				ItemCount = 0,
				RandomPrice = false,
				Price = 1,
			}
		}
	}
}