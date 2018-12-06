local caesar = require('luaCracking/caesarCipher')

local vigenere = {}


function vigenere.getKey(utils, ct)
end

function vigenere.solveWithKey(utils, key, ct)
end

function vigenere.crack(utils, ct)
    bestDec = caesar.crack(utils, ct)
    bestScore = utils.quadgramScore(bestDec)
    for keylength = 2, 20 do
        local strs = {}
        for i = 0, keylength - 1 do strs[i] = '' end
        local i = 0
        ct:gsub('.', function(c)
            strs[i % keylength] = strs[i % keylength] .. c
            i = i + 1
        end)
        -- print(keylength)
        -- for i = 0, #strs do print(strs[i]) end
        
        for i = 0, #strs do
            strs[i] = caesar.crack(utils, strs[i])
        end
        
        local dec = ''
        for i = 0, #ct do
            dec = dec .. strs[i % keylength]:sub(1, 1)
            strs[i % keylength] = strs[i % keylength]:sub(2)
        end
        
        local thisScore = utils.quadgramScore(dec)
        if thisScore > bestScore then
            bestDec = dec
            bestScore = thisScore
        end
    end
    return bestDec
end

return vigenere