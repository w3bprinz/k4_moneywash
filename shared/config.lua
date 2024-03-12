Config = {}

--Config.Locale = 'de'

Config.Locale = GetConvar('esx:locale', 'de')

Config.WashingPosition = vector3(712.259338, 4102.008789, 35.783936)

Config.NPC = {
    model = "s_m_m_fiboffice_02",
    position = vector3(712.259338, 4102.008789, 35.783936),
    heading = 184.251968
}

Config.Tax = 30

Config.FactionOnly = true -- true or false

Config.Factions = {
    "police",
    "unemployed"
}

Config.DiscordWebhook       = "https://discord.com/api/webhooks/1216865357994659950/XT8Yjo95dyINTwYj_tr2MSb8hTW4HDN_5r3Z5g_43-RChbFWky0AuP6NpPsbYo1ZZ9cE"
Config.DiscordBotName       = "K4-Moneywash Logs"
Config.Green                = 56108
Config.Grey                 = 8421504
Config.Red                  = 16711680
Config.Orange               = 16744192
Config.Blue                 = 2061822
Config.Purple               = 11750815


function k4_Notify (source, msg, msgType, time)
    TriggerClientEvent('esx:showNotification', source, 'Verpiss Dich, Du hast keine Kohle.', msgType, time)
end
