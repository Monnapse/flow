--[[
    Convert a list of keycodes to list of Keys
--]]

--// Modules
local info = require(script.Parent.info)

local convert = {}
convert.__index = convert

--[[
    Convert a table of keycodes to a table of Keyinfos
    ex: {Enum.KeyCode.W,Enum.KeyCode.Up} -> {{KeyCode=Enum.KeyCode.w,Normal=1},{KeyCode=Enum.KeyCode.Up,Normal=1}}
--]]
function convert.TableToKeys(Table: {Enum.KeyCode}, Normal: number, Axis: Enum.Axis | nil)
    local ButtonTable = {}

    for index, value in pairs(table) do
        table.insert(ButtonTable, info.NewKey(value,Normal, Axis))
    end

    return ButtonTable
end

--[[
    Convert multiple table of keycodes to a table of Keyinfos

    Put your table of keycodes you want positive in "PositiveTable" parameter and your keycodes table that you want negative in NegativeTable parameter
--]]
function convert.TablesToKeys(PositiveTable: {Enum.KeyCode}, NegativeTable: {Enum.KeyCode})
    local ButtonTable = {}

    for index, value in pairs(PositiveTable) do
        if type(value) == "table" and  value.__type == "key" then
            value.Normal = 1
            table.insert(ButtonTable, value)
        else
            table.insert(ButtonTable, info.NewKey(value,1))
        end
    end

    for index, value in pairs(NegativeTable) do
        if type(value) == "table" and  value.__type == "key" then
            value.Normal = -1
            table.insert(ButtonTable, value)
        else
            table.insert(ButtonTable, info.NewKey(value,-1))
        end
    end

    return ButtonTable
end

return convert