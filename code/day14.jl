function main(file)
    decoderV1(file), decoderV2(file)
end

function decoderV1(file)
    input = readlines(file)
    memory = Dict{}()
    mask = String
    for line in eachindex(input)
        if match(r"mask = ", input[line]) !== nothing
            mask = match(r"(mask = )(.+)", input[line]).captures[2]
            continue
        end
        addr = parse(Int, match(r"(?<=\[)[0-9]+(?=\])", input[line]).match)
        value = string(parse(Int, match(r"(?<=\s)[0-9]+", input[line]).match), base = 2, pad = 36)
        memory[addr] = bitmaskV1(value, mask)
    end
    memory |> x -> sum(parse.(Int, collect(values(x)), base = 2))
end

function bitmaskV1(bits, mask)
    mask, bits = split(mask, ""), split(bits, "")
    for i in 1:size(mask, 1)
        if mask[i] == "1"
            bits[i] = "1"
        elseif mask[i] == "0"
            bits[i] = "0"
        end
    end
    join(bits)
end

function decoderV2(file)
    input = readlines(file)
    memory = Dict{}()
    mask = String
    for line in eachindex(input)
        if match(r"mask = ", input[line]) !== nothing
            mask = match(r"(mask = )(.+)", input[line]).captures[2]
            continue
        end
        addr = string(parse(Int, match(r"(?<=\[)[0-9]+(?=\])", input[line]).match), base = 2, pad = 36)
        value = parse(Int, match(r"(?<=\s)[0-9]+", input[line]).match)
        for a in bitmaskV2(addr, mask)
            memory[a] = value
        end
    end
    memory |> x -> sum(collect(values(x)))
end

function bitmaskV2(bits, mask)
    mask, bits = split(mask, ""), split(bits, "")
    addr = []
    for i in 1:size(mask, 1)
        if mask[i] == "X"
            bits[i] = "X"
        elseif mask[i] == "1"
            bits[i] = "1"
        end
    end
    floats = findall(==('X'), join(bits))
    for i in bitenumerate(length(floats))
        for (r, j) in zip(split(i, ""), floats)
            bits[j] = r
        end
        push!(addr, join(bits))
    end
    addr
end

function bitenumerate(n)
    [string(i, base = 2, pad = n) for i in 0:((2^n) - 1)]
end
