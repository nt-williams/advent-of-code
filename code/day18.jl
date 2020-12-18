function main()
    [rpn(shuntingyard1(i)) for i in eachline("data/day18")] |> sum |> println
    [rpn(shuntingyard2(i)) for i in eachline("data/day18")] |> sum |> println
end

# 1.  While there are tokens to be read:
# 2.        Read a token
# 3.        If it's a number add it to queue
# 4.        If it's an operator
# 5.               While there's an operator on the top of the stack with greater precedence:
# 6.                       Pop operators from the stack onto the output queue
# 7.               Push the current operator onto the stack
# 8.        If it's a left bracket push it onto the stack
# 9.        If it's a right bracket 
# 10.            While there's not a left bracket at the top of the stack:
# 11.                     Pop operators from the stack onto the output queue.
# 12.             Pop the left bracket from the stack and discard it
# 13. While there are operators on the stack, pop them to the queue

function shuntingyard1(input) 
    tokens = replace(input, " " => "")
    queue, stack = [], []
    funcs = ['*', '+']
    for i in eachindex(tokens)
        if tokens[i] ∈ funcs
            while length(stack) > 0 && stack[begin] != '('
                push!(queue, stack[begin])
                popfirst!(stack)
            end
            pushfirst!(stack, tokens[i])
        elseif tokens[i] == '('
            pushfirst!(stack, tokens[i])
        elseif tokens[i] == ')'
            while stack[begin] != '('
                push!(queue, stack[begin])
                popfirst!(stack)
            end
            popfirst!(stack)
        else 
            push!(queue, tokens[i])
        end
    end
    
    while length(stack) > 0
        push!(queue, stack[begin])
        popfirst!(stack)
    end
    string.(queue) |> x -> join(x, " ")
end

function shuntingyard2(input) 
    tokens = replace(input, " " => "")
    queue, stack = [], []
    funcs = ['*', '+']
    for i in eachindex(tokens)
        if tokens[i] ∈ funcs
            while length(stack) > 0 && stack[begin] == '+'
                push!(queue, stack[begin])
                popfirst!(stack)
            end
            pushfirst!(stack, tokens[i])
        elseif tokens[i] == '('
            pushfirst!(stack, tokens[i])
        elseif tokens[i] == ')'
            while stack[begin] != '('
                push!(queue, stack[begin])
                popfirst!(stack)
            end
            popfirst!(stack)
        else 
            push!(queue, tokens[i])
        end
    end
    
    while length(stack) > 0
        push!(queue, stack[begin])
        popfirst!(stack)
    end
    string.(queue) |> x -> join(x, " ")
end

function rpn(s)
    stack = Any[]
    for op in map(eval, map(Meta.parse, split(s)))
        if isa(op, Function)
            arg2 = pop!(stack)
            arg1 = pop!(stack)
            push!(stack, op(arg1, arg2))
        else
            push!(stack, op)
        end
    end
    stack[1]
end