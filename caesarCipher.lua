local caesar = {}

function caesar.getKey(utils, ct)
    
    local bestScore = utils.monogramScore(ct)
    local bestDec = ct
    local bestkey = 0
    
    for i = 1, 25 do
        ct = caesar.solveWithKey("1", ct)
        print(ct)
        local thisScore = utils.monogramScore(ct)
        if thisScore > bestScore then
            print(ct)
            bestScore = thisScore
            bestDec = ct
            bestKey = i
        end
    end
    return tostring(bestKey)
end

function caesar.solveWithKey(key, ct)
    local dec = ""
    local keyNum = tonumber(key)
    print(keyNum)
    for c in ct:gmatch"." do
        local newChar = string.byte(c) + keyNum
        if newChar > string.byte("0") then
            newChar = newChar - 26
        end
        dec = dec .. string.char(newChar)
    end
    return dec
end

function caesar.crack(utils, ct)
    return caesar.solveWithKey(caesar.getKey(utils, ct), ct)
end

return caesar