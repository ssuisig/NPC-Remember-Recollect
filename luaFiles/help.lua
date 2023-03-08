-----------------------------------------------------------------------------------------
--
-- setting.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()


function scene:create( event )
	local sceneGroup = self.view
	audio.resume(2)
	
	local background = {}
   	background[1] = display.newImage("image/대기실/도움말/도움말창.png의 사본.png")
	background[2] = display.newImage("image/대기실/도움말/도움말창2.png의 사본.png")

	background[1].x, background[1].y = display.contentWidth * 0.47, display.contentHeight/2
	sceneGroup:insert(background[1])
	background[2].x, background[2].y = display.contentWidth * 0.47, display.contentHeight/2
	sceneGroup:insert(background[2])

	background[1].alpha = 1
	background[2].alpha = 0

	local logo = {}
	logo[1] = display.newImageRect("image/대기실/도움말/도움말 넘김 버튼.png", 100,100)
	logo[1].x, logo[1].y = display.contentWidth * 0.8, display.contentHeight*0.72
	logo[2] = display.newImageRect("image/대기실/도움말/도움말 넘김 버튼.png", 100,100)
	logo[2].x, logo[2].y = display.contentWidth * 0.8, display.contentHeight*0.72
	logo[3] = display.newImageRect("image/대기실/도움말/도움말 넘김 버튼 2.png", 100,100)
	logo[3].x, logo[3].y = display.contentWidth * 0.2, display.contentHeight*0.72

	logo[2].alpha = 0
	logo[3].alpha = 0

	sceneGroup:insert(logo[1])
	sceneGroup:insert(logo[2])
	sceneGroup:insert(logo[3])

    function click( event )
        composer.hideOverlay('help')
    end

	function next(event)
		background[1].alpha = 0
		background[2].alpha = 1
		logo[1].alpha = 0
		logo[2].alpha=1
		logo[3].alpha=1
	end

	function before (event)
		background[1].alpha = 1
		background[2].alpha = 0
		logo[1].alpha = 1
		logo[2].alpha=0
		logo[3].alpha=0
	end

	logo[1]:addEventListener("tap", next)
	logo[2]:addEventListener("tap", click)
	logo[3]:addEventListener("tap", before)

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