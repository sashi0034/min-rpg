MapEventManager:addMapEvents({

    tree_1 = function (self, e)
        if FlagManager.getFlag(FlagName.broke_tree_branch)==true then
            return
        end
        
        local m = MessageWindow.open()
        

        m:streamText("元気な木が育ってるみたい")
        while m:isRunning() do Yield() end

        m:streamText("\n"..[[おや、枝がもろいぞ]])
        while m:isRunning() do Yield() end

        local s = SelectionWindow.open({[[そっとする]], [[折っちゃう]]})
        while s:isRunning() do Yield() end
        local index=s:selectedIndex()
        s:close()

        if (index==0) then
            m:streamText("\n"..[[この木も生きているからね]].."\n"..[[そっとしておこう]])
            while m:isRunning() do Yield() end
        elseif index==1 then
            m:streamText("\n"..[[ぽきっ!]])
            while m:isRunning() do Yield() end

            m:streamText("\n"..[[何かに使えそうだからとっておこう]])
            while m:isRunning() do Yield() end

            FlagManager.setFlag(FlagName.broke_tree_branch, true)
            FlagManager.setFlag(FlagName.have_tree_branch, true)
        end

        m:close()
    end,})
    