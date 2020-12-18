function main()
    rules, you, nearby = parseinput("data/day16")
    nearby = removeinvalid(nearby, rules)
    c = Dict()
    for d in collect(keys(rules))
        allvalid(d, c, 1:20, nearby)
    end
    fields = collect(keys(rules))
    while any(length.(values(c)) .!= 1)
        fnd = fields[findall(x -> x == 1, [length(x) for x in collect(values(c))])]
        for k in setdiff(keys(c), fnd)
            c[k] = setdiff(c[k], collect(Iterators.flatten([collect(c[f]) for f in fnd])))
        end
    end
    dpt = [c[k][1] for k in keys(c) if startswith(k, r"departure")]
    println(reduce(*, you[dpt]), " is puzzle 2 answer!")
end

function parseinput(file)
    lines = readlines(file)
    parserules(lines), parseperson(lines), parsenearby(lines)
end

function parserules(input)
    rules = Dict()
    for line in eachindex(input)
        if occursin(r"-", input[line])
            x = match(r".+(?=:)", input[line]).match
            rules[x] = begin
                ranges = [i.match for i in collect(eachmatch(r"([0-9]+-[0-9]+)", input[line]))]
                ranges = [split(r, "-") |> x -> parse.(Int, x) |> x -> collect(range(x[1], stop = x[2])) for r in ranges]
                collect(Iterators.flatten(ranges))
            end
        end
    end
    rules
end

function parsenearby(input)
    nb = findfirst(x -> startswith(x, r"nearby"), input)
    [parse.(Int, split(input[x], ",")) for x in (nb + 1):size(input, 1)]
end

function parseperson(input)
    you = findfirst(x -> startswith(x, r"your"), input)
    parse.(Int, split(input[you + 1], ","))
end

function removeinvalid(tickets, rules)
    value = collect(Iterators.flatten(tickets))
    valid = Set(collect(Iterators.flatten(values(rules))))
    bad = value[findall([!(r in valid) for r in value])]
    println(sum(bad), " is puzzle 1 answer!")

    fields = collect(keys(rules))
    pos = collect(1:20)
    bad = Set(bad)
    good = []
    for n in 1:size(tickets, 1)
        if any([x in bad for x in tickets[n]])
            continue
        else
            push!(good, nearby[n])
        end
    end
    good
end

function allvalid(key, collect, range, tickets)
    for i in range
        if all([x in rules[key] for x in [x[i] for x in tickets]])
            if haskey(collect, key)
                collect[key] = push!(collect[key], i)
            else
                collect[key] = [i]
            end
        end
    end
end
