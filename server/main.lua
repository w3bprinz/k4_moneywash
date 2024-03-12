RegisterNetEvent('k4_moneywash:washMoney')
AddEventHandler('k4_moneywash:washMoney', function(dirtyMoney)
    local xPlayer = ESX.GetPlayerFromId(source)
    local blackMoney = tonumber(dirtyMoney)

    local moneyAfterTax = math.floor(dirtyMoney - (dirtyMoney/100*Config.Tax))
    --print("Geld nach Steuer: " .. moneyAfterTax)
    
    if xPlayer then 
        local playerName    = xPlayer.getName()
        local steamid       = false
        local license       = false
        local discord       = false
        local xbl           = false
        local liveid        = false
        local ip            = false
        local identifier    = false

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
        local message = nil

        if steamid == false then
            identifier = license 
        else 
            identifier = steamid
        end

        local accountMoney = xPlayer.getAccount('black_money')

        if accountMoney.money >= blackMoney then
            --print("Schwarzgeld-Konto: " .. accountMoney.money)

            xPlayer.removeAccountMoney('black_money', blackMoney)
            xPlayer.addAccountMoney('money', moneyAfterTax)
            DiscordLog(Config.DiscordWebhook, Config.Orange, playerName, identifier, blackMoney, moneyAfterTax, blackMoney-moneyAfterTax)
        else
            --print("Schwarzgeld-Konto: " .. accountMoney.money)
            k4_NotifyServer(source, Translate('fuckyou'), "info", 5000 )
        end
    end
end)

function DiscordLog(webhook, color, playerName, playerIdentifier, blackMoney, greenMoney, tax)
    local embedMessage = {
        embeds = {
            {
                title = "K4-MONEYWASH",
                description = Translate('money_washed'),
                color = color, -- Hex-Wert für die Farbe (z. B. Rot)
                fields = {
                    { name = Translate('player'), value = playerName, inline = false },
                    { name = Translate('identifier'), value = "||" .. playerIdentifier .. "||", inline = false },
                    { name = Translate('blackmoney'), value = blackMoney, inline = true },
                    { name = Translate('greenmoney'), value = greenMoney, inline = true },
                    { name = Translate('tax'), value = tax, inline = true },
                },
                footer = { text = "K4-MONEYWASH LOGS" },
            }
        }
    }

    PerformHttpRequest(webhook, function(err, text, headers)
        -- Handle the response
        print(text)
    end, 'POST', json.encode(embedMessage), { ['Content-Type'] = 'application/json' })
end



