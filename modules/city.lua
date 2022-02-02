function createCity()
    local city={}

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
    local mapFile=require("assets/carte")
    city.map=loadTiledMap(mapFile, spriteSheet)

    -- width, height, margin,maximum length of each line, number of lines, scale
    city.dialogBox=createDialogBox(128,16,8,16,2,1)
    city.solids=createSolidObjects(spriteSheet,city.map,city.dialogBox)
    --create the player
    --position x in the grid, position y in the gris, animations array with: top, bottom, left and right
    city.player=createPlayer(playerAnims,"bottom",8,8,city.map,city.solids)
    city.camera=createCamera(city.player,city.map,64,64,2,true)

    function city:update(dt)
        if city.dialogBox.active==false then
            self.player:update(dt)
        end
    end

    function city:draw()
        love.graphics.push()
        self.camera:up()
        self.map:drawTiles()
        self.player:draw()
        self.solids:draw()
        love.graphics.pop()
        city.dialogBox:draw()
    end

    function city:keyPressed(key)
        if key == "space" then
            city.dialogBox:next()
         end
    end

    return city
end