local QBCore = exports['qb-core']:GetCoreObject()


local cooldownTimes = {} 



RegisterNetEvent("j4-stash:server:SearchStash")
AddEventHandler("j4-stash:server:SearchStash", function()
    local src = source
    local policePlayer = QBCore.Functions.GetPlayer(src)

    if policePlayer and policePlayer.PlayerData.job.name == "police" then
     
        TriggerClientEvent("j4-stash:client:RequestPlayerID", src)
    else
        TriggerClientEvent('QBCore:Notify', src, "Bu işlemi yalnızca polis gerçekleştirebilir.", "error")
    end
end)



RegisterNetEvent("j4-stash:server:HandleStashSearch")
AddEventHandler("j4-stash:server:HandleStashSearch", function(playerId)
    local src = source
    local policePlayer = QBCore.Functions.GetPlayer(src)

    if policePlayer and policePlayer.PlayerData.job.name == "police" then
        local targetPlayer = QBCore.Functions.GetPlayer(tonumber(playerId))
        
        if targetPlayer then
            local citizenId = targetPlayer.PlayerData.citizenid
            local closestStashName = "Depo_" .. citizenId
            local currentTime = os.time()

            -- Hedef oyuncu için cooldown kontrolü
            if cooldownTimes[playerId] and currentTime < cooldownTimes[playerId] then
                local remainingTime = cooldownTimes[playerId] - currentTime
                TriggerClientEvent('QBCore:Notify', src, "Bu oyuncunun deposunu aramak için " .. remainingTime .. " saniye beklemeniz gerekiyor.", "error")
                return
            end

            -- %50 şansla stash seçimi
            local stashToOpen
            if math.random() < 0.5 then
                stashToOpen = closestStashName 
            else
                stashToOpen = "depo_janiel" 
            end

            -- SQL'den stash verilerini al
            local stashItems = MySQL.query.await('SELECT * FROM stashitems WHERE stash = ?', {stashToOpen})

            if stashItems and #stashItems > 0 then
                TriggerClientEvent("j4-stash:client:OpenStash", src, stashToOpen)

                -- Hedef oyuncunun stash'i için cooldown'u ayarla
                cooldownTimes[playerId] = currentTime + 1200 -- 20 dakika cooldown
            else
                TriggerClientEvent('QBCore:Notify', src, "Bu stash boş veya bulunamadı.", "error")
            end
        else
            TriggerClientEvent('QBCore:Notify', src, "Geçersiz player ID.", "error")
        end
    end
end)








