function createDialogBox(width,height,margin)
    local dialogBox = {
        width=width,
        height=height,
        margin=margin,
        stroke=2,
        active=true,
        xR=(love.graphics.getWidth()-(width+margin))*0.5,
        yR=love.graphics.getHeight()-(height+margin*3),
        xT=(love.graphics.getWidth()-(width))*0.5,
        yT=love.graphics.getHeight()-(height+margin*2),
        txt="bonjour comment ca*va !*je suis ravi de*l'apprendre",
        index=1,
        keyPressed=false,
        delay=0.05,
        time=0,
        charIndex=1,
        txtShow=""
    }
    local txtArr=string.explode(dialogBox.txt,'*')
    local txt={}
    for i=0, math.round(#txtArr/2)-1 do
        local txt1=txtArr[i*2+1] or ""
        local txt2=txtArr[i*2+2] or ""
        table.insert(txt,txt1..'\n'..txt2)
    end
    dialogBox.txt=txt

    function dialogBox:up()

        if love.keyboard.isDown('space') and self.keyPressed == false then
            self.keyPressed=true
        else
            self.keyPressed=false
        end
    end

    function dialogBox:draw()
        if self.active then
            self:animText()
            love.graphics.push()
            love.graphics.setColor(0,0,0,1)
            love.graphics.setLineWidth(self.stroke)
            love.graphics.rectangle(
                "fill",
                self.xR,
                self.yR,
                self.width+self.margin*2,
                self.height+self.margin*2
            )
            love.graphics.setColor(255,255,255,1)
            love.graphics.rectangle(
                "line",
                self.xR,
                self.yR,
                self.width+self.margin*2,
                self.height+self.margin*2
            )
            love.graphics.print(self.txtShow,self.xT,self.yT)
            love.graphics.pop()
        end

    end

    function dialogBox:animText()
        local txt =self.txt[self.index]
        local t = love.timer.getTime()

        if self.time<t and self.charIndex <= #txt then
            self.time=t+self.delay
            self.txtShow=txt:sub(0,self.charIndex)
            self.charIndex=self.charIndex+1
        end

    end

    function dialogBox:next()
        local txt =self.txt[self.index]
        if self.charIndex >= #txt then
            self.index=self.index+1
            self.time=0
            self.charIndex=1
            self.txtShow=""
            if self.index > #self.txt then
                self.index=1
                self.active=false
            end
        end
    end
    return dialogBox
end