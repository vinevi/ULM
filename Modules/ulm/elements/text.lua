local Element = require('ulm.element')
local Fonts = require('ulm.fonts')

local Text = {}

function RGB16(r, g, b)
	return r:And(248)*256 + g:And(252)*8 + math.floor(b/8)
end

Text.renderProc = mem.asmproc[[
	PUSH EBP
	MOV EBP, ESP
	MOV EDX, dword ptr [EBP+16]		; get argument 3 (font)
	PUSH 0x55cde0 					; target text buffer
	MOV ECX,dword ptr [0x004d50b8]	; set to game viewport
	MOV EAX, [EBP+20]
	PUSH EAX
	MOV EAX, [EBP+8] 				; get argument 1 (offset Y)
	PUSH EAX 						; Offset Y
	MOV EAX, [EBP+12]				; get argument 2 (offset X)
	PUSH EAX 						; Offset X
	CALL absolute 0x004435f0		; call create text box function
	MOV ESP, EBP					; return
	POP EBP
	RET
]]

Text.render = function(self)
	local font = mem.u4[Fonts[self.font]] or 'create'
	Game.TextBuffer = self.text
	mem.call(self.renderProc, 0, self.y, self.x, font, self.color)
end

Text.new = function(self, text, x, y, font, color)
	o = Element:new(x, y)
	setmetatable(o, self)
	self.__index = self
	o.color = RGB16(0,0,255)
	o.text = text
	o.font = font
	
	return o
end

return Text