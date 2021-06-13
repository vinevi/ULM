local Canvas = {}

Canvas.viewports = {
	game = 0x004352ba,
}

Canvas.init = function(self)
	mem.autohook(self.viewport, function()
		for key, element in pairs(self.elements) do
			if(element.render) then
				element:render()
			end
		  end
	end)
end

Canvas.mount = function(self, element)
	table.insert(self.elements, element)
end

Canvas.new = function(self, viewport)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.elements = {}
	o.viewport = o.viewports[viewport]
	o:init()
	return o
end


return Canvas