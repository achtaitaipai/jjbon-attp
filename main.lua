require("modules/loadTiledMap")
require("modules/player")
require("modules/spriteSheet")
require("modules/anim")

--scale of the game
_G.scale=2

function love.load()
    --scale pixels without blur
    love.graphics.setDefaultFilter("nearest", "nearest")

    --create spriteSheet
    -- path to the file, width of each sprite, height of each sprite
    local spriteSheet=loadSpriteSheet("assets/attpjjbon.png",8,8)

    --define the anims of the player
    local playerSpriteSheet=loadSpriteSheet('assets/playerAnim.png',8,8)
    local fps =8
    playerAnims={
        --spriteSheet, index of the frames to display in the order, fps, flip the image or not, frame to display in peuse mode
        top=createAnim(playerSpriteSheet,{1,2,3},fps,false,1),
        bottom=createAnim(playerSpriteSheet,{1,2,3},fps,false,1),
        left=createAnim(playerSpriteSheet,{4,5,6},fps,true,2),
        right=createAnim(playerSpriteSheet,{4,5,6},fps,false,2)
    }

    --create the map
    local mapFile=require("assets/testMap")
    _G.currentMap=loadTiledMap(mapFile, spriteSheet)
    --create the player
    --position x in the grid, position y in the gris, animations array with: top, bottom, left and right
    _G.player=createPlayer(15,15,playerAnims)

end

function love.update(dt)
    _G.player:update(dt)
end

function love.draw()
    love.graphics.scale(_G.scale)
    _G.currentMap:drawTiles()
    _G.player:draw()
end