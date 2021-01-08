-- menuScene

local composer = require( "composer" )
local widget = require("widget")
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
local function showGameScene()
    local options = {
        effect = "fade",
        time = 500
    }
    composer.gotoScene( "game" , options )
end 
 
 
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        
        --Cosmetics such as the background and title
        local background = display.newRect(display.contentCenterX, display.contentCenterY, 1000, 1000)
        background:setFillColor( 0/255,255/255,0/255 )
        background:toFront()
        sceneGroup:insert( background ) 

        local titleText = display.newText( "Black Jack", 160, -10, "Impact", 50)
        titleText:setFillColor( 0/255, 97/255, 255/255 )
        titleText:toFront()

        --The text that displays the rules of the game
        local rulesText = display.newText( "Rules:", 160, 35, "Consolas", 30)
        rulesText:setFillColor( 0/255, 97/255, 255/255 )
        rulesText:toFront()

        local goalText = display.newText( "Your goal: get more points than the", 160, 60, "Consolas", 15)
        goalText:setFillColor( 0/255, 97/255, 255/255 )
        goalText:toFront()

        local goalText2 = display.newText( "dealer without going over 21!", 160, 80, "Consolas", 15)
        goalText2:setFillColor( 0/255, 97/255, 255/255 )
        goalText2:toFront()

        local maxCards = display.newText( "Maximum six cards each.", 160, 110, "Consolas", 15)
        maxCards:setFillColor( 0/255, 97/255, 255/255 )
        maxCards:toFront()

        local hitButtonText = display.newText( "Press 'Hit' for another card.", 160, 140, "Consolas", 15)
        hitButtonText:setFillColor( 0/255, 97/255, 255/255 )
        hitButtonText:toFront()

        local standButtonText = display.newText( "Press 'Stand' to end your turn.", 160, 170, "Consolas", 15)
        standButtonText:setFillColor( 0/255, 97/255, 255/255 )
        standButtonText:toFront()

        local acesText = display.newText( "Aces can be 1 or 11.", 160, 200, "Consolas", 15)
        acesText:setFillColor( 0/255, 97/255, 255/255 )
        acesText:toFront()

        local faceText = display.newText( "Face cards are all worth 10.", 160, 230, "Consolas", 15)
        faceText:setFillColor( 0/255, 97/255, 255/255 )
        faceText:toFront()

        local moneyText1 = display.newText( "You start with 50$.", 160, 260, "Consolas", 15)
        moneyText1:setFillColor( 0/255, 97/255, 255/255 )
        moneyText1:toFront()

        local moneyText2 = display.newText( "You play until you have 0$.", 160, 290, "Consolas", 15)
        moneyText2:setFillColor( 0/255, 97/255, 255/255 )
        moneyText2:toFront()

        local winText = display.newText( "You gain $10 for a win.", 160, 320, "Consolas", 15)
        winText:setFillColor( 0/255, 97/255, 255/255 )
        winText:toFront()

        local lossText = display.newText( "You lose $10 for a loss.", 160, 350, "Consolas", 15)
        lossText:setFillColor( 0/255, 97/255, 255/255 )
        lossText:toFront()

        local glhfText = display.newText( "Good luck, have fun! (:", 160, 380, "Consolas", 15)
        glhfText:setFillColor( 0/255, 97/255, 255/255 )
        glhfText:toFront()

        local noteText = display.newText( "Note: leaving the game will lose all your", 160, 405, "Consolas", 10)
        noteText:setFillColor( 0/255, 97/255, 255/255 )
        noteText:toFront()

        local noteText2 = display.newText( "money you have gained ( money resets to 0).", 160, 420, "Consolas", 10)
        noteText2:setFillColor( 0/255, 97/255, 255/255 )
        noteText2:toFront()


        --Button that starts the game
        local button = widget.newButton
        {
            label = "Press To Start",
            fontSize = 30,
            -- Properties for a rounded rectangle button
            shape = "roundedRect",
            width = 300,
            height = 50,
            cornerRadius = 2,
            fillColor = { default={1,1,1,1}, over={1,0.1,0.7,0.4} },
            strokeColor = { default={1,0.4,0,1}, over={0.8,0.8,1,1} },
            strokeWidth = 4,
            onEvent = function (event)
                if event.phase == "ended" then
                    display.remove(highScoreButton)
                    display.remove(titleText)
                    display.remove(rulesText)
                    display.remove(goalText)
                    display.remove(goalText2)
                    display.remove(maxCards)
                    display.remove(hitButtonText)
                    display.remove(standButtonText)
                    display.remove(acesText)
                    display.remove(faceText)
                    display.remove(moneyText1)
                    display.remove(moneyText2)
                    display.remove(winText)
                    display.remove(lossText)
                    display.remove(glhfText)
                    display.remove(noteText)
                    display.remove(noteText2)
                    
                    composer.gotoScene("game")
                end
            end
        }
        button.x = 160
        button.y = 460
        button:toFront()
        sceneGroup:insert(button)
    

        --Hides the name textfield
        function scene:hide(event)

        if nameFieldTextField then
            nameFieldTextField :removeSelf()
            nameFieldTextField = nil
        end
end
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
 
    end
end

function scene:destroy( event )
 
    local sceneGroup = self.view
    

end
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
--scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
--scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
scene:addEventListener( "hide", scene )
-- -----------------------------------------------------------------------------------
 
return scene