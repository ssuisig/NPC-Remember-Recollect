-----------------------------------------------------------------------------------------
--
-- setting.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()


function scene:create( event )
	local sceneGroup = self.view

	local background = display.newImageRect("image/settingbg.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	local resume = display.newImageRect("image/resume.png", 220, 100)
	resume.x, resume.y = display.contentWidth*0.53, 250

	local exit = display.newImageRect("image/end.png", 220, 100)
	exit.x, exit.y = display.contentWidth*0.53, 450

	function resume:tap(event)
		local timeAttack = composer.getVariable("timeAttack")
 		timer.resume(timeAttack)

		composer.hideOverlay("setting")
 	end

	function exit:tap(event)
		local backgroundMusicChannel = composer.getVariable( "backgroundMusicChannel" )
		audio.pause(backgroundMusicChannel, {channel=7})

		composer.hideOverlay("setting")
        composer.gotoScene("waitingRoom1")
	end

	resume:addEventListener("tap", resume)
	exit:addEventListener("tap", exit)

	sceneGroup:insert(background)
	sceneGroup:insert(resume)
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