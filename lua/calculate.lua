function isValidExpression(expression)
    -- 移除所有空格
    expression = expression:gsub("%s+", "")

    -- 利用正则表达式检查是否包含不合法的字符
    if not expression:match("^[0-9+%-%*/()%]+$") then
        return false
    end

    -- 利用正则表达式检查括号是否匹配
    local parenthesesStack = {}
    for i = 1, #expression do
        local char = expression:sub(i, i)
        if char == "(" then
            table.insert(parenthesesStack, char)
        elseif char == ")" then
            if #parenthesesStack == 0 then
                return false  -- 括号不匹配
            end
            table.remove(parenthesesStack)
        end
    end

    -- 检查括号是否完全匹配
    return #parenthesesStack == 0
end

function calculate(expression)
    -- 移除所有空格
    expression = expression:gsub("%s+", '')

    -- 利用正则表达式分割表达式中的数字、运算符和括号
    local tokens = {}
    for token in expression:gmatch("(%d+|[+%-*/()]") do
        table.insert(tokens, token)
    end

    -- 如果表达式不是有效的计算表达式，则直接返回
    if #tokens == 0 then
        print('Invalid expression')
        return
    end

    -- 将中缀表达式转换为后缀表达式
    local postfixExpression = infixToPostfix(tokens)

    -- 计算后缀表达式的结果
    local result = evaluatePostfix(postfixExpression)

    return result
end

-- 辅助函数：将中缀表达式转换为后缀表达式
function infixToPostfix(infix)
    local output = {}
    local stack = {}

    local precedence = {
        ['+'] = 1,
        ['-'] = 1,
        ['*'] = 2,
        ['/'] = 2,
    }

    for _, token in ipairs(infix) do
        if token:match('%d+') then
            table.insert(output, token)
        elseif token == '(' then
            table.insert(stack, token)
        elseif token == ')' then
            while #stack > 0 and stack[#stack] ~= '(' do
                table.insert(output, table.remove(stack))
            end
            table.remove(stack)  -- 弹出 '('
        else
            while #stack > 0 and precedence[token] <= precedence[stack[#stack]] do
                table.insert(output, table.remove(stack))
            end
            table.insert(stack, token)
        end
    end

    while #stack > 0 do
        table.insert(output, table.remove(stack))
    end

    return output
end

-- 辅助函数：计算后缀表达式的结果
function evaluatePostfix(postfix)
    local stack = {}

    for _, token in ipairs(postfix) do
        if token:match('%d+') then
            table.insert(stack, tonumber(token))
        else
            local operand2 = table.remove(stack)
            local operand1 = table.remove(stack)

            if token == '+' then
                table.insert(stack, operand1 + operand2)
            elseif token == '-' then
                table.insert(stack, operand1 - operand2)
            elseif token == '*' then
                table.insert(stack, operand1 * operand2)
            elseif token == '/' then
                table.insert(stack, operand1 / operand2)
            end
        end
    end

    return stack[1]
end

local function translator(input, seg)
    if (isValidExpression(input)) then
        local result = calculate(input)
        yield(Candidate("calculate", seg.start, seg._end, result, "计算"))
    end
    
end
