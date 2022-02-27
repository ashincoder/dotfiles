local heirline = require "heirline"

local Component1 = {}

local Component2 = {}

local statusline = {
   Component1,
   Component2,
}

heirline.setup { statusline }
