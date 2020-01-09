


-- check the game state etc... and do something for
-- ---- State: ----
-- IN A GAME
-- IN LOBBY

-- Game time 5 times

game = {

    state: "", -- lobby,game
    huntersTeams = {},
    propsTeams = {}

}

players = {}

function PlayerJoin(player)

    if(state == "lobby") then
        AddPlayerChat(player, "Bienvenue sur propshunts vous êtes dans le lobby")

        -- choose a team for the player
        local team_for_player = Random(1, 2)
        
        -- if team is hunter
        if(team_for_player == 1) then
            game.huntersTeams[player] = players[player]
            AddPlayerChat(player, "Vous êtes dans la teams des Hunters.")
        end

        if(team_for_player == 2) then
            game.propsTeams[player] = players[player]
            AddPlayerChat(player, "Vous êtes dans la teams des props.")
        end
    end

end

-- tp the player to the loby
function OnPlayerJoin(player)
    
    -- set the player to global
    -- get player on the db 
    p = {
        steam_id: ""
        level: 0
        money: 500
    }

    players[player] = p
    
    -- Set where the player is going to spawn.
	SetPlayerSpawnLocation(player, 125773.000000, 80246.000000, 1645.000000, 90.0)
end

function GameEnd()

end

AddEvent("OnPackageStart", function()
    -- check if game is on and do something

    game.state = "lobby"

    Delay(60000, function()
        print('Game start in 1 minutes !')
        AddPlayerChatAll("Game start in 1 minute !")
    end)

    Delay(120000, function()
    
        AddPlayerChatAll("Game start !")

        for k, v in ipairs(game.huntersTeams) do 
            
            SetPlayerDimension(k, 50)
            AddPlayerChat(k, "Vous devez attendre pendant 1 minutes pendants que les props ce cache !")

            Delay(60000, function()
                SetPlayerDimension(k, 0)
                SetPlayerLocation(k, 125773.000000 + 500, 80246.000000, 1645.000000, 90.0)
                AddPlayerChat(k, "Vous devez trouvez les props.")

                -- after hunters start tracking 5 minutes end the game
                Delay(300000, GameEnd())
            end)
            
        end

        for k, v in ipairs(game.propsTeams) do 
            SetPlayerLocation(k, 125773.000000 + 500, 80246.000000, 1645.000000, 90.0)
            AddPlayerChat(k, "Vous avez 1 minutes pour vous cachez avec (E) !!!")
        end
    
    end)
    
    

    print('Starting a game')

    local object_test = CreateObject(1, 125773.000000 + 200, 80246.000000, 1645.000000, 90.0)
    EnableObjectHitEvents(object , object_test)

end)

AddRemoteEvent("AttachPlayerObject", function(player, object)
    local x,y,z = GetPlayerLocation(player)
    SetObjectAttached(object, attachtype, ATTACH_PLAYER, x, y, z, )
    print('player are now object:' .. object)
end)
