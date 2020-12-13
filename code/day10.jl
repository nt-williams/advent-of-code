function differences(file)
    jolts = parse.(Int, readlines(file)) |> sort |> x -> pushfirst!(x, 0)
    diffs = [jolts[i + 1] - jolts[i] for i in 1:(length(jolts) - 1)]
    sum(diffs .== 1) * (sum(diffs .== 3) + 1)
end

function paths(file)
    jolts = parse.(Int, readlines(file)) |> sort
    ans = Dict{Int, Int}(0 => 1)
    for jolt in jolts
        ans[jolt] = get(ans, jolt - 1, 0) + get(ans, jolt - 2, 0) + get(ans, jolt - 3, 0)
    end
    get(ans, maximum(jolts), 0)
end
