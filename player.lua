function createPlayer(x,y,dir)
    local player={
        gridX=x or 0,
        gridY=y or 0,
        newGridX=x or 0,
        newGridY=y or 0,
        --tile per seconds
        speed=3,
        sprite=love.graphics.newImage('assets/player.png'),
        direction=dir or "bottom"
    }
    

    function player:update(dt)
        if(self.gridX==self.newGridX and self.gridY==self.newGridY)then
            self.newGridX=self.gridX
            self.newGridY=self.gridY
            if love.keyboard.isDown('up') then
                self.newGridY=self.newGridY - 1
                
            end
            if love.keyboard.isDown('down') then
                self.newGridY=self.newGridY + 1
                
            end
            if love.keyboard.isDown('left') then
                self.newGridX=self.newGridX - 1
                
            end
            if love.keyboard.isDown('right') then
                self.newGridX=self.newGridX + 1
                
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

    function player:draw()
        love.graphics.draw(self.sprite,self.xx,self.yy)
    end

    function player:absPos(px,py)
        return {x=math.floor(px*_G.map.tileset.tilewidth+0.5),y=math.floor(py*_G.map.tileset.tileheight+0.5)}
    end

    return player

end