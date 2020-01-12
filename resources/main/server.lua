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

timesConfigs = {
    gametime = 0,
    playerjoinmsg = 0
}

players = {}
blacklists = {851}

-- tp the player to the loby
function OnPlayerJoin(player)
    
    if(game.state == "lobby") then
        Delay(10000, function()
            NotifyPlayer(player, "Bienvenue sur propshunts vous êtes dans le lobby", "Lobby", 10000)
        end)
    else
        Delay(10000, function()
            SetPlayerLocation(player, -15648.6054, 133113.5625, 1561.6047, 90 )
            SetPlayerSpectate(player, true)
            NotifyPlayer(player, "Une partie est en cours !", "CURRENTLY IN A GAME !!!", 10000)
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
    SetPlayerSpawnLocation(player,  18483.21875, 140415.296875, 1556.962+100, 160)
end
AddEvent("OnPlayerJoin", OnPlayerJoin)

AddEvent("OnPlayerSpawn", function(player)
    Delay(5000, function()
        SetPlayerWeapon(player, 13, 200, true, 1, true)
    end)
    if(game.state == "lobby") then
        SetPlayerTeam(player)

        Delay(15000, function()
            StartTheGame()
        end)
    end
   
    Delay(5000, function()
        for i=1,GetObjectCount() do
            if IsValidObject(i) then
                CallRemoteEvent(player, "SetObjectOutilned", i)
            end
        end
    end)
end)

function SetPlayerTeam(player)
    -- hunter: 1 props: 2
    -- choose a team for the player
    local count_props = #game.propsTeams  
    local count_hunts = #game.huntersTeams
    if(game.state == "lobby") then
        if(count_hunts >= count_props) then
            game.huntersTeams[player] = players[player]
            print(game.huntersTeams[player])
            NotifyPlayer(player, "1-Vous êtes dans la teams des Hunters.", "HUNTERS", 5000)
        else
            game.propsTeams[player] = players[player]
            print('hunt Props')
            NotifyPlayer(player, "2-Vous êtes dans la teams des Props.", "PROPS", 5000)
        end
    end

end

 -- function for start game
function StartTheGame()
    if(GetPlayerCount() >= 1) then
        NotifyAllPlayers("Game start in 30 seconds !", "Game Start !", 30000)
        -- start the game after 5 seconds (for players spawnings time)
        Delay(30000, function()
            print('game start')
            NotifyAllPlayers("Game start !", "test", 2000)
            print(game.huntersTeams[1], game.propsTeams[1])
            local object_test = CreateObject(490, 125773.000000, 80246.000000, 1645.000000, 0)
            
            game.state = "game"

            for k, v in ipairs(game.huntersTeams) do 
                SetPlayerDimension(k, 50)
                NotifyPlayer(k, "Vous devez attendre pendant 1 minutes pendants que les props ce cache !", "HUNTER", 60000)
                SetPlayerWeapon(k, 5, 500, true, 1, true)
    
                Delay(5000, function()
                    SetPlayerDimension(k, 0)
                    SetPlayerLocation(k, -15648.6054, 133113.5625, 1561.6047, 90 )
                    print('Is on hunts team:' .. GetPlayerName(k))
                    NotifyPlayer(k, "Vous devez trouvez les props.", "HUNTER", 2000)
                end)
            end
    
            for k, v in ipairs(game.propsTeams) do 
                SetPlayerLocation(k, -15648.6054, 133113.5625, 1561.6047, 90 )
                
                NotifyPlayer(k, "Vous avez 1 minutes pour vous cachez avec (E) !!!", "PROP", 10000)
                
                print('Is on props team:' .. GetPlayerName(k))
            end
    
            AddPlayerChatAll('Props win after 5 minutes!', "Game started", 5000)
            Delay(120000, function()
                NotifyAllPlayers('End of the game in 2.5 minutes!', nil, 5000)
            end)
            Delay(240000, function() 
                NotifyAllPlayers('props wins !!!!!!!!')
                
                game.huntersTeams = {}
                game.propsTeams = {}

                game.state = "lobby"

                local randomx = Random(1, 50)

                for k, v in ipairs(GetAllPlayers()) do
                    SetPlayerTeam(k)
                    SetPlayerSpectate(k, false)
                    SetPlayerLocation(k,  18483.21875+randomx, 140415.296875, 1556.962+100, 160)
                end
                    
    
                Delay(240000, function()
                    StartTheGame()
                end)
            end)
        end)
       
    else
        Delay(20000, function()
            local counts = GetPlayerCount()
            local max = 4 - counts
            NotifyPlayer(k, "There is not enough players to start the game !" .. "You have to wait: " .. max .. "more players!", "Enough player !", 5000)
        end)
    end
end


AddEvent("OnPackageStart", function()
    LoadMapFromIni("packages/ogk_gg/maps/armory.ini")
	LoadMapFromIni("packages/ogk_gg/maps/gg2.ini")
	LoadMapFromIni("packages/ogk_gg/maps/western.ini")
	LoadMapFromIni("packages/ogk_gg/maps/western_doorblock1.ini")
	LoadMapFromIni("packages/ogk_gg/maps/western_doorblock2.ini")
	LoadMapFromIni("packages/ogk_gg/maps/western_doorblock3.ini")
	LoadMapFromIni("packages/ogk_gg/maps/western_doorblock4.ini")
	LoadMapFromIni("packages/ogk_gg/maps/ports1.ini")
	LoadMapFromIni("packages/ogk_gg/maps/ports2.ini")
	LoadMapFromIni("packages/ogk_gg/maps/ports_murs.ini")
	LoadMapFromIni("packages/ogk_gg/maps/port_objects.ini")
	LoadMapFromIni("packages/ogk_gg/maps/port_small.ini")
	LoadMapFromIni("packages/ogk_gg/maps/spawn_zone.ini")
	LoadMapFromIni("packages/ogk_gg/maps/trucks.ini")
	LoadMapFromIni("packages/ogk_gg/maps/trucks2.ini")
	LoadMapFromIni("packages/ogk_gg/maps/trucks3.ini")
	LoadMapFromIni("packages/ogk_gg/maps/tropico_walls.ini")
	LoadMapFromIni("packages/ogk_gg/maps/tropico_objects.ini")
	LoadMapFromIni("packages/ogk_gg/maps/tropicofixblocks.ini")
	LoadMapFromIni("packages/ogk_gg/maps/tropicofix2.ini")
	LoadMapFromIni("packages/ogk_gg/maps/hangar.ini")
	LoadMapFromIni("packages/ogk_gg/maps/hangarwalls.ini")
	LoadMapFromIni("packages/ogk_gg/maps/hangar_spawns.ini")
    
    -- check if game is on and do something
    game.state = "lobby"
end)

AddRemoteEvent("AttachPlayerObject", function(player, objectt)
    local x, y, z = GetPlayerLocation(player)
    print("Getting player locaiton")

    if(players[player].attached == true) then
        SetObjectDetached(players[player].object)

        OGK.SendPlayerMessage(player, "test removed")
        players[player].attached = false
        players[player].object = nil

        local x,y,z = GetPlayerLocation(player)
   
        for k, v in ipairs(players) do
            CallRemoteEvent(k, "PlayerHider", player, false)
        end
   
    else
        if(objectt == 0) then return end
        for _, v in ipairs(blacklists) do
            print(v, GetObjectModel(objectt))
            if(GetObjectModel(objectt) == v) then
                NotifyPlayer(player, "Vous ne pouvez pas devenir cet objet !", "", 1000)
                return
            end
        end
        SetObjectAttached(objectt, ATTACH_PLAYER, player, 0, 110, 0, 0, 0, 0)
        players[player].attached = true
        players[player].object = objectt
       
        -- async hide for all players
        for k, v in ipairs(GetAllPlayers()) do
            CallRemoteEvent(k, "PlayerHider", player, true, objectt)
        end
        NotifyPlayer(player, "Vous êtes maintenant devenu un props !", "", 2000)
    end
    print('player are now object:' .. objectt)
end)


AddEvent("OnPlayerDeath", function(player, instigator)
    SetObjectDetached(players[player].object)
    for k, v in ipairs(GetAllPlayers()) do
        CallRemoteEvent(k, "PlayerHider", player, false, objectt)
    end
    players[player].attached = false
    players[player].object = nil
end)
