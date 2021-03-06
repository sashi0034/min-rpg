MapEventManager:addMapEvents({

    house_on_hill = function (self, e)
        local m = MessageWindow.open()

        if FlagManager.getFlag(FlagName.obtain_solt) then
            m:streamText([[はちみつ美味しいね]])
            while m:isRunning() do Yield() end

            m:streamText("\n"..[[ぺろぺろ、ぺろぺろ]])
            while m:isRunning() do Yield() end

            m:close()
            return
        end

        m:streamText([[はちみつが食べたいね]])
        while m:isRunning() do Yield() end

        if FlagManager.getFlag(FlagName.obtain_honey) then
            m:streamText("\n"..[[くんくん.. ]])
            while m:isRunning() do Yield() end

            m:streamText([[きみははちみつを]].."\n"..[[持っているんじゃないかな?]])
            while m:isRunning() do Yield() end

            local index=0
            local refuseCount=0

            repeat
                local s = SelectionWindow.open({[[あげる]], [[あげない]]})
                while s:isRunning() do Yield() end
                index=s:selectedIndex()
                s:close()

                if index==1 then
                    m:streamText("\n"..[[やだ、お願い!]])
                    while m:isRunning() do Yield() end
                    refuseCount=refuseCount+1
                end
            until index==0

            if refuseCount==0 then
                m:streamText("\n"..[[ありがとう!]])
                while m:isRunning() do Yield() end
            else
                m:streamText("\n"..[[無理を言ってごめんね..]])
                while m:isRunning() do Yield() end
            end

            m:streamText("\n"..[[お礼に近くでとれた岩塩を]].."\n"..[[あげるよ]])
            while m:isRunning() do Yield() end

            FlagManager.setFlag(FlagName.obtain_solt, true)
        end

        m:close()
    end
})
