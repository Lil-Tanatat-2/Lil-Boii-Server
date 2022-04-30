Config = {}
Translation = {}

Config.Shopkeeper = 416176080 -- hash of the shopkeeper ped
Config.Locale = 'en' -- 'en', 'sv' or 'custom'

Config.Shops = {
    -- {coords = vector3(x, y, z), heading = peds heading, money = {min, max}, cops = amount of cops required to rob, blip = true: add blip on map false: don't add blip, name = name of the store (when cops get alarm, blip name etc)}
    {coords = vector3(24.03, -1345.63, 29.5-0.98), heading = 266.0, money = {7000, 10000}, cops = 5, blip = true, name = '7/11', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
	{coords = vector3(-1485.96, -377.76, 40.16-0.98), heading = 128.98, money = {7000, 10000}, cops = 5, blip = true, name = '7/11', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(-705.73, -914.91, 19.22-0.98), heading = 91.0, money = {7000, 10000}, cops = 5, blip = true, name = '7/11', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(-45.94, -1757.71, 28.42), heading = 51.0, money = {7000, 10000}, cops = 5, blip = true, name = '7/11', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(1133.66, -983.37, 45.42), heading = 284.0, money = {7000, 10000}, cops = 5, blip = true, name = '7/11', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(372.68, 328.15, 102.57), heading = 257.0, money = {7000, 10000}, cops = 5, blip = true, name = '7/11', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(1164.88, -321.99, 68.21), heading = 101.0, money = {7000, 10000}, cops = 5, blip = true, name = '7/11', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
}

Config.NPC = {
    "mp_m_shopkeep_01",
    "s_m_m_migrant_01",
    "s_m_m_ammucountry",
}

Translation = {
    ['en'] = {
        ['shopkeeper'] = 'shopkeeper',
        ['robbed'] = "I was just robbed and ~r~don't ~w~have any money left!",
        ['cashrecieved'] = 'You got:',
        ['currency'] = '$',
        ['scared'] = 'Scared:',
        ['no_cops'] = 'There are ~r~not~w~ enough cops online!',
        ['cop_msg'] = 'We have sent a photo of the robber taken by the CCTV camera!',
        ['set_waypoint'] = 'Set waypoint to the store',
        ['hide_box'] = 'Close this box',
        ['robbery'] = 'Robbery in progress',
        ['walked_too_far'] = 'You walked too far away!'
    },
    ['sv'] = {
        ['shopkeeper'] = 'butiksbiträde',
        ['robbed'] = 'Jag blev precis rånad och har inga pengar kvar!',
        ['cashrecieved'] = 'Du fick:',
        ['currency'] = 'SEK',
        ['scared'] = 'Rädd:',
        ['no_cops'] = 'Det är inte tillräckligt med poliser online!',
        ['cop_msg'] = 'Vi har skickat en bild på rånaren från övervakningskamerorna!',
        ['set_waypoint'] = 'Sätt GPS punkt på butiken',
        ['hide_box'] = 'Stäng denna rutan',
        ['robbery'] = 'Pågående butiksrån',
        ['walked_too_far'] = 'Du gick för långt bort!'
    },
    ['custom'] = { -- edit this to your language
        ['shopkeeper'] = '',
        ['robbed'] = '',
        ['cashrecieved'] = '',
        ['currency'] = '',
        ['scared'] = '',
        ['no_cops'] = '',
        ['cop_msg'] = '',
        ['set_waypoint'] = '',
        ['hide_box'] = '',
        ['robbery'] = '',
        ['walked_too_far'] = ''
    }
}