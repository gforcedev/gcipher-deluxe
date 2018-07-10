local monoSub = {}

function monoSub.getKey(utils, ct)
    ct = utils.processText(ct)
    local alphabetToShuffle = utils.alphabet
    table.insert(alphabetToShuffle, "A")
    local randomKeyArray = utils.arrayShuffle(alphabetToShuffle)
    local parentKey = ""
    for i,v in ipairs(randomKeyArray) do
        parentKey = parentKey .. v
    end
    
    local count = 0
    local bestDec = monoSub.solveWithKey(utils, parentKey, ct)
    local bestScore = utils.quadgramScore(bestDec)
    while count < 1000 do
        local newKey = utils.swapTwoInString(parentKey)
        local thisDec = monoSub.solveWithKey(utils, newKey, ct)
        local thisScore = utils.quadgramScore(thisDec)
        if thisScore > bestScore then
            parentKey = newKey
            bestDec = thisDec
            bestScore = thisScore
            count = 0
        end
        count = count + 1
    end
    return parentKey
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