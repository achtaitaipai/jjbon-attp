function loadSpriteSheet(imgPath,frameWidth,frameHeight)
    local spriteSheet={
        image=love.graphics.newImage(imgPath),
        frameWidth=frameWidth,
        frameHeight=frameHeight,
        quads={}
    }
    local nW = spriteSheet.image:getWidth()/spriteSheet.frameWidth - 1
    local nH = spriteSheet.image:getHeight()/spriteSheet.frameHeight -1

    for y=0, nH do
        for x=0, nW do
            local quad = love.graphics.newQuad(
                x * spriteSheet.frameWidth,
                y * spriteSheet.frameHeight,
                spriteSheet.frameWidth,
                spriteSheet.frameHeight,
                spriteSheet.image:getWidth(),
                spriteSheet.image:getHeight()
            )
            table.insert( spriteSheet.quads,quad )
        end
    end

    function spriteSheet:draw(id,x,y,fl)
        local flip=fl or false
        local sx = flip and -1 or 1
        local offsetX = flip and self.frameWidth or 0
        love.graphics.draw(
            self.image,
            self.quads[id],
            x + offsetX,
            y,
            0,
            sx,
            1
        )
    end
    return spriteSheet
end