--This is the connection to the main.lua scene changer
local composer = require( "composer" )
local scene = composer.newScene()

--This is the change and transition to the next scene after the user presses a button
local function showScene2 ()

    local options = {
        effect = "crossFade",
        time = 1000
    }
    composer.gotoScene( "menu", options)
end
 
--The main functionality for the scene is located in the scene:show function
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        
        --Cosmetics such as the background and title text
        local background = display.newImageRect ( "Assets/highscores.png", 500, 1000)
        background.x = 160
        background.y = 240
        background:setFillColor(255, 255, 255)
        sceneGroup:insert(background)

        local myText = display.newText( "Black Jack", 160, 240, "Impact", 50)
        myText:setFillColor( 255/255, 255/255, 255/255 )
        sceneGroup:insert(myText)

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
         timer.performWithDelay( 5000, showScene2 )
    end
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
--scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
--scene:addEventListener( "hide", scene )
--scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene
