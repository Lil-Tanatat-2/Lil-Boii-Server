-- Config = {}


-- Config.UseCop = true -- แจ้งตำรวจ
-- Config.CopsRequiredToSell = 0 -- จำนวนตำรวจ
-- Config.UseCopsPercent = 1 -- % ที่ NPC จะแจ้งตำรวจ 1 = 10% ใส่อย่างน้อย 1
-- Config.PedRejectPercent = 3 -- % ที่ NPC จะไม่ซื้อ 1 = 10% ใส่อย่างน้อย 1
-- Config.TimeDelay = 5000 -- 5 วิ
-- Config.WeedPrice = { 200, 400 } -- สุ่มราคา
-- Config.DistanceFromCity = 10000
-- Config.CityPoint = {x= -255.94, y= -983.93, z= 30.21}

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


Config.CopsRequiredToSell = 4 -- จำนวนตำรวจ
Config.PercentCallCopWithFace = 20

Config.Items ={
    {
        ItemName = "marijuana",
        ItemLabel = "~r~กัญชาขวด",
        ItemLabel_En = "~r~Marijuana",
        DirtMoney = true,
        Price = {350, 500},
        UseCop = true,
        Message1 = "They don't care.",
        Message2 = "Your drug sucks, i will call ~r~cops"
    },
	{
        ItemName = "coke_pooch",
        ItemLabel = "~r~โคเคน",
        ItemLabel_En = "~r~Coke Pooch",
        DirtMoney = true,
        Price = {2000, 2500},
        UseCop = true,
        Message1 = "They don't care.",
        Message2 = "Your drug sucks, i will call ~r~cops"
    },
    {
        ItemName = "meatfood",
        ItemLabel = "~b~สเต็กเซอร์ลอยน์ A5",
        ItemLabel_En = "~b~Meat food",
        DirtMoney = false,
        Price = {80, 85},
        UseCop = false,
        Message1 = "They don't care.",
        Message2 = "Your food sucks"
    },
    {
        ItemName = "catfishfood",
        ItemLabel = "~b~ยำปลาดุฟู",
        ItemLabel_En = "~b~Catfish food",
        DirtMoney = false,
        Price = {50, 100},
        UseCop = false,
        Message1 = "They don't care.",
        Message2 = "Your food sucks"
    },
    {
        ItemName = "snakefishfood",
        ItemLabel = "~y~ปลาช่อนเผา",
        ItemLabel_En = "~y~Snake fish food",
        DirtMoney = false,
        Price = {100, 120},
        UseCop = false,
        Message1 = "They don't care.",
        Message2 = "Your food sucks"
    }
}