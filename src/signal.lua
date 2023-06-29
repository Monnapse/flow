--[[
    Monnapse's Signal Script MODIFIED
    @0.1.0
--]]

local signal = {}
signal.__index = signal

export type signal = {}

function signal.new(): signal
    local self = setmetatable({}, signal)
    self.CallbackEvents = {}
    self.enabled = true
    return self
end

function signal:Fire(...)
    for index, CallbackEvent in pairs(self.CallbackEvents) do
        CallbackEvent(...)
    end
end

--// Connect to the signal to get callbacks
function signal:Connect(CallbackEvent)
    table.insert(self.CallbackEvents,CallbackEvent)
end

--// Stops all the continues functions
function signal:Stop()
    for index, thread in pairs(self.Threads) do
        thread:Pause()
    end
end

--// Destroy the signal
function signal:Destroy()
    setmetatable(self,nil)
end

--// Just for extra checks
function signal:Enable()
    self.enabled = true
end
--// Just for extra checks
function signal:Disable()
    self.enabled = false
end

return signal