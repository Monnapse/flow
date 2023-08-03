--[[
    Made by Monnapse
--]]

--// DataTypes
export type Key = {
    InputType: Enum.KeyCode | Enum.UserInputType, --// The Key Code
    Normal: number, --// 1 for Positive, -1 for Negative
    __type: string,
    Axis: Enum.Axis | nil --//
}

export type Action = {
    Name: string,
    Keys: {Key},
    Invert: boolean,
    Type: number, --// 1 for Boolean, 2 for Number, 3 for Vector2
    __type: string,
    Axis: {Enum.Axis} | Enum.Axis | nil
}

--[=[
    Where the types get made.

    @class info
    @client
]=]
local info = {}
info.__index = info

--// Functions

--[=[
    Create a Key.

    @client
    @param InputType Enum.KeyCode | Enum.UserInputType -- The input type
    @param Normal number -- The number your keycode will be multiplied by, 1 or -1
    @param Axis Enum.Axis | nil -- Where your keycode axis will go on
    @return Key
]=]
function info.NewKey(
    InputType: Enum.KeyCode | Enum.UserInputType,
    Normal: number,
    Axis: Enum.Axis | nil
): Key
    local new: Key = {
        InputType = InputType,
        Normal = Normal,
        __type = "key"
    }
    if Axis ~= nil then
        new.Axis = Axis
    end
    return new
end

--[=[
    Create a input Action.

    @client
    @param Name string -- The name of the input Action
    @param Keys {Key} -- All of the buttons that will trigger the event
    @param Invert boolean -- Inverts the value
    @param Type number -- The returning value: 1 for Boolean, 2 for Number, 3 for Vector2
    @return Action
]=]
function info.NewAction(
    Name: string,
    Keys: {Key},
    Invert: boolean,
    Type: number,
    Axis: {Enum.Axis} | Enum.Axis | nil
): Action
    local new: Action = {
        Name = Name,
        Keys = Keys,
        Invert = Invert,
        Type = Type,
        __type = "Action",
        Axis = Axis
    }

    return new
end

return info