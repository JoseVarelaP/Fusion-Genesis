local Select = false
local Speed = 1

-- Define the default options
GAMESTATE:ApplyGameCommand("mod,1x", PLAYER_1)
PREFSMAN:SetPreference("TimingWindowSecondsW1", 0.033)
PREFSMAN:SetPreference("TimingWindowSecondsW2", 0.049)
PREFSMAN:SetPreference("TimingWindowSecondsW3", 0.065)
PREFSMAN:SetPreference("TimingWindowSecondsW4", 0.065)
PREFSMAN:SetPreference("TimingWindowSecondsW5", 0.065)

local function InputHandler(event)
	if not event.PlayerNumber then return end
	if event.type ~= "InputEventType_FirstPress" then return end
	
	if event.button == "UpLeft" then
		if Select == 1 then
			SOUND:PlayOnce(THEME:GetPathS("", "Enter"))
			SCREENMAN:set_input_redirected(PLAYER_1, false)
			SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen")
		else
			SOUND:PlayOnce(THEME:GetPathS("", "Switch"))
			GAMESTATE:SetPreferredDifficulty(PLAYER_1, "Difficulty_Easy")
			Select = 1
		end
	elseif event.button == "UpRight" then
		if Select == 2 then
			SOUND:PlayOnce(THEME:GetPathS("", "Enter"))
			SCREENMAN:set_input_redirected(PLAYER_1, false)
			SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen")
		else
			SOUND:PlayOnce(THEME:GetPathS("", "Switch"))
			GAMESTATE:SetPreferredDifficulty(PLAYER_1, "Difficulty_Medium")
			Select = 2
		end
	elseif event.button == "DownLeft" then
		if Select == 3 then
			SOUND:PlayOnce(THEME:GetPathS("", "Enter"))
			SCREENMAN:set_input_redirected(PLAYER_1, false)
			SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen")
		else
			SOUND:PlayOnce(THEME:GetPathS("", "Switch"))
			GAMESTATE:SetPreferredDifficulty(PLAYER_1, "Difficulty_Hard")
			Select = 3
		end
	elseif event.button == "DownRight" then
		SOUND:PlayOnce(THEME:GetPathS("", "Start"))
		
		Speed = Speed + 0.5
		if Speed > 2 then Speed = 1 end
		
		GAMESTATE:ApplyGameCommand("mod," .. Speed .. "x", PLAYER_1)
		Select = 4
	elseif event.button == "Back" then
		SCREENMAN:set_input_redirected(PLAYER_1, false)
		SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToPrevScreen")
	end
	
	MESSAGEMAN:Broadcast("UpdateMode")
end

return Def.ActorFrame {
	OnCommand=function(self)
		SCREENMAN:set_input_redirected(PLAYER_1, true)
		SCREENMAN:GetTopScreen():AddInputCallback(InputHandler)
	end,
	
	OffCommand=function(self)
		SCREENMAN:set_input_redirected(PLAYER_1, false)
	end,
	
	Def.Quad {
		InitCommand=function(self)
			self:FullScreen():diffuse(color("#eeaacc"))
		end
	},
	
	LoadActor("StarBackground.lua"),

	Def.Sprite {
		Texture=THEME:GetPathG("", "SelectMode/Header"),
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X, 8):valign(0)
			:SetTextureFiltering(false)
		end
	},
	
	Def.Sprite {
		Texture=THEME:GetPathG("", "SelectMode/Easy"),
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X - 130, 55):halign(0):valign(0)
			:SetTextureFiltering(false)
		end
	},
	
	Def.Sprite {
		Frames=Sprite.LinearFrames(8, 0.75),
		Texture=THEME:GetPathG("", "SelectMode/Highlight"),
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X - 136, 49):halign(0):valign(0)
			:SetTextureFiltering(false):visible(false)
		end,
		UpdateModeMessageCommand=function(self) self:setstate(0):visible(Select == 1) end
	},
	
	Def.Sprite {
		Texture=THEME:GetPathG("", "SelectMode/Hard"),
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X + 130, 55):halign(1):valign(0)
			:SetTextureFiltering(false)
		end
	},
	
	Def.Sprite {
		Frames=Sprite.LinearFrames(8, 0.75),
		Texture=THEME:GetPathG("", "SelectMode/Highlight"),
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X + 136, 49):halign(1):valign(0)
			:SetTextureFiltering(false):visible(false)
		end,
		UpdateModeMessageCommand=function(self) self:setstate(0):visible(Select == 2) end
	},
	
	Def.Sprite {
		Texture=THEME:GetPathG("", "SelectMode/Normal"),
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X - 130, SCREEN_BOTTOM - 28):halign(0):valign(1)
			:SetTextureFiltering(false)
		end
	},
	
	Def.Sprite {
		Frames=Sprite.LinearFrames(8, 0.75),
		Texture=THEME:GetPathG("", "SelectMode/Highlight"),
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X - 136, SCREEN_BOTTOM - 22):halign(0):valign(1)
			:SetTextureFiltering(false):visible(false)
		end,
		UpdateModeMessageCommand=function(self) self:setstate(0):visible(Select == 3) end
	},
	
	Def.Sprite {
		Texture=THEME:GetPathG("", "SelectMode/Learner"),
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X + 130, SCREEN_BOTTOM - 28):halign(1):valign(1)
			:SetTextureFiltering(false)
		end,
		UpdateModeMessageCommand=function(self)
			if Speed == 1 then
				self:Load(THEME:GetPathG("", "SelectMode/Learner"))
			elseif Speed == 1.5 then
				self:Load(THEME:GetPathG("", "SelectMode/Expert"))
			elseif Speed == 2 then
				self:Load(THEME:GetPathG("", "SelectMode/Master"))
			else
				self:Load(THEME:GetPathG("", "SelectMode/Learner"))
			end
		end,
	},
	
	Def.Sprite {
		Frames=Sprite.LinearFrames(8, 0.75),
		Texture=THEME:GetPathG("", "SelectMode/Highlight"),
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X + 136, SCREEN_BOTTOM - 22):halign(1):valign(1)
			:SetTextureFiltering(false):visible(false)
		end,
		UpdateModeMessageCommand=function(self) self:setstate(0):visible(Select == 4) end
	},
}