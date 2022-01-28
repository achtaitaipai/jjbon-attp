function createAnim(spriteSheet,frameList,fps,flip,pauseFrame)
    local anim={
        spriteSheet=spriteSheet,
        list=frameList,
        playing=false,
        frame=1,
        fps=fps or 5,
        flip=flip or false,
        pauseFrame=pauseFrame,
        time=0
    }

    function anim:play(frame)
        self.playing=true
        self.frame=frame or 1
        self.time=love.timer.getTime()+1/self.fps
    end

    function anim:pause()
        self.playing=false
        self.frame=self.pauseFrame or self.frame
    end

    function anim:draw(x,y)
        if self.playing==true and love.timer.getTime() > self.time then
            self.time=love.timer.getTime()+1/self.fps
            self.frame=self.frame>=#self.list and 1 or self.frame+1
        end
        local img=self.list[self.frame]
        self.spriteSheet:draw(img,x,y,self.flip)
    end


    return anim
end