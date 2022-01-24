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
	
	LoadModule("Gameplay.Score.lua")(PLAYER_1),
}