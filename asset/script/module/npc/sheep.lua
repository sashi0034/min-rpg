

SheepLuaData = {

    new = function()
        
        local self = Instantiate(SheepLuaData, IngameEventBase)
        
        self.vel = 50
        self.frameInterval = 180

        return self
    end,

    update = function(self)
        IngameEventBase.update(self)

        if (self.events.talk~=nil) then
            self.pausedEvents.move = true
        else
            self.pausedEvents.move = nil
        end
    end,
}

