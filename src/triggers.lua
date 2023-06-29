local signal = require(script.Parent.signal)

export type Trigger = signal.signal

local triggers = {}
triggers.__index = triggers

function triggers.NewTrigger(): Trigger
    local new = signal.new()
    new:Disable()
    return new
end

return triggers