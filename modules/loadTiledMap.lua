--https://www.youtube.com/watch?v=yKk-rODDD8Y

function loadTiledMap(map,spriteSheet)
    local map= map

    map.quads={}
    map.tileset=map.tilesets[1]
    map.spriteSheet=spriteSheet

    function map:drawTiles()
        for i, layer in ipairs(self.layers) do
            if layer.type=="tilelayer" then
                for y = 0, layer.height - 1 do
                    for x = 0, layer.width - 1 do
                        local index = y * layer.width + x + 1
                        local tileId = layer.data[index]

                        if tileId ~= 0 then
                            local quad = self.spriteSheet.quads[tileId]
                            local xx = x * self.spriteSheet.frameWidth
                            local yy = y * self.spriteSheet.frameHeight
                            
                            self.spriteSheet:draw(tileId,xx,yy)
                        end
                    end
                end
            end
        end

    end

    function map:isSolid(x,y)
        if x < 0 or y < 0 or x >= self.width or y >= self.height then
            return true
        end
        for i,layer in ipairs(self.layers) do
            if layer.properties.solid then
                local index= y * layer.width + x + 1
                if layer.data[index]~=0 then
                    return true
                end
            end
        end
        return false
    end

    function map:getObject(type)
        local retour ={}
        for i, layer in ipairs(self.layers) do
            if layer.type=="objectgroup" then
                for j,object in ipairs(layer.objects) do
                    if object.type==type then
                        table.insert(retour,object)
                    end
                end
            end
        end
        if #retour == 0 then
            return nil
        end
        return retour
    end
    
    return map
end