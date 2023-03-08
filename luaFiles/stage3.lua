-----------------------------------------------------------------------------------------
--
-- stage3.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

local timeAttack

function scene:create( event )
	local sceneGroup = self.view
	
	physics.start()
	--physics.setDrawMode( "hybrid" )

	local bgm = audio.loadStream("bgm/stage3bgm.mp3")
	local bgmChannel = audio.play(bgm, {loops = -1, channel = 5})

	local jump = audio.loadSound("bgm/jumpsound.wav")

	local background = display.newImageRect("image/스테이지3/image/background.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	local time = display.newText(60, 50, 50)

	time.size = 50
	time:setFillColor(0)
	time.alpha = 0.7

	local ground = {}
	ground[1] = display.newImageRect("image/스테이지3/image/ground1.png", display.contentWidth, 90)
	ground[1].x, ground[1].y = display.contentWidth/2, 680
	ground[2] = display.newImageRect("image/스테이지3/image/ground5.png", 200, 50)
	ground[2].x, ground[2].y = 350, 560
	ground[3] = display.newImageRect("image/스테이지3/image/ground3.png", 120, 50)
	ground[3].x, ground[3].y = 130, 430
	ground[4] = display.newImageRect("image/스테이지3/image/ground4.png", 150, 50)
	ground[4].x, ground[4].y = 380, 310
	ground[5] = display.newImageRect("image/스테이지3/image/ground2.png", 50, 50)
	ground[5].x, ground[5].y = 520, 380
	ground[6] = display.newImageRect("image/스테이지3/image/ground2.png", 50, 50)
	ground[6].x, ground[6].y = 630, 460
	ground[7] = display.newImageRect("image/스테이지3/image/ground4.png", 150, 50)
	ground[7].x, ground[7].y = 680, 210
	ground[8] = display.newImageRect("image/스테이지3/image/ground5.png", 200, 50)
	ground[8].x, ground[8].y = 810, 530
	ground[9] = display.newImageRect("image/스테이지3/image/ground5.png", 200, 50)
	ground[9].x, ground[9].y = 1000, 300

	local wall = {}
	wall[1] = display.newRect(0, background.y, 0, background.height)
	wall[2] = display.newRect(background.width, background.y, 0, background.height)
	wall[3] = display.newRect(background.x, 0, background.width, 0)
	wall[4] = display.newRect(background.x, background.height, background.width, 0)
	
	local set = display.newImageRect("image/스테이지3/image/set.png", 70, 70)
	set.x, set.y = 1220, 50
	
	sceneGroup:insert(background)
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


	--구조물 (출구, 장애물, 아이템)
	local door = display.newImageRect("image/스테이지3/image/door.png", 150, 225)
	door.x, door.y = 1200, 525
	door.name = "door"

	physics.addBody(door, "kinematic", {isSensor = true})
	sceneGroup:insert(door)

	local smallCac = display.newImageRect("image/스테이지3/image/cactus1.png", 60, 90)
	local smallCac_outline = graphics.newOutline(1, "image/스테이지3/image/cactus1.png")
	smallCac.x, smallCac.y = 410, 510
	smallCac.name = "smallCac"

	physics.addBody(smallCac, "kinematic", {isSensor = true, outline = smallcac_outline})
	sceneGroup:insert(smallCac)

	local bigCac = display.newImageRect("image/스테이지3/image/cactus2.png", 200, 300)
	local bigCac_outline = graphics.newOutline(1, "image/스테이지3/image/cactus2.png")
	bigCac.x, bigCac.y = 1020, 510
	bigCac.name = "bigCac"

	physics.addBody(bigCac, "kinematic", {isSensor = true, outline = bigcac_outline})
	sceneGroup:insert(bigCac)

	--local candy = display.newImageRect("image/스테이지3/image/candy.png", 80, 80)
	--candy.x, candy.y = 780, 460
	--candy.name = "candy"

	--physics.addBody(candy, "kinematic", {isSensor = true})
	--sceneGroup:insert(candy)

	local chest = display.newImageRect("image/스테이지3/image/chest.png", 100, 80)
	chest.x, chest.y = 860, 460
	chest.name = "chest"
	physics.addBody(chest, "kinematic", {isSensor = true})
	

	local memory = display.newImageRect("image/스테이지3/image/memory.png", 80, 80)
	memory.x, memory.y = 860, 460
	memory.name = "memory"
	physics.addBody(memory, "kinematic", {isSensor = true})

	sceneGroup:insert(memory)
	sceneGroup:insert(chest)

	local light = display.newImageRect("image/스테이지3/image/light.png", 80, 160)
	light.x, light.y = 327, 410
	light.name = "light"
	physics.addBody(light, "kinematic", {isSensor = true})

	local key = display.newImageRect("image/스테이지3/image/key.png", 30, 45)
	key.x, key.y = 330, 458
	key.name = "key"
	physics.addBody(key, "kinematic", {isSensor = true})

	sceneGroup:insert(key)
	sceneGroup:insert(light)

	-- 방향키, 플레이어
	local leftButton = display.newImageRect("image/스테이지3/image/leftbutton.png", 60, 65)
	leftButton.x, leftButton.y = 70, 680
	local rightButton = display.newImageRect("image/스테이지3/image/rightbutton.png", 60, 65)
	rightButton.x, rightButton.y = 130, 680
	local jumpButton = display.newImageRect("image/스테이지3/image/jumpbutton.png", 60, 60)
	jumpButton.x, jumpButton.y = 1200, 680

	local player = display.newImageRect("image/스테이지3/image/haru.png", 80, 120)
	local player_outline = graphics.newOutline(2, "image/스테이지3/image/haru.png")
	player.x, player.y = 150, 480
	player.name = "player"

	physics.addBody(player, {friction = 1, bounce = 0, outline = player_outline})
	player.isFixedRotation = true
	sceneGroup:insert(player)

	-- 움직임 함수
	local function setplayerVelocity()
		if (player.getLinearVelocity) then
			local playerHorisontalVelocity, playerVerticalVelocity = player:getLinearVelocity()--수평, 수직 속도
			player:setLinearVelocity( player.velocity, playerVerticalVelocity)
		end
	end

	local function fillLeft()
		player.fill = {
			type = "image",
			filename = "image/스테이지3/image/haruleft.png"
		}
	end
	local function fillRight()
		player.fill = {
			type = "image",
			filename = "image/스테이지3/image/haruright.png"
		}
	end
	local function fillFace()
		player.fill = {--플레이어 방향전환
				type = "image",
				filename = "image/face.png"
			}
	end

	function arrowTab_left (event)
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

	function arrowTab_right (event)
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

	function arrowTab_jump (event)
		local jumpSound = audio.play(jump, {loops = 0, fadein = 0})

		x = player.x
		y = player.y

		transition.to(player, {time = 300, y = (y-120)})
		player.isFixedRotation = true
	end

	leftButton:addEventListener("touch", arrowTab_left)
	rightButton:addEventListener("touch", arrowTab_right)
	jumpButton:addEventListener("tap", arrowTab_jump)

	sceneGroup:insert(leftButton)
	sceneGroup:insert(rightButton)
	sceneGroup:insert(jumpButton)

	--스테이지 클리어 조건
	local stage3_clear = 0
	local flag = false
	local escape = false

	function exit (self, event)
		if (event.phase == "ended" and flag == false) then
			if (event.other.name == "memory") then
				print("memory")
				flag = true

				display.remove(memory)
				memory = nil
			end
		end

		if (event.phase == "ended" and escape == false) then
			if (event.other.name == "key") then
				escape = true
				print("key")
				
				display.remove(key)
				key = nil
			end
		end

		if (event.phase == "began" and flag == true and escape == true) then
			if (event.other.name == "door") then
				print("door")
				Runtime:removeEventListener("enterFrame", setplayerVelocity) 
				player.velocity = 0
				display.remove(player)

				stage3_clear = 1
				audio.pause(5)

				timer.performWithDelay(0, function()
					physics.start()
					physics.stop()
				end
				)
				timer.performWithDelay(0, function()
					composer.gotoScene("scene4")
				end
				)
			end
		end

		if (event.phase == "ended" and event.other.name == "wall") then
			print("wall")
			timer.pause(timeAttack)
			display.remove(leftButton)
			display.remove(rightButton)
			display.remove(jumpButton)
			display.remove(set)
			audio.pause(5)

			Runtime:removeEventListener("enterFrame", setplayerVelocity) 
			player.velocity = 0
			display.remove(player)

			timer.performWithDelay(0, function()
				physics.start()
				physics.stop()
			end
			)
			timer.performWithDelay(0, function()
				composer.gotoScene("ending_stage3")
			end
			)
		end

		if (event.phase == "ended" and (event.other.name == "smallCac" or event.other.name == "bigCac")) then
			print("cac")
			timer.pause(timeAttack)
			display.remove(leftButton)
			display.remove(rightButton)
			display.remove(jumpButton)
			display.remove(set)
			audio.pause(5)

			Runtime:removeEventListener("enterFrame", setplayerVelocity) 
			player.velocity = 0
			display.remove(player)

			timer.performWithDelay(0, function()
				physics.start()
				physics.stop()
			end
			)
			timer.performWithDelay(0, function()
				composer.gotoScene("ending_stage3")
			end
			)
		end
	end

	player.collision = exit
	player:addEventListener("collision")

	local function counter (event)
		time.text = time.text - 1

		if (time.text == '5') then
			time:setFillColor(1, 0, 0)
		end

		if (time.text == '-1') then
			time.alpha = 0

			display.remove(leftButton)
			display.remove(rightButton)
			display.remove(jumpButton)
			display.remove(set)
			display.remove(player)

			timer.performWithDelay(10, function()
				physics.start()
				physics.stop()
			end
			)

			timer.pause(timeAttack)

			timer.performWithDelay(100, function()
				composer.gotoScene("ending_stage3")
			end
			)
		end
	end

	timeAttack = timer.performWithDelay(1000, counter, 61)

	function set:tap (event)
		timer.pause(timeAttack)
		composer.setVariable("timeAttack", timeAttack)
		composer.showOverlay("setting")
	end
	set:addEventListener("tap", set)
	
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
		composer.removeScene("stage3")
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end
end

function scene:destroy( event )
	local sceneGroup = self.view
	timer.performWithDelay( 1, function()
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