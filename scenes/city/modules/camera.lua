function createCamera(target,map,width,height, scale, clamp)
    local camera={
        target=target,
        map=map,
        width = width,
        height = height,
        scale=scale or 1,
        clamp=clamp or true
    }
    camera.tx=(love.graphics.getWidth()/2)/camera.scale -target.xx -target.width/2
    camera.ty=(love.graphics.getHeight()/2)/camera.scale -target.yy -target.height/2

    function camera:up()
        local leftBorder = ((love.graphics.getWidth() - self.width)/2)/self.scale -self.tx
        local rightBorder = ((love.graphics.getWidth() + self.width)/2)/self.scale -self.tx
        local topBorder = ((love.graphics.getHeight() - self.height)/2)/self.scale - self.ty
        local bottomBorder = ((love.graphics.getHeight() + self.height)/2)/self.scale - self.ty

        if(self.target.xx<leftBorder)then
            self.tx=self.tx+1
        end
        if(self.target.xx>rightBorder -self.target.width)then
            self.tx=self.tx-1
        end
        if(self.target.yy>bottomBorder -self.target.height)then
            self.ty=self.ty-1
        end
        if(self.target.yy<topBorder)then
            self.ty=self.ty+1
        end
        if clamp==true then
            local hMax=math.max((self.map.height*self.map.tileheight*self.scale-love.graphics.getHeight())/self.scale)
            local wMax=math.max((self.map.width*self.map.tilewidth*self.scale-love.graphics.getWidth())/self.scale)
            self.ty=math.min(0,self.ty)
            self.tx=math.min(0,self.tx)
            self.ty=math.max(-hMax,self.ty)
            self.tx=math.max(-wMax,self.tx)
        end
        love.graphics.scale(self.scale)
        love.graphics.translate(self.tx,self.ty)
    end

    function camera:absolutePosition(xx,yy)
       return {
            x=(xx-self.tx)/self.scale,
            y=(yy-self.ty)/self.scale, 
        }
    end
    return camera
end

return createCamera