function createSolidObjects(spriteSheet)
    local objects={
        list={}
    }
    local solids =_G.map:getObject("solid")
    for i,solid in ipairs(solids) do
        -- print(solid.properties.dialog)
        local object ={
            gridX= math.round(solid.x/_G.map.tilewidth),
            gridY= math.round(solid.y/_G.map.tileheight),
            dialog = solid.properties.dialog,
            frame=solid.gid
        }
        function object:draw()
            spriteSheet:draw(self.frame,self.gridX*_G.map.tilewidth,self.gridY*_G.map.tilewidth)
        end

        function object:collidePlayer()
            if self.dialog ~= nil then
                _G.dialogBox:open(self.dialog)
            end
        end

        table.insert( objects.list, object )
    end

    function objects:draw()
        for i,object in ipairs(objects.list) do
            object:draw()
        end
    end

    function objects:isSolid(x,y)
        for i,object in ipairs(objects.list) do
            if object.gridX==x and object.gridY==y then
                object:collidePlayer()
                return true
            end
        end
        return false
    end
    return objects
end