function main()
    input = readlines("data/day13")
    depart(input), crt(input)
end

function depart(input)
    time = parse(Int, input[1])
    ids = [parse(Int, id) for id in split(input[2], ",") if id != "x"]
    bus = [(time - mod(time, id)) + id for id in ids] |> findmin
    (bus[1] - time) * ids[bus[2]]
end

function crt(input)
    values = split(input[2], ",")
    nmb, rmn = [], []
    for x in eachindex(values)
        if values[x] != "x"
            n = parse(Int, values[x])
            push!(nmb, n)
            push!(rmn, n - (x - 1))
        end
    end
    ∏ = prod(nmb)
    pp = [convert(Int, ∏ / x) for x in nmb]
    inm = [invmod(p, x) for (p, x) in zip(pp, nmb)]
    mod(sum([r * p * i for (r, p, i) in zip(rmn, pp, inm)]), ∏)
end

# naive solution to puzzle 2
# not worth figuring out how long it would take to finish
# i = 1
# div = 23 * 383
# while true
#     local val = (div * i) - lst[0]
#     chck = [mod(val + key, lst[key]) == 0 for key in collect(keys(lst))]
#     if all(chck) === true
#         return val, [val + key for key in collect(keys(lst))]
#     end
#     global i += 1
# end
