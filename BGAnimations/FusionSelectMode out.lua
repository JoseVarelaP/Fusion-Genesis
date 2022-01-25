return Def.Quad {
    StartTransitioningCommand=function(self)
        self:FullScreen():diffuse(Color.Black)
		:diffusealpha(0):sleep(2):queuecommand("StopMusic"):diffusealpha(1):sleep(2)
    end,
	StopMusicCommand=function(self) SOUND:StopMusic() end
}