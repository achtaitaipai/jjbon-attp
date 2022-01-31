function createPlayer(anims,dir,width,height)
    local player={
        gridX=0,
        gridY=0,
        newGridX=x or 0,
        newGridY=y or 0,
        --tile walk per seconds
        speed=3,
        anims = anims,
        direction=dir or "bottom",
        width=width,
        height=height,
        wCell=math.floor(math.max(1,width/_G.map.tilewidth)),
        hCell=math.floor(math.max(1,height/_G.map.tileheight))
    }
    player.currentAnim=player.anims[player.direction] 
    local playerMapObject = _G.map:getObject("player")[1]
    player.gridX=math.floor(playerMapObject.x/_G.map.tilewidth)
    player.gridY=math.floor(playerMapObject.y/_G.map.tileheight)
    player.newGridX=player.gridX
    player.newGridY=player.gridY

    function player:update(dt)
        if(self.gridX==self.newGridX and self.gridY==self.newGridY)then
            self.newGridX=self.gridX
            self.newGridY=self.gridY
            self.currentAnim:pause(2)
            if love.keyboard.isDown('up') then
                self:defineDirection('top')
                if self:collide() ~=true then
                    self.newGridY=self.newGridY - 1
                    self.currentAnim:play()
                end
            elseif love.keyboard.isDown('down') then
                self:defineDirection('bottom')
                if self:collide() ~=true then
                    self.newGridY=self.newGridY + 1
                    self.currentAnim:play()
                end
            elseif love.keyboard.isDown('left') then
                self:defineDirection('left')
                if self:collide() ~=true then
                    self.newGridX=self.newGridX - 1
                    self.currentAnim:play()
                end
            elseif love.keyboard.isDown('right') then
                self:defineDirection('right')
                if self:collide() ~=true then
                    self.newGridX=self.newGridX + 1 
                    self.currentAnim:play()
                end
            end
        else
            if(self.newGridX>self.gridX)then
                self.gridX=math.min(self.gridX+self.speed*dt,self.newGridX)
            end
            if(self.newGridY>self.gridY)then
                self.gridY=math.min(self.gridY+self.speed*dt,self.newGridY)
            end
            if(self.newGridY<self.gridY)then
                self.gridY=math.max(self.gridY-self.speed*dt,self.newGridY)
            end
            if(self.newGridX<self.gridX)then
                self.gridX=math.max(self.gridX-self.speed*dt,self.newGridX)
            end
        end
        local pos =self:absPos(self.gridX,self.gridY)
        self.xx=pos.x
        self.yy=pos.y
    end

    function player:collide()
        if self.direction=="right" then
            for y=0,self.hCell - 1 do
                if _G.solids:isSolid(self.gridX + self.wCell,self.gridY+y) ==true then
                    return true
                end
                if _G.map:isSolid(self.gridX + self.wCell,self.gridY+y) ==true then
                    return true
                end
            end
        elseif self.direction=="left" then
            for y=0,self.hCell - 1 do
                if _G.solids:isSolid(self.gridX - 1,self.gridY+y) ==true then
                    return true
                end
                if _G.map:isSolid(self.gridX - 1,self.gridY+y) ==true then
                    return true
                end
            end
        elseif self.direction=="bottom" then
            for x=0,self.wCell - 1 do
                if _G.solids:isSolid(self.gridX + x,self.gridY+self.hCell) ==true then
                    return true
                end
                if _G.map:isSolid(self.gridX + x,self.gridY+self.hCell) ==true then
                    return true
                end
            end
        elseif self.direction=="top" then
            for x=0,self.wCell - 1 do
                if _G.solids:isSolid(self.gridX + x,self.gridY - 1) ==true then
                    return true
                end
                if _G.map:isSolid(self.gridX + x,self.gridY - 1) ==true then
                    return true
                end
            end
        end
        return false

    end
    

    function player:defineDirection(dir)
        self.direction=dir
        self.currentAnim=self.anims[self.direction]
    end

    function player:draw()
        self.currentAnim:draw(self.xx,self.yy)
    end

    function player:absPos(px,py)
        return {x=math.floor(px*_G.map.tileset.tilewidth+0.5),y=math.floor(py*_G.map.tileset.tileheight+0.5)}
    end

        local pos =player:absPos(player.gridX,player.gridY)
    player.xx=pos.x
    player.yy=pos.y
    return player

end