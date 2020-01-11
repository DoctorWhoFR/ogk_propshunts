-- check the game state etc... and do something for
-- ---- State: ----
-- IN A GAME
-- IN LOBBY

-- Game time 5 times

game = {

    state = "lobby", -- lobby,game
    huntersTeams = {},
    propsTeams = {}

}

players = {}
blacklists = {'745','738', '688'}

-- tp the player to the loby
function OnPlayerJoin(player)
    
    if(game.state == "lobby") then
        Delay(1000, function()
            AddPlayerChat(player, "Bienvenue sur propshunts vous êtes dans le lobby")

            -- choose a team for the player
            local team_for_player = 2
            
            -- if team is hunter
            if(team_for_player == 1) then
                game.huntersTeams[player] = players[player]
                AddPlayerChat(player, "Vous êtes dans la teams des Hunters.")
            end
    
            if(team_for_player == 2) then
                game.propsTeams[player] = players[player]
                AddPlayerChat(player, "Vous êtes dans la teams des props.")
            end
        end)
    end

    -- set the player to global
    -- get player on the db 
    p = {
        steam_id = "",
        level = 0,
        money = 500,
        attached = false,
        object = 0
    }

    players[player] = p
    
    -- Set where the player is going to spawn.
	SetPlayerSpawnLocation(player, -78409.382812, -165535.0625, 3218.9055175781, 0)
end
AddEvent("OnPlayerJoin", OnPlayerJoin)


function GameEnd()

end

AddEvent("OnPackageStart", function()
    LoadMapFromIni("packages/ogk_gg/maps/western.ini")
	LoadMapFromIni("packages/ogk_gg/maps/western_doorblock1.ini")
	LoadMapFromIni("packages/ogk_gg/maps/western_doorblock2.ini")
    LoadMapFromIni("packages/ogk_gg/maps/western_doorblock3.ini")
    
    -- check if game is on and do something
    game.state = "lobby"

--    Delay(60000, function()
  --      print('Game start in 1 minutes !')
    --    AddPlayerChatAll("Game start in 1 minute !")
    -- end)

    Delay(5000, function()
    
        AddPlayerChatAll("Game start !")

        local object_test = CreateObject(490, 125773.000000, 80246.000000, 1645.000000, 0)
           
        for k, v in ipairs(game.huntersTeams) do 
            
            SetPlayerDimension(k, 50)
            AddPlayerChat(k, "Vous devez attendre pendant 1 minutes pendants que les props ce cache !")

            Delay(60000, function()
                SetPlayerDimension(k, 0)
                SetPlayerLocation(k, 125773.000000 + 500, 80246.000000, 1645.000000, 90.0)
                print('Is on hunts team:' .. GetPlayerName(player))
                AddPlayerChat(k, "Vous devez trouvez les props.")
            end)
        end

        for k, v in ipairs(game.propsTeams) do 

            SetPlayerLocation(k, -73164.578125, -163825.953425, 3341.1821289063, 0)
            AddPlayerChat(k, "Vous avez 1 minutes pour vous cachez avec (E) !!!")
            print('Is on props team:' .. GetPlayerName(k))
        end
    
    end)

    print('Starting a game')

   
    
end)

AddRemoteEvent("AttachPlayerObject", function(player, objectt)
    local x, y, z = GetPlayerLocation(player)
    print("Getting player locaiton")

  
    if(players[player].attached == true) then
        SetObjectDetached(players[player].object)

                    
        AddPlayerChat(player, "test removed")
        players[player].attached = false
        players[player].object = nil

        local x,y,z = GetPlayerLocation(player)
        SetPlayerLocation(player, x, y, z + 10)
        CallRemoteEvent(player, "PlayerHider", player, false)
    else
        if(objectt == 0) then return end
        for _, v in ipairs(blacklists) do
            if(objectt == v) then
                AddPlayerChat(player, "Vous ne pouvez pas devenir cette object !")
                return
            end
        end
        SetObjectAttached(objectt, ATTACH_PLAYER, player, 0, 0, 0, 0, 0, 0)
        players[player].attached = true
        players[player].object = objectt
        CallRemoteEvent(player, "PlayerHider", player, true)
    end
    print('player are now object:' .. objectt)
end)