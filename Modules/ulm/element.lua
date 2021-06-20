local Element = {}

Element.new = function(self, x, y)
	o = {}
	o.x = x
	o.y = y
	setmetatable(o, self)
	self.__index = self
	return o
end

return Element