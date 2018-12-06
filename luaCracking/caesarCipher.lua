local caesar = {}

function caesar.getKey(utils, ct)
    ct = utils.processText(ct)
    
    local bestScore = utils.monogramScore(ct)
    local bestDec = ct
    local bestKey = 0
    
    for i = 1, 25 do
        local thisDec = caesar.solveWithKey(utils, tonumber(i), ct)
        local thisScore = utils.monogramScore(thisDec)
        if thisScore > bestScore then
            bestScore = thisScore
            bestDec = ct
            bestKey = i
        end
    end
    
    return tostring(bestKey)
end

function caesar.solveWithKey(utils, key, ct)
    ct = utils.processText(ct)
    local dec = ""
    local newDec = ""
    for i = 1, tonumber(key) do
        for c in ct:gmatch"." do
            dec = dec .. utils.alphabet[(utils.alphanum[c] + 1) % 26]
        end
        ct = dec
        dec = ""
    end
    return ct
end

function caesar.crack(utils, ct)
    return caesar.solveWithKey(utils, caesar.getKey(utils, ct), ct)
end

return caesar