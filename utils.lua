math.randomseed(os.time())
local utils = {}

utils.alphabet = {"B","C","D","E","F","G","H","I","J","K","L","M","N",
  "O","P","Q","R","S","T","U","V","W","X","Y","Z"}
utils.alphabet[0] = "A"

utils.alphanum = {}
for i = 0, #utils.alphabet do
  utils.alphanum[utils.alphabet[i]] = i
end

utils.monograms = {}
local monogramLines = io.lines("assets/english_monograms.txt")
for line in monogramLines do
  utils.monograms[line] = math.log10(tonumber(monogramLines()))
end

utils.quadgrams = {}
local quadgramLines = io.lines("assets/english_quadgrams.txt")
for line in quadgramLines do
  utils.quadgrams[line] = math.log10(tonumber(quadgramLines()))
end
utils.quadgramDefault = math.log10(1)

function utils.processText(t)
  return t:gsub('%W',''):upper()
end

function utils.monogramScore(t)
  t = utils.processText(t)
  local fitness = 0
  for c in t:gmatch"." do
    fitness = fitness + utils.monograms[c]
  end
  return fitness
end

function utils.quadgramScore(t)
  t = utils.processText(t)
  local fitness = 0
  for c = 1, #t - 3 do
    local thisQuad = t:sub(c, c) .. t:sub(c+1, c+1) .. t:sub(c+2, c+2) .. t:sub(c+3, c+3)
    if not pcall(function() fitness = fitness + utils.quadgrams[thisQuad] end) then
     fitness = fitness + utils.quadgramDefault
    end
  end
  return fitness
end

function utils.arrayShuffle(tbl)
  local size = #tbl
  for i = size, 1, -1 do
    local rand = math.random(size)
    tbl[i], tbl[rand] = tbl[rand], tbl[i]
  end
  return tbl
end

function utils.swapTwoInString(a)
  x = math.random(1, #a)
  y = math.random(1, #a)
  tempx = a:sub(x, x)
  tempy = a:sub(y, y)
  local newA = ""
  for c in a:gmatch"." do
    if c == tempx then
      newA = newA .. tempy
    elseif c == tempy then
      newA = newA .. tempx
    else
      newA = newA .. c
    end
  end
  return newA
end

return utils
