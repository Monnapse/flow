local InputManager = require(InputManager)

--VerticlePositiveKeys = {Enum.KeyCode.W,Enum.KeyCode.DPadUp,Enum.KeyCode.Up,Enum.KeyCode.Thumbstick1,Enum.KeyCode.Thumbstick2,Enum.UserInputType.MouseMovement}
VerticlePositiveKeys = {InputManager.Info.NewKey(Enum.KeyCode.W,1,Enum.Axis.Y),Enum.KeyCode.Thumbstick1,Enum.UserInputType.MouseButton1}
VerticleNegativeKeys = {Enum.UserInputType.MouseWheel,InputManager.Info.NewKey(Enum.KeyCode.S,1,Enum.Axis.Y)}

local VerticleKeys = InputManager.Convert.TablesToKeys(VerticlePositiveKeys,VerticleNegativeKeys)
local VerticleInfo = InputManager.Info.NewAction(
    "Verticle",
    VerticleKeys,
    false, -- invert
    3, -- type
    Enum.Axis.Y -- axis
)

local VerticleManager = InputManager.NewManager(VerticleInfo)

VerticleManager.Triggers.Began:Enable()
VerticleManager.Triggers.Began:Connect(function(Key)
    print("BEGAN:",VerticleManager.Value,Key)
end)

VerticleManager.Triggers.Ended:Enable()
VerticleManager.Triggers.Ended:Connect(function(Key)
    print("ENDED:",VerticleManager.Value,Key)
end)

VerticleManager.Triggers.Changed:Enable()
VerticleManager.Triggers.Changed:Connect(function(Key)
    print("CHANGED:",VerticleManager.Value,Key)
end)