function createSolidObjects(spriteSheet,map,dialogBox)
    local objects={
        list={}
    }
    local solids =map:getObject("solid")
    for i,solid in ipairs(solids) do
        local object ={
            gridX= math.round(solid.x/map.tilewidth),
            gridY= math.round(solid.y/map.tileheight),
            dialog = solid.properties.dialog,
            sprite=solid.gid,
            anim=solid.anim,
            map=map,
            dialogBox=dialogBox
        }
        function object:draw()
            if self.anim ~= nil then
                self.anim:draw(self.gridX*self.map.tilewidth,self.gridY*self.map.tilewidth)
            else
                spriteSheet:draw(self.sprite,self.gridX*self.map.tilewidth,self.gridY*self.map.tilewidth)
            end
        end

        function object:collidePlayer()
            if self.dialog ~= nil then
                self.dialogBox:open(self.dialog)
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

return createSolidObjects