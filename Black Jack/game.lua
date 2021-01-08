--Game Scene

--Initializing composer variables
local composer = require( "composer" )
local scene = composer.newScene()

--Requiring widget variable to make buttons
local widget = require("widget")

--Setting player and dealer card values to global
playerCard1 = nil
playerCard2 = nil
playerCard3 = nil
playerCard4 = nil
playerCard5 = nil
playerCard6 = nil

dealerCard1 = nil
dealerCard2 = nil
dealerCard3 = nil
dealerCard4 = nil
dealerCard5 = nil
dealerCard6 = nil

--Setting up image variables as global
playerCardImage1 = nil
playerCardImage2 = nil
playerCardImage3 = nil
playerCardImage4 = nil
playerCardImage5 = nil
playerCardImage6 = nil

dealerCardImage1 = nil
dealerCardImage2 = nil
dealerCardImage3 = nil
dealerCardImage4 = nil
dealerCardImage5 = nil
dealerCardImage6 = nil

--Setting the dealer and player card values to 0
playerCardValue1 = 0
playerCardValue2 = 0
playerCardValue3 = 0
playerCardValue4 = 0
playerCardValue5 = 0
playerCardValue6 = 0

dealerCardValue1 = 0
dealerCardValue2 = 0
dealerCardValue3 = 0
dealerCardValue4 = 0
dealerCardValue5 = 0
dealerCardValue6 = 0

