
function NotifyPlayer(playerid, message, title, timeout)
    local emitTimestamp = os.time(os.date("!*t"))
    local id = playerid.."-"..uuid();
    local notif = json.stringify({title =  title, message = message, timestamp = emitTimestamp, id = id})
    AddPlayerChat(playerid, 'Adding the notification ' .. notif..' number '..id)
    CallRemoteEvent(playerid, "GUISendMessage", notif) 

    if timeout then
        Delay(timeout, function()
            AddPlayerChat(playerid, 'Clearing ....' .. notif..' number '..id)
            CallRemoteEvent(playerid, "GUIClearMessage", id)
        end)
    end
    return id;
end

function NotifyAllPlayers(message, title, timeout)
    for k,v in ipairs(GetAllPlayers()) do
        NotifyPlayer(v, message, title, timeout)
    end
end
