function differences(file)
    jolts = parse.(Int, readlines(file)) |> sort |> x -> pushfirst!(x, 0)
    i, d1, d3 = 1, 0, 0
    while i < length(jolts)
        if jolts[i + 1] - jolts[i] == 1
            d1 += 1
        elseif jolts[i + 1] - jolts[i] == 3
            d3 += 1
        end
        i += 1
    end
    d1 * (d3 + 1)
end

function paths(file)
    jolts = parse.(Int, readlines(file)) |> sort
    ans = Dict{Int, Int}(0 => 1)
    for jolt in jolts
        ans[jolt] = get(ans, jolt - 1, 0) + get(ans, jolt - 2, 0) + get(ans, jolt - 3, 0)
    end
    ans[last(jolts)]
end
