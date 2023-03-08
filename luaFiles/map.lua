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
	
    local background = display.newImageRect("image/대기실/지도/스테이지 0 프롤로그 클리어.png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2
	sceneGroup:insert(background)

	local end_logo = display.newImageRect("image/대기실/지도/지도 종료버튼.png", 200 * 0.5,200  * 0.5)
	end_logo.x, end_logo.y = display.contentWidth * 0.95, display.contentHeight * 0.08
	sceneGroup:insert(end_logo)

	local icon1 = display.newImage("image/대기실/지도/0 슬리펠프마을.png", display.contentWidth * 0.325, display.contentHeight * 0.736)
	local icon2 = display.newImage("image/대기실/지도/1 하얀산맥.png", display.contentWidth * 0.194, display.contentHeight * 0.378)
	local icon4 = display.newImage("image/대기실/지도/2 붉은모래마을.png", display.contentWidth * 0.428, display.contentHeight * 0.2)
	local icon3 = display.newImage("image/대기실/지도/3 시간이 멈춘 숲.png", display.contentWidth * 0.58, display.contentHeight * 0.54)
	local icon5 = display.newImage("image/대기실/지도/4 깊은 노래의 바다.png", display.contentWidth * 0.78, display.contentHeight * 0.36)

	if(stage1_clear == 1) then
		icon3.alpha = 1
	else
		icon3.alpha = 0
	end

	if(stage2_clear == 1) then
		icon4.alpha = 1
	else
		icon4.alpha = 0
	end

	if(stage3_clear == 1) then
		icon5.alpha = 1
	else
		icon5.alpha = 0
	end

	sceneGroup:insert(icon1)
	sceneGroup:insert(icon2)
	sceneGroup:insert(icon3)
	sceneGroup:insert(icon4)
	sceneGroup:insert(icon5)

    function end_tap( event )
        composer.removeScene( "map" ) 
		audio.pause(2)  
		composer.gotoScene("waitingRoom1")
    end

	function stage1_tap( event )
		audio.pause(2)
        composer.removeScene( "map" )   
		composer.gotoScene("view1")
    end

	function stage2_tap( event )
		audio.pause(2)
        composer.removeScene( "map" )   
		composer.gotoScene("stage2")
    end

	function stage3_tap( event )
		audio.pause(2)
        composer.removeScene( "map" )   
		composer.gotoScene("stage3")
    end

	function stage4_tap( event )
		audio.pause(2)
        composer.removeScene( "map" )   
		composer.gotoScene("game")
    end

	end_logo:addEventListener("tap", end_tap)
    icon1:addEventListener("tap", end_tap)
	icon2:addEventListener("tap", stage1_tap)
	icon3:addEventListener("tap", stage2_tap)
	icon4:addEventListener("tap", stage3_tap)
	icon5:addEventListener("tap", stage4_tap)

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