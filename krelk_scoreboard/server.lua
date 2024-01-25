ESX.RegisterServerCallback('krelk_scoreboard:getOnlinePlayers', function(source, cb, nombre)
    local adminsOnline, policeOnline, emsOnline, mechanicOnline, taxiOnline, playersOnline = 0, 0, 0, 0, 0, 0
    for _, playerId in ipairs(GetPlayers()) do
        --Whitelisted Jobs Count
        if ESX.GetPlayerFromId(playerId) then
            local xPlayer = ESX.GetPlayerFromId(playerId)
            local xPlayerGroup = xPlayer.getGroup()
            if xPlayerGroup ~= 'user' then
                adminsOnline=adminsOnline+1
            end
            local xPlayerJob = xPlayer.getJob().name
            if xPlayerJob == Config.PoliceJob then --Police Count
                policeOnline=policeOnline+1
            elseif xPlayerJob == Config.AmbulanceJob then --Ems Count
                emsOnline=emsOnline+1
            elseif xPlayerJob == Config.MechanicJob then --Mechanic Count
                mechanicOnline=mechanicOnline+1
            elseif xPlayerJob == Config.TaxiJob then --Taxi Count
                taxiOnline=taxiOnline+1
            end
        end
        --Total Players Count
        playersOnline=playersOnline+1
    end
    local maxPlayersOnline = GetConvarInt("sv_maxclients", 0)
    local returnData = {
        adminsOnline, policeOnline, emsOnline, mechanicOnline, taxiOnline, playersOnline, maxPlayersOnline
    }
    cb(returnData)
end)

RegisterNetEvent('esx:setJob', function(player, job, lastJob)
    local isJobWhitelisted, isLastJobWhitelited = isWhitelistedJob(job.name), isWhitelistedJob(lastJob.name)
    if isJobWhitelisted or isLastJobWhitelited then
        local adminsOnline, policeOnline, emsOnline, mechanicOnline, taxiOnline, playersOnline = 0, 0, 0, 0, 0, 0
        for _, playerId in ipairs(GetPlayers()) do
            --Whitelisted Jobs Count
            if ESX.GetPlayerFromId(playerId) then
                local xPlayer = ESX.GetPlayerFromId(playerId)
                local xPlayerGroup = xPlayer.getGroup()
                if xPlayerGroup ~= 'user' then
                    adminsOnline=adminsOnline+1
                end
                local xPlayerJob = xPlayer.getJob().name
                if xPlayerJob == Config.PoliceJob then --Police Count
                    policeOnline=policeOnline+1
                elseif xPlayerJob == Config.AmbulanceJob then --Ems Count
                    emsOnline=emsOnline+1
                elseif xPlayerJob == Config.MechanicJob then --Mechanic Count
                    mechanicOnline=mechanicOnline+1
                elseif xPlayerJob == Config.TaxiJob then --Taxi Count
                    taxiOnline=taxiOnline+1
                end
            end
            --Total Players Count
            playersOnline=playersOnline+1
        end
        local returnData = {
            adminsOnline, policeOnline, emsOnline, mechanicOnline, taxiOnline, playersOnline
        }
        TriggerClientEvent("krelk_scoreboard:update", -1, returnData)
    end
end)

function isWhitelistedJob(job)
    local jobs = { Config.PoliceJob, Config.AmbulanceJob, Config.Mechanic, Config.TaxiJob }
    local isWhitelisted = false
    for k,v in ipairs(jobs) do
        if v == job then
            isWhitelisted = true
            break
        end
    end
    return isWhitelisted
end