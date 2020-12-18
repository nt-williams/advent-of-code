function main()
    input = parseinput("data/day17")
    for _ in 1:6
        input = cycle(input)
    end
    count(input)
end

function parseinput(file) 
    input = readlines(file) |> 
        x -> split.(x, "") |> 
        x -> Iterators.flatten(x) |> 
        x -> collect(x) |> 
        x -> reshape(x, 8, 8)

    out = falses(10, 10, 3, 3)
    for i in 1:size(input, 1), j in 1:size(input, 2)
        input[i, j] == "#" && (out[i + 1, j + 1, 2, 2] = true)
    end
    out
end

function cycle(input)
    input = begin
        new = falses(size(input) .+ 2)
        new[begin + 1:end - 1, begin + 1:end - 1, begin + 1:end - 1, begin + 1:end - 1] = input
        new
    end
    cp = copy(input)
    neighbors = [(x, y, z, w) for x = -1:1, y = -1:1, z = -1:1, w = -1:1 if !(x==y==z==w==0)]
    for x = 2:size(input, 1) - 1, y = 2:size(input, 2) - 1, z = 2:size(input, 3) - 1, w = 2:size(input, 4) - 1
        around = [input[[x, y, z, w] .+ n...] for n in neighbors]
        input[x, y, z, w] && 2 <= count(around) <= 3 || (cp[x, y, z, w] = false)
        !input[x, y, z, w] && count(around) == 3 && (cp[x, y, z, w] = true)
    end
    cp
end