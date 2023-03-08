-----------------------------------------------------------------------------------------
--
-- view2.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
	audio.resume(2)

	
	local background = display.newImageRect("image/대기실/아이콘 클릭전(대기실)/대기실 이미지 참고.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	local player = display.newImageRect("image/대사창/대사창 하루.png", 634 * 0.47,810 * 0.47)
	player.x, player.y = display.contentWidth*0.53, display.contentHeight * 0.67

	local edin = display.newImageRect("image/대사창/대사창 에딘.png",687 * 0.2, 617*0.2)
	edin.x, edin.y = display.contentWidth * 0.7, display.contentHeight * 0.44

    local map = display.newImageRect("image/대기실/아이콘/지도.png", 103.075, 91.175)
    map.x, map.y = display.contentWidth * 0.05, display.contentHeight * 0.07

    local memoryPiece = display.newImageRect("image/대기실/아이콘/기억의 조각.png", 144.2,138.6)
    memoryPiece.x, memoryPiece.y = display.contentWidth * 0.13, display.contentHeight * 0.07

    local help = display.newImageRect("image/대기실/아이콘/도움말.png",74,76.5)
	help.x, help.y = display.contentWidth * 0.21, display.contentHeight * 0.075

    local sceneEnd = display.newImage("image/대기실/아이콘/종료.png", display.contentWidth * 0.92, display.contentHeight * 0.075)
    
	local function clickMap(event)
        composer.removeScene( "waitingRoom1" )   
		audio.pause(2)
		composer.gotoScene("map")
    end

    local function clickMemory(event)
        composer.removeScene( "waitingRoom1" )   
		audio.pause(2)
		composer.gotoScene("memoryPiece")
    end

    local function clickHelp(event)
		audio.pause(2)
        composer.showOverlay('help')
    end

    local function clickEnd(event)
        composer.removeScene( "waitingRoom1" )       	
		audio.pause(2)
		composer.gotoScene("start")
    end

    map:addEventListener("tap",clickMap)
    memoryPiece:addEventListener("tap",clickMemory)
    help:addEventListener("tap", clickHelp)
    sceneEnd:addEventListener("tap", clickEnd)

    sceneGroup:insert(background)
	sceneGroup:insert(player)
	sceneGroup:insert(edin)
    sceneGroup:insert(map)
    sceneGroup:insert(memoryPiece)
    sceneGroup:insert(help)
    sceneGroup:insert(sceneEnd)

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
