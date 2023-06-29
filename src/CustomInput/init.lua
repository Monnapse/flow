--[[
    Monnapse's Input Script
    @0.1.0
--]]

local signal = require(script.signal)

local inputdevices = {}
inputdevices.__index = inputdevices

inputdevices.Began = signal.new()
inputdevices.Ended = signal.new()
inputdevices.Changed = signal.new()

type axes = {
    name: string,
    type: string
}

function inputdevices.NewInput(inputName: string,inputType: string, event): axes
    local input: axes = {
        name = inputName,
        type = "Custom."+inputType
    }

    return input
end

return inputdevices