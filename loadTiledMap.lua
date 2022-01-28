--https://www.youtube.com/watch?v=yKk-rODDD8Y

function loadTiledMap(path,spriteSheet)
    local map= require(path)

    map.quads={}
    map.tileset=map.tilesets[1]
    map.spriteSheet=spriteSheet

    function map:drawTiles()
        for i, layer in ipairs(self.layers) do
            if layer.type=="tilelayer" then
                for y = 0, layer.height - 1 do
                    for x = 0, layer.width - 1 do
                        local index = (x + y * layer.width) + 1
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
    return map
end