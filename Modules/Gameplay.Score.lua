return function(Player)
	local function NumberOfElements(t)
		local count = 0
		if t then
			for index in pairs(t) do
				count = count + 1
			end
		end
		return count
	end

	local TapNoteScorePoints = {
		TapNoteScore_CheckpointHit = 200,
		TapNoteScore_W1 = 200,
		TapNoteScore_W2 = 150,
		TapNoteScore_W3 = 100,
		TapNoteScore_W4 = 0,
		TapNoteScore_W5 = 0,
		TapNoteScore_Miss = 0,
		TapNoteScore_CheckpointMiss = 0,
		TapNoteScore_None =	0,
		TapNoteScore_HitMine = 0,
		TapNoteScore_AvoidMine = 0
	}
	
	local CurrentCombo = 0
	local PlayerScore = 0

	return Def.Actor {
		InitCommand=function(self)
            -- Reset your score, dummy
            local CSS = STATSMAN:GetCurStageStats()
            local PSS = CSS:GetPlayerStageStats(Player)
            PSS:SetScore(0)
		end,

		OnCommand=function(self)
			MESSAGEMAN:Broadcast("PIUScore",{Score = 0})
		end,
		
		JudgmentMessageCommand=function(self, params)
			local Notes = {}
			local Holds = {}
			local StepsCount = 0
			local TapNote = params.TapNote
			local TapNoteScore = params.TapNoteScore
			local CSS = STATSMAN:GetCurStageStats()
			local PSS = CSS:GetPlayerStageStats(Player)
			
			if Player ~= params.Player or not TapNoteScore or params.HoldNoteScore then
				-- Used for debugging
				--SCREENMAN:SystemMessage("Expected player "..ToEnumShortString(Player).." but got "..ToEnumShortString(params.Player)) 
				PSS:SetScore(PlayerScore)
				return
			end
			
			local State = GAMESTATE:GetPlayerState(Player)

			-- Make sure the player isn't AutoPlay
			if State:GetPlayerController() ~= "PlayerController_Autoplay" then
				-- Now we can safely calculate the number of notes from the judgement
				Holds = params.Holds
				Notes = params.Notes
				StepsCount = NumberOfElements(Holds) + NumberOfElements(Notes)
				
				-- Count the combo from Lua due to some issues, don't ask me
				if TapNote and TapNote:GetTapNoteType() ~= "TapNoteType_HoldTail" then
					CurrentCombo = CurrentCombo
				else
					if (TapNoteScore <= "TapNoteScore_W2" and TapNoteScore >= "TapNoteScore_W1") or TapNoteScore == "TapNoteScore_CheckpointHit" then
						CurrentCombo = CurrentCombo + 1
					else
						CurrentCombo = 0
					end
				end
				
				local NoteScore = TapNoteScorePoints[TapNoteScore]
				if CurrentCombo > 50 then NoteScore = NoteScore * 2 end
				
				PlayerScore = PlayerScore + (NoteScore * StepsCount)
				
				-- We don't want negative scores
				if PlayerScore < 0 then PlayerScore = 0 end
				
				PSS:SetScore(PlayerScore)

				MESSAGEMAN:Broadcast("PIUScore",{Score = PlayerScore})
			end
		end
	}
end