function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then

    	--Background
   		local background = display.newRect(display.contentCenterX, display.contentCenterY, 1000, 1000)
        background:setFillColor( 1/255,109/255,41/255 )
        sceneGroup:insert( background )

        --Images to create a deck of cards
        local deckOfCards = display.newImage("Assets/PNG/red_back.png") 
        deckOfCards.x = 270
        deckOfCards.y = 100
        deckOfCards.width = 75
        deckOfCards.height = 100

        local deckOfCards2 = display.newImage("Assets/PNG/red_back.png") 
        deckOfCards2.x = 272.5
        deckOfCards2.y = 102.5
        deckOfCards2.width = 75
        deckOfCards2.height = 100
      	
      	local deckOfCards3 = display.newImage("Assets/PNG/red_back.png") 
        deckOfCards3.x = 275
        deckOfCards3.y = 105
        deckOfCards3.width = 75
        deckOfCards3.height = 100

        --Widget values for the hit button
        local hitButton = widget.newButton
        {
            label = "Hit",
            fontSize = 15,
            labelColor = { default = {1,1,1,1}, over = {1,1,1,1} },
            -- Properties for a rounded rectangle button
            shape = "roundedRect",
            width = 50,
            height = 25,
            cornerRadius = 2,
            fillColor = { default={0,0.71,0.93,1}, over={0.8,0.8,1,1} },
            strokeColor = { default={1,1,1,1}, over={1,0.1,0.7,0.4} },
            strokeWidth = 3,
            onEvent = function (event)
                if event.phase == "ended" then
                    hitButtonTouch()
                end
            end
        }
        hitButton.x = 285
        hitButton.y = 450
        hitButton:toFront()
        sceneGroup:insert(hitButton)

        --Widget values for the stand button
        local standButton = widget.newButton
        {
            label = "Stand",
            fontSize = 15,
            labelColor = { default = {1,1,1,1}, over = {1,1,1,1} },
            -- Properties for a rounded rectangle button
            shape = "roundedRect",
            width = 50,
            height = 25,
            cornerRadius = 2,
            fillColor = { default={0,0.71,0.93,1}, over={0.8,0.8,1,1} },
            strokeColor = { default={1,1,1,1}, over={1,0.1,0.7,0.4} },
            strokeWidth = 3,
            onEvent = function (event)
                if event.phase == "ended" then
                    standButtonTouch()
                end
            end
        }
        standButton.x = 285
        standButton.y = 400
        standButton:toFront()
        sceneGroup:insert(standButton)

        --This is the code that shows the location of the player's hand
        playerText = display.newText( "Your Hand", 160, 500, native.systemFont, 20 )
        playerText:setFillColor( 255/255, 255/255, 255/255 )

        --Defining variables for displaying the player's amount of money
        playerMoney = 50

        playerMoneyText = display.newText( "Money: $"..playerMoney, 45, 500, native.systemFont, 12 )
		playerMoneyText:setFillColor( 255/255, 255/255, 255/255 )

        --This is the variable for the highest amount of money the player had in the game
        highestMoney = 50

        --This variable is the number of rounds played
        rounds = 0

        --This controls which random cards you and the dealer will receive
        math.randomseed( os.time() )

        --This is the code that creates the dealer and his starting hand
        dealerText = display.newText( "The Dealer", 160, -20, native.systemFont, 20 )
		dealerText:setFillColor( 255/255, 255/255, 255/255 )

        --Initializing both player and dealer amounts
        playerAmount = 0
        dealerAmount = 0

        --There are parameters for card dimensions and locations
        cardWidth = 75
        cardHeight = 100

        dealerCard1X = 160
        dealerCard1Y = 60
        dealerCard2X = 100
        dealerCard2Y = 50
        dealerCard3X = 40
        dealerCard3Y = 170
        dealerCard4X = 120
        dealerCard4Y = 170
        dealerCard5X = 200
        dealerCard5Y = 170
        dealerCard6X = 280
        dealerCard6Y = 170

        playerCard1X = 185
        playerCard1Y = 400
        playerCard2X = 135
        playerCard2Y = 390
        playerCard3X = 40
        playerCard3Y = 280
        playerCard4X = 120
        playerCard4Y = 280
        playerCard5X = 200
        playerCard5Y = 280
        playerCard6X = 280
        playerCard6Y = 280

        --Setting up the variable that keeps track of the high scores and rounds played
        composer.setVariable( "finalScore", highestMoney )
        composer.setVariable("roundsPlayed", rounds)

        --This function allows the player to see the high scores accumulated by the game
        function gameOver()
            --Removing all cards
            display.remove(playerCardImage1)
            display.remove(playerCardImage2)
            display.remove(playerCardImage3)
            display.remove(playerCardImage4)
            display.remove(playerCardImage5)
            display.remove(playerCardImage6)
            display.remove(dealerCardImage1)
            display.remove(dealerCardImage2)
            display.remove(dealerCardImage3)
            display.remove(dealerCardImage4)
            display.remove(dealerCardImage5)
            display.remove(dealerCardImage6)
            display.remove(deckOfCards)
            display.remove(deckOfCards2)
            display.remove(deckOfCards3)

            --Removing all buttons
            display.remove(highScoreButton)
            display.remove(standButton)
            display.remove(hitButton)

            --Removing all text
            display.remove(playerMoneyText)
            display.remove(playerAmountText)
            display.remove(dealerAmountText)
            display.remove(dealerText)
            display.remove(playerText)
            display.remove(endText)

            --Passing the player's score to 
            composer.setVariable( "finalScore", highestMoney )
            composer.setVariable( "roundsPlayed", rounds )
            composer.gotoScene("gameover")
        end

        --This function resets the board and allows the player to play again
        function resetBoard()
            --This if statement determines whether or not the player is bankrupt
            if playerMoney == 0 then
                timer.performWithDelay(1000, gameOver)
            else
                --Print statements announcing reset
                print("")
                print("game reset")
                print("")

                --Removing all the images from the screen
                display.remove(playerCardImage1)
                display.remove(playerCardImage2)
                display.remove(playerCardImage3)
                display.remove(playerCardImage4)
                display.remove(playerCardImage5)
                display.remove(playerCardImage6)
                display.remove(dealerCardImage1)
                display.remove(dealerCardImage2)
                display.remove(dealerCardImage3)
                display.remove(dealerCardImage4)
                display.remove(dealerCardImage5)
                display.remove(dealerCardImage6)

                --Setting variables back to 0 or nil
                playerCardValue1 = 0
                playerCardValue2 = 0
                playerCardValue3 = 0
                playerCardValue4 = 0
                playerCardValue5 = 0
                playerCardValue6 = 0

                dealerCardValue1 = 0
                dealerCardValue2 = 0
                dealerCardValue3 = 0
                dealerCardValue4 = 0
                dealerCardValue5 = 0
                dealerCardValue6 = 0

                playerCard1 = nil
                playerCard2 = nil
                playerCard3 = nil
                playerCard4 = nil
                playerCard5 = nil
                playerCard6 = nil

                dealerCard1 = nil
                dealerCard2 = nil
                dealerCard3 = nil
                dealerCard4 = nil
                dealerCard5 = nil
                dealerCard6 = nil

                dealerAmount = 0
                playerAmount = 0
                endText.text = ("")

                --Moving the stand and hit button back into position
                standButton.y = 400
                hitButton.y = 450

                --Setting the card counter back to 0
                cardCounter = 0

                --This chooses the dealer's first card
                dealerCard1 = math.random(1,52)
                dealerCardValue1 = chooseCardValue(dealerCard1, dealerAmount)
                dealerCardImage1 = chooseCard(dealerCard1)
                dealerCardImage1.x = dealerCard1X
                dealerCardImage1.y = dealerCard1Y
                dealerCardImage1.width = cardWidth
                dealerCardImage1.height = cardHeight

                --This shows the back of the yet to be revealed second dealer card
                dealerCardImage2 = display.newImage( "Assets/PNG/red_back.png" )
                dealerCardImage2.x = 100
                dealerCardImage2.y = 50
                dealerCardImage2.width = 75
                dealerCardImage2.height = 100

                --Text indicating the dealer's score
                dealerAmountText.text = ("Amount: "..dealerCardValue1)

                --This chooses the player's first card
                playerCard1 = math.random(1,52)
                if playerCard1 == dealerCard1 then
                    playerCard1 = playerCard1 + 1
                end
                playerCardValue1 = chooseCardValue(playerCard1, playerAmount)
                playerCardImage1 = chooseCard(playerCard1)
                playerCardImage1.x = playerCard1X
                playerCardImage1.y = playerCard1Y
                playerCardImage1.width = cardWidth
                playerCardImage1.height = cardHeight

                --This chooses the player's second card
                playerCard2 = math.random(1,52)
                --Duplicate Blocker
                while playerCard2 == dealerCard1 or playerCard1 == playerCard2 do
                    playerCard2 = playerCard2 + 1
                end
                playerCardValue2 = chooseCardValue(playerCard2, playerAmount)
                playerCardImage2 = chooseCard(playerCard2)
                playerCardImage2.x = playerCard2X
                playerCardImage2.y = playerCard2Y
                playerCardImage2.width = cardWidth
                playerCardImage2.height = cardHeight

                --This variable calculates the total amount the player has in their hand
                playerAmount = playerCardValue1 + playerCardValue2

                --Making sure if the player draws two aces, it won't amount to 22
                if playerCardValue2 == 11 and playerCardValue1 == 11 then
                    playerCardValue2 = 1
                end

                --This variable calculates the total amount the player has in their hand
                playerAmount = playerCardValue1 + playerCardValue2

                --Text indicating the player's score
                playerAmountText.text = ("Amount: "..playerAmount)
            end
        end

        --This function chooses a card according to a randomly generated number
        function chooseCard(randomCard1)
            if randomCard1 == 1 then
                cardImage = display.newImage( "Assets/PNG/2C.png" )
            elseif randomCard1 == 2 then
                cardImage = display.newImage( "Assets/PNG/3C.png" )
            elseif randomCard1 == 3 then
                cardImage = display.newImage( "Assets/PNG/4C.png" )
            elseif randomCard1 == 4 then
                cardImage = display.newImage( "Assets/PNG/5C.png" )
            elseif randomCard1 == 5 then
                cardImage = display.newImage( "Assets/PNG/6C.png" )
            elseif randomCard1 == 6 then
                cardImage = display.newImage( "Assets/PNG/7C.png" )
            elseif randomCard1 == 7 then
                cardImage = display.newImage( "Assets/PNG/8C.png" )
            elseif randomCard1 == 8 then
                cardImage = display.newImage( "Assets/PNG/9C.png" )
            elseif randomCard1 == 9 then
                cardImage = display.newImage( "Assets/PNG/10C.png" )
            elseif randomCard1 == 10 then
                cardImage = display.newImage( "Assets/PNG/JC.png" )
            elseif randomCard1 == 11 then
                cardImage = display.newImage( "Assets/PNG/QC.png" )
            elseif randomCard1 == 12 then
                cardImage = display.newImage( "Assets/PNG/KC.png" )
            elseif randomCard1 == 13 then
                cardImage = display.newImage( "Assets/PNG/AC.png" )
            elseif randomCard1 == 14 then
                cardImage = display.newImage( "Assets/PNG/2H.png" )
            elseif randomCard1 == 15 then
                cardImage = display.newImage( "Assets/PNG/3H.png" )
            elseif randomCard1 == 16 then
                cardImage = display.newImage( "Assets/PNG/4H.png" )
            elseif randomCard1 == 17 then
                cardImage = display.newImage( "Assets/PNG/5H.png" )
            elseif randomCard1 == 18 then
                cardImage = display.newImage( "Assets/PNG/6H.png" )
            elseif randomCard1 == 19 then
                cardImage = display.newImage( "Assets/PNG/7H.png" )
            elseif randomCard1 == 20 then
                cardImage = display.newImage( "Assets/PNG/8H.png" )
            elseif randomCard1 == 21 then
                cardImage = display.newImage( "Assets/PNG/9H.png" )
            elseif randomCard1 == 22 then
                cardImage = display.newImage( "Assets/PNG/10H.png" )
            elseif randomCard1 == 23 then
                cardImage = display.newImage( "Assets/PNG/JH.png" )
            elseif randomCard1 == 24 then
                cardImage = display.newImage( "Assets/PNG/QH.png" )
            elseif randomCard1 == 25 then
                cardImage = display.newImage( "Assets/PNG/KH.png" )
            elseif randomCard1 == 26 then
                cardImage = display.newImage( "Assets/PNG/AH.png" )
            elseif randomCard1 == 27 then
                cardImage = display.newImage( "Assets/PNG/2S.png" )
            elseif randomCard1 == 28 then
                cardImage = display.newImage( "Assets/PNG/3S.png" )
            elseif randomCard1 == 29 then
                cardImage = display.newImage( "Assets/PNG/4S.png" )
            elseif randomCard1 == 30 then
                cardImage = display.newImage( "Assets/PNG/5S.png" )
            elseif randomCard1 == 31 then
                cardImage = display.newImage( "Assets/PNG/6S.png" )
            elseif randomCard1 == 32 then
                cardImage = display.newImage( "Assets/PNG/7S.png" )
            elseif randomCard1 == 33 then
                cardImage = display.newImage( "Assets/PNG/8S.png" )
            elseif randomCard1 == 34 then
                cardImage = display.newImage( "Assets/PNG/9S.png" )
            elseif randomCard1 == 35 then
                cardImage = display.newImage( "Assets/PNG/10S.png" )
            elseif randomCard1 == 36 then
                cardImage = display.newImage( "Assets/PNG/JS.png" )
            elseif randomCard1 == 37 then
                cardImage = display.newImage( "Assets/PNG/QS.png" )
            elseif randomCard1 == 38 then
                cardImage = display.newImage( "Assets/PNG/KS.png" )
            elseif randomCard1 == 39 then
                cardImage = display.newImage( "Assets/PNG/AS.png" )
            elseif randomCard1 == 40 then
                cardImage = display.newImage( "Assets/PNG/2D.png" )
            elseif randomCard1 == 41 then
                cardImage = display.newImage( "Assets/PNG/3D.png" )
            elseif randomCard1 == 42 then
                cardImage = display.newImage( "Assets/PNG/4D.png" )
            elseif randomCard1 == 43 then
                cardImage = display.newImage( "Assets/PNG/5D.png" )
            elseif randomCard1 == 44 then
                cardImage = display.newImage( "Assets/PNG/6D.png" )
            elseif randomCard1 == 45 then
                cardImage = display.newImage( "Assets/PNG/7D.png" )
            elseif randomCard1 == 46 then
                cardImage = display.newImage( "Assets/PNG/8D.png" )
            elseif randomCard1 == 47 then
                cardImage = display.newImage( "Assets/PNG/9D.png" )
            elseif randomCard1 == 48 then
                cardImage = display.newImage( "Assets/PNG/10D.png" )
            elseif randomCard1 == 49 then
                cardImage = display.newImage( "Assets/PNG/JD.png" )
            elseif randomCard1 == 50 then
                cardImage = display.newImage( "Assets/PNG/QD.png" )
            elseif randomCard1 == 51 then
                cardImage = display.newImage( "Assets/PNG/KD.png" )
            elseif randomCard1 == 52 then
                cardImage = display.newImage( "Assets/PNG/AD.png" )
            elseif randomCard1 == 53 then
                cardImage = display.newImage( "Assets/PNG/2C.png" )
            else
                print("Oops, this ain't it chief")
            end
            return cardImage
        end

        --This function sets the proper value of the card image selected
        function chooseCardValue(randomCard2, personAmount)
            if randomCard2 == 1 then
                cardValue = 2
            elseif randomCard2 == 2 then
                cardValue = 3
            elseif randomCard2 == 3 then
                cardValue = 4
            elseif randomCard2 == 4 then
                cardValue = 5
            elseif randomCard2 == 5 then
                cardValue = 6
            elseif randomCard2 == 6 then
                cardValue = 7
            elseif randomCard2 == 7 then
                cardValue = 8
            elseif randomCard2 == 8 then
                cardValue = 9
            elseif randomCard2 == 9 then
                cardValue = 10
            elseif randomCard2 == 10 then
                cardValue = 10
            elseif randomCard2 == 11 then
                cardValue = 10
            elseif randomCard2 == 12 then
                cardValue = 10
            elseif randomCard2 == 13 then
                if personAmount >= 11 then
                    cardValue = 1
                else
                    cardValue = 11
                end
            elseif randomCard2 == 14 then
                cardValue = 2
            elseif randomCard2 == 15 then
                cardValue = 3
            elseif randomCard2 == 16 then
                cardValue = 4
            elseif randomCard2 == 17 then
                cardValue = 5
            elseif randomCard2 == 18 then
                cardValue = 6
            elseif randomCard2 == 19 then
                cardValue = 7
            elseif randomCard2 == 20 then
                cardValue = 8
            elseif randomCard2 == 21 then
                cardValue = 9
            elseif randomCard2 == 22 then
                cardValue = 10
            elseif randomCard2 == 23 then
                cardValue = 10
            elseif randomCard2 == 24 then
                cardValue = 10
            elseif randomCard2 == 25 then
                cardValue = 10
            elseif randomCard2 == 26 then
                if personAmount >= 11 then
                    cardValue = 1
                else
                    cardValue = 11
                end
            elseif randomCard2 == 27 then
                cardValue = 2
            elseif randomCard2 == 28 then
                cardValue = 3
            elseif randomCard2 == 29 then
                cardValue = 4
            elseif randomCard2 == 30 then
                cardValue = 5
            elseif randomCard2 == 31 then
                cardValue = 6
            elseif randomCard2 == 32 then
                cardValue = 7
            elseif randomCard2 == 33 then
                cardValue = 8
            elseif randomCard2 == 34 then
                cardValue = 9
            elseif randomCard2 == 35 then
                cardValue = 10
            elseif randomCard2 == 36 then
                cardValue = 10
            elseif randomCard2 == 37 then
                cardValue = 10
            elseif randomCard2 == 38 then
                cardValue = 10
            elseif randomCard2 == 39 then
                if personAmount >= 11 then
                    cardValue = 1
                else
                    cardValue = 11
                end
            elseif randomCard2 == 40 then
                cardValue = 2
            elseif randomCard2 == 41 then
                cardValue = 3
            elseif randomCard2 == 42 then
                cardValue = 4
            elseif randomCard2 == 43 then
                cardValue = 5
            elseif randomCard2 == 44 then
                cardValue = 6
            elseif randomCard2 == 45 then
                cardValue = 7
            elseif randomCard2 == 46 then
                cardValue = 8
            elseif randomCard2 == 47 then
                cardValue = 9
            elseif randomCard2 == 48 then
                cardValue = 10
            elseif randomCard2 == 49 then
                cardValue = 10
            elseif randomCard2 == 50 then
                cardValue = 10
            elseif randomCard2 == 51 then
                cardValue = 10
            elseif randomCard2 == 52 then
                if personAmount >= 11 then
                    cardValue = 1
                else
                    cardValue = 11
                end
            elseif randomCard2 == 53 then
                cardValue = 2
            else
                print("Oops, this ain't it chief")
            end
            return cardValue
        end

        --This function determines the winner of the game
        function endGame()
            --Console print for visual reference for the user
            print("")
            print("Dealer Total: "..dealerAmount)
            print("Player Total: "..playerAmount)
            print("")
            print("We're in the endgame now....")
            print("")

            --Setting the buttons so the player can't interfere with the results
            hitButton.y = 1000
            standButton.y = 1000

            --This text tells you the outcome of the match
            endText = display.newText( "", 160, 240, native.systemFont, 40 )
            endText:setFillColor( 0/255, 0/255, 0/255 )

            --This if statement determines who wins the game
            if playerAmount > 21 then
                --This happens if the player is bust
                endText.text = ("Bust!")
                playerMoney = playerMoney - 10
                playerMoneyText.text = ("Money: $"..playerMoney)
                print("Player Money: "..playerMoney)
            elseif dealerAmount > 21 then
                --This happens if the dealer is bust
                endText.text = ("You Won!")
                playerMoney = playerMoney + 10
                playerMoneyText.text = ("Money: $"..playerMoney)
                print("Player Money: "..playerMoney)
            elseif playerAmount > dealerAmount then
                --This happens if the player wins
                endText.text = ("You Won!")
                playerMoney = playerMoney + 10
                playerMoneyText.text = ("Money: $"..playerMoney)
                print("Player Money: "..playerMoney)
            elseif playerAmount < dealerAmount then
                --This happens if the dealer wins
                endText.text = ("You Lost!")
                playerMoney = playerMoney - 10
                playerMoneyText.text = ("Money: $"..playerMoney)
                print("Player Money: "..playerMoney)
            elseif playerAmount == dealerAmount then
                --This happens if the player and dealer tied
                endText.text = ("You Tied!")
            else
                print("In the game of thrones you win.... or you die")
            end

            --Adds one to the number of rounds played
            rounds = rounds + 1
            print("Rounds Played: "..rounds)

            --This statement checks to see if the player has reached a new monetary high
            if playerMoney > highestMoney then
                highestMoney = highestMoney + 10
            else
                print("")
                print("Bringing home the bacon")
                print("")
            end

            --This calls the function that resets the board
            timer.performWithDelay(3000, resetBoard)
        end

        --Setting up the card counting variable for the player
        cardCounter = 0

        --This function gives the dealer his cards when the player wishes to stand
        function standButtonTouch ( event )
            --Setting the buttons so the player can't interfere with the results
            hitButton.y = 1000
            standButton.y = 1000

            --Caluculating the player's total amount
            playerAmount = playerCardValue1 + playerCardValue2 + playerCardValue3 + playerCardValue4
                    + playerCardValue5 +playerCardValue6

            --Caluculating the dealer's total amount
            dealerAmount = dealerCardValue1 + dealerCardValue2 + dealerCardValue3 + dealerCardValue4
                    + dealerCardValue5 +dealerCardValue6

            --The reveal of the dealer's second card
            display.remove(dealerCardImage2)
            dealerCard2 = math.random(1,52)
            --Duplicate Blocker
            while dealerCard2 == dealerCard1 or dealerCard2 == playerCard1 or 
                        dealerCard2 == playerCard2 or dealerCard2 == 
                        playerCard3 or dealerCard2 == playerCard4  or 
                        dealerCard2 == playerCard5 or dealerCard2 == playerCard6 do
                dealerCard2 = dealerCard2 + 1
            end
            dealerCardValue2 = chooseCardValue(dealerCard2, dealerAmount)
            dealerCardImage2 = chooseCard(dealerCard2)
            dealerCardImage2.x = dealerCard2X
            dealerCardImage2.y = dealerCard2Y
            dealerCardImage2.width = cardWidth
            dealerCardImage2.height = cardHeight

            --Caluculating the dealer's total amount
            dealerAmount = dealerCardValue1 + dealerCardValue2 + dealerCardValue3 + dealerCardValue4
                    + dealerCardValue5 + dealerCardValue6

            --Updated dealer amount text
            dealerAmountText.text = ("Amount: ".. dealerAmount)

            --This loop will continue to choose new cards for the dealer until the dealer's amount is 17
            if dealerAmount < 17 then
                for dealerCardCounter = 0,2,1 do
                    if dealerCardCounter == 1 then
                        --The dealer's third card
                        dealerCard3 = math.random(1,52)
                        --Duplicate Blocker
                        while dealerCard3 == dealerCard1 or dealerCard3 == playerCard1 or 
                                    dealerCard3 == playerCard2 or dealerCard3 == 
                                    playerCard3 or dealerCard3 == playerCard4  or 
                                    dealerCard3 == playerCard5 or dealerCard3 == playerCard6 or
                                    dealerCard3 == dealerCard2 do
                            dealerCard3 = dealerCard3 + 1
                        end
                        dealerCardValue3 = chooseCardValue(dealerCard3, dealerAmount)
                        dealerCardImage3 = chooseCard(dealerCard3)
                        dealerCardImage3.x = dealerCard3X
                        dealerCardImage3.y = dealerCard3Y
                        dealerCardImage3.width = cardWidth
                        dealerCardImage3.height = cardHeight
                        --Caluculating the dealer's total amount
                        dealerAmount = dealerCardValue1 + dealerCardValue2 + dealerCardValue3 + 
                                dealerCardValue4 + dealerCardValue5 + dealerCardValue6
                        --Updated dealer amount text
                        dealerAmountText.text = ("Amount: ".. dealerAmount)
                        if dealerAmount >= 17 then
                            break
                        end
                    elseif dealerCardCounter == 2 then
                        --The dealer's fourth card
                        dealerCard4 = math.random(1,52)
                        --Duplicate Blocker
                        while dealerCard4 == dealerCard1 or dealerCard4 == playerCard1 or 
                                    dealerCard4 == playerCard2 or dealerCard4 == 
                                    playerCard3 or dealerCard4 == playerCard4  or 
                                    dealerCard4 == playerCard5 or dealerCard4 == playerCard6 or
                                    dealerCard4 == dealerCard2 or dealerCard4 == dealerCard3 do
                            dealerCard4 = dealerCard4 + 1
                        end
                        dealerCardValue4 = chooseCardValue(dealerCard4, dealerAmount)
                        dealerCardImage4 = chooseCard(dealerCard4)
                        dealerCardImage4.x = dealerCard4X
                        dealerCardImage4.y = dealerCard4Y
                        dealerCardImage4.width = cardWidth
                        dealerCardImage4.height = cardHeight
                        --Caluculating the dealer's total amount
                        dealerAmount = dealerCardValue1 + dealerCardValue2 + dealerCardValue3 + 
                                dealerCardValue4 + dealerCardValue5 + dealerCardValue6
                        --Updated dealer amount text
                        dealerAmountText.text = ("Amount: ".. dealerAmount)
                        if dealerAmount >= 17 then
                            break
                        end
                    elseif dealerCardCounter == 3 then
                        --The dealer's fourth card
                        dealerCard5 = math.random(1,52)
                        --Duplicate Blocker
                        while dealerCard5 == dealerCard1 or dealerCard5 == playerCard1 or 
                                    dealerCard5 == playerCard2 or dealerCard5 == 
                                    playerCard3 or dealerCard5 == playerCard4  or 
                                    dealerCard5 == playerCard5 or dealerCard5 == playerCard6 or
                                    dealerCard5 == dealerCard2 or dealerCard5 == dealerCard3 or
                                    dealerCard5 == dealerCard4 do
                            dealerCard5 = dealerCard5 + 1
                        end
                        dealerCardValue5 = chooseCardValue(dealerCard5, dealerAmount)
                        dealerCardImage5 = chooseCard(dealerCard5)
                        dealerCardImage5.x = dealerCard5X
                        dealerCardImage5.y = dealerCard5Y
                        dealerCardImage5.width = cardWidth
                        dealerCardImage5.height = cardHeight
                        --Caluculating the dealer's total amount
                        dealerAmount = dealerCardValue1 + dealerCardValue2 + dealerCardValue3 + 
                                dealerCardValue4 + dealerCardValue5 + dealerCardValue6
                        --Updated dealer amount text
                        dealerAmountText.text = ("Amount: ".. dealerAmount)
                        if dealerAmount >= 17 then
                            break
                        end
                    elseif dealerCardCounter == 4 then
                        --The dealer's fourth card
                        dealerCard6 = math.random(1,52)
                        --Duplicate Blocker
                        while dealerCard6 == dealerCard1 or dealerCard6 == playerCard1 or 
                                    dealerCard6 == playerCard2 or dealerCard6 == 
                                    playerCard3 or dealerCard6 == playerCard4  or 
                                    dealerCard6 == playerCard5 or dealerCard6 == playerCard6 or
                                    dealerCard6 == dealerCard2 or dealerCard6 == dealerCard3 or
                                    dealerCard6 == dealerCard4 or dealerCard6 == dealerCard5 do
                            dealerCard6 = dealerCard6 + 1
                        end
                        dealerCardValue6 = chooseCardValue(dealerCard6, dealerAmount)
                        dealerCardImage6 = chooseCard(dealerCard6)
                        dealerCardImage6.x = dealerCard6X
                        dealerCardImage6.y = dealerCard6Y
                        dealerCardImage6.width = cardWidth
                        dealerCardImage6.height = cardHeight
                        --Caluculating the dealer's total amount
                        dealerAmount = dealerCardValue1 + dealerCardValue2 + dealerCardValue3 + 
                                dealerCardValue4 + dealerCardValue5 + dealerCardValue6
                        --Updated dealer amount text
                        dealerAmountText.text = ("Amount: ".. dealerAmount)
                        if dealerAmount >= 17 then
                            break
                        end
                    else
                        print("I have a bad feeling about this....")
                    end
                end
            end
            --Calling the endGame function to determine the score
            timer.performWithDelay(1000, endGame)
        end

        --This function calculates the player's next cards should they want to hit
        function hitButtonTouch ( event )
            cardCounter = cardCounter + 1
            print("")
            print("Cards Drawn: "..cardCounter)
            print("")

            --Caluculating the player's total amount
            playerAmount = playerCardValue1 + playerCardValue2 + playerCardValue3 + playerCardValue4
                    + playerCardValue5 +playerCardValue6

            --The if statement that determines what card the player will get
            if cardCounter == 1 then
                --This chooses the player's third card
                playerCard3 = math.random(1,52)
                --Duplicate Blocker
                while playerCard3 == dealerCard1 or playerCard3 == playerCard1 or 
                            playerCard3 == playerCard2 do
                    playerCard3 = playerCard3 + 1
                end
                playerCardValue3 = chooseCardValue(playerCard3, playerAmount)
                playerCardImage3 = chooseCard(playerCard3)
                playerCardImage3.x = playerCard3X
                playerCardImage3.y = playerCard3Y
                playerCardImage3.width = cardWidth
                playerCardImage3.height = cardHeight
                --Caluculating the dealer's total amount
                playerAmount = playerCardValue1 + playerCardValue2 + playerCardValue3 + 
                        playerCardValue4 + playerCardValue5 + playerCardValue6
                --Updated player amount text
                playerAmountText.text = ("Amount: ".. playerAmount)
            elseif cardCounter == 2 then
                --This chooses the player's fourth card
                playerCard4 = math.random(1,52)
                --Duplicate Blocker
                while playerCard4 == dealerCard1 or playerCard4 == playerCard1 
                            or playerCard4 == playerCard2 or playerCard4 == playerCard3 do
                    playerCard4 = playerCard4 + 1
                end
                playerCardValue4 = chooseCardValue(playerCard4, playerAmount)
                playerCardImage4 = chooseCard(playerCard4)
                playerCardImage4.x = playerCard4X
                playerCardImage4.y = playerCard4Y
                playerCardImage4.width = cardWidth
                playerCardImage4.height = cardHeight
                --Caluculating the dealer's total amount
                playerAmount = playerCardValue1 + playerCardValue2 + playerCardValue3 + 
                        playerCardValue4 + playerCardValue5 + playerCardValue6
                --Updated player amount text
                playerAmountText.text = ("Amount: ".. playerAmount)
            elseif cardCounter == 3 then
                --This chooses the player's fifth card
                playerCard5 = math.random(1,52)
                --Duplicate Blocker
                while playerCard5 == dealerCard1 or playerCard5 == playerCard1 or 
                            playerCard5 == playerCard2 or playerCard5 == 
                            playerCard3 or playerCard5 == playerCard4 do
                    playerCard5 = playerCard5 + 1
                end
                playerCardValue5 = chooseCardValue(playerCard5, playerAmount)
                playerCardImage5 = chooseCard(playerCard5)
                playerCardImage5.x = playerCard5X
                playerCardImage5.y = playerCard5Y
                playerCardImage5.width = cardWidth
                playerCardImage5.height = cardHeight
                --Caluculating the dealer's total amount
                playerAmount = playerCardValue1 + playerCardValue2 + playerCardValue3 + 
                        playerCardValue4 + playerCardValue5 + playerCardValue6
                --Updated player amount text
                playerAmountText.text = ("Amount: ".. playerAmount)
                elseif cardCounter == 4 then
                --This chooses the player's sixth card
                playerCard6 = math.random(1,52)
                --Duplicate Blocker
                while playerCard6 == dealerCard1 or playerCard6 == playerCard1 or 
                            playerCard6 == playerCard2 or playerCard6 == 
                            playerCard3 or playerCard6 == playerCard4  or 
                            playerCard6 == playerCard5 do
                    playerCard6 = playerCard6 + 1
                end
                playerCardValue6 = chooseCardValue(playerCard6, playerAmount)
                playerCardImage6 = chooseCard(playerCard6)
                playerCardImage6.x = playerCard6X
                playerCardImage6.y = playerCard6Y
                playerCardImage6.width = cardWidth
                playerCardImage6.height = cardHeight
                --Caluculating the dealer's total amount
                playerAmount = playerCardValue1 + playerCardValue2 + playerCardValue3 + 
                        playerCardValue4 + playerCardValue5 + playerCardValue6
                --Updated player amount text
                playerAmountText.text = ("Amount: ".. playerAmount)
                --Calling the stand function because the player has drawn the maximum cards
                standButtonTouch()
            end
            --This determines if the player has gone bust
            if playerAmount > 21 then
                endGame()
            else
                print("It is not yet your time....")
            end
        end

        --This chooses the dealer's first card
        dealerCard1 = math.random(1,52)
        dealerCardValue1 = chooseCardValue(dealerCard1, dealerAmount)
        dealerCardImage1 = chooseCard(dealerCard1)
        dealerCardImage1.x = dealerCard1X
        dealerCardImage1.y = dealerCard1Y
        dealerCardImage1.width = cardWidth
        dealerCardImage1.height = cardHeight

        --This shows the back of the yet to be revealed second dealer card
        dealerCardImage2 = display.newImage( "Assets/PNG/red_back.png" )
        dealerCardImage2.x = 100
        dealerCardImage2.y = 50
        dealerCardImage2.width = 75
        dealerCardImage2.height = 100

        --Text indicating the dealer's score
        dealerAmountText = display.newText( "Amount: ".. dealerCardValue1, 
                    275, -20, native.systemFont, 12 )
        dealerAmountText:setFillColor( 255/255, 255/255, 255/255 )

        --This chooses the player's first card
        playerCard1 = math.random(1,52)
        if playerCard1 == dealerCard1 then
            playerCard1 = playerCard1 + 1
        end
        playerCardValue1 = chooseCardValue(playerCard1, playerAmount)
        playerCardImage1 = chooseCard(playerCard1)
        playerCardImage1.x = playerCard1X
        playerCardImage1.y = playerCard1Y
        playerCardImage1.width = cardWidth
        playerCardImage1.height = cardHeight

        --This chooses the player's second card
        playerCard2 = math.random(1,52)
        --Duplicate Blocker
        while playerCard2 == dealerCard1 or playerCard1 == playerCard2 do
            playerCard2 = playerCard2 + 1
        end
        playerCardValue2 = chooseCardValue(playerCard2, playerAmount)
        playerCardImage2 = chooseCard(playerCard2)
        playerCardImage2.x = playerCard2X
        playerCardImage2.y = playerCard2Y
        playerCardImage2.width = cardWidth
        playerCardImage2.height = cardHeight

        --This variable calculates the total amount the player has in their hand
        playerAmount = playerCardValue1 + playerCardValue2

        --Making sure if the player draws two aces, it won't amount to 22
        if playerCardValue2 == 11 and playerCardValue1 == 11 then
            playerCardValue2 = 1
        end

        --This variable calculates the total amount the player has in their hand
        playerAmount = playerCardValue1 + playerCardValue2

        --Text indicating the player's score
        playerAmountText = display.newText( "Amount: ".. playerAmount, 275, 500, native.systemFont, 12 )
        playerAmountText:setFillColor( 255/255, 255/255, 255/255 )

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

--Event listeners for the scenes
scene:addEventListener( "show", scene )
scene:addEventListener( "destroy", scene )
--End of the scene function
return scene