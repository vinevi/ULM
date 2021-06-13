local Element = require('ulm.element')
local Fonts = require('ulm.fonts')

local Text = Element:new()

Text.renderProc = mem.asmproc[[
	PUSH EBP
	MOV EBP, ESP
	MOV EDX, dword ptr [EBP+16]		; get argument 3 (font)
	PUSH 0x0
	PUSH 0x100
	PUSH 0x55cde0 					; target text buffer
	MOV ECX,dword ptr [0x004d50b8]	; set to game viewport
	PUSH 0x0
	MOV EAX, [EBP+8] 				; get argument 1 (offset Y)
	PUSH EAX 						; Offset Y
	MOV EAX, [EBP+12]				; get argument 2 (offset X)
	PUSH EAX 						; Offset X
	CALL absolute 0x00443210		; call create text box function
	MOV ESP, EBP					; return
	POP EBP
	RET
]]

Text.render = function(self)
	if(not self.font) then
		self.font = 'create'
	end

	Game.TextBuffer = self.text
	mem.call(self.renderProc, 0, self.y, self.x, mem.u4[Fonts[self.font]])
end

Text.new = function(self, text, x, y, font)
	o = {}
	setmetatable(o, self)
	self.__index = self
	o.text = text
	o.x = x
	o.y = y
	o.font = font
	return o
end

return Text