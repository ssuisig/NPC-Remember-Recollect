-----------------------------------------------------------------------------------------
--
-- scene3.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view

	local backgroundMusic = audio.loadStream("music/scene.mp3")
	local backgroundMusicChannel = audio.play(backgroundMusic, {loops=-1})

	local bg = display.newRect(display.contentWidth/2, display.contentHeight/2, display.contentWidth, display.contentHeight)

	sceneGroup:insert(bg)

	local index = 0

	local function nextScript( event )
		bg.alpha = 1
		index = index + 1
		
		if(index > 6) then 
			stage2_clear = 1
			print(stage2_clear)
			audio.pause(backgroundMusicChannel)
			composer.gotoScene("memoryPiece")
			return
		end
		
		transition.from(bg, {time = 500, alpha = 0.0})

		bg.fill = {
			type = "image",
			filename = "image/scene3_"..index..".png"
		}
	end

	bg:addEventListener("tap", nextScript)
	nextScript()
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