-- print('loading')
local utils = require('luaCracking/utils')
-- print('Loaded')

local ciphers = {}
ciphers.caesar = require('luaCracking/caesarCipher')
ciphers.monosub = require('luaCracking/monoalphabeticSubstitutionCipher')
ciphers.vigenere = require('luaCracking/vigenereCipher')


while true do
    local arguments = io.read()
    -- format is cipher,ciphertext[,key]
    
    local argTable = {}
    
    for s in string.gmatch(arguments, '([^,]+)') do
        table.insert(argTable, s)
    end
    
    io.write(ciphers[argTable[1]].crack(utils, string.upper(argTable[2])))
    io.flush()
end