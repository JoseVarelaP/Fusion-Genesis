local t = Def.ActorFrame {}

for i = 1, 28 do
	t[#t+1] = Def.ActorFrame {
		Def.Sprite {
			Texture=THEME:GetPathG("", "StarBackground"),
			InitCommand=function(self)
				self:xy(SCREEN_CENTER_X, i * 8):valign(0):setstate(i - 1)
				:texcoordvelocity((i % 2 == 0 and 1 or -1) * (math.random() / 10), 0):SetTextureFiltering(false)
			end
		}
	}
end

return t