function loadTiledMap(map,spriteSheet)
    local map= map

    map.quads={}
    map.tileset=map.tilesets[1]
    map.spriteSheet=spriteSheet


    for i, layer in ipairs(map.layers) do
        if layer.type=="tilelayer" then
            for y = 0, layer.height - 1 do
                for x = 0, layer.width - 1 do
                    local index = y * layer.width + x + 1
                    local tileId = layer.data[index]
                    local tile ={
                        id=tileId
                    }

                    for i=1,#map.tileset.tiles do
                        if map.tileset.tiles[i].id == tileId - 1 then
                            local  frames = {}
                            for i,f in ipairs(map.tileset.tiles[i].animation) do
                                table.insert(frames,f.tileid + 1)
                            end
                            local fps = 1000 /(map.tileset.tiles[i].animation[1].duration)
                            tile.anim=createAnim(map.spriteSheet,frames,fps)
                            tile.anim:play()
                        end
                    end

                    function tile:draw()
                        if tileId ~= 0 then
                            local xx = x * map.spriteSheet.frameWidth
                            local yy = y * map.spriteSheet.frameHeight
                            if self.anim == nil then
                                map.spriteSheet:draw(tileId,xx,yy)
                            else
                                tile.anim:draw(xx,yy)
                            end
                            
                        end
                    end

                    layer.data[index]=tile
                end
            end
        end
    end

    function map:drawTiles()
        for i, layer in ipairs(self.layers) do
            if layer.type=="tilelayer" then
                for index = 1, #layer.data do
                    local tileId = layer.data[index].id
                    layer.data[index]:draw()
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
                if layer.data[index].id~=0 then
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
                        local obj = object
                        obj.y = obj.y - map.spriteSheet.frameHeight
                        --Tiled export with Y starting to 1 tile and x starting to 0
                        table.insert(retour,obj)
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