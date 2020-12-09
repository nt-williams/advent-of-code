function xmas(input)
    start, stop, preamble = 1, 25, 25
    for line in preamble:size(input, 1)
        value = input[stop + 1]
        search = filter(x -> x != value / 2, input[start:stop])
        rmn = value .- search
        if any([any(r .== search) for r in rmn])
            start += 1
            stop += 1
            continue
        else
            return value
        end
    end
end

function break_xmas(input, target)
    search = input[1:findall(target .== input)[1] - 1]
    index = 1
    cont = [search[index]]
    while index < length(search)
        if sum(cont) < target
            index += 1
            push!(cont, search[index])
        elseif sum(cont) > target
            popfirst!(cont)
        elseif sum(cont) == target
            break
        end
    end
    cont
end

input = readlines("data/day9") |> x -> parse.(Int, x)

# puzzle 1
target = xmas(input)

# puzzle 2
break_xmas(input, target)
