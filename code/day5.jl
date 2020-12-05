# Advent of Code Day 5 Julia Solution

function findSeats(file)
    codes = readlines(file)
    [toDecimal(code) for code in codes]
end

function toDecimal(x::AbstractString)
    binary = replace(replace(x, r"F|L" => "0"), r"B|R" => "1")
    count, pow = 0, length(binary)
    for i in 1:(pow)
        count += parse(Int, binary[i]) * 2^(pow - i)
    end
    count
end

seats = findSeats("data/day5")

# puzzle 1
maximum(seats)

# puzzle 2
sort!(seats)
for seat in seats
    if seats[seat + 1] - seats[seat] == 2
        println(seats[seat] + 1)
        break
    end
end
