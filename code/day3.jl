map = []
open("data/day3") do io
    for x in eachline(io)
        push!(map, split(x, ""))
     end
end

len = size(map)[1]
wid = size(map[1])[1]

function trees(map, x, y, length, width)
    counter, i, j = 0, 1, 1
    while i < length
        j = j + x > width ? x - (width - j) : j + x
        i += y
        counter += map[i][j] == "#" ? 1 : 0
    end
    counter
end

# puzzle 1
println(trees(map, 3, 1, len, wid))

# puzzle 2
xrules = [1, 3, 5, 7, 1]
yrules = [1, 1, 1, 1, 2]
prod([trees(map, x, y, len, wid) for (x, y) in zip(xrules, yrules)]) |>
println
