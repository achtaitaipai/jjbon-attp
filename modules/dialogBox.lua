function createDialogBox(width,height,margin,lengthLines,numberOfLines,scale)
    local dialogBox = {
        width=width,
        height=height,
        margin=margin,
        scale=scale or 2,
        lengthLines= lengthLines,
        numberOfLines=numberOfLines,
        stroke=2,
        active=false,
        xR=(love.graphics.getWidth()-(width+margin))*0.5,
        yR=love.graphics.getHeight()-(height+margin*3),
        xT=(love.graphics.getWidth()-(width))*0.5,
        yT=love.graphics.getHeight()-(height+margin*2),
        txt="",
        index=1,
        keyPressed=false,
        delay=0.05,
        time=0,
        charIndex=1,
        txtShow="",
    }

    function dialogBox:draw()
        if self.active then
            self:animText()
            love.graphics.push()
            love.graphics.scale(self.scale)
            love.graphics.translate(love.graphics.getWidth()*(0.5/self.scale),love.graphics.getWidth()/self.scale -(self.height+self.margin*2))
            love.graphics.setColor(0,0,0,1)
            love.graphics.setLineWidth(self.stroke)
            love.graphics.rectangle(
                "fill",
                -(self.width+self.margin*2)/2,
                -(self.height+self.margin*2)/2,
                self.width+self.margin*2,
                self.height+self.margin*2
            )
            love.graphics.setColor(255,255,255,1)
            love.graphics.rectangle(
                "line",
                -(self.width+self.margin*2)/2,
                -(self.height+self.margin*2)/2,
                self.width+self.margin*2,
                self.height+self.margin*2
            )
            love.graphics.printf(
                self.txtShow,
                -self.width/2,
                -self.height/2,
                self.width,
                "left")
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

    function dialogBox:open(txt)
        self.txt={}
        self.active=true
        self.index=1
        self.charIndex=1
        self.time=0
        self.txtShow=""

        local txtArr = string.splitByLength(txt,self.lengthLines)
        for i=0, math.floor(#txtArr / self.numberOfLines) do
            local txt = txtArr[2 * i +1] or ''
            for j=1,numberOfLines - 1 do
                if( txtArr[2 * i +1 + j]) then
                    txt = txt..'\n'.. txtArr[2 * i +1 + j] or ''
                end
            end
            if txt ~="" then
                table.insert( self.txt, txt )
            end
            
        end
    end
    return dialogBox
end