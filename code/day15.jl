function main()
    input = parse.(Int, split(readline("data/day15"), ","))
    memorygame(input, 10)
end

function memorygame(input, n)
    said = Dict(input[i] => i for i in eachindex(input))
    spoken = last(input)
    turn = length(input) + 1
    while turn <= n
        if spoken ∈ keys(said)
            spoken = turn - 1 - said[spoken]
        else
            spoken = 0
            said[spoken] = turn
        end
        turn += 1
    end
    spoken
end

# Solution that doesn't scale
# Keeps track of all previous turns which is memory intensive
function memorygame(input, n)
    said = Dict()
    for i in eachindex(input)
        said[input[i]] = [i]
    end
    x = length(input) + 1
    spoken = input[length(input)]
    while x <= n
        turnspoken = get(said, spoken, nothing)
        if length(turnspoken) == 1
            spoken = 0
            said[spoken] = sort(push!(get(said, spoken, nothing), x))
        else
            spoken = turnspoken[lastindex(turnspoken)] - turnspoken[lastindex(turnspoken) - 1]
            spokenbefore = get(said, spoken, nothing)
            if spokenbefore === nothing
                said[spoken] = [x]
            else
                said[spoken] = sort(push!(spokenbefore, x))
            end
        end
        x += 1
    end
    spoken
end
