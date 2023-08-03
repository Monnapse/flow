--[[
    Made by Monnapse
--]]

--[=[
    @class assert
    @client
    @private
    Where all of the checking is handled.
]=]
local assert = {}
assert.__index = assert

--[=[
    @private
    @client
    @param Value key
    @param Table keylist
    Check if a KeyCode is in a table of keys.
]=]
function assert.CheckKeyAssert(Value,Table)
    for index, value in pairs(Table) do
        if Value == value.InputType then
            return value
        end
    end

    return false
end

--[=[
    @private
    @client
    @param Table {}
    Check if a Key Has Custom Input.
]=]
function assert.CheckCustomAssert(Table)
    for index, value in pairs(Table) do
        if value.Type:match("Custom") then
            return value
        end
    end

    return false
end

--[=[
    @private
    @client

    @param Value Vector3
    @param Axis {Enum.Axis} | Enum.Axis | nil
]=]
function assert.BuildAxis(Value: Vector3, Axis: {Enum.Axis} | Enum.Axis | nil)
    if type(Axis) == "table" and #Axis > 0 then
        local NewX = 0
        local NewY = 0
        local NewZ = 0

        for index, axes in pairs(Axis) do
            if axes == Enum.Axis.X then
                NewX = Value.X
            elseif axes == Enum.Axis.Y then
                NewY = Value.Y
            elseif axes == Enum.Axis.Z then
                NewZ = Value.Z
            end
        end

        return Vector3.new(NewX,NewY,NewZ)
    elseif type(Axis) == "table" and #Axis == 0 then
        return Value
    elseif Axis ~= nil then
        if Axis == Enum.Axis.X then
            return(Value.X)
        elseif Axis == Enum.Axis.Y then
            return(Value.Y)
        elseif Axis == Enum.Axis.Z then
            return(Value.Z)
        end
    else
        return 1
    end
end

return assert