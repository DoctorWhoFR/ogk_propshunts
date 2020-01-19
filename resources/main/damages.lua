AddEvent("OnPlayerWeaponShot", function(player, weapon, hittype, hitid, hitX, hitY, hitZ, startX, startY, startY, normalX, normalY, normalZ)
    --print("Got a hit by " ..player.." with "..weapon)
    --print("Hit on "..hitid)
    --print("With entity being "..hittype)
    --print("Hit Location "..hitX..","..hitY..","..hitZ)
    
    if(game.state == "game") then
        -- Check if the hitid is coherent to continue processing
        if hittype == 5 and hitid ~= 0 then
            -- Search nearest player hit
            local victim = GetNearestPlayer2D(hitX, hitY)
            if players[victim].object == hitid then
                local victimHealth = GetPlayerHealth(victim)
                SetPlayerHealth(victim, victimHealth - 15)
                return false;
            end
        end

        
        local damage = Random(1, 3)
        -- Give penalty to the player
        local playerHealth = GetPlayerHealth(player)
        SetPlayerHealth(player, playerHealth - damage)
        return false
    end

end)
