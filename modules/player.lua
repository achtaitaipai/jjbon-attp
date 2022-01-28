function createPlayer(x,y,anims,dir,width,height)
    local player={
        gridX=x or 0,
        gridY=y or 0,
        newGridX=x or 0,
        newGridY=y or 0,
        --tile walk per seconds
        speed=3,
        anims = anims,
        direction=dir or "bottom",
        width=anims.left.frameWidth,
        height=anims.left.frameHeight,
    }
    player.currentAnim=player.anims[player.direction] 
    local playerMapObject = _G.map:getObject("player")
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
                if _G.map:isSolid(self.gridX,self.gridY - 1) ~=true then
                    self.newGridY=self.newGridY - 1
                    self.currentAnim:play()
                end
                self:defineDirection('top')
            elseif love.keyboard.isDown('down') then
                if _G.map:isSolid(self.gridX,self.gridY + 1) ~=true then
                    self.newGridY=self.newGridY + 1
                    self.currentAnim:play()
                end
                self:defineDirection('bottom')
            elseif love.keyboard.isDown('left') then
                if _G.map:isSolid(self.gridX - 1,self.gridY) ~=true then
                    self.newGridX=self.newGridX - 1
                    self.currentAnim:play()
                end
                self:defineDirection('left')
            elseif love.keyboard.isDown('right') then
                if _G.map:isSolid(self.gridX + 1,self.gridY) ~=true then
                    self.newGridX=self.newGridX + 1 
                    self.currentAnim:play()
                end
                self:defineDirection('right')
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