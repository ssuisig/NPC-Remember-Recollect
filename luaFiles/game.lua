-----------------------------------------------------------------------------------------
--
-- game.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local timeAttack

function scene:create( event )
	local sceneGroup = self.view

	physics.start()
	--physics.setDrawMode( "hybrid" )

	local backgroundMusic = audio.loadStream("audio/bgm.mp3")
	local backgroundMusicChannel = audio.play( backgroundMusic, {channel = 6, loops = -1, fadein = 5000})

	-- create background
	local background = display.newImageRect("image/스테이지4/image/background.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2
	
	sceneGroup:insert(background)

	-- create time
	local time = display.newText(60, 50, 50)
	time.size = 50
	time:setFillColor(1, 1, 1)
	time.alpha = 0.7

	sceneGroup:insert(time)

	-- create ground
	local ground = {}
	ground[1] = display.newImage("image/스테이지4/image/ground2.png")
	ground[1].x, ground[1].y = 468, 681
	ground[2] = display.newImage("image/스테이지4/image/ground2.png")
	ground[2].x, ground[2].y = 350, 420
	ground[3] = display.newImage("image/스테이지4/image/ground2.png")
	ground[3].x, ground[3].y = 600, 320
	ground[4] = display.newImage("image/스테이지4/image/ground1.png")
	ground[4].x, ground[4].y = 180, 470
	ground[5] = display.newImage("image/스테이지4/image/ground4.png")
	ground[5].x, ground[5].y = 1130, 270
	ground[6] = display.newImage("image/스테이지4/image/ground2.png")
	ground[6].x, ground[6].y = 850, 430

	ground1_outline = graphics.newOutline(2, "image/스테이지4/image/ground1.png")
	ground2_outline = graphics.newOutline(2, "image/스테이지4/image/ground2.png")
	ground4_outline = graphics.newOutline(2, "image/스테이지4/image/ground4.png")
	
	physics.addBody(ground[1], "static", {outline=ground2_outline})
	physics.addBody(ground[2], "static", {outline=ground2_outline})
	physics.addBody(ground[3], "static", {outline=ground2_outline})
	physics.addBody(ground[4], "static", {outline=ground1_outline})
	physics.addBody(ground[5], "static", {outline=ground4_outline})
	physics.addBody(ground[6], "static", {outline=ground2_outline})

	local ground_box = {}
	ground_box[1] = display.newRect(ground[1].x+5, ground[1].y-35.5, 120, 20)
	ground_box[2] = display.newRect(ground[2].x, ground[2].y-36, 120, 20)
	ground_box[3] = display.newRect(ground[3].x, ground[3].y-36, 120, 20)
	ground_box[4] = display.newRect(ground[4].x, ground[4].y-30, 90, 20)
	ground_box[5] = display.newRect(ground[5].x, ground[5].y-34, 220, 20)
	ground_box[6] = display.newRect(ground[6].x, ground[6].y-36, 120, 20)

	for i = 1, #ground do
		physics.addBody(ground_box[i], "static")
	end	

	for i = 1, #ground do	
		sceneGroup:insert(ground[i])
		sceneGroup:insert(ground_box[i])
	end

	for i = 1, #ground_box do
		ground_box[i]:toBack()
	end

	-- create wall
	local wall = {}
	wall[1] = display.newRect(0, background.y, 0, background.height)
	wall[2] = display.newRect(background.width, background.y, 0, background.height)
	wall[3] = display.newRect(background.x, 0, background.width, 0)
	wall[4] = display.newRect(background.x, background.height, background.width, 0)

	for i = 1, #wall do
		physics.addBody(wall[i], "static")
		sceneGroup:insert(wall[i])
		wall[i].name = "wall"
	end

	-- create baseground
	local baseground = {}
	baseground[1] = display.newImage("image/스테이지4/image/baseground1.png")
	baseground[1].x, baseground[1].y = 205, 677
	baseground[2] = display.newImage("image/스테이지4/image/baseground2.png")
	baseground[2].x, baseground[2].y = 1098, 667

	local baseground2_outline = graphics.newOutline(2, "image/스테이지4/image/baseground2.png")

	physics.addBody(baseground[1], "static")
	physics.addBody(baseground[2], "static", {outline = baseground2_outline})

	for i = 1, #baseground do
		sceneGroup:insert( baseground[i] )
	end

	-- create player(haru)
	local player = display.newImageRect("image/스테이지4/image/haru_front.png", 80, 120)
	local player_outline = graphics.newOutline(2, "image/스테이지4/image/haru_front.png")
	player.x, player.y = baseground[1].x-120, baseground[1].y-90
	player.name = "player"
	player.speed = 170

	physics.addBody(player, {friction=1, bounce=0, outline=player_outline})
	player.isFixedRotation = true
	sceneGroup:insert( player )

	-- create arrow
	function setPlayerVelocity()
		if (player.getLinearVelocity) then
			local playerHorizontalVelocity, playerVerticalVelocity = player:getLinearVelocity()
			player:setLinearVelocity(player.velocity, playerVerticalVelocity)
		end
	end

	local leftButton = display.newImageRect("image/스테이지4/image/leftButton.png", 100, 65)
	leftButton.x, leftButton.y = 120, 680
	local rightButton = display.newImageRect("image/스테이지4/image/rightButton.png", 100, 65)
	rightButton.x, rightButton.y = 183, 680
	local jumpButton = display.newImageRect("image/스테이지4/image/jumpButton.png", 70, 70)
	jumpButton.x, jumpButton.y = 1130, 678 
	--jumpButton.x, jumpButton.y = leftButton.x+100, 678
	jumpButton.name = "btnJump"

	function arrowTap_left (event)
		x = player.x
		y = player.y

		player.speed = 170

		local buttonPressed = event.target

		if event.phase == "began" then
			Runtime:addEventListener("enterFrame", setPlayerVelocity)

			player.velocity = -player.speed
			player.fill = {
				type = "image",
				filename = "image/스테이지4/image/haru_left.png"
			}
		end
		if event.phase == "ended" then

			Runtime:removeEventListener("enterFrame", setPlayerVelocity)

			player.velocity = 0
			player.velocity = 0
			timer.performWithDelay( 500, function()
				player.fill = {
				type = "image",
				filename = "image/스테이지4/image/haru_front.png"
			}
		end )
	end
		player.isFixedRotation = true
	end

	function arrowTap_right (event)
		x = player.x
		y = player.y

		player.speed = 170

		local buttonPressed = event.target

		if event.phase == "began" then
			Runtime:addEventListener("enterFrame", setPlayerVelocity)

			player.velocity = player.speed
			player.fill = {
				type = "image",
				filename = "image/스테이지4/image/haru_right.png"
			}
		end
		if event.phase == "ended" then
			Runtime:removeEventListener("enterFrame", setPlayerVelocity)

			player.velocity = 0
			timer.performWithDelay( 500, function()
				player.fill = {
				type = "image",
				filename = "image/스테이지4/image/haru_front.png"
			}
		end )
	end
		player.isFixedRotation = true
	end

	function arrowTap_jump ( event )
		x = player.x
		y = player.y

		local jumpMusic = audio.loadStream("audio/jumpbgm2.wav")
		local jumpMusicChannel = audio.play(jumpMusic, {channel = 2})

		transition.to(player, {time=300, y=(y-120)})
		player.isFixedRotation = true
	end

	leftButton:addEventListener("touch", arrowTap_left)
	rightButton:addEventListener("touch", arrowTap_right)
	jumpButton:addEventListener("touch", arrowTap_jump)

	sceneGroup:insert(leftButton)
	sceneGroup:insert(rightButton)
	sceneGroup:insert(jumpButton)

	-- create element (devilelf, light, key, memory, boat, wave)
	-- create devilelf
	local devilelf1 = display.newImageRect("image/스테이지4/image/devilelf1_left.png", 120, 120)
	local devilelf1_outline = graphics.newOutline(3, "image/스테이지4/image/devilelf1_left.png")
	devilelf1.x, devilelf1.y = baseground[2].x-80, ground[1].y-70
	devilelf1.name = "devilelf1"

	physics.addBody(devilelf1, "kinematic", {outline=devilelf1_outline, isSensor=true})
	devilelf1.isFixedRotation = true

	local devilelf2 = display.newImageRect("image/스테이지4/image/devilelf2_face.png", 80, 100)
	local devilelf2_outline = graphics.newOutline(4, "image/스테이지4/image/devilelf2_face.png")
	devilelf2.x, devilelf2.y = ground[2].x+70, ground[2].y-60
	devilelf2.name = "devilelf2"

	physics.addBody(devilelf2, "kinematic", {outline=devilelf2_outline, isSensor=true})
	devilelf2.isFixedRotation = true

	local devilelf3 = display.newImageRect("image/스테이지4/image/devilelf1_face.png", 90, 110)
	local devilelf3_outline = graphics.newOutline(4, "image/스테이지4/image/devilelf1_face.png")
	devilelf3.x, devilelf3.y = ground[6].x-70, ground[6].y-70
	devilelf3.name = "devilelf3"

	physics.addBody(devilelf3, "kinematic", {outline=devilelf3_outline, isSensor=true})
	devilelf3.isFixedRotation = true

	-- create door
	-- local door1 = display.newImageRect("image/스테이지4/image/door1.png", 130, 170)
	-- --door1.x, door1.y = ground[5].x+10, ground[5].y-127
	-- door1.name = "door1"
	-- physics.addBody(door1, "kinematic", {isSensor=true})

	local light = display.newImageRect("image/스테이지4/image/light.png", 100, 100)
	light.x, light.y = 820, 600
	light.name = "light"

	local key = display.newImageRect("image/스테이지4/image/key.png", 30, 60)
	local key_outline = graphics.newOutline(2, "image/스테이지4/image/key.png")
	key.x, key.y = light.x+2, light.y+17
	key:rotate(40)
	key.name = "key"

	physics.addBody(key, "kinematic", {outline=key_outline, isSensor=true})

	local memory = display.newImageRect("image/스테이지4/image/memory.png", 130, 140)
	memory.x, memory.y = ground[5].x+10, ground[5].y-110
	memory.name = "memory"
	physics.addBody(memory, "kinematic", {isSensor=true})
	
	local boat = display.newImage("image/스테이지4/image/boat.png")
	local boat_outline = graphics.newOutline(4, "image/스테이지4/image/boat.png")
	boat.x, boat.y = 750, 670
	boat.name = "boat"

	physics.addBody(boat, "static", {outline=boat_outline})

	local exit = display.newImageRect("image/스테이지4/image/exit.png", 230, 250)
	exit.x, exit.y = baseground[2].x + 87, baseground[2].y - 160
	exit.name = "exit"

	local exitBox = display.newRect(exit.x, exit.y+33, 150, 150)
	exitBox.name = "exitBox"

	physics.addBody(exitBox, "kinematic", {isSensor = true})

	local wave = display.newImageRect("image/스테이지4/image/wave.png", 580, 90)
	wave.x, wave.y = 650, 680
	wave.name = "wave"

	local wave1 = display.newImageRect("image/스테이지4/image/wave1.png", 68, 80)
	wave1.x, wave1.y = 580, 676
	wave1.name = "wave1"

	physics.addBody(wave1, "kinematic")

	local wave2 = display.newImageRect("image/스테이지4/image/wave1.png", 35, 80)
	wave2.x, wave2.y = 910, 675.5
	wave2.name = "wave2"

	physics.addBody(wave2, "kinematic")

	sceneGroup:insert(wave)
	sceneGroup:insert(wave1)
	sceneGroup:insert(wave2)
	sceneGroup:insert(key)
	sceneGroup:insert(light)
	sceneGroup:insert(boat)
	sceneGroup:insert(exitBox)
	sceneGroup:insert(exit)
	sceneGroup:insert(memory)
	sceneGroup:insert(devilelf1)
	sceneGroup:insert(devilelf2)
	sceneGroup:insert( devilelf3 )
	--sceneGroup:insert( door1 )

   	-- create Setting
	local setting = display.newImageRect("image/스테이지4/image/settingButton.png", 70, 70)
	setting.x, setting.y = 1220, 50
   
	function setting:tap( event )
		timer.pause(timeAttack)
		composer.setVariable("timeAttack", timeAttack)
		composer.setVariable("backgroundMusicChannel", backgroundMusicChannel)
		composer.showOverlay("setting")
	end
	setting:addEventListener("tap", setting)
   
	sceneGroup:insert( setting )


	local isMove1 = false
	local isMove2 = false

	local function counter(event)
		time.text = time.text - 1

		if((time.text+1) % 3 == 0) then
			if(isMove1 == false) then
				transition.moveBy(devilelf2, {x=20, time=2000})
				isMove1 = true
			elseif(isMove1 == true) then
				transition.moveBy(devilelf2, {x=-20, time=2000})
				isMove1 = false
			end
		end

		if((time.text+1) % 3 == 0) then
			if(isMove2 == false) then
				transition.moveBy(devilelf3, {y=-30, time=2000})
				isMove2 = true
			elseif(isMove2 == true) then
				transition.moveBy(devilelf3, {y=30, time=2000})
				isMove2 = false
			end
		end
		if( time.text == '5' ) then
			time:setFillColor(1, 0, 0)
		end

		if( time.text == '-1') then
			time.alpha = 0

			audio.pause(6)
			
			player.velocity = 0
			display.remove(player)
			Runtime:removeEventListener("enterFrame", setPlayerVelocity)

			display.remove(leftButton)
			display.remove(rightButton)
			display.remove(jumpButton)
			
			timer.performWithDelay(10, function()
				physics.stop()
			end )
			
			timer.performWithDelay( 100, function()
				composer.gotoScene("ending_stage4")
			end )
		end
	end

   timeAttack = timer.performWithDelay(1000, counter, 61)

	-- create function
	local flag = false
	local escape = false

	function haru(self, event)
		if((event.phase == "began" or event.phase == "ended") and flag == false and escape == false) then
			if(event.other.name == "key") then
				flag = true
				display.remove(key)
				key = nil
			end
		elseif((event.phase == "began" or event.phase == "ended") and flag == true and escape == false) then
			if(event.other.name == "memory") then
				escape = true
				display.remove(memory)
				--display.remove( door1 )
				-- local door2 = display.newImageRect("image/스테이지4/image/door2.png", 140, 140)
				-- door2.x, door2.y = ground[5].x, ground[5].y-110
				-- sceneGroup:insert( door2 )
				--door1 = nil
				memory = nil
			end
		elseif(event.phase == "began" and flag == true and escape == true) then
			if(event.other.name == "exitBox") then
	
				audio.pause(6)

				Runtime:removeEventListener("enterFrame", setPlayerVelocity)
				player.velocity = 0
				display.remove(player)

				timer.performWithDelay( 0, function()
					physics.stop()
				end )
				display.remove(background)
				background = nil

				stage1_clear = 1

				timer.performWithDelay( 100, function()
					composer.gotoScene("scene2")
					return
				end )

				exit = nil
			end
		end
		
		if((event.phase == "began" or event.phase == "ended") and (event.other.name == "wave1" or event.other.name == "wave2")) then
			audio.pause(6)

			Runtime:removeEventListener("enterFrame", setPlayerVelocity)

			display.remove(leftButton)
			display.remove(rightButton)
			display.remove(jumpButton)
			display.remove(player)

			display.remove(wave1)
			wave1 = nil
			display.remove(wave2)
			wave2 = nil

			timer.performWithDelay(0, function()
				physics.start()
				physics.stop()
			end )

			timer.performWithDelay( 0, function()
				composer.gotoScene("ending_stage4")
			end )
		end
		if(event.phase == "ended" and event.other.name == "devilelf1") then
			audio.pause(6)

			Runtime:removeEventListener("enterFrame", setPlayerVelocity)
		
			display.remove(player)
			display.remove(leftButton)
			display.remove(rightButton)
			display.remove(jumpButton)

			display.remove(devilelf1)
			devilelf1 = nil

			timer.performWithDelay(0, function()
				physics.start()
				physics.stop()
			end )

			timer.performWithDelay( 0, function()
				composer.gotoScene("ending_stage4")
			end )
		end

		if(event.phase == "ended" and event.other.name == "devilelf2") then
			audio.pause(6)

			Runtime:removeEventListener("enterFrame", setPlayerVelocity)

			display.remove(leftButton)
			display.remove(rightButton)
			display.remove(jumpButton)
			display.remove(player)

			display.remove(devilelf2)
			devilelf2 = nil

			timer.performWithDelay(0, function()
				physics.start()
				physics.stop()
			end )

			timer.performWithDelay( 0, function()
				composer.gotoScene("ending_stage4")
			end )
		end

		if(event.phase == "ended" and event.other.name == "devilelf3") then
			audio.pause(6)

			Runtime:removeEventListener("enterFrame", setPlayerVelocity)

			display.remove(leftButton)
			display.remove(rightButton)
			display.remove(jumpButton)
			display.remove(player)

			display.remove(devilelf3)
			devilelf3 = nil

			timer.performWithDelay(0, function()
				physics.start()
				physics.stop()
			end )

			timer.performWithDelay( 0, function()
				composer.gotoScene("ending_stage4")
			end )
		end

		if(event.phase == "ended" and event.other.name == "wall") then
			audio.pause(6)

			Runtime:removeEventListener("enterFrame", setPlayerVelocity)
			
			display.remove(player)
			display.remove(leftButton)
			display.remove(rightButton)
			display.remove(jumpButton)
			
			timer.performWithDelay(0, function()
				physics.start()
				physics.stop()
			end )

			timer.performWithDelay( 0, function()
				composer.gotoScene("ending_stage4")
			end )
		end
	end

	player.collision = haru
	player:addEventListener("collision")

	baseground[1]:toFront()
	baseground[2]:toFront()
	ground[1]:toFront()
	ground[5]:toFront()
	leftButton:toFront()
	rightButton:toFront()
	jumpButton:toFront()
	wave1:toBack()
	wave2:toBack()
	player:toFront()
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
		composer.removeScene("game")
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end
end

function scene:destroy( event )
	local sceneGroup = self.view
	timer.performWithDelay(1, function()
		physics.start()
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
