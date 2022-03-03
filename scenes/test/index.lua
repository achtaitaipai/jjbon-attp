--load specifics modules here
local scene={}
--load assets here

function scene:update(dt)
end

function scene:draw()
    love.graphics.setColor(1, 0, 0)
	love.graphics.circle("fill", 50, 50, 20)
end

function scene:keyPressed(key)
end
return scene
