return function(PlayerScore)
    local Perfects 	= PlayerScore:GetTapNoteScores("TapNoteScore_W1")
    local Greats 	= PlayerScore:GetTapNoteScores("TapNoteScore_W2")
    local Goods 	= PlayerScore:GetTapNoteScores("TapNoteScore_W3")
    local Misses 	= PlayerScore:GetTapNoteScores("TapNoteScore_Miss") +
                      PlayerScore:GetTapNoteScores("TapNoteScore_CheckpointMiss")
    local MaxCombo	= PlayerScore:MaxCombo()  
    local FailGrade = PlayerScore:GetGrade()

    local GradeLetter = "F"
    local TotalNotes = Perfects + Greats + Goods + Misses
    local PlayerAccuracy = (Perfects * 1 + Greats * 0.75 + Goods * 0.5 + MaxCombo * 0.05) / TotalNotes
    
	if FailGrade ~= "Grade_Failed" then
		if PlayerAccuracy >= 0.7 then
			GradeLetter = "A"
		elseif PlayerAccuracy >= 0.65 then
			GradeLetter = "B"
		elseif PlayerAccuracy >= 0.60 then
			GradeLetter = "C"
		elseif PlayerAccuracy >= 0.55 then
			GradeLetter = "D"
		elseif PlayerAccuracy >= 0.50 then
			GradeLetter = "E"
		end
	end
    
    return GradeLetter
end