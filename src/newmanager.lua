--[[
    Made by Monnapse
--]]
--// Services
local UserInputManager = game:GetService("UserInputService")

--// Modules
local assert = require(script.Parent.assert)
local invert = require(script.Parent.invert)
local triggers = require(script.Parent.triggers)
local signal = require(script.Parent.signal)

--[=[
    @within NewManager
    @type Triggers {
        Began: signal.signal,
        Ended: signal.signal,
        Changed: signal.signal,
    }
]=]
export type Triggers = {
    Began: signal.signal,
    Ended: signal.signal,
    Changed: signal.signal,
}

--[=[
    @within NewManager
    @type Manager {
        Triggers: Triggers,
        Value: boolean | number | Vector2 | Vector3
    }
]=]
export type Manager = {
    Triggers: Triggers,
    Value: boolean | number | Vector2 | Vector3
}

--[=[
    @class NewManager
    @client
]=]
local NewManager = {}
NewManager.__index = NewManager

--[=[
    Where you action will be handled, this is the main function.

    @client
    @param Manager Action -- Your action holding your data
    @within manager
    @return Manager
]=]
function NewManager.Manager(Manager): Manager
    local self = {}

    self.Triggers = {
        Began = triggers.NewTrigger(),
        Ended = triggers.NewTrigger(),
        Changed = triggers.NewTrigger(),

        Shared = triggers.NewTrigger(),
        SharedEnded = triggers.NewTrigger(),
    }

    self.Value = nil

    local function KeyInput(Input, UserInputState: Enum.UserInputState)
        if UserInputState == Enum.UserInputState.Begin then
            if Manager.Type == 1 then
                self.Value = true

                if Manager.Invert then
                    self.Value = invert.InvertValue(self.Value)
                end
            elseif Manager.Type == 2 or Manager.Type == 3 then
                self.Value = assert.BuildAxis(assert.BuildAxis(Vector3.new(1,1,1), {Input.Axis}), Manager.Axis)  * Input.Normal

                if Manager.Invert then
                    self.Value = invert.InvertValue(self.Value)
                end
            end

            --// Triggers
            if self.Triggers.Began.enabled then
                self.Triggers.Began:Fire(Input)
            end
            if self.Triggers.Shared.enabled then
                self.Triggers.Shared:Fire(Input)
            end
        elseif UserInputState == Enum.UserInputState.End then
            if Manager.Type == 1 then
                if Manager.Invert then
                    self.Value = invert.InvertValue(false)
                else
                    self.Value = false
                end
            elseif Manager.Type == 2 then
                if type(Manager.Axis) == "table" and #Manager.Axis > 1 then
                    self.Value = assert.BuildAxis(Vector3.new(0,0,0), Manager.Axis) * Input.Normal
                else
                    self.Value = 0
                end
                
                if Manager.Invert then
                    self.Value = invert.InvertValue(self.Value)
                end
            elseif Manager.Type == 3 then
                self.Value = assert.BuildAxis(Vector3.new(0,0,0), {Manager.Axis})  * Input.Normal

                if Manager.Invert then
                    self.Value = invert.InvertValue(self.Value)
                end
            end

            --// Triggers
            if self.Triggers.Ended.enabled then
                self.Triggers.Ended:Fire(Input)
            end
            if self.Triggers.SharedEnded.enabled then
                self.Triggers.SharedEnded:Fire(Input)
            end
        elseif UserInputState == Enum.UserInputState.Change then
            if Manager.Type == 3 then
                if Manager.Invert then
                    self.Value = invert.InvertValue(assert.BuildAxis(Input.Position, Manager.Axis)) * Input.Normal
                    Input.Position = self.Value
                else
                    self.Value = assert.BuildAxis(Input.Position, Manager.Axis) * Input.Normal
                end
            end

            --// Triggers
            if self.Triggers.Changed.enabled then
                self.Triggers.Changed:Fire(Input)
            end
            if self.Triggers.Shared.enabled then
                self.Triggers.Shared:Fire(Input)
            end
        end
    end

    local function InputBegan(input, gameProcessedEvent)
        local Key = assert.CheckKeyAssert(input.KeyCode, Manager.Keys)
        local UserInput = assert.CheckKeyAssert(input.UserInputType, Manager.Keys)

        if Key then
            Key.Position = input.Position
            KeyInput(Key,Enum.UserInputState.Begin)
        elseif UserInput then
            UserInput.Position = input.Position
            KeyInput(UserInput,Enum.UserInputState.Begin)
        end
    end
    local function InputEnded(input, gameProcessedEvent)
        local Key = assert.CheckKeyAssert(input.KeyCode, Manager.Keys)
        local UserInput = assert.CheckKeyAssert(input.UserInputType, Manager.Keys)

        if Key then
            Key.Position = input.Position
            KeyInput(Key,Enum.UserInputState.End)
        elseif UserInput then
            UserInput.Position = input.Position
            KeyInput(UserInput,Enum.UserInputState.End)
        end
    end
    local function InputChanged(input, gameProcessedEvent)
        local Key = assert.CheckKeyAssert(input.KeyCode, Manager.Keys)
        local UserInput = assert.CheckKeyAssert(input.UserInputType, Manager.Keys)

        if Key then
            Key.Position = input.Position
            KeyInput(Key,Enum.UserInputState.Change)
        elseif UserInput then
            UserInput.Position = input.Position
            KeyInput(UserInput,Enum.UserInputState.Change)
        end
    end

    UserInputManager.InputBegan:Connect(InputBegan)
    UserInputManager.InputEnded:Connect(InputEnded)
    UserInputManager.InputChanged:Connect(InputChanged)

    --// Custom Inputs or Inputs that are not included in Enum.KeyCode

    return self
end

return NewManager.Manager