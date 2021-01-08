--Game Over scene

local composer = require( "composer" )
local scene = composer.newScene()
local widget = require("widget")

function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
    	--Background
        local background = display.newRect(display.contentCenterX, display.contentCenterY, 1000, 1000)
        background:setFillColor( 153/255,50/255,204/255 )
        background:toFront()
        sceneGroup:insert( background )

        --Game over text
        local titleText = display.newText( "You Went Bankrupt!", 160, 50, "Impact", 35)
        titleText:setFillColor( 255/255, 255/255, 255/255 )
        titleText:toFront()

        --Game over text
        local gameOverText = display.newText( "Game Over", 160, 95, "Impact", 30)
        gameOverText:setFillColor( 255/255, 255/255, 255/255 )
        gameOverText:toFront()

        --Getting the highest score and rounds played variables from the game scene
        local highestMoney = composer.getVariable( "finalScore" )
        local numberOfRounds = composer.getVariable( "roundsPlayed" )

        --Displaying the highest amount of money the player had while playing
        moneyText = display.newText( "Highest Money: "..highestMoney.."$", 160, 210, native.systemFont, 25 )
        moneyText:setFillColor( 255/255, 255/255, 255/255 )

        --Displaying the number of rounds played
        roundText = display.newText( "Rounds Played: "..numberOfRounds, 160, 270, native.systemFont, 25 )
        roundText:setFillColor( 255/255, 255/255, 255/255 )

        --Button that sends the player back to the menu
        local menuButton = widget.newButton
        {
            label = "Back to Menu",
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
                    display.remove(background)
                    display.remove(titleText)
                    display.remove(gameOverText)
                    display.remove(roundText)
                    display.remove(moneyText)
                    
                    composer.gotoScene("menu")
                end
            end
        }
        menuButton.x = 160
        menuButton.y = 460
        menuButton:toFront()
        sceneGroup:insert(menuButton)

        --Button that sends the player to see the high scores
        local highScoresButton = widget.newButton
        {
            label = "View High Scores",
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
                    display.remove(background)
                    display.remove(titleText)
                    display.remove(gameOverText)
                    display.remove(roundText)
                    display.remove(moneyText)
                    
                    composer.gotoScene("highscores")
                end
            end
        }
        highScoresButton.x = 160
        highScoresButton.y = 380
        highScoresButton:toFront()
        sceneGroup:insert(highScoresButton)

    elseif ( phase == "did" ) then
    	-- Code here runs when the scene is entirely on screen
    end
end

function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
    
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