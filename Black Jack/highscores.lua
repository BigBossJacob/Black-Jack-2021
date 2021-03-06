--High scores scene

local composer = require( "composer" )
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

--json file for storing highscores
local json = require( "json" )
 
local scoresTable = {}
 
local filePath = system.pathForFile( "scores.json", system.DocumentsDirectory )

local function loadScores()

    local file = io.open( filePath, "r" )
 
    if file then
        local contents = file:read( "*a" )
        io.close( file )
        scoresTable = json.decode( contents )
    end
 
    if ( scoresTable == nil or #scoresTable == 0 ) then
        scoresTable = { 50, 50, 50, 50, 50 }
    end
end

local function saveScores()
 
    for i = #scoresTable, 6, -1 do
        table.remove( scoresTable, i )
    end
 
    local file = io.open( filePath, "w" )
 
    if file then
        file:write( json.encode( scoresTable ) )
        io.close( file )
    end
end
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
local function gotoMenu()
    display.remove(cover3)
    cover3:toBack()
    composer.gotoScene( "menu" )

end

-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    
    -- Load the previous scores
    loadScores()

    -- Insert the saved score from the last game into the table, then reset it
    table.insert( scoresTable, composer.getVariable( "finalScore" ) )
    composer.setVariable( "finalScore", 0 )

    -- Sort the table entries from highest to lowest
    local function compare( a, b )
        return a > b
    end
    table.sort( scoresTable, compare )

    -- Save the scores
    saveScores()

    --Background
    local background = display.newRect(display.contentCenterX, display.contentCenterY, 1000, 1000)
    background:setFillColor( 0/255,85/255,130/255 )
    sceneGroup:insert( background )

    --Title text
    local highScoresHeader = display.newText( sceneGroup, "High Scores", display.contentCenterX, 100, "Impact", 44 )

    for i = 1, 5 do
        if ( scoresTable[i] ) then
            local yPos = 150 + ( i * 56 )
            
            cover3 = display.newImage( "Assets/PNG/green_card_back.png" )
            cover3.x = 40
            cover3.y = 280
            cover3.width = 1000
            cover3.height = 300
            cover3:toBack()

            local rankNum = display.newText( sceneGroup, i .. ")", display.contentCenterX-50, yPos, native.systemFont, 36 )
            rankNum:setFillColor( 255/255, 255/255, 255/255 )
            rankNum.anchorX = 1
            rankNum:toFront()
 
            local thisScore = display.newText( sceneGroup, scoresTable[i]..("$"), display.contentCenterX-30, yPos, native.systemFont, 36 )
            thisScore.anchorX = 0
            thisScore:toFront()
        end
    end

    local gameButton = display.newText( sceneGroup, "Back To Menu", display.contentCenterX, 0, native.systemFont, 20 )
    gameButton:setFillColor( 255, 255, 255 )
    gameButton:addEventListener( "tap", gotoMenu )
    gameButton:toFront()
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
 
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
        composer.removeScene( "highscores" )
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene