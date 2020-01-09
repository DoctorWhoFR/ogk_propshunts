function OnKeyPress(key)
	AddPlayerChat(key)
	if key == "E" then
		AddPlayerChat("You have pressed TAB!")
	end
end
AddEvent("OnKeyPress", OnKeyPress)

AddEvent("OnPackageStart", function()
    
end)

AddEvent("OnObjectHit", function(object, hittype, hitid, hitX, hitY, hitZ, normalX, normalY, normalZ)
    if IsValidObject(object) then
        if IsValidPlayer(hitid) then
            AddPlayerChat(hitid, "test")
            GetPlayerActor(hitid):SetActorHiddenInGame(true)
            CallRemoteEvent("AttachPlayerObject", object)
        end
    end
end)