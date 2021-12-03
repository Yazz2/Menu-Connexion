
local Chargement = nil
local Percentage = 0.0

function Validation()
    local CoMenu = RageUI.CreateMenu("Votre Serveur", "ALARME")
    --CoMenu:SetRectangleBanner(51, 153,237, 0.68) --[enlevez les deux tiré devant la ligne et vous allez sur ce site pour avoir les couleur : https://rgbacolorpicker.com/]
    CoMenu.Closable = false

    RageUI.Visible(CoMenu, not RageUI.Visible(CoMenu))

    while CoMenu do 
        Wait(0)
        RageUI.IsVisible(CoMenu, function()
            
            RageUI.Separator("~b~Votre Discord")
            RageUI.Button('Cliquer pour se Réveiller', nil , {}, true, {
                onSelected = function()
                    Chargement = true   

                end
            })
            if Chargement == true then
                RageUI.PercentagePanel(Percentage or 0.0, "Réveil en cours ... ("..math.floor(Percentage * 100).."%)", "", "",  function(Hovered, Active, Percent)
                    if Percentage < 1.0 then
                        Percentage = Percentage + 0.004
                    else
                        DoScreenFadeOut(1000)
                        Citizen.Wait(2000)
                        RenderScriptCams(false, false, 0, true, true)
                        Wait(1000)
                        FreezeEntityPosition(GetPlayerPed(-1), false)
                        SetEntityVisible(GetPlayerPed(-1), true, 0)
                        RageUI.CloseAll()
                        
                        DoScreenFadeIn(2000)
                        TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_BUM_SLUMPED", 0, 0)
                        Wait(4000)
                        ClearPedTasks(GetPlayerPed(-1))
                        DisplayRadar(true)
                        
                    end 
                end)
                
            end
        end)
        if not RageUI.Visible(CoMenu) then
            CoMenu = RMenu:DeleteType('CoMenu', true)
        end
    end
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    spawn()
	Validation()

end)

function spawn()
    DisplayRadar(false)
    TriggerEvent('esx_status:setDisplay', 0.0)
    guiEnabled = true
    local playerPed = PlayerPedId()
    pressedenter = true
    local introcam
    SetEntityVisible(playerPed, false, false)
    FreezeEntityPosition(GetPlayerPed(-1), true)
    SetFocusEntity(playerPed)
    Wait(1)
    SetOverrideWeather("EXTRASUNNY")
    NetworkOverrideClockTime(19, 0, 0)
    BeginSrl()
    introstep = 1
    isinintroduction = true
    Wait(1)
    DoScreenFadeIn(500)
    if introstep == 1 then
        introcam = CreateCam("DEFAULT_SCRIPTED_CAMERA", false)
        SetCamActive(introcam, true)
        SetCamCoord(introcam, 701.47, 1031.08, 330.57)
        ShakeCam(introcam, "HAND_SHAKE", 0.1)
        SetCamRot(introcam, -0, -0, -11.48)
        SetCamActive(introcam, true)
        RenderScriptCams(1, 0, 500, false, false)
        return
    end
end



