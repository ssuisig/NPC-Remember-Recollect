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

    local devil1 = display.newImageRect("image/devilelf1_face.png", 656 * 0.3,806 * 0.3)
    devil1.x, devil1.y = display.contentWidth * 0.7, display.contentHeight * 0.36

    local devil2 = display.newImageRect("image/devilelf2_face.png", 706 * 0.3,927 * 0.3)
    devil2.x, devil2.y = display.contentWidth * 0.55, display.contentHeight * 0.32

    local memoryPiece = {}
    memoryPiece[1] = display.newImageRect("image/기억의 방/색깔 있는 병 1.png", 384 * 0.5,408*0.5)
    memoryPiece[2] = display.newImageRect("image/기억의 방/색깔 있는 병 5.png", 384*0.5,408*0.5)
    memoryPiece[3] = display.newImageRect("image/기억의 방/색깔 있는 병 3.png", 384*0.5,408*0.5)
    memoryPiece[4] = display.newImageRect("image/기억의 방/색깔 있는 병 4.png", 384 * 0.5,408*0.5)

    memoryPiece[1].x, memoryPiece[1].y = display.contentWidth * 0.33, display.contentHeight * 0.4
    memoryPiece[2].x, memoryPiece[2].y = display.contentWidth * 0.41, display.contentHeight * 0.4
    memoryPiece[3].x, memoryPiece[3].y = display.contentWidth * 0.41, display.contentHeight * 0.26
    memoryPiece[4].x, memoryPiece[4].y = display.contentWidth * 0.33, display.contentHeight * 0.26


	sceneGroup:insert(background)
    sceneGroup:insert(devil1)
    sceneGroup:insert(devil2)
    sceneGroup:insert(memoryPiece[1])
    sceneGroup:insert(memoryPiece[2])
    sceneGroup:insert(memoryPiece[3])
    sceneGroup:insert(memoryPiece[4])
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
		"그럼 만약에 데비레프가 내 기억의 조각을\n모두 가져가면 어떻게 돼?",
        "만약 걔네들이 너의 기억의 조각을 모두\n빼앗으면, 현실세계에서 너는 죽게되고,\n드림피아는 데비레프에게 잡아먹힐거야",
	}
    
    chatting[1]=display.newText(text[1],display.contentWidth * 0.82,display.contentHeight,display.contentWidth, display.contentHeight * 0.6, "KyoboHandwriting2019.ttf")
    chatting[2]=display.newText(text[2],display.contentWidth * 0.82,display.contentHeight,display.contentWidth, display.contentHeight * 0.75, "KyoboHandwriting2019.ttf")

    chatting[1]:setFillColor(0)
    chatting[1].size=50
    chatting[2]:setFillColor(0)
    chatting[2].size=50
    
    chatting[2].alpha=0

	local j=1
	c[2].alpha = 1
	t[2].alpha = 1


	local function click(event)
		
		j=j+1
        if j>=1 and j<=2 then
			if(j == 1) then
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

        if j==3 then 
        	chatting[2].alpha=0
            composer.removeScene( "talk11" )
            composer.setVariable("complete", true)
            composer.gotoScene("talk12")
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
