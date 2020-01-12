local gui = nil
AddEvent("OnPlayerSpawn", function()
    if gui == nil then 
        gui = CreateWebUI(0.0, 0.0, 0.0, 0.0, 5, 24)
        LoadWebFile(gui, "http://asset/ogk_propshunts/resources/gui/build/index.html")
        SetWebAlignment(gui, 0.0, 0.0)
        SetWebAnchors(gui, 0.0, 0.0, 1.0, 1.0)
        SetWebVisibility(gui, WEB_VISIBLE)
        SetInputMode(INPUT_GAME)

        CreateTimer(function()
            if gui then
                local playerHealth = GetPlayerHealth()
                local playerState = json.stringify({health = playerHealth})
                AddPlayerChat("Setting playerHeamth to ..."..playerState)
                ExecuteWebJS(gui, "updatePlayerState('"..playerState.."')")
            end
        end, 180)
    end
end)

AddRemoteEvent("GUISendMessage", function(message, title)
    local displayTitle
    if title then
        displayTitle = title
    else
        displayTitle = ""
    end
    
    if gui then
        ExecuteWebJS(gui, "addNotification('"..message.."', '"..displayTitle.."')")
    end
end)

AddRemoteEvent("GUIClearMessage", function(id)
    if gui then
        ExecuteWebJS(gui, "clearNotification('"..id.."')")
    end
end)
