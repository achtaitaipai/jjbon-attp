require("modules/utils")
require("modules/loadTiledMap")
require("modules/player")
require("modules/spriteSheet")
require("modules/anim")
require("modules/camera")
require("modules/dialogBox")

function love.load()
    --scale pixels without blur
    love.graphics.setDefaultFilter("nearest", "nearest")

    local font = love.graphics.newImageFont( "assets/abcmin.png", "'abcdefghijklmnopqrstuvwxyz[!]~ " )
    love.graphics.setFont(font)

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
    _G.map=loadTiledMap(mapFile, spriteSheet)
    --create the player
    --position x in the grid, position y in the gris, animations array with: top, bottom, left and right
    _G.player=createPlayer(7,7,playerAnims,"bottom",8,8)
    _G.camera=createCamera(32,32,3,true)
    _G.dialogBox=createDialogBox(128,16,5,1)
end

function love.update(dt)
    if _G.dialogBox.active==false then
        _G.player:update(dt)
    end
    _G.dialogBox:up()
end

function love.draw()

    love.graphics.push()
    _G.camera:up()
    _G.map:drawTiles()
    _G.player:draw()
    love.graphics.pop()
    _G.dialogBox:draw()
    
end

function love.keypressed( key )
    if key == "space" then
       _G.dialogBox:next()
    end
 end