local monoSub = {}

function monoSub.makeKey(t)
    local s = ""
    for i,v in ipairs(t) do
        s = s .. t[i]
    end
    return s
end

function monoSub.getKey(utils, ct)
    ct = utils.processText(ct)
    if string.len(ct) > 500 then ct = string.sub(ct, 0, 500) end
    
    local bestScore = -math.huge
    local bestKey = utils.shuffle({"A", "B","C","D","E","F","G","H","I","J","K","L","M","N",
  "O","P","Q","R","S","T","U","V","W","X","Y","Z"})
    
    local count = 0
    
    while count < 1000 do
        --swap 2 chars in the key
        local i = math.random(1, 26)
        local j = math.random(1, 26)
        local thisKey = utils.copy(bestKey)
        local temp = thisKey[i]
        thisKey[i] = thisKey[j]
        thisKey[j] = temp
        
        local thisScore = utils.quadgramScore(monoSub.solveWithKey(utils, monoSub.makeKey(thisKey), ct))
        if thisScore > bestScore then
            bestScore = thisScore
            bestKey = thisKey
            count = 0
        else
            count = count + 1
        end
    end
    return monoSub.makeKey(bestKey)
end

function monoSub.solveWithKey(utils, key, ct)
    ct = utils.processText(ct)
    local dec = ""
    for c in ct:gmatch"." do
        dec = dec .. key:sub(utils.alphanum[c] + 1, utils.alphanum[c] + 1)
    end
    return dec
end

function monoSub.crack(utils, ct)
    return monoSub.solveWithKey(utils, monoSub.getKey(utils, ct), ct)
end

return monoSub