players = {}

-- tp the player to the loby
function OnPlayerJoin(player)
    -- set the player to global
    -- get player on the db 
    p = {
        steam_id = "",
        level = 0,
        money = 500,
        attached = false,
        object = 0,
        spawned = false
    }

    players[player] = p

    local rand = Random(1, 100)
    -- Set where the player is going to spawn.
    SetPlayerSpawnLocation(player, 18483.21875 + rand, 140415.296875, 1556.962, 160 )
end

AddEvent("OnPlayerJoin", OnPlayerJoin)

AddEvent("OnPlayerSpawn", function(player)
    Delay(5000, function()
        for i=1,GetObjectCount() do
            if IsValidObject(i) then
                CallRemoteEvent(player, "SetObjectOutilned", i)
            end
        end
    end)
end)

function assign_spawn(player)
    local spawn_location = spawns[current_map]
    local spawn_idx = Random(1, spawns_max[current_map])
    local assigned_spawn = spawn_location[spawn_idx]
    
    if OGK_GG_DEBUG then
        AddPlayerChat(player, "You are assigned spawn #".. spawn_idx.. "")
    end
    -- local assigned_spawn = spawn_location[Random(1, 1]
    
    SetPlayerLocation(player, assigned_spawn[1], assigned_spawn[2], assigned_spawn[3] + 150, assigned_spawn[4])
end

function SetPlayerTeam(player)
    -- hunter: 1 props: 2
    -- choose a team for the player
    local count_props = #game.propsTeams  
    local count_hunts = #game.huntersTeams
    
    if(game.state == "lobby" or game.state == "regame") then
        if(count_hunts == count_props) then
            game.huntersTeams[count_hunts+1] = player
            players[player].team = "hunter"
            Logger.info('server.lua', "Player in hunter: " .. #game.huntersTeams .. "Player in props: " .. #game.propsTeams, "SetPlayerTeam() - 1")
            NotifyPlayer(player, "1-Vous êtes dans la teams des Hunters.", "HUNTERS", 5000)
        else
            game.propsTeams[count_props+1] = player
            players[player].team = "prop"
            Logger.info('server.lua', "Player in hunter: " .. #game.huntersTeams .. "Player in props: " .. #game.propsTeams, "SetPlayerTeam() - 2")
            NotifyPlayer(player, "2-Vous êtes dans la teams des Props.", "PROPS", 5000)
        end
    end

end

function EndTheGame()
    -- check if props doesn't win
    if(game.state == "huntwin") then return false end
    Delay(150000, function()
        NotifyAllPlayers('End of the game in 2.5 minutes!', nil, 5000)
    end)
    Delay(300000, function() 
        game.state = "regame"

        NotifyAllPlayers('props wins !!!!!!!!', nil, 1000)
        
        game.huntersTeams = {}
        game.propsTeams = {}
        
        local randomx = Random(1, 50)

        -- Electing random maps
        local next_map = Random(1, avaible_map_count)
        current_map = avaible_map[next_map]

        Delay(5000, function()
            for k, v in ipairs(GetAllPlayers()) do
                if(players[k].attached == true)then
                    SetObjectDetached(players[player].object)
                    for k, v in ipairs(GetAllPlayers()) do
                        CallRemoteEvent(k, "PlayerHider", player, false, objectt)
                    end
                    players[player].attached = false
                    players[player].object = nil
                end
                SetPlayerWeapon(k, 1, 0, true, 1, true)
                SetPlayerSpectate(k, false)
                CallEvent("PlayerHider", k, false, players[k].object)
                
                players[k].team = ""
                local rand = Random(1, 100)
                -- Set where the player is going to spawn.
                SetPlayerLocation(k, 18483.21875 + rand, 140415.296875, 1556.962+150, 160 )
                SetPlayerTeam(k)
            end
        end)
        Delay(20000, function()
            game.state = "lobby"
        end)
    end)
end
 -- function for start game
function StartTheGame()
    local calc = #game.huntersTeams + #game.propsTeams
    Logger.info('server.lua', #game.huntersTeams .. #game.propsTeams, "StartTheGame() - 1")
    if(calc >= game.minplayer) then
        if(game.state == "lobby") then
            game.state = "game"
            NotifyAllPlayers("Game start in 30 seconds !", "Game Start !", 30000)
            -- start the game after 5 seconds (for players spawnings time)
            Delay(30000, function()
                Logger.info('server.lua', 'game start', "StartTheGame() - 2")
                NotifyAllPlayers("Game start !", "test", 2000)
                local object_test = CreateObject(490, 125773.000000, 80246.000000, 1645.000000, 0)
    
                for _, v in ipairs(game.huntersTeams) do
                    NotifyPlayer(v, "Vous devez attendre pendant 1 minutes pendants que les props ce cache !", "HUNTER", 60000)
        
                    Delay(15000, function()
                        assign_spawn(v)
                        NotifyPlayer(v, "Vous devez trouvez les props.", "HUNTER", 2000)

                         -- async hide for all players
                        Delay(5000, function()
                            for _, t in ipairs(game.propsTeams) do
                                if(players[t].attached == true) then
                                    CallRemoteEvent(v, "PlayerHider", t, true, players[t].object)
                                end
                            end

                            SetPlayerWeapon(v, 5, 500, true, 1, true)
                        end)
                    end)

                   
                end
        
                for _, v in ipairs(game.propsTeams) do 
                    assign_spawn(v)
                    NotifyPlayer(v, "Vous avez 1 minutes pour vous cachez avec (E) !!!", "PROP", 10000)
                end
        
                AddPlayerChatAll('Props win after 5 minutes!', "Game started", 5000)
                
                -- start the end function
                EndTheGame()
            end)
        end
    else
        local counts = GetPlayerCount()
        local max = 4 - counts
        NotifyAllPlayers("There is not enough players to start the game !" .. "You have to wait: " .. max .. "more players!", "Enough player !", 15000)
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

    CreateTimer(function()
        if(game.state ~= "lobby" or game.state ~= "regame") then
            StartTheGame()
        end
    end, 30000)
    
    -- check if game is on and do something
    game.state = "lobby"
end)

AddRemoteEvent("AttachPlayerObject", function(player, objectt)
    local x, y, z = GetPlayerLocation(player)
    if(game.state == "game") then
        if(players[player].team == "hunter") then return end
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
        Logger.info('server.lua', 'player' .. GetPlayerName(player) .. 'are now object:' .. objectt, "EVENT: AttachPlayerObject - 2")
    end
end)

AddEvent("OnPlayerDeath", function(player, instigator)
    if(game.state ~= "lobby") then
        print(game.propsTeams[player])
        if(game.propsTeams[player] ~= nil) then
            game.killed_props = game.killed_props + 1
            print('slt')
            prin(#game.propsTeams, game.killed_props)
            print(game.state)
            if(game.killed_props == #game.propsTeams and game.state == "game") then
                game.state = "huntwin"
                NotifyAllPlayers('Hunters wins !!!!!!!!', nil, 1000)
                prin(#game.propsTeams, game.killed_props)
                game.huntersTeams = {}
                game.propsTeams = {}
                
                local randomx = Random(1, 50)
        
                -- Electing random maps
                local next_map = Random(1, avaible_map_count)
                current_map = avaible_map[next_map]
                game.state = "regame"
        
                Delay(5000, function()
                    for k, v in ipairs(GetAllPlayers()) do
                        if(players[k].attached == true)then
                            SetObjectDetached(players[player].object)
                            for k, v in ipairs(GetAllPlayers()) do
                                CallRemoteEvent(k, "PlayerHider", player, false, objectt)
                            end
                            players[player].attached = false
                            players[player].object = nil
                        end
                        SetPlayerWeapon(k, 1, 0, true, 1, true)
                        SetPlayerSpectate(k, false)
                        CallEvent("PlayerHider", k, false, players[k].object)
                        
                        players[k].team = ""
                        local rand = Random(1, 100)
                        -- Set where the player is going to spawn.
                        SetPlayerLocation(k, 18483.21875 + rand, 140415.296875, 1556.962+150, 160 )
                        SetPlayerTeam(k)
                    end
                end)
                Delay(20000, function()
                    game.state = "lobby"
                end)
            
            end
        end

        SetObjectDetached(players[player].object)
        for k, v in ipairs(GetAllPlayers()) do
            CallRemoteEvent(k, "PlayerHider", player, false, objectt)
        end
        players[player].attached = false
        players[player].object = nil
    end
end)

function PlayerJoinFunc(player)
    if(game.state == "lobby") then
        NotifyPlayer(player, "Bienvenue sur propshunts vous êtes dans le lobby", "Lobby", 10000)
        SetPlayerTeam(player)
   
    else    
        NotifyPlayer(player, "Une partie est en cours !", "CURRENTLY IN A GAME !!!", 60000)
        Delay(5000, function()
            assign_spawn(player)
            SetPlayerSpectate(player, true)
        end)
    end
end

AddRemoteEvent("SetPlayerAsSpawn", function(player)
    if(players[player].spawned == false) then
        players[player].spawned = true
        PlayerJoinFunc(player)
    end
end)
