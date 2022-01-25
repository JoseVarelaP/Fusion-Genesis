return Def.ActorFrame {
	Def.BitmapText {
		Font="Score",
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X - 25, SCREEN_BOTTOM - 23)
			:halign(1):valign(1):SetTextureFiltering(false)
		end,
		PIUScoreMessageCommand=function(self,params)
			self:settext(string.format("%08d", params.Score))
		end
	}
}