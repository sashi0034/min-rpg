
chick_3 = {

    new = function()
        
        local self = Instantiate(chick_3, ChickLuaData)
        
        self.events = {
            move = nil,
        }
        self.chickId = 3

        return self
    end,

    update = function(self)
        ChickLuaData.update(self)


        if (self.events.move==nil and self.events.followPlayer==nil) then
            self.events.move = coroutine.create(ChickLuaData.move)
            coroutine.resume(self.events.move, self)
        end

    end,


    talk = function (self, e)
        if self.events.followPlayer~=nil then
            return
        end

        local w = MessageWindow.open()

        self.awaits:sleep(0.5); Sound.dynamic("mew_chick.mp3")
        w:streamText("ぴよ、ぴよ")
        while w:isRunning() do Yield() end

        w:streamText("\n"..[[おうち分かんない]])
        while w:isRunning() do Yield() end

        self.events.followPlayer = coroutine.create(ChickLuaData.followPlayer)
        coroutine.resume(self.events.followPlayer, self)
        self.events.move = nil
        FlagManager.setFlag(FlagName.catch_chick_3, true)

        w:close()
    end
}




