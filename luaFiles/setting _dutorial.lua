-----------------------------------------------------------------------------------------
--
-- setting.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local setBg = display.newImageRect("image/setBg.png", display.contentWidth, display.contentHeight)
	setBg.x, setBg.y = display.contentWidth/2, display.contentHeight/2

	local back = display.newImageRect("image/back.png", 220, 100)
	back.x, back.y = display.contentWidth/2, 250

	local exit = display.newImageRect("image/exit.png", 220, 100)
	exit.x, exit.y = display.contentWidth/2, 450

	function back:tap(event)
 		composer.hideOverlay('setting')
	end

	function exit:tap(event)
		audio.pause(2)
		composer.hideOverlay('setting')
		composer.gotoScene("waitingRoom1")	
	end

	back:addEventListener("tap", back)
	exit:addEventListener("tap", exit)

	sceneGroup:insert(setBg)
	sceneGroup:insert(back)
	sceneGroup:insert(exit)
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
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end
end

function scene:destroy( event )
	local sceneGroup = self.view
	
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