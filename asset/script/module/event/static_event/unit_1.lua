MapEventManager:addStaticEvents({
    summonMouse = function (self)
        Yield()
        while not FlagManager.getFlag(FlagName.heard_mouse_rumor) do Yield() end
        OutLog("Mouse is ready to summon.\n")

        local c = coroutine.create(self.doSleep)
        while coroutine.resume(c, 12.0) do Yield() end

        local e = MapEventManager.getUnique("mouse_fast_start")

        MapEventManager.installCharacter(e.x, e.y, "mouse", "mouse_fast")
    end,
    walkerToHill = function (self)
        Yield()
        while not FlagManager.getFlag(FlagName.kill_slime) do Yield() end

        local c = coroutine.create(self.doSleep)
        while coroutine.resume(c, 9.0) do Yield() end

        OutLog("cat_goto_hill is ready to summon.\n")

        local e = MapEventManager.getUnique("cat_goto_hill_start")

        MapEventManager.installCharacter(e.x, e.y, "punicat", "cat_goto_hill")
    end,

    startMessage = function (self)
        Yield()
        local m = MessageWindow.open()

        self.awaits:streamText(m, [[勇者さん、あと5分で世界が滅びそうです]])
        self.awaits:streamText(m, "\n"..[[どうか世界を救ってください]])

        m:close()
    end,

    test = function (self)
        self.awaits:sleep(5.0)

        
        --MapEventManager.winningPlayer()
    end,


    -- sayHello = function (self)
    --     local c = coroutine.create(self.doSleep)
    --     while coroutine.resume(c, 3.0) do Yield() end

    --     local m = MessageWindow.open()

    --     m:streamText("おはようございます")
    --     while m:isRunning() do Yield() end

    --     m:close()
    --     OutLog("Static event `sat Hello` is finished\n")
    -- end,
})

    