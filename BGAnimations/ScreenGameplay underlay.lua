return Def.ActorFrame {
	Def.Sprite {
		Texture=THEME:GetPathG("", "Gameplay/LifeBarEmpty"),
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X - 4, 17)
			:valign(0):SetTextureFiltering(false)
		end
	},
	
	Def.Sprite {
		Texture=THEME:GetPathG("", "Gameplay/LifeBarFull"),
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X - 4, 17)
			:valign(0):SetTextureFiltering(false)
		end,
		LifeChangedMessageCommand=function(self, params)
			if params.Player == PLAYER_1 then
				local LifeAmount = params.LifeMeter:GetLife()
				
				self:cropleft(math.floor((1 - LifeAmount) * 30) / 30)
			end
		end
	},
	
	Def.Sprite {
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X + 64, 19)
			:halign(0):valign(0):SetTextureFiltering(false)
			
			if GAMESTATE:GetPlayerState(PLAYER_1):GetPlayerOptions("ModsLevel_Preferred"):FailSetting() == "FailType_Off" then
				self:Load(THEME:GetPathG("", "Gameplay/Free"))
			else
				self:Load(THEME:GetPathG("", "Gameplay/Arcade"))
			end
		end
	},
	
	Def.Sprite {
		Texture=THEME:GetPathG("", "Gameplay/ScoreLabel"),
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X - 73, SCREEN_BOTTOM - 42)
			:halign(1):valign(1):SetTextureFiltering(false)
		end
	},
	
	Def.BitmapText {
        Font="Score",
        InitCommand=function(self)
            self:xy(SCREEN_CENTER_X - 25, SCREEN_BOTTOM - 23)
			:halign(1):valign(1):SetTextureFiltering(false)
            :playcommand("Refresh")
        end,
        JudgmentMessageCommand=function(self) self:playcommand("Refresh") end,
        RefreshCommand=function(self)
            -- Let's give ourselves some time for our score module to properly calculate meanwhile
            self:stoptweening():sleep(0.1)
            
            local PSS = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)
            
			self:settext(string.format("%08d", PSS:GetScore()))
        end
    }
}