MapEventManager:addMapEvents({

    house_r_3 = function (self, e)
        local m = MessageWindow.open()

        m:streamText([[ここから東の大地から]]..[[魔の気配を感じます]])
        while m:isRunning() do Yield() end

        m:close()
    end
})
