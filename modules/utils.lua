function string.explode(str, div)
    assert(type(str) == "string" and type(div) == "string", "invalid arguments")
    local o = {}
    while true do
        local pos1,pos2 = str:find(div)
        if not pos1 then
            o[#o+1] = str
            break
        end
        o[#o+1],str = str:sub(1,pos1-1),str:sub(pos2+1)
    end
    return o
end

function string.splitByLength(str,maxLength)
    local arr = str.explode(str,' ')
    local txt=''
    local splitedTxt={}
    while #arr >= 1 do
        while #arr >= 1 and #(txt..arr[1])<=maxLength do
            txt=txt..table.remove(arr,1)..' '
        end
        txt=txt:sub(1, -2)
        table.insert( splitedTxt,txt)
        txt=""
    end
    
    return splitedTxt
   
end

function math.round(n)
    return math.floor(n+0.5)
end