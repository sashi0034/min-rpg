MapEventManager:addMapEvents({

    house_1 = function (self, e)
        OutLog("Enter house.\n")
        local c = coroutine.create( self.doSleep )
        while coroutine.resume(c, 2.5) do Yield() end
        OutLog("Ok.\n")
    end,

    house_2 = function (self, e)
        local m = MessageWindow.open()

        m:streamText("おはようございます")
        while m:isRunning() do Yield() end

        local s = SelectionWindow.open({"こんにちは", "おはよう", "眠い", "いいえ", "ありがとう"})
        while s:isRunning() do Yield() end
        local index=s:selectedIndex()
        s:close()

        if index==0 then
            m:streamText("\n"..[[こんにちはこんにちは]])
            while m:isRunning() do Yield() end
        elseif index==1 then
            m:streamText("\n"..[[おはようございます、おはようございます、おはようございます]])
            while m:isRunning() do Yield() end
        elseif index==2 then
            m:streamText("\n"..[[眠いですね]])
            while m:isRunning() do Yield() end
        elseif index==3 then
            m:streamText("\n"..[[いいえこちらこそ]].."\n"..[[なにこれ??]])
            while m:isRunning() do Yield() end
        elseif index==4 then
            m:streamText("\n"..[[感謝の気持ちを持ちましょう]])
            while m:isRunning() do Yield() end
        end

        m:close()
    end,

    
    stones_1 = function (self, e)
        local w = MessageWindow.open()

        w:streamText("石ころが転がっている")
        while w:isRunning() do Yield() end
        
        local s = SelectionWindow.open({"はい", "いいえ"})
        while s:isRunning() do Yield() end
        s:close()

        Yield()
        
        w:close()

        w = MessageWindow.open()
        w:streamText("眠い\nねむいです\nねます")
        while w:isRunning() do Yield() end

        local c = coroutine.create( self.doSleep )
        while coroutine.resume(c, 2.5) do Yield() end

        w:close()
    end
})


