-----------------------------------------------------------------------------------------
--
-- view2.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

function scene:create( event )
	local sceneGroup = self.view
	
	local background = display.newImageRect("image/대기실/아이콘 클릭전(대기실)/배경(+지형).png", display.contentWidth, display.contentHeight)
	background.x, background.y = display.contentWidth/2, display.contentHeight/2

	local talk = display.newImage("image/대사창/대사창.png", display.contentWidth/2, display.contentHeight * 0.5)

    local memoryPiece = display.newImageRect("image/대기실/아이콘/기억의 조각.png", 412,396)
    memoryPiece.x, memoryPiece.y = display.contentWidth/2, display.contentHeight * 0.25

	sceneGroup:insert(background)
    sceneGroup:insert(memoryPiece)
    sceneGroup:insert(talk)

	local c={}
	c[1] = display.newImageRect("image/대사창/대사창 에딘.png",687 * 0.65, 617*0.65)
	c[1].x, c[1].y = display.contentWidth * 0.175, display.contentHeight * 0.64
	c[2] = display.newImageRect("image/대사창/대사창 하루.png", 634 * 0.5,810 * 0.5)
	c[2].x, c[2].y = display.contentWidth * 0.15, display.contentHeight * 0.58

	c[1].alpha = 0
	c[2].alpha = 0

	sceneGroup:insert(c[1])
	sceneGroup:insert(c[2])

	local t={}
	t[1] = display.newImage("image/대사창/에딘 이름.png", display.contentWidth * 0.16, display.contentHeight * 0.89)
	t[2] = display.newImage("image/대사창/하루 이름.png", display.contentWidth * 0.16, display.contentHeight * 0.89)

	t[1].alpha = 0
	t[2].alpha = 0

	sceneGroup:insert(t[1])
	sceneGroup:insert(t[2])

	local chatting={}
	local text={
		"아까 너가 떨어질 때, 기억의 조각을 하나\n주웠는데..한번 볼래?",
        "이건 내 이름이야..!\n맞아 난 하루였어",
        "하루?? 왠지 많이 들어본 이름이네",
        "내 이름이 흔해서 그런가..?\n아무튼 이름 찾아줘서 고마워",
	}

	for i=1,4 do
        chatting[i]=display.newText(text[i],display.contentWidth * 0.82,display.contentHeight,display.contentWidth, display.contentHeight * 0.6, "KyoboHandwriting2019.ttf")
        chatting[i]:setFillColor(0)
        chatting[i].size=50
    end
    for i=2,4 do
        chatting[i].alpha=0
    end

	local j=1
	c[1].alpha = 1
	t[1].alpha = 1


	local function click(event)
		
		j=j+1
        if j>=1 and j<=4 then
			if(j == 2 or j == 4) then
				c[1].alpha = 0
				c[2].alpha = 1
				t[1].alpha = 0
				t[2].alpha = 1
			else
				c[2].alpha = 0
				c[1].alpha = 1
				t[2].alpha = 0
				t[1].alpha = 1
			end

            chatting[j-1].alpha=0
            chatting[j].alpha=1
        end

        if j==5 then 
        	chatting[4].alpha=0
            composer.removeScene( "talk6" )
            composer.setVariable("complete", true)
            composer.gotoScene("talk7")
        end

	end
	background:addEventListener("tap",click)
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
