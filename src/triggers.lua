--[[
    Made by Monnapse
--]]
local signal = require(script.Parent.signal)

export type Trigger = signal.signal

--[=[
    Where the triggers are handled
    @class triggers
    @client
    @private
]=]
local triggers = {}
triggers.__index = triggers

--[=[
    This is a trigger, where keycodes will send a signal if they are pressed or changed, note that signals are automatically disabled so you will have to enable them to use the connection
    @client
    @return Trigger
]=]
function triggers.NewTrigger(): Trigger
    local new = signal.new()
    new:Disable()
    return new
end

return triggers