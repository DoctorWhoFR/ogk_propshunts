local function GetViewPoint(maxdistance)
    local width, height = GetScreenSize()
    local sc1, cX, cY, cZ = ScreenToWorld(width / 2, height / 2)
    if not sc1 then
        return false
    end
    local vX, vY, vZ = GetCameraForwardVector()
    local hitType, hitId, hitX, hitY, hitZ = LineTrace(cX, cY, cZ, cX + (vX * maxdistance), cY + (vY * maxdistance), cZ + (vZ * maxdistance))
    if hitType ~= 5 and hitType ~= 6 then
        return false
    end
    return hitX, hitY, hitZ
end

local function GetClosestPickup(x, y, z, maxdistance)
    local pickups = GetStreamedObjects()
    local pickup = 0
    local distance = maxdistance
    for i=1,#pickups do
        local px, py, pz = GetObjectLocation(pickups[i])
        local d = GetDistance3D(x, y, z, px, py, pz)
        if d < distance then
            distance = d
            pickup = pickups[i]
        end
    end
    return pickup
end

local function GetPickupLookingAt()
    local vx, vy, vz = GetViewPoint(600)
    if vx == false then
        return 0
    end
    return GetClosestPickup(vx, vy, vz, 150)
end

AddEvent("OnPlayerSpawn", function(playerid)
end)

function OnKeyPress(key)
    if key == "E" then
        local object = GetPickupLookingAt()
        CallRemoteEvent("AttachPlayerObject", object)
    end
    if key == "Z" then
        CallRemoteEvent("SetPlayerAsSpawn", GetPlayerId())
    end
    if key == "D" then
        CallRemoteEvent("SetPlayerAsSpawn", GetPlayerId())
    end
    if key == "S" then
        CallRemoteEvent("SetPlayerAsSpawn", GetPlayerId())
    end
end
AddEvent("OnKeyPress", OnKeyPress)

AddRemoteEvent("PlayerHider", function(player, status, object)
    GetPlayerActor(player):SetActorHiddenInGame(status)
    GetObjectStaticMeshComponent( object ):SetCollisionEnabled(ECollisionEnabled.QueryAndPhysics)
end)

AddRemoteEvent("SetObjectOutilned", function(objectId)
    AddPlayerChat("Set outlining for player : " .. objectId)
    SetObjectOutline(objectId, true)
end)

AddEvent("OnPlayerDeath", function(player, instigator)
   CallRemoteEvent("ServerPlayerDeath", player, instigator)
end)