function main()
    seats = parse_seats("data/day11")
    puzzle(seats, rule_adjacent), puzzle(seats, rule_sight)
end

function parse_seats(file)
    hcat([split(line, "") for line in readlines(file)]...)
end

function puzzle(seats, rule)
    rows, cols = size(seats)
    stable = false
    while stable === false
        next = copy(seats)
        for i in 1:rows, j in 1:cols
            next[i, j] = rule(seats, i, j)
        end
        if next == seats
            break
        end
        seats = copy(next)
    end
    count(x -> x == "#", seats)
end

function rule_adjacent(seats, i, j)
    seat = seats[i, j]
    if seat == "."
        return seat
    end
    occupied = occupied_adjacent(seats, i, j)
    if seat == "L" && occupied == 0
        return "#"
    elseif seat == "#" && occupied >= 4
        return "L"
    else
        return seat
    end
end

function occupied_adjacent(seats, ipos, jpos)
    coord = [(0, -1), (0, 1), (-1, 0), (1, 0), (-1, -1), (1, 1), (1, -1), (-1, 1)]
    occupied = 0
    rows, cols = size(seats)
    for (r, c) in coord
        i = ipos + r
        j = jpos + c
        if j < 1 || j > cols || i < 1 || i > rows
            continue
        end
        if seats[i, j] == "#"
            occupied += 1
        end
    end
    occupied
end

function rule_sight(seats, i, j)
    seat = seats[i, j]
    if seat == "."
        return seat
    end
    occupied = occupied_sight(seats, i, j)
    if seat == "L" && occupied == 0
        return "#"
    elseif seat == "#" && occupied >= 5
        return "L"
    else
        return seat
    end
end

function occupied_sight(seats, ipos, jpos)
    coord = [(0, -1), (0, 1), (-1, 0), (1, 0), (-1, -1), (1, 1), (1, -1), (-1, 1)]
    occupied = 0
    rows, cols = size(seats)
    for (r, c) in coord
        i = ipos + r
        j = jpos + c
        if j < 1 || j > cols || i < 1 || i > rows
            continue
        end
        while seats[i, j] == "."
            i += r
            j += c
            if j < 1 || j > cols || i < 1 || i > rows
                break
            end
        end
        if j < 1 || j > cols || i < 1 || i > rows
            continue
        end
        if seats[i, j] == "#"
            occupied += 1
        end
    end
    occupied
end
