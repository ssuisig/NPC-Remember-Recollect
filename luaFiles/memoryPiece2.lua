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
	
    local background = display.newImageRect("image/대기실/아이콘 클릭 후(전체화면/대기실 이미지 1.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2
	sceneGroup:insert(background)

	local player = display.newImageRect("image/대사창/대사창 하루.png", 634 * 0.23,810 * 0.23)
	player.x, player.y = display.contentWidth*0.52, display.contentHeight * 0.83
	sceneGroup:insert(player)

	player.alpha = 0

	local edin = display.newImageRect("image/대사창/대사창 에딘.png",687 * 0.1, 617*0.1)
	edin.x, edin.y = display.contentWidth * 0.6, display.contentHeight * 0.7
	sceneGroup:insert(edin)

	local sceneEnd = display.newImage("image/대기실/아이콘/종료.png", display.contentWidth * 0.92, display.contentHeight * 0.075)
	sceneGroup:insert(sceneEnd)

	local door = display.newImage("image/대기실/아이콘 클릭 후(전체화면/문.png", display.contentWidth * 0.52, display.contentHeight * 0.835)
	sceneGroup:insert(door)

	local piece1 = display.newImage("image/대기실/아이콘 클릭 후(전체화면/스테이지 1 조각.png", display.contentWidth * 0.375, display.contentHeight * 0.48)
	local piece3 = display.newImage("image/대기실/아이콘 클릭 후(전체화면/스테이지 2 조각.png", display.contentWidth * 0.398, display.contentHeight * 0.165)
	local piece2 = display.newImage("image/대기실/아이콘 클릭 후(전체화면/스테이지 3 조각.png", display.contentWidth * 0.595, display.contentHeight * 0.215)
	local piece4 = display.newImage("image/대기실/아이콘 클릭 후(전체화면/스테이지 4 조각.png", display.contentWidth * 0.555, display.contentHeight * 0.48)
	
	sceneGroup:insert(piece1)
	sceneGroup:insert(piece2)
	sceneGroup:insert(piece3)
	sceneGroup:insert(piece4)

	 function ending_tap( event )
		audio.pause(2)
		composer.removeScene( "memoryPiece" )   
		composer.gotoScene("ending1")
	end
	
	 door:addEventListener("tap", ending_tap)

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