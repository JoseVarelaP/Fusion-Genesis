local function InputHandler(event)
	if not event.PlayerNumber then return end
	if event.type ~= "InputEventType_FirstPress" then return end
	
	if event.button == "UpLeft" then
		GAMESTATE:ApplyGameCommand("mod,FailOff")
		SOUND:PlayOnce(THEME:GetPathS("", "Switch"))
		SCREENMAN:set_input_redirected(PLAYER_1, false)
		SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen")
	elseif event.button == "UpRight" then
		GAMESTATE:ApplyGameCommand("mod,FailImmediate")
		SOUND:PlayOnce(THEME:GetPathS("", "Switch"))
		SCREENMAN:set_input_redirected(PLAYER_1, false)
		SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen")
	elseif event.button == "Back" then
		SCREENMAN:set_input_redirected(PLAYER_1, false)
		SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToPrevScreen")
	end
end

return Def.ActorFrame {
	OnCommand=function(self)
		GAMESTATE:JoinPlayer(PLAYER_1)
		SCREENMAN:set_input_redirected(PLAYER_1, true)
		SCREENMAN:GetTopScreen():AddInputCallback(InputHandler)
	end,
	
	OffCommand=function(self)
		SCREENMAN:set_input_redirected(PLAYER_1, false)
	end,
   
	Def.Quad {
		InitCommand=function(self)
			self:FullScreen():diffuse(Color.White)
		end
	},
	
	Def.Sprite {
		Frames=Sprite.LinearFrames(149, 4),
		Texture=THEME:GetPathG("", "TitleScreen/Background"),
		InitCommand=function(self)
			self:Center():SetTextureFiltering(false)
		end
	},
	
	Def.Sprite {
		Texture=THEME:GetPathG("", "TitleScreen/Logo"),
		InitCommand=function(self)
			self:Center():SetTextureFiltering(false)
		end
	},
	
	Def.Sprite {
		Frames=Sprite.LinearFrames(22, 1.2),
		Texture=THEME:GetPathG("", "TitleScreen/MaleDancer"),
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X - 55, SCREEN_BOTTOM - 41)
			:halign(1):valign(1):SetTextureFiltering(false)
		end
	},
	
	Def.Sprite {
		Frames=Sprite.LinearFrames(29, 1.5),
		Texture=THEME:GetPathG("", "TitleScreen/FemaleDancer"),
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X + 48, SCREEN_BOTTOM - 40)
			:halign(0):valign(1):SetTextureFiltering(false)
		end
	},
	
	Def.Sprite {
		Texture=THEME:GetPathG("", "TitleScreen/1st2ndStripe"),
		InitCommand=function(self)
			self:cropto(30, 224)
			:xy(SCREEN_CENTER_X - 136, SCREEN_CENTER_Y)
			:texcoordvelocity(0, -0.233):SetTextureFiltering(false)
		end
	},
	
	Def.Sprite {
		Texture=THEME:GetPathG("", "TitleScreen/OBGStripe"),
		InitCommand=function(self)
			self:cropto(30, 224)
			:xy(SCREEN_CENTER_X + 136, SCREEN_CENTER_Y)
			:texcoordvelocity(0, 0.233):SetTextureFiltering(false)
		end
	}
}