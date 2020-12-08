function program(code)
    line = 1
    acc = 0
    log = Set()
    infinite = false
    while line <= size(code, 1)
        if line ∈ log
            infinite = true
            break
        end
        push!(log, line)
        inst, val = split(code[line], " ")
        if inst == "nop"
            line += 1
        elseif inst == "acc"
            line += 1
            acc += parse(Int, val)
        elseif inst == "jmp"
            line += parse(Int, val)
        end
    end
    acc, infinite, log
end

function fixcode(code)
    broke = program(code)
    for line in broke[3]
        codecopy = copy(code)
        inst, val = split(codecopy[line], " ")
        if inst == "acc"
            continue
        elseif inst == "jmp"
            codecopy[line] = "nop " * val
        elseif inst == "nop"
            codecopy[line] = "jmp " * val
        end
        result = program(codecopy)
        if result[2] == false
            return result[1]
            break
        end
    end
end

code = readlines("data/day8")
# puzzle 1
program(code)

# puzzle 2
fixcode(code)
