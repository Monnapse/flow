local invert = {}
invert.__index = invert

function invert.InvertBoolean(Value:boolean)
    return not Value
end

function invert.InvertNumber(Value:number)
    return Value * -1
end

function invert.InvertVector2(Value: Vector2)
    return Vector2.new(invert.InvertNumber(Value.X),invert.InvertNumber(Value.Y))
end

function invert.InvertVector3(Value: Vector3)
    return Vector3.new(invert.InvertNumber(Value.X),invert.InvertNumber(Value.Y),invert.InvertNumber(Value.Z))
end

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