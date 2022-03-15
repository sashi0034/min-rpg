-- class IngameEventBase
IngameEventBase = {
    new = function()
        local self = Instantiate(IngameEventBase)
        
        self.time = 0
        self.events = {}
        self.pausedEvents = {}
        
        return self
    end,

    -- Do update corutines id self.events[key].
    -- You can pause corutines if the coroutine have self.pausedEvents[key].
    update = function(self)
        for key, value in pairs(self.events) do
            if (coroutine.status(value))~="dead" then
                if (self.pausedEvents[key]~=true) then
                    coroutine.resume(value)    
                end
            else
                self.events[key] = nil
            end
        end

        self.time = self.time+Time.deltaMilli()
        return 0
    end,

    doSleep = function (time)
        local t = 0
        while t<time do 
            t = t + Time.deltaSec()
            Yield(true)
        end
        return false
    end,

    eventDrive = function (self, key, e)
        if (self[key]==nil) then
            ErrLog("Event function: "..key.." is not exit.\n");
            return
        elseif (self.events[key]~=nil) then
            ErrLog("Event function: "..key.." is already running.\n")
            return
        end

        OutLog("Event: "..key.." is driven.\n")

        self.events[key] = coroutine.create(self[key])
        coroutine.resume(self.events[key], self, e)
    end
}
