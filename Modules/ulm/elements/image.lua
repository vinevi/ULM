local Element = require('ulm.element')

local Image = {}

Image.render = function(self)
	Game.Screen:Draw(self.x, self.y, self.image)
end

Image.new = function(self, image, x, y)
	o = Element:new(x, y)
	setmetatable(o, self)
	self.__index = self
	o.image = image
	return o
end

return Image