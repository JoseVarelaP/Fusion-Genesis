local JCMDConv = {
	TapNoteScore_W1 = "W1Command",
	TapNoteScore_W2 = "W2Command",
	TapNoteScore_W3 = "W3Command",
	TapNoteScore_W4 = "W4Command",
	TapNoteScore_W5 = "W5Command",
	TapNoteScore_Miss = "MissCommand"
}

local TNSFrames = {
	TapNoteScore_W1 = 0,
	TapNoteScore_W2 = 1,
	TapNoteScore_W3 = 2,
	TapNoteScore_W4 = 3,
	TapNoteScore_W5 = 4,
	TapNoteScore_Miss = 5
}

local sPlayer = Var "Player"

-- Note that this does not really represent a CMD in lua.
-- This is grabbing the metric from the current theme.
local function GetJCMD(Type,JCMD)
	if Type == 1 then Type = "Judgment" else Type = "Protiming" end
	return THEME:GetMetric( Type, Type..JCMDConv[JCMD] )
end

return Def.ActorFrame {
	Def.Sprite {
		Name="Judgment",
		Texture=THEME:GetPathG("Judgment", "Normal"),
		InitCommand=function(self) self:pause():visible(false):SetTextureFiltering(false) end,
		OnCommand=THEME:GetMetric("Judgment","JudgmentOnCommand"),
		ResetCommand=function(self) self:finishtweening():stopeffect():visible(false) end
	},
	
	JudgmentMessageCommand=function(self, params)
		local Judg = self:GetChild("Judgment")
		if params.Player ~= sPlayer then return end
		if params.HoldNoteScore then return end
		if string.find(params.TapNoteScore, "Mine") then return end
		
		local iFrame = TNSFrames[params.TapNoteScore]

		if not iFrame then return end

		self:playcommand("Reset")

		Judg:visible(true)
		Judg:setstate(iFrame)
		GetJCMD(1, params.TapNoteScore)(Judg)
	end
}
