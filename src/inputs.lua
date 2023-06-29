-- BAD EXAMPLE
local Players = game:GetService("Players")

local CustomInput = require(script.Parent.CustomInput)

local Player = Players.LocalPlayer

local Mouse = Player:GetMouse()

local inputdevices = {}
inputdevices.__index = inputdevices

inputdevices.Mouse = {
    WheelForward = {
        name = "WheelForward",
        type = "Custom.Button.Mouse",
    },
    WheelBackward = {
        name = "WheelBackward",
        type = "Custom.Button.Mouse",
    },
    Button1  = {
        name = "Button1",
        type = "Custom.Button.Mouse",
    },
    Button2  = {
        name = "Button2",
        type = "Custom.Button.Mouse",
    }
}

--// Button1
Mouse.Button1Down:Connect(function()
    CustomInput.Began:Fire(inputdevices.Button1)
end)
Mouse.Button1Up:Connect(function()
    CustomInput.Ended:Fire(inputdevices.Button1)
end)
--// Button2
Mouse.Button2Down:Connect(function()
    CustomInput.Began:Fire(inputdevices.Button2)
end)
Mouse.Button2Down:Connect(function()
    CustomInput.Began:Fire(inputdevices.Button2)
end)
--// Wheel
Mouse.WheelForward:Connect(function()
    CustomInput.Began:Fire(inputdevices.WheelForward)
end)
Mouse.WheelBackward:Connect(function()
    CustomInput.Began:Fire(inputdevices.WheelBackward)
end)

return inputdevices