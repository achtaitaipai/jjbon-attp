--https://www.youtube.com/watch?v=yKk-rODDD8Y
function loadTiledMap(path)
    local map= require(path)

    map.quads={}
    map.tileset=map.tilesets[1]
    map.image=love.graphics.newImage('assets/'..map.tileset.image)

    for y=0,(map.tileset.imageheight/map.tileset.tileheight) -1 do
        for x=0,(map.tileset.imagewidth/map.tileset.tilewidth) -1 do
            local quad=love.graphics.newQuad(
                x*map.tileset.tilewidth,
                y*map.tileset.tileheight,
                map.tileset.tilewidth,
                map.tileset.tileheight,
                map.tileset.imagewidth,    
                map.tileset.imageheight   
            )
            table.insert( map.quads,quad)
        end
    end


    function map:drawTiles()
        for i, layer in ipairs(self.layers) do
            if layer.type=="tilelayer" then
                for y = 0, layer.height - 1 do
                    for x = 0, layer.width - 1 do
                        local index = (x + y * layer.width) + 1
                        local tileId = layer.data[index]

                        if tileId ~= 0 then
                            local quad = self.quads[tileId]
                            local xx = x * self.tileset.tilewidth
                            local yy = y * self.tileset.tileheight
                            
                            love.graphics.draw(
                                self.image,
                                quad,
                                xx,
                                yy
                            )
                        end
                    end
                end
            end
        end

    end
    return map
end