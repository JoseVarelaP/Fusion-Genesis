local Songs = {}
local AllSongs = GAMESTATE:GetPreferredDifficulty(PLAYER_1) == "Difficulty_Edit"

for Song in ivalues(AllSongs and SONGMAN:GetAllSongs() or SONGMAN:GetSongsInGroup("PIU Genesis")) do
	if Song:GetOneSteps("StepsType_Pump_Single", GAMESTATE:GetPreferredDifficulty(PLAYER_1)) then
		Songs[#Songs+1] = Song
	end
end

local Index1 = 1
local Index2 = Index1 + 1
if Index2 > #Songs then Index2 = 1 end
local CurrentSongs = { Songs[Index1], Songs[Index2] }
local Select = false

local function InputHandler(event)
	if not event.PlayerNumber then return end
	if event.type == "InputEventType_Release" then return end
	
	if event.button == "UpLeft" then
		if Select == 1 then
			SOUND:PlayOnce(THEME:GetPathS("", "Enter"))
			SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen")
		else
			SOUND:PlayOnce(THEME:GetPathS("", "Switch"))
			GAMESTATE:SetCurrentSong(CurrentSongs[1])
			GAMESTATE:SetCurrentSteps(PLAYER_1, CurrentSongs[1]:GetOneSteps("StepsType_Pump_Single", GAMESTATE:GetPreferredDifficulty(PLAYER_1)))
			Select = 1
		end
	elseif event.button == "UpRight" then
		if Select == 2 then
			SOUND:PlayOnce(THEME:GetPathS("", "Enter"))
			SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToNextScreen")
		else
			SOUND:PlayOnce(THEME:GetPathS("", "Switch"))
			GAMESTATE:SetCurrentSong(CurrentSongs[2])
			GAMESTATE:SetCurrentSteps(PLAYER_1, CurrentSongs[2]:GetOneSteps("StepsType_Pump_Single", GAMESTATE:GetPreferredDifficulty(PLAYER_1)))
			Select = 2
		end
	elseif event.button == "DownLeft" then
		
		SOUND:PlayOnce(THEME:GetPathS("", "Start"))
		Index2 = Index1 - 1
		if Index2 < 1 then Index2 = #Songs end
		Index1 = Index2 - 1
		if Index1 < 1 then Index1 = #Songs end
		CurrentSongs = { Songs[Index1], Songs[Index2] }
		Select = false
		
	elseif event.button == "DownRight" then
		
		SOUND:PlayOnce(THEME:GetPathS("", "Start"))
		Index1 = Index2 + 1
		if Index1 > #Songs then Index1 = 1 end
		Index2 = Index1 + 1
		if Index2 > #Songs then Index2 = 1 end
		CurrentSongs = { Songs[Index1], Songs[Index2] }
		Select = false
		
	elseif event.button == "Back" then
		SCREENMAN:set_input_redirected(PLAYER_1, false)
		SCREENMAN:GetTopScreen():StartTransitioningScreen("SM_GoToPrevScreen")
	end
	
	MESSAGEMAN:Broadcast("UpdateMusic")
end

return Def.ActorFrame {
	OnCommand=function(self)
		GAMESTATE:SetCurrentPlayMode("PlayMode_Regular")
		GAMESTATE:SetCurrentStyle("single")
		SCREENMAN:GetTopScreen():AddInputCallback(InputHandler)

		self:RunCommandsRecursively(function(self)
			if self.SetTextureFiltering then self:SetTextureFiltering(false) end
		end)
	end,
	
	Def.Quad {
		InitCommand=function(self)
			self:FullScreen():diffuse(color("#eeaacc"))
		end
	},
	
	LoadActor("StarBackground.lua"),

	Def.Sprite {
		Texture=THEME:GetPathG("", "SelectMusic/Header"),
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X, 8):valign(0)
		end
	},
	
	Def.Sprite {
		Texture=THEME:GetPathG("", "SelectMusic/BannerMask"),
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X - 18, 53):align(1,0)
			:MaskSource()
		end
	},
	
	Def.Sprite {
		Texture=CurrentSongs[1]:GetBannerPath(),
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X - 18, 53):align(1,0):zoomto(108, 74)
			:MaskDest():ztestmode("ZTestMode_WriteOnFail")
		end,
		UpdateMusicMessageCommand=function(self)
			self:Load(CurrentSongs[1]:GetBannerPath()):zoomto(108, 74)
		end,
	},
	
	Def.Sprite {
		Frames=Sprite.LinearFrames(8, 0.75),
		Texture=THEME:GetPathG("", "SelectMusic/Highlight"),
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X - 12, 47):align(1,0)
			:visible(false)
		end,
		UpdateMusicMessageCommand=function(self) self:setstate(0):visible(Select == 1) end
	},
	
	Def.Sprite {
		Texture=THEME:GetPathG("", "SelectMusic/BannerMask"),
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X + 26, 52):align(0,0)
			:MaskSource()
		end
	},
	
	Def.Sprite {
		Texture=CurrentSongs[2]:GetBannerPath(),
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X + 26, 52):align(0,0):zoomto(108, 74)
			:MaskDest():ztestmode("ZTestMode_WriteOnFail")
		end,
		UpdateMusicMessageCommand=function(self)
			self:Load(CurrentSongs[2]:GetBannerPath()):zoomto(108, 74)
		end,
	},
	
	Def.Sprite {
		Frames=Sprite.LinearFrames(8, 0.75),
		Texture=THEME:GetPathG("", "SelectMusic/Highlight"),
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X + 20, 46):align(0,0)
			:visible(false)
		end,
		UpdateMusicMessageCommand=function(self) self:setstate(0):visible(Select == 2) end
	},
	
	Def.Sprite {
		Texture=THEME:GetPathG("", "SelectMusic/ShiftLeft"),
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X - 114, SCREEN_BOTTOM - 30):align(0,1)
		end
	},
	
	Def.Sprite {
		Texture=THEME:GetPathG("", "SelectMusic/ShiftRight"),
		InitCommand=function(self)
			self:xy(SCREEN_CENTER_X + 126, SCREEN_BOTTOM - 30):align(1,1)
		end
	},
}