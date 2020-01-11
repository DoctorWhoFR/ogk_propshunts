local testUi
AddEvent("OnPlayerSpawn", function()
    testUi = CreateWebUI(0.0, 0.0, 0.0, 0.0, 5, 60)
	LoadWebFile(testUi, "http://asset/ogk_propshunts/resources/gui/build/index.html")
	SetWebAlignment(testUi, 0.0, 0.0)
	SetWebAnchors(testUi, 0.0, 0.0, 1.0, 1.0)
    SetWebVisibility(testUi, WEB_VISIBLE)
    SetInputMode(INPUT_GAME)    
    
    CreateTimer(function()
        if testUi then
            ExecuteWebJS(testUi, "incrementCounter()")
        end
    end, 1000)

    Delay(5000, function()
        SetWebVisibility(testUi, WEB_HIDDEN)
    end)
end)
