-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

local timeAttack

function scene:create( event )
	local sceneGroup = self.view
	
	audio.resume(2)
	physics.start()
	-- physics.setDrawMode( "hybrid" )

	local background = display.newImageRect("image/대기실/아이콘 클릭전(대기실)/배경(+지형).png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

    local time= display.newText(1000, 50, 50)

 	time.size = 50
 	time:setFillColor(0)
 	time.alpha = 0

	local ground = display.newImage("image/대기실/아이콘 클릭전(대기실)/지형.png")
	ground.x, ground.y = display.contentWidth / 2, display.contentHeight * 0.99

	local door = display.newImage("image/door.png")
	door.x, door.y = 1180, display.contentHeight * 0.812
	door.name = "door"

	local door_outline = graphics.newOutline(1, "image/door.png")

	local set = display.newImageRect("image/set.png", 70, 70)
	set.x, set.y = 1220, 50

	local wall = {}
	wall[1] = display.newRect(0, background.y, 0, background.height)
	wall[2] = display.newRect(background.width, background.y, 0, background.height)
	wall[3] = display.newRect(background.x, 0, background.width, 0)
	wall[4] = display.newRect(background.x, background.height, background.width, 0)

	physics.addBody(ground, "static")
	sceneGroup:insert(ground)

	sceneGroup:insert(background)
    sceneGroup:insert(time)
	sceneGroup:insert(set)

	for i = 1, #wall do
		physics.addBody(wall[i], "static")
		sceneGroup:insert(wall[i])
		wall[i].name = "wall"
	end

	physics.addBody(door, "kinematic", {isSensor=true})
	sceneGroup:insert(door)
              
	local player = {}
	player = display.newImageRect("image/face.png", 80, 115)
	local player_outline = graphics.newOutline(2, "image/face.png")
	player.x, player.y = 130, 600
	player.name = "player"

	physics.addBody(player, {friction=1, bounce=0, outline = player_outline})
	player.isFixedRotation = true

	---방향키---
	local leftButton = display.newImageRect("image/arrow_left.png", 90, 70)
	leftButton.x, leftButton.y = 80, 675
	
	local rightButton = display.newImageRect("image/arrow_right.png", 90, 70)
	rightButton.x, rightButton.y = 170, 675

	local jumpButton = display.newImageRect("image/arrow_jump.png", 80, 80)
	jumpButton.x, jumpButton.y = 1150, 675 --220

	local point = display.newRect(1160, 200, 135, 135)
	point.name = "point"
	point:setFillColor( 0.5 )
	point.alpha = 0
	physics.addBody(point, "kinematic", {isSeneor=true})

	---설정---
	local set = display.newImageRect("image/set.png", 70, 70)
	set.x, set.y = 1220, 50

	---스테이지클리어flag---
	local stage1_clear = 0

	sceneGroup:insert(player)
	sceneGroup:insert(leftButton)
	sceneGroup:insert(rightButton)
	sceneGroup:insert(jumpButton)
	sceneGroup:insert(set)
	sceneGroup:insert(time)


	---함수---
	--움직임
	
	local function setplayerVelocity()
		local playerHorisontalVelocity, playerVerticalVelocity = player:getLinearVelocity()--수평, 수직 속도
		player:setLinearVelocity( player.velocity, playerVerticalVelocity)
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
			--transition.to(player, {time=150, x=(x-40)})
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

		---점프사운드---
		jumpSound = audio.loadStream("music/jumpsound.wav")
		local music = audio.play(jumpSound)
	end

		--탈출조건
		local flag1 = 0
		local flag2 = 1
		local flag3 = 1
	
		 function exit(self, event)
			if(event.phase == "ended" and flag1 == 0 and flag2 == 0) then
				if(event.other.name == "key") then
				   flag1 = 1
					print("key"..flag1)
	
					display.remove( key )
					key = nil
	
				end
			elseif(event.phase == "began" and flag1 == 1 and flag2 == 0) then
				if(event.other.name == "block") then
					print("block"..flag1)
	
					display.remove(block)
					block = nil
					
					transition.fadeOut( rock, { time=1000 } )
				elseif(event.other.name == "memory2") then
					flag2 = 1
					print("memory2"..flag2)
	
					display.remove(memory)
					memory = nil
					display.remove(memory2)
					memory2 = nil
				end
			end
			if(event.phase == "began") then
				if(event.other.name == "door") then
					print("point")
					Runtime:removeEventListener("enterFrame", setplayerVelocity) 
					player.velocity = 0
	
					display.remove(background)
	
					timer.performWithDelay( 0, function()
						physics.stop()
					end )
					display.remove(background)
					background = nil
	
					stage1_clear = 1
					print(stage1_clear)
	
					timer.performWithDelay( 0, function()
						audio.pause(2)
						composer.gotoScene("memoryPiece")
						return
					end )
					flag1 = 0
					flag2 = 0
				end
			end
		end
		
	
		---적용---
		leftButton:addEventListener("touch", arrowTab_left)
		rightButton:addEventListener("touch", arrowTab_right)
		jumpButton:addEventListener("tap", arrowTab_jump)
	
		function set:tap( event )
			 composer.setVariable( "timeAttack", timeAttack )
			composer.showOverlay('setting _dutorial')
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
		-- timer.cancel(timeAttack)
		composer.removeScene("dutorial")
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