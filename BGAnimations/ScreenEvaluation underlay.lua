return Def.ActorFrame {
	OnCommand=function(self)
		local PSS = STATSMAN:GetCurStageStats():GetPlayerStageStats(PLAYER_1)
		
		self:GetChild("Grade"):Load(THEME:GetPathG("", "Grades/" .. LoadModule("Score.Grade.lua")(PSS)))
		
		self:GetChild("Perfect"):settext(PSS:GetTapNoteScores("TapNoteScore_W1"))
		self:GetChild("Great"):settext(PSS:GetTapNoteScores("TapNoteScore_W2"))
		self:GetChild("Good"):settext(PSS:GetTapNoteScores("TapNoteScore_W3"))
		self:GetChild("Calory"):settext(math.floor(PSS:GetCaloriesBurned()))
		self:GetChild("Miss"):settext(PSS:GetTapNoteScores("TapNoteScore_Miss"))
		self:GetChild("MaxCombo"):settext(PSS:MaxCombo())
		
		self:GetChild("Score"):settext(string.format("%08d", PSS:GetScore()))
	end,
	
	Def.Quad {
		InitCommand=function(self)
			self:FullScreen():diffuse(Color.White)
		end
	},
	
	Def.Sprite {
		Texture=THEME:GetPathG("", "Evaluation"),
		InitCommand=function(self) 
			self:Center():SetTextureFiltering(false)
		end
	},
	
	Def.Sprite {
		Name="Grade",
		Texture=THEME:GetPathG("", "Grades/F"),
		InitCommand=function(self) 
			self:xy(SCREEN_CENTER_X - 56, SCREEN_BOTTOM - 56)
			:halign(1):valign(1):SetTextureFiltering(false)
		end
	},
	
	Def.BitmapText {
		Name="Perfect",
        Font="JudgeNumbers",
        InitCommand=function(self)
            self:xy(SCREEN_CENTER_X - 92, 56)
			:halign(0):valign(0):SetTextureFiltering(false)
        end
    },
	
	Def.BitmapText {
		Name="Great",
        Font="JudgeNumbers",
        InitCommand=function(self)
            self:xy(SCREEN_CENTER_X - 92, 80)
			:halign(0):valign(0):SetTextureFiltering(false)
        end
    },
	
	Def.BitmapText {
		Name="Good",
        Font="JudgeNumbers",
        InitCommand=function(self)
            self:xy(SCREEN_CENTER_X - 92, 104)
			:halign(0):valign(0):SetTextureFiltering(false)
        end
    },
	
	Def.BitmapText {
		Name="Calory",
        Font="JudgeNumbers",
        InitCommand=function(self)
            self:xy(SCREEN_CENTER_X - 92, 128)
			:halign(0):valign(0):SetTextureFiltering(false)
        end
    },
	
	Def.BitmapText {
		Name="Miss",
        Font="JudgeNumbers",
        InitCommand=function(self)
            self:xy(SCREEN_CENTER_X - 92, 152)
			:halign(0):valign(0):SetTextureFiltering(false)
        end
    },
	
	Def.BitmapText {
		Name="MaxCombo",
        Font="JudgeNumbers",
        InitCommand=function(self)
            self:xy(SCREEN_CENTER_X - 92, 176)
			:halign(0):valign(0):SetTextureFiltering(false)
        end
    },
	
	Def.BitmapText {
		Name="Score",
        Font="EvalScore",
        InitCommand=function(self)
            self:xy(SCREEN_CENTER_X - 54, SCREEN_BOTTOM - 18)
			:halign(1):valign(1):SetTextureFiltering(false)
        end
    }
}