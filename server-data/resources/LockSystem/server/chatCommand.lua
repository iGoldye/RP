if(globalConf["SERVER"].enableGiveKey)then
    RegisterCommand('givekey', function(source, args, rawCommand)
        local src = source
        local identifier = GetPlayerIdentifiers(src)[1]

        if(args[1])then
            local targetId = args[1]
            local targetIdentifier = GetPlayerIdentifiers(targetId)[1]
            if(targetIdentifier)then
                if(targetIdentifier ~= identifier)then
                    if(args[2])then
                        local plate = string.lower(args[2])
                        if(owners[plate])then
                            if(owners[plate] == identifier)then
                                alreadyHas = false
                                for k, v in pairs(secondOwners) do
                                    if(k == plate)then
                                        for _, val in ipairs(v) do
                                            if(val == targetIdentifier)then
                                                alreadyHas = true
                                            end
                                        end
                                    end
                                end

                                if(not alreadyHas)then
                                    TriggerClientEvent("ls:giveKeys", targetIdentifier, plate)
                                    TriggerEvent("ls:addSecondOwner", targetIdentifier, plate)

                                    TriggerClientEvent("ls:notify", targetId, "Вы получили ключи от транспорта " .. plate .. " от " .. GetPlayerName(src))
                                    TriggerClientEvent("ls:notify", src, "Вы дали ключи от транспорта" .. plate .. "  " .. GetPlayerName(targetId))
                                else
                                    TriggerClientEvent("ls:notify", src, "У этого человека уже есть ключи")
                                    TriggerClientEvent("ls:notify", targetId, GetPlayerName(src) .. "дает вам ключи, которые уже есть")
                                end
                            else
                                TriggerClientEvent("ls:notify", src, "Это не ваш транспорт")
                            end
                        else
                            TriggerClientEvent("ls:notify", src, "Неверный номер транспорта")
                        end
                    else
                        TriggerClientEvent("ls:notify", src, "Второй недостающий аргумент : /givekey <id> <plate>")
                    end
                else
                    TriggerClientEvent("ls:notify", src, "Вы не можете выбрать себя")
                end
            else
                TriggerClientEvent("ls:notify", src, "Нет человека")
            end
        else
            TriggerClientEvent("ls:notify", src, 'Первый достающий аргумент : /givekey <id> <plate>')
        end

        CancelEvent()
    end)
end
