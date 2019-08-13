Config = {}
Translation = {}

Config.Shopkeeper = 416176080 -- hash of the shopkeeper ped
Config.Locale = 'en' -- 'en', 'sv' or 'custom'

Config.Shops = {
    -- {coords = vector3(x, y, z), heading = peds heading, money = {min, max}, cops = amount of cops required to rob, blip = true: add blip on map false: don't add blip, name = name of the store (when cops get alarm, blip name etc)}
    {coords = vector3(24.03, -1345.63, 29.5-0.98), heading = 266.0, money = {100, 700}, cops = 1, blip = false, name = '7/11', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(-705.73, -912.91, 19.22-0.98), heading = 91.0, money = {100, 1200}, cops = 1, blip = false, name = '7/11', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(-46.29, -1757.48, 29.42-0.98), heading = 45.0, money = {100, 700}, cops = 4, blip = false, name = '7/11', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(1134.01, -983.78, 46.42-0.98), heading = 277.0, money = {100, 1200}, cops = 1, blip = false, name = '7/11', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(1164.62, -321.86, 69.21-0.98), heading = 100.0, money = {100, 1200}, cops = 1, blip = false, name = '7/11', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(373.01, 328.09, 103.57-0.98), heading = 257.0, money = {100, 1200}, cops = 1, blip = false, name = '7/11', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(-1221.41, -907.86, 12.33-0.98), heading = 30.0, money = {100, 1200}, cops = 1, blip = false, name = '7/11', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(-1820.75, 794.83, 138.09-0.98), heading = 130.0, money = {100, 1200}, cops = 1, blip = false, name = '7/11', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(-1486.61, -377.46, 40.16-0.98), heading = 135.0, money = {100, 1200}, cops = 1, blip = false, name = '7/11', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(-2966.39, 391.51, 15.04-0.98), heading = 88.0, money = {100, 1200}, cops = 4, blip = false, name = '7/11', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(-3040.61, 584.06, 7.91-0.98), heading = 14.0, money = {100, 1200}, cops = 4, blip = false, name = '7/11', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(-3244.01, 1000.16, 12.16-0.98), heading = 350.0, money = {100, 1200}, cops = 2, blip = false, name = '7/11', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(549.26, 2669.7, 42.16-0.98), heading = 97.0, money = {100, 1200}, cops = 2, blip = false, name = '7/11', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(1165.39, 2710.82, 39.16-0.98), heading = 177.0, money = {100, 1200}, cops = 2, blip = false, name = '7/11', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(1958.92, 3741.38, 32.16-0.98), heading = 299.0, money = {100, 1200}, cops = 2, blip = false, name = '7/11', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(2676.49, 3280.08, 55.16-0.98), heading = 334.0, money = {100, 1200}, cops = 2, blip = false, name = '7/11', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(1698.99, 4922.31, 42.16-0.98), heading = 326.0, money = {100, 1200}, cops = 2, blip = false, name = '7/11', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false},
    {coords = vector3(1728.47, 6416.87, 35.16-0.98), heading = 242.0, money = {100, 1200}, cops = 4, blip = false, name = '7/11', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false}
}

Translation = {
    ['en'] = {
        ['shopkeeper'] = 'Продавец',
        ['robbed'] = "Сжальтесь! У меня больше ~r~нет~w~ денег!",
        ['cashrecieved'] = 'Вы получили:',
        ['currency'] = '$',
        ['scared'] = 'Напуган:',
        ['no_cops'] = 'На смене ~r~недостаточно~w~ полицейских!',
        ['cop_msg'] = 'Мы отправили фотографию грабителя, сделанную камерой видеонаблюдения!',
        ['set_waypoint'] = 'Установить точку маршрута в магазин',
        ['hide_box'] = 'Закройте это окно',
        ['robbery'] = 'Ограбление в процессе',
        ['walked_too_far'] = 'Вы слишком далеко ушли!'
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
