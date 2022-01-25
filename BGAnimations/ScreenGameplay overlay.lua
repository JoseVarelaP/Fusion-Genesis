return Def.ActorFrame {
	Def.BitmapText {
		Font="Score",
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X - 25, SCREEN_BOTTOM - 23)
			:halign(1):valign(1):SetTextureFiltering(false)
			:settext(string.format("%08d", 0))
		end,
		PIUScoreMessageCommand=function(self,params)
			-- Let's give ourselves some time for our score module to properly calculate meanwhile
			self:stoptweening():sleep(0.1)
			
			--local PSS = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)
			self:settext(string.format("%08d", params.Score))
		end
	}
}