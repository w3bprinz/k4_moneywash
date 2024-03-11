RegisterNetEvent('k4_moneywash:washMoney')
AddEventHandler('k4_moneywash:washMoney', function(dirtyMoney)
    local xPlayer = ESX.GetPlayerFromId(source)
    local blackMoney = tonumber(dirtyMoney)

    local moneyAfterTax = math.floor(dirtyMoney - (dirtyMoney/100*Config.Tax))
    --print("Geld nach Steuer: " .. moneyAfterTax)
    
    if xPlayer then 
        local playerName = xPlayer.getName()
        local steamid  = false
        local license  = false
        local discord  = false
        local xbl      = false
        local liveid   = false
        local ip       = false

        for k,v in pairs(GetPlayerIdentifiers(source))do
            --print(v)
                
            if string.sub(v, 1, string.len("steam:")) == "steam:" then
                steamid = v
            elseif string.sub(v, 1, string.len("license:")) == "license:" then
                license = v
            elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
                xbl  = v
            elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
                ip = v
            elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
                discord = v
            elseif string.sub(v, 1, string.len("live:")) == "live:" then
                liveid = v
            end
            
        end

        local message = "Es wurde Geld gewaschen!\nSpieler: " .. playerName .. "\nLizenz: "..license.."\n\nSchwarzgeld: " .. blackMoney .. " $ \nGrüngeld: " .. moneyAfterTax .. " $"
        
        local accountMoney = xPlayer.getAccount('black_money')

        if accountMoney.money >= blackMoney then
            --print("Schwarzgeld-Konto: " .. accountMoney.money)

            xPlayer.removeAccountMoney('black_money', blackMoney)
            xPlayer.addAccountMoney('money', moneyAfterTax)

            sendToDiscord(Config.DiscordWebhook, Config.DiscordBotName, message, Config.orange)
        else
            --print("Schwarzgeld-Konto: " .. accountMoney.money)
            k4_Notify(source, "Verpiss Dich, DU hast keine Kohle.", msgType, time)
        end
    end
end)



function sendToDiscord(webhook, name, message, color)
  -- Modify here your discordWebHook username = name, content = message,embeds = embeds
local DiscordWebHook = webhook
local embeds = {
    {
        ["title"]= message,
        ["type"]= "rich",
        ["color"] = color,
        ["footer"]=  {
        ["text"]= "K4-MONEYWASH LOGS",
       },
    }
}

  if message == nil or message == '' then return FALSE end
  PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end



