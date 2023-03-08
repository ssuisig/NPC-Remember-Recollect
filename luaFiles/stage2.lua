-----------------------------------------------------------------------------------------
--
-- stage2.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

local timeAttack

function scene:create( event )
	local sceneGroup = self.view
	
	physics.start()
	-- physics.setDrawMode( "hybrid" )

	local backgroundMusic = audio.loadStream("music/stage2bgm.mp3")
	local backgroundMusicChannel = audio.play(backgroundMusic, {loops=-1, channel =4})

	local jump = audio.loadSound("music/jumpSound.wav")

	local background = display.newImageRect("image/forest.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	local time= display.newText(60, 50, 50)

 	time.size = 50
 	time:setFillColor(0)
 	time.alpha = 0.7

 	local gr2 = display.newImageRect("image/gr2.png", 320, 350)
	gr2.x, gr2.y = 1180, 640

	local ground = {}
	ground[1] = display.newImageRect("image/gr1.png", 240, 90)
	ground[1].x, ground[1].y = 120, 680
	ground[2] = display.newImageRect("image/gr4.png", 130, 40)
	ground[2].x, ground[2].y = 250, 570
	ground[3] = display.newImageRect("image/gr5.png", 150, 40)
	ground[3].x, ground[3].y = 450, 500
	ground[4] = display.newImageRect("image/gr5.png", 150, 40)
	ground[4].x, ground[4].y = 700, 330
	ground[5] = display.newImageRect("image/gr6.png", 100, 40)
	ground[5].x, ground[5].y = 880, 570
	ground[6] = display.newImageRect("image/gr3.png", 480, 90)
	ground[6].x, ground[6].y = 1180, 680
	ground[7] = display.newImageRect("image/gr7.png", 50, 50)
	ground[7].x, ground[7].y = 580, 420

	local tree = display.newImageRect("image/tree.png", 1000, 400)
	tree.x, tree.y = 500, 200

	local door = display.newImageRect("image/door.png", 150, 150)
	door.x, door.y = 1110, 400
	door.name = "door"

	local set = display.newImageRect("image/set.png", 70, 70)
	set.x, set.y = 1220, 50

	local wall = {}
	wall[1] = display.newRect(0, background.y, 0, background.height)
	wall[2] = display.newRect(background.width, background.y, 0, background.height)
	wall[3] = display.newRect(background.x, 0, background.width, 0)
	wall[4] = display.newRect(background.x, background.height, background.width, 0)

	local light = display.newImageRect("image/전등1.png", 80, 180)
	light.x, light.y = 710, 170

	local key = display.newImageRect("image/스테이지2.png", 40, 50)
	key.x, key.y = 710, 225
	key.name = "key"

	local chest = display.newImageRect("image/상자.png", 100, 65)
	chest.x, chest.y = 1120, 610
	chest.name = "chest"

	local memory = display.newImageRect("image/기억의 조각.png", 90, 90)
	memory.x, memory.y = 1120, 605
	memory.name = "memory"

	sceneGroup:insert(background)
	sceneGroup:insert(gr2)
	sceneGroup:insert(tree)
	sceneGroup:insert(time)
	sceneGroup:insert(set)

	for i = 1, #ground do 
		physics.addBody(ground[i], "static")
		sceneGroup:insert(ground[i])
	end

	for i = 1, #wall do
		physics.addBody(wall[i], "static")
		sceneGroup:insert(wall[i])
		wall[i].name = "wall"
	end

	physics.addBody(light, "kinematic", {isSensor=true})
	sceneGroup:insert(light)

	physics.addBody(key, "kinematic", {isSensor=true})
	sceneGroup:insert(key)

	physics.addBody(door, "kinematic", {isSensor=true})
	sceneGroup:insert(door)

	physics.addBody(memory, "kinematic", {isSensor=true})
	sceneGroup:insert(memory)

	physics.addBody(chest, "kinematic", {isSensor=true})
	sceneGroup:insert(chest)

	local debbie1 = display.newImageRect("image/데비레프1.png", 40, 50)
	debbie1.x, debbie1.y = 825, 150
	debbie1.name = "debbie1"

	physics.addBody(debbie1, "kinematic", {isSensor=true})
	sceneGroup:insert(debbie1)

	local debbie2 = display.newImageRect("image/데비레프2.png", 50, 80)
	debbie2.x, debbie2.y = 1050, 600
	debbie2.name = "debbie2"

	physics.addBody(debbie2, "kinematic", {isSensor=true})
	sceneGroup:insert(debbie2)
              
    local leftButton = display.newImageRect("image/arrow_left.png", 60, 65)
	leftButton.x, leftButton.y = 70, 680
	local rightButton = display.newImageRect("image/arrow_right.png", 60, 65)
	rightButton.x, rightButton.y = 130, 680
	local jumpButton = display.newImageRect("image/arrow_jump.png", 60, 60)
	jumpButton.x, jumpButton.y = 1200, 680

	local player = display.newImageRect("image/face.png", 80, 120)
	local player_outline = graphics.newOutline(2, "image/face.png")
	player.x, player.y = 100, 510
	player.name = "player"
	player.speed = 170

	physics.addBody(player, {friction=1, bounce=0, outline = player_outline})
	player.isFixedRotation = true 
	sceneGroup:insert(player)

	local function setplayerVelocity()
		if (player.getLinearVelocity) then
			local playerHorisontalVelocity, playerVerticalVelocity = player:getLinearVelocity()--수평, 수직 속도
			player:setLinearVelocity( player.velocity, playerVerticalVelocity)
		end
	end

	local function fillLeft()
		player.fill = {--플레이어 방향전환
				type = "image",
				filename = "image/leftface.png"
			}
	end
	local function fillRight()
		player.fill = {--플레이어 방향전환
				type = "image",
				filename = "image/rightface.png"
			}
	end
	local function fillFace()
		player.fill = {--플레이어 방향전환
				type = "image",
				filename = "image/face.png"
			}
	end

	function arrowTab_left ( event )
		x = player.x
		y = player.y

		player.speed = 170

		local buttonPressed = event.target
		
		if event.phase == "began" then
			Runtime:addEventListener("enterFrame", setplayerVelocity)
			Runtime:addEventListener("enterFrame",fillLeft)
			player.velocity = -player.speed

		elseif event.phase == "ended" then
			Runtime:removeEventListener("enterFrame", setplayerVelocity) 
			player.velocity = 0
			timer.performWithDelay( 500, function()
				Runtime:addEventListener("enterFrame", fillFace)
			end )
		end

		player.isFixedRotation = true
	end

	function arrowTab_right ( event )
		x = player.x
		y = player.y

		player.speed = 170

		local buttonPressed = event.target
		
		if event.phase == "began" then
			Runtime:addEventListener("enterFrame", setplayerVelocity)
			Runtime:addEventListener("enterFrame",fillRight)
			player.velocity = player.speed 

		elseif event.phase == "ended" then
			Runtime:removeEventListener("enterFrame", setplayerVelocity) 
			player.velocity = 0
			timer.performWithDelay( 500, function()
				Runtime:addEventListener("enterFrame", fillFace)
			end )
		end

		player.isFixedRotation = true
	end

	function arrowTab_jump ( event )
		x = player.x
		y = player.y

		transition.to(player, {time=300, y=(y-120)})
		player.isFixedRotation = true

		-- ---점프사운드---
		local jumpSound = audio.play(jump, {loops=0, fadein=0})
	end

	leftButton:addEventListener("touch", arrowTab_left)
	rightButton:addEventListener("touch", arrowTab_right)
	jumpButton:addEventListener("tap", arrowTab_jump)

	sceneGroup:insert(leftButton)
	sceneGroup:insert(rightButton)
	sceneGroup:insert(jumpButton)

	local flag = false
	local escape = false

	function exit(self, event)
		if(event.phase == "ended" and flag == false and escape == false) then
			if(event.other.name == "key") then
				print("key")
			    flag = true

			    display.remove( key )
				key = nil
			end
		elseif(event.phase == "ended" and flag == true and escape == false) then
			if(event.other.name == "chest") then
				escape = true
				print("escape = true")

				display.remove(memory)
				memory = nil
			end
		elseif(event.phase == "began" and flag == true and escape == true) then
			if(event.other.name == "door") then
				print("door")

				Runtime:removeEventListener("enterFrame", setplayerVelocity) 
				player.velocity = 0
				display.remove(player)

				timer.performWithDelay( 0, function()
	               physics.stop()
	            end )

				audio.pause(4)

				timer.performWithDelay( 0, function()
	               composer.gotoScene("scene3")
	               return
	            end )
			end
		end

		if (event.phase == "ended") then
			if (event.other.name == "wall" or event.other.name == "debbie1" 
				or event.other.name == "debbie2") then
				Runtime:removeEventListener("enterFrame", setplayerVelocity) 
				player.velocity = 0

				timer.pause(timeAttack)
				display.remove(jumpButton)
				display.remove(set)
				display.remove(player)

				audio.pause(4)

				timer.performWithDelay( 0, function()
				    physics.start()
				    physics.stop()
				end )

				timer.performWithDelay( 0, function()
				    composer.gotoScene("ending_stage2")
					return
				end )
	 		end
		end
	end

	local isMove1 = false
	local isMove2 = false

	local function counter( event )
 		time.text = time.text - 1

 		if ((time.text+1) % 3 == 0) then
			if (isMove1 == false) then
				transition.moveBy( debbie1, { y=300, time=3000 } )
				isMove1 = true
			elseif(isMove1 == true) then
				transition.moveBy( debbie1, { y=-300, time=3000 } )
				isMove1 = false
			end
		end

		if ((time.text+1) % 3 == 0) then
			if (isMove2 == false) then
				transition.moveBy( debbie2, { x=200, time=3000 } )
				isMove2 = true
			elseif(isMove2 == true) then
				transition.moveBy( debbie2, { x=-200, time=3000 } )
				isMove2 = false
			end
		end

 		print(time.text)

	 	if( time.text == '5' ) then
	 		time:setFillColor(1, 0, 0)
	 	end

	 	if( time.text == '-1') then
	 		time.alpha = 0

	 		player.velocity = 0
			Runtime:removeEventListener("enterFrame", setPlayerVelocity)


	 		display.remove(leftButton)
			display.remove(rightButton)
			display.remove(jumpButton)
			display.remove(set)
			display.remove(player)

			audio.pause(4)

			player.velocity = 0
         	Runtime:removeEventListener("enterFrame", setPlayerVelocity)

			timer.performWithDelay( 0, function()
			   physics.stop()
		    end )

		    timer.pause(timeAttack)
			
			timer.performWithDelay( 0, function()
			   composer.gotoScene("ending_stage2")
		    end )
	 	end
	end

	timeAttack = timer.performWithDelay(1000, counter, 61)

 	function set:tap( event )
 		timer.pause(timeAttack)
 		composer.setVariable( "timeAttack", timeAttack )
 		composer.showOverlay('setting')
 	end
 	set:addEventListener("tap", set)

	player.collision = exit
	player:addEventListener("collision")
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
		timer.cancel(timeAttack)
		composer.removeScene("stage2")
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end
end

function scene:destroy( event )
	local sceneGroup = self.view
	timer.performWithDelay( 1, function()
    				physics.stop()
    			end, 1)
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene