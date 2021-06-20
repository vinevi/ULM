local Canvas = {}

Canvas.shouldRender = function(self)
	if(self.type == 'house') then
		return const.HouseScreens[self.screen] == Game.HouseScreen
	elseif(self.type == 'char') then
		return const.CharScreens[self.screen] == Game.CurrentCharScreen
	elseif(self.type == 'game') then
		return const.Screens[self.screen] == Game.CurrentScreen
	end
	return false
end

Canvas.init = function(self)

	mem.autohook(0x00435322, function()
		for key, element in pairs(self.elements) do
			if(element.render and self:shouldRender() == true) then
				element:render()
			end
		end
	end)
end

Canvas.mount = function(self, element)
	table.insert(self.elements, element)
end

Canvas.unmount = function(self, removeElement)
	for key, element in pairs(self.elements) do
		if(element == removeElement) then
			self.elements[key] = nil
		end
	end
end

Canvas.new = function(self, type, screen)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.elements = {}
	o.type = type or 'game' -- game / char / house
	o.screen = screen or 'Game' -- subtype from ConstAndBits.lua
	o:init()
	return o
end


return Canvas