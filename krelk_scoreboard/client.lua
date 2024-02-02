local antiSpam = false
local clientTimeout = nil

--IF RESOURCE IS RESTARTED THIS EVENT HANDLER WILL SET UP THE CONFIG AND COLORS AGAIN
AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    Citizen.Wait(100) --Wait for NUI be loaded, don't touch
    SendNUIMessage({
        action = 'setupHudColor',
        colors = Config.ColorHUD
    })
    if Config.EnableAdminsOnline then
        SendNUIMessage({
            action = 'enableAdminsOnline'
        })
    end
    if Config.AutoHide then
        SendNUIMessage({
            action = 'setupAutoHide',
            seconds = Config.HideSeconds
        })
    end
    if Config.ShowServerName then
        SendNUIMessage({
            action = 'enableServerName',
            name = Config.ServerName,
            color = Config.ServerNameColor
        })
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
    Citizen.Wait(100) --Wait for NUI be loaded, don't touch
    SendNUIMessage({
        action = 'setupHudColor',
        colors = Config.ColorHUD
    })
    if Config.EnableAdminsOnline then
        SendNUIMessage({
            action = 'enableAdminsOnline'
        })
    end
    if Config.AutoHide then
        SendNUIMessage({
            action = 'setupAutoHide',
            seconds = Config.HideSeconds
        })
    end
    if Config.ShowServerName then
        SendNUIMessage({
            action = 'enableServerName',
            name = Config.ServerName,
            color = Config.ServerNameColor
        })
    end
end)

RegisterNetEvent('krelk_scoreboard:update')
AddEventHandler('krelk_scoreboard:update', function(playersData)
    if playersData ~= nil then
        SendNUIMessage({
            action = 'updatePlayersData',
            data = playersData
        })
    end
end)

RegisterNUICallback('getOnlinePlayers', function(data, cb)
    if Config.AntiSpamEvent then
        if antiSpam then
            cb('notok')
            return
        end
    end
    ESX.TriggerServerCallback('krelk_scoreboard:getOnlinePlayers', function(playersData)
        if playersData then
            cb(playersData)
            if Config.AntiSpamEvent then
                if not antiSpam then
                    startAntiSpamEvent()
                end
            end
        else
            cb(false)
        end
    end, 'ok')
end)

RegisterCommand('scoreboard', function()
    SendNUIMessage({
        action = 'toggleScoreBoard'
    })
end)

RegisterKeyMapping('scoreboard', 'Krelk Free ScoreBoard', 'keyboard', Config.ScoreBoardKey)

function startAntiSpamEvent()
    antiSpam = true
    clientTimeout = ESX.SetTimeout(Config.TimeoutEvent*1000, function() antiSpam = false clientTimeout = nil end)
end