--[[
    SCRAPPED (COULDNT GET IT TO WORK HOW INTENDED TO)
    Monnapse's Thread Script
    @0.1.0
--]]

local thread = {}
thread.__index = thread

thread.scanner = function(signal)
    coroutine.yield()
end

export type thread = {}

function thread.new(): thread
    local self = setmetatable({}, thread)

    return self
end

function thread:SetThreadFunction(ThreadFunction)
    self.Thread = coroutine.create(ThreadFunction)
    coroutine.resume(self.Thread)

    thread.Threads[self.Thread] = true
end

--// Destroy the thread
function thread:Destroy()
    coroutine.close(self.Thread)
    setmetatable(self,nil)
end

--// Pause the thread
function thread:Pause()
    --thread.Threads[self.Thread] = false
    self.Signal:Fire()
    --self.Thread.pauser()
    --coroutine.yield(self.Thread)
end

--// Resume the thread
function thread:Resume()
    coroutine.resume(self.Thread)
end

return thread