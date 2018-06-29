local utils = {}

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

function utils.processText(t)
  return t:gsub('%W',''):upper()
end

function utils.monogramScore(t)
  t = utils.processText(t)
  local fitness = 0
  for c in t:gmatch"%W" do
    fitness = fitness + utils.monograms[c]
  end
  return fitness
end

function utils.quadgramScore(t)
  t = utils.processText(t)
  local fitness = 0
  for c in t:gmatch"...." do
    fitness = fitness + utils.quadgrams[c]
  end
  return fitness
end

return utils
