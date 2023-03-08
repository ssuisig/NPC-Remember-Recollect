-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------
--문제 : 통로통과 후 점프없이 적1과 첫 충돌시 ending_stage1으로 가지 않음

local composer = require( "composer" )
local scene = composer.newScene()

local timeAttack

function scene:create( event )
	local sceneGroup = self.view
	
	physics.start()
	--physics.setDrawMode( "hybrid" )


	---배경---
	local background = display.newImageRect("image/sky.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	sceneGroup:insert(background)
	
	---배경음악---
	local backgroundMusic = audio.loadSound("music/backgroundMusic.mp3")
	audio.play(backgroundMusic, {channel = 3})

	---땅---
	local ground = {}
	ground[1] = display.newImageRect("image/ground.png", 2320, 90)
	ground[1].x, ground[1].y = 120, 675
	ground[2] = display.newImageRect("image/ground3.png", 200, 50)
	ground[2].x, ground[2].y = 280, 488
	ground[3] = display.newImageRect("image/ground3.png", 170, 50)
	ground[3].x, ground[3].y = 390, 380
	ground[4] = display.newImageRect("image/ground3.png", 150, 50)
	ground[4].x, ground[4].y = 540, 300
	ground[5] = display.newImageRect("image/ground3.png", 220, 50)
	ground[5].x, ground[5].y = 800, 280
	ground[6] = display.newImageRect("image/ground3.png", 300, 50)
	ground[6].x, ground[6].y = 1150, 290
	ground[7] = display.newImageRect("image/ground3.png", 150, 50)
	ground[7].x, ground[7].y = 1150, 560
	ground[8] = display.newImageRect("image/ground3.png", 80, 50)
	ground[8].x, ground[8].y = 40, 570

	---벽---
	local wall = {}
	wall[1] = display.newRect(0, background.y, 0, background.height)
	wall[2] = display.newRect(background.width, background.y, 0, background.height)
	wall[3] = display.newRect(background.x, 0, background.width, 0)
	wall[4] = display.newRect(background.x, background.height, background.width, 1)

	---타이머---
	local time= display.newText(60, 50, 50)

	time.size = 50
 	time:setFillColor(0)
 	time.alpha = 0.7

	---플레이어---
	local player = {}
	player = display.newImageRect("image/face.png", 80, 115)
	local player_outline = graphics.newOutline(2, "image/face.png")
	player.x, player.y = 130, 600
	player.name = "player"

	physics.addBody(player, {friction=1, bounce=0, outline = player_outline})
	player.isFixedRotation = true

	---방향키---
	local leftButton = display.newImageRect("image/arrow_left.png", 70, 70)
   leftButton.x, leftButton.y = 80, 675
   
   local rightButton = display.newImageRect("image/arrow_right.png", 70, 70)
   rightButton.x, rightButton.y = 150, 675

	local jumpButton = display.newImageRect("image/jump.png", 80, 80)
	jumpButton.x, jumpButton.y = 1150, 675 --220

	--장애물--
	local block = display.newRect(750, 570, 300, 135)
	block.name = "block"
	block:setFillColor( 0.5 )
	block.alpha = 0
	physics.addBody(block, "kinematic", {isSeneor=true})

	---자물쇠---
	local rock = display.newImageRect("image/자물쇠.png",35, 35)
	rock.x, rock.y = 640, 510
	rock.name = "rock"
	local rock_outline = graphics.newOutline(1, "image/자물쇠.png")

	---눈사람---
	local snowman3 = display.newImageRect("image/snowman3.png",350, 210)
	snowman3.x, snowman3.y = 770, 400
	snowman3.name = "snowman3"
	local snowman3_outline = graphics.newOutline(2, "image/snowman3.png")
	physics.addBody(snowman3, "static", {outline = snowman3_outline})

	local snowman2 = display.newImageRect("image/snowman2.png",350, 135)
	snowman2.x, snowman2.y = 770, 570
	snowman2.name = "snowman2"
	local snowman2_outline = graphics.newOutline(2, "image/snowman2.png")


	---출구---
	local door = display.newImageRect("image/door.png", 300, 150)
	door.x, door.y = 1180, 192
	door.name = "door"
	--physics.addBody(door, "kinematic", {isSensor=true})

	local point = display.newRect(1160, 200, 135, 135)
	point.name = "point"
	point:setFillColor( 0.5 )
	point.alpha = 0
	physics.addBody(point, "kinematic", {isSeneor=true})

	---기억의 조각---
	local memory = display.newImageRect("image/memory.png", 130, 130)
	memory.x, memory.y = 1040, 380
	memory.name = "memory"
	--physics.addBody(memory, "kinematic", {isSensor=true})

	local memory2 = display.newImageRect("image/memory2.png", 39, 81)
	memory2.x, memory2.y = 1040, 370
	memory2.name = "memory2"
	memory2.alpha = 0
	local memory2_outline = graphics.newOutline(3, "image/memory2.png")
	physics.addBody(memory2, "kinematic", {isSensor=true})

	---전등---
	local light = display.newImageRect("image/light.png", 180, 140)
	light.x, light.y = 470, 430
	light.name = "light"
	local light_outline = graphics.newOutline(1, "image/light.png")

	---열쇠---
	local key = display.newImageRect("image/스테이지1.png", 35, 35)
	key.x, key.y = 475, 450
	key.name = "key"
	local key_outline = graphics.newOutline(2, "image/스테이지1.png")
	physics.addBody(key, "kinematic", {isSensor=true, outline = key_outline})

	---적1---
	local enemy1 = display.newImageRect("image/enemyF.png", 75, 75)
	enemy1.x, enemy1.y = 1070, 600
	enemy1.name = "enemy1"
	local enemy1_outline = graphics.newOutline(3, "image/enemyF.png")
	physics.addBody(enemy1, "kinematic", {isSensor=true, outline = enemy1_outline})

	---적2---
	local enemy2 = display.newImageRect("image/enemyL.png", 75, 75)
	enemy2.x, enemy2.y = 960, 310
	enemy2.name = "enemy2"
	local enemy2_outline = graphics.newOutline(3, "image/enemyL.png")
	physics.addBody(enemy2, "kinematic", {isSensor=true, outline = enemy2_outline})

	---설정---
	local set = display.newImageRect("image/set.png", 70, 70)
	set.x, set.y = 1220, 50

	---스테이지클리어flag---
	local stage1_clear = 0

	---정렬---
	for i = 1, #ground do
		physics.addBody(ground[i], "static")
		sceneGroup:insert(ground[i])
	end
	background:toBack()
	
	for i = 1, #wall do
		physics.addBody(wall[i], "static")
		sceneGroup:insert(wall[i])
		wall[i].name = "wall"
	end

	sceneGroup:insert(leftButton)
	sceneGroup:insert(rightButton)
	sceneGroup:insert(jumpButton)
	sceneGroup:insert(key)
	sceneGroup:insert(light)
	sceneGroup:insert(memory)
	sceneGroup:insert(memory2)
	sceneGroup:insert(door)
	sceneGroup:insert(player)
	sceneGroup:insert(snowman3)
	sceneGroup:insert(snowman2)
	sceneGroup:insert(set)
	sceneGroup:insert(block)
	sceneGroup:insert(enemy1)
	sceneGroup:insert(enemy2)
	sceneGroup:insert(rock)
	sceneGroup:insert(time)


	---함수---
	--움직임
	
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

		---점프사운드---
		local jumpSound = audio.loadStream("music/jumpsound.wav")
		local music = audio.play(jumpSound)
	end

	--타이머함수
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

			display.remove(leftButton)
		    display.remove(rightButton)
		    display.remove(jumpButton)
		    display.remove(set)
			display.remove(player)

		    audio.pause(3)

		    player.velocity = 0
         	Runtime:removeEventListener("enterFrame", setPlayerVelocity)

			timer.performWithDelay( 0, function()
			   physics.stop()
		   end )

		   timer.pause(timeAttack)
			
			timer.performWithDelay( 0, function()
			   -- composer.showOverlay("ending_stage1")
			   composer.gotoScene("ending_stage1")
		   end )
		end
   end

   timeAttack = timer.performWithDelay(1000, counter, 61)

	--탈출조건
	local flag1 = 0
	local flag2 = 0
	local flag3 = 0

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
			if(event.other.name == "enemy1" or event.other.name == "enemy2") then
				print("enemy")
				
				Runtime:removeEventListener("enterFrame", setplayerVelocity) 
				player.velocity = 0
				
				timer.performWithDelay( 0, function()
				    physics.stop()
				end )

				timer.performWithDelay( 0, function()
				    composer.gotoScene("ending_stage1")
					return
				end )
				display.remove(enemy2)
				enemy2 = nil
				display.remove(enemy1)
				enemy1 = nil

				display.remove(player)

				flag1 = 0
				flag2 = 0
			elseif(event.other.name == "wall") then
				print("wall")
		
				Runtime:removeEventListener("enterFrame", setplayerVelocity) 
				player.velocity = 0

				timer.performWithDelay( 0, function()
				    physics.start()
				    physics.stop()
				end )

				timer.performWithDelay( 0, function()
				    composer.gotoScene("ending_stage1")
					return
				end )
			
				display.remove(player)
				flag1 = 0
				flag2 = 0
			elseif(event.other.name == "point" and flag2 == 1) then
				print("point")
				Runtime:removeEventListener("enterFrame", setplayerVelocity) 
				player.velocity = 0

				display.remove(background)
				display.remove(player)

				timer.performWithDelay( 0, function()
					physics.stop()
				end )
				display.remove(background)
				background = nil

				stage1_clear = 1
				print(stage1_clear)

				timer.performWithDelay( 0, function()
					composer.gotoScene("scene")
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
		-- e.g. key2t timers, begin animation, play audio, etc.
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

		composer.removeScene("view1")
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end
	audio.pause(3)
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