--[[
    Made by Monnapse
--]]

--[=[
    Where all of the inverting is handled

    @class invert
    @client
    @private
]=]
local invert = {}
invert.__index = invert

--[=[
    Invert a boolean
    
    @client
    @private
    @param Value boolean
    @return boolean
]=]
function invert.InvertBoolean(Value: boolean): boolean
    return not Value
end

--[=[
    Invert a number
    
    @client
    @private
    @param Value number
    @return number
]=]
function invert.InvertNumber(Value: number)
    return Value * -1
end

--[=[
    Invert a vector2
    
    @client
    @private
    @param Value Vector2
    @return Vector2
]=]
function invert.InvertVector2(Value: Vector2)
    return Vector2.new(invert.InvertNumber(Value.X),invert.InvertNumber(Value.Y))
end

--[=[
    Invert a vector3
    
    @client
    @private
    @param Value Vector3
    @return Vector3
]=]
function invert.InvertVector3(Value: Vector3)
    return Vector3.new(invert.InvertNumber(Value.X),invert.InvertNumber(Value.Y),invert.InvertNumber(Value.Z))
end

--[=[
    Invert a value
    
    @client
    @private

    @param Value boolean | number | Vector2 | Vector3
]=]
function invert.InvertValue(Value)
    if type(Value) == "boolean" then
        return invert.InvertBoolean(Value)
    elseif type(Value) == "number" then
        return invert.InvertNumber(Value)
    elseif typeof(Value) == "Vector2" then
        return invert.InvertVector2(Value)
    elseif typeof(Value) == "Vector3" then
        return invert.InvertVector3(Value)
    end
end

return invert