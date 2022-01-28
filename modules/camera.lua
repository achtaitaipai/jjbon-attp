function createCamera(width,height, scale)
    local camera={
        width = 32,
        height = 32,
        scale=scale or 1
    }
    camera.tx=(love.graphics.getWidth()/2)/camera.scale - _G.player.xx - _G.player.width/2
    camera.ty=(love.graphics.getHeight()/2)/camera.scale - _G.player.yy - _G.player.height/2

    function camera:up()
        local leftBorder = ((love.graphics.getWidth() - self.width)/2)/self.scale -self.tx
        local rightBorder = ((love.graphics.getWidth() + self.width)/2)/self.scale -self.tx
        local topBorder = ((love.graphics.getHeight() - self.height)/2)/self.scale - self.ty
        local bottomBorder = ((love.graphics.getHeight() + self.height)/2)/self.scale - self.ty

        if( _G.player.xx<leftBorder)then
            self.tx=self.tx+1
        end
        if( _G.player.xx>rightBorder - _G.player.width)then
            self.tx=self.tx-1
        end
        if(_G.player.yy>bottomBorder - _G.player.height)then
            self.ty=self.ty-1
        end
        if(_G.player.yy<topBorder)then
            self.ty=self.ty+1
        end
        self.ty=math.min(0,self.ty)
        self.tx=math.min(0,self.tx)
        self.ty=math.max(-love.graphics.getHeight()/2,self.ty)
        self.tx=math.max(-love.graphics.getWidth()/2,self.tx)
        love.graphics.scale(self.scale)
        love.graphics.translate(self.tx,self.ty)
    end
    return camera
end