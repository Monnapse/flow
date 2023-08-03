--[[
    Made by Monnapse
--]]
--// Services
local UserInputManager = game:GetService("UserInputService")

--// Modules
local assert = require(script.Parent.assert)
local invert = require(script.Parent.invert)
local triggers = require(script.Parent.triggers)

--[=[
    Where you action will be handled, this is the main function.

    @client
    @param Manager Action -- Your action holding your data
    @within manager
]=]
function newManager(Manager)
    local self = {}

    -- @interface Triggers
    -- .Began Signal
    -- .Ended Signal
    -- .Changed Signal
    self.Triggers = {
        -- @function Began
        Began = triggers.NewTrigger(),
        -- @function Ended
        Ended = triggers.NewTrigger(),
        -- @function Changed
        Changed = triggers.NewTrigger(),
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

return newManager