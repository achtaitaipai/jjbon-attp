require("modules/utils")
require("modules/dialogBox")
require("modules/spriteSheet")
require("modules/loadTiledMap")
require("modules/anim")



function love.load()
    --scale pixels without blur
    love.graphics.setDefaultFilter("nearest", "nearest")

    local font = love.graphics.newImageFont( "assets/abcmin.png", "'abcdefghijklmnopqrstuvwxyz[!]~ " )
    love.graphics.setFont(font)
    
    scenes={
        city =require("scenes/city/index"),
        test= require("scenes/test/index")
    }
    currentScene= scenes.city
end

function love.update(dt)
    if currentScene.update~= nil then
        currentScene:update(dt)
    end
end

function love.draw()
    if currentScene.draw ~= nil then
        currentScene:draw()
    end
end

function love.keypressed( key )
    if currentScene.keyPressed ~= nil then
        currentScene:keyPressed(key)
    end
    if key == 'a' then
        loadScene("test",true)
    end
    if key == 'b' then
        loadScene("city",true)
    end
 end

 --scene -> string : nom de la scene à charger 
 --reset -> boolean : faut il réinitialiser la nouvelle scene
 function loadScene(scene,reset)
    currentScene = scenes[scene]
    if reset and currentScene.reset ~= nil then
        currentScene.reset()
    end
 end