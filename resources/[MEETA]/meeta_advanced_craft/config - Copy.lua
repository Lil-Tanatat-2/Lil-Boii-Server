-- BY THANAWUT PROMRAUNGDATE
Config              = {}
Config.DrawDistance = 100
Config.Locale       = 'en'
Config.Zones = {

	CraftWeaponZone = {
		Mode = "Weapon",
		Type = 25,
		Color = {r = 255, g = 0, b = 0, a = 150},
		Size = {x = 1.5, y = 1.5, z = 1.5},
		Pos = {
			{x = 149.8,   y = 322.06, z = 111.19}			
		},
		Marker = true,
		Blips = {
			Spirte = 402,
			Size = 1.0,
			Color = 29,
			Text = "Crafting"
		}
	}
}

Config.Explosion = {
	Timer = 3000, -- เวลานับถอยหลังก่อนระเบิด
	DamageScale = 0.5
}

Config.Mode_illegal = {
	Pistol50 = {
		Name = "Pistol",
		DeleteItem = true,
		Explosion = true,
		Percent = 15, -- 10%
		ItemExplosion = {"broken_gun"},
		Used = {
			ItemName = "zap_oil,steel_bar,spring,gun_barrel,broken_gun,leather_gun",
			ItemCount = "1,5,1,1,1,1"
		},
		Reward = {
			Type = "Weapon",
			ItemName = "WEAPON_PISTOL",
			Count = 0
		}
	},
	AmmoPistol = {
		Name = "Pistol (Ammo) x12",
		DeleteItem = true,
		Explosion = false,
		ItemExplosion = {},
		Percent = 80, -- 10%`
		Used = {
			ItemName = "copper_bar,steel_bar,stone",
			ItemCount = "10,2,100"
		},
		Reward = {
			Type = "Item",
			ItemName = "ammo_pistol",
			Count = 1
		}
	},
	AmmoPistol50 = {
		Name = "Pistol .50 (Ammo) x9",
		DeleteItem = true,
		Explosion = false,
		ItemExplosion = {},
		Percent = 80, -- 10%`
		Used = {
			ItemName = "copper_bar,steel_bar,stone",
			ItemCount = "10,2,100"
		},
		Reward = {
			Type = "Item",
			ItemName = "ammo_pistol50",
			Count = 1
		}
	},
	Bat = {
	    Name = "Baseball Bat",
		DeleteItem = true,
		Explosion = false,
		Percent = 15, -- 10%
		ItemExplosion = {},
		Used = {
			ItemName = "steel_bar,zap_oil,leather",
			ItemCount = "2,2,1"
		},
		Reward = {
			Type = "Weapon",
			ItemName = "WEAPON_BAT",
			Count = 0
		}
	},
	Handcuff = {
	    Name = "Handcuff",
		DeleteItem = true,
		Explosion = false,
		Percent = 10, -- 10%
		ItemExplosion = {},
		Used = {
			ItemName = "steel_bar,wood,spring,copper_bar",
			ItemCount = "5,10,1,1"
		},
		Reward = {
			Type = "Item",
			ItemName = "handcuffs",
			Count = 1
		}
	},
	Armor = {
	    Name = "Armor",
		DeleteItem = true,
		Explosion = false,
		Percent = 70, -- 10%
		ItemExplosion = {},
		Used = {
			ItemName = "bikersuit,leather,copper_bar,steel_bar",
			ItemCount = "1,10,5,1"
		},
		Reward = {
			Type = "Item",
			ItemName = "armor",
			Count = 1
		}
	},
}

Config.Mode_Normal = {
	Sanwich = {
		Name = "แซนวิส",
		DeleteItem = true,
		Explosion = false,
		Used = {
			ItemName = "bread,packaged_chicken,weed",
		},
		Reward = {
			Type = "Item",
			ItemName = "sanwich",
			Count = 5
		}
	},
	Burger = {
		Name = "เบอเกอร์ชีส",
		DeleteItem = true,
		Explosion = false,
		Used = {
			ItemName = "crab,water",
		},
		Reward = {
			Type = "Item",
			ItemName = "burger",
			Count = 5
		}
	},
	CrabFried = {
		Name = "ผัดปูผงกระหรี่",
		DeleteItem = true,
		Explosion = false,
		Used = {
			ItemName = "bread,packaged_chicken,weed",
		},
		Reward = {
			Type = "Item",
			ItemName = "sanwich",
			Count = 5
		}
	},
	Water = {
		Name = "น้ำเปล่า",
		DeleteItem = true,
		Explosion = false,
		Used = {
			ItemName = "bread,packaged_chicken,weed",
		},
		Reward = {
			Type = "Item",
			ItemName = "sanwich",
			Count = 5
		}
	},
	Cola = {
		Name = "โคล่า",
		DeleteItem = true,
		Explosion = false,
		Used = {
			ItemName = "bread,packaged_chicken,weed",
		},
		Reward = {
			Type = "Item",
			ItemName = "sanwich",
			Count = 5
		}
	},
	Coffee = {
		Name = "กาแฟ",
		DeleteItem = true,
		Explosion = false,
		Used = {
			ItemName = "bread,packaged_chicken,weed",
		},
		Reward = {
			Type = "Item",
			ItemName = "sanwich",
			Count = 5
		}
	},
	Smoke = {
		Name = "บุหรี่โทนี่",
		DeleteItem = true,
		Explosion = false,
		Used = {
			ItemName = "bread,packaged_chicken,weed",
		},
		Reward = {
			Type = "Item",
			ItemName = "sanwich",
			Count = 5
		}
	},
	FishFried = {
		Name = "ผัดปลา",
		DeleteItem = true,
		Explosion = false,
		Used = {
			ItemName = "bread,packaged_chicken,weed",
		},
		Reward = {
			Type = "Item",
			ItemName = "sanwich",
			Count = 5
		}
	},
	Chicken = {
		Name = "ไก่ยัดไส้",
		DeleteItem = true,
		Explosion = false,
		Used = {
			ItemName = "bread,packaged_chicken,weed",
		},
		Reward = {
			Type = "Item",
			ItemName = "sanwich",
			Count = 5
		}
	},
	BeefFried = {
		Name = "กระเพาเนื้อ",
		DeleteItem = true,
		Explosion = false,
		Used = {
			ItemName = "bread,packaged_chicken,weed",
		},
		Reward = {
			Type = "Item",
			ItemName = "sanwich",
			Count = 5
		}
	},
	Slat = {
		Name = "สลัดไก่",
		DeleteItem = true,
		Explosion = false,
		Used = {
			ItemName = "bread,packaged_chicken,weed",
		},
		Reward = {
			Type = "Item",
			ItemName = "sanwich",
			Count = 5
		}
	},
	Pizza = {
		Name = "พิชซ่า",
		DeleteItem = true,
		Explosion = false,
		Used = {
			ItemName = "bread,packaged_chicken,weed",
		},
		Reward = {
			Type = "Item",
			ItemName = "sanwich",
			Count = 5
		}
	},
	BeefFried = {
		Name = "กระเพาเนื้อ",
		DeleteItem = true,
		Explosion = false,
		Used = {
			ItemName = "bread,packaged_chicken,weed",
		},
		Reward = {
			Type = "Item",
			ItemName = "sanwich",
			Count = 5
		}
	},
	Borrito = {
		Name = "โบริโต้",
		DeleteItem = true,
		Explosion = false,
		Used = {
			ItemName = "bread,packaged_chicken,weed",
		},
		Reward = {
			Type = "Item",
			ItemName = "sanwich",
			Count = 5
		}
	}
	
}