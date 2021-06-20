ulm = require('ulm.main')
ulm:init()

canvas = ulm.Canvas:new('game')
local color = RGB(0, 0, 0)
text = ulm.Elements.Text:new('test', 10, 10, 'smallnum', color)
canvas:mount(text)

textb = ulm.Elements.Text:new('test b', 10, 40, 'smallnum')
canvas:mount(textb)

image = ulm.Elements.Image:new('apple', 15, 100)
canvas:mount(image)