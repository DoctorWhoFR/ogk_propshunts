-------- GAME MANAGER --------

-- check the game state etc... and do something for
-- ---- State: ----
-- IN A GAME
-- IN LOBBY

-- Game time 5 times
game = {
    state = "lobby", -- lobby, game
    minplayer = 2,
    huntersTeams = {},
    propsTeams = {},
    killed_props = 0
}

timesConfigs = {
    GameStartTime = 0, -- time after enough player or restart a game
    PlayerJoinMsg = 30000, -- time for player message
}
-------- GAME MANAGER --------

-------- MAP MANAGER --------
current_map = "tropico"
-- current_map = "hangar"

avaible_map = {"western", "armory", "port", "port_small", "trucks_center", "tropico"} -- "paradise_ville", "chemistry"}
avaible_map_count = 6
last_map = 6
-------- MAP MANAGER --------

-- BLACK LIST OF MODEL Id
blacklists = {851}
