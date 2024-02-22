-- 计算器
-- 需要配制flag recognizer/patterns/calculator: "^\/.*$" 
local function translator(input, seg)
    local flag = "/"
    local flagEnd = string.len(flag);
    if string.sub(input, 1, flagEnd) == flag then
        local expression = input:gsub(" ", "") -- Remove spaces
        expression = string.sub(expression, flagEnd+1) -- Remove "coco"
        local result = load("return " .. expression)() -- Evaluate expression
        yield(Candidate("calc", seg.start, seg._end, tostring(result), "计算结果"))
        -- yield(Candidate("calc", seg.start, seg._end, expression, "计算结果"))
    end
end

return translator
