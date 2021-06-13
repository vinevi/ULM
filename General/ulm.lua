ulm = require('ulm.main')
ulm:init()

canvas = ulm.Canvas:new('game')
text = ulm.Elements.Text:new('test', 10, 10, 'smallnum')
canvas:mount(text)

textb = ulm.Elements.Text:new('test b', 10, 40, 'smallnum')
canvas:mount(textb)