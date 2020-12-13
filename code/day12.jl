function main()
    code = readlines("data/day12")
    ship(code), waypoint(code)
end

function ship(code)
    coord = Dict("E"=>0, "N"=>0, "S"=>0, "W"=>0)
    facing = Dict(0=>"E", 90=>"N", 180=>"W", 270=>"S")
    angle, line = 0, 1
    for line in eachindex(code)
        command, moves = match(r"([A-Z])(.+)", code[line]).captures
        moves = parse(Int, moves)
        if command == "L"
            angle = mod((angle + moves), 360)
        elseif command == "R"
            angle = mod((angle - moves), 360)
        elseif command == "F"
            coord[facing[angle]] += moves
        else
            coord[command] += moves
        end
    end
    abs(coord["N"] - coord["S"]) + abs(coord["E"] - coord["W"])
end

function waypoint(code)
    wpx, wpy = 10, 1
    spx, spy = 0, 0
    for line in eachindex(code)
        command, moves = match(r"([A-Z])(.+)", code[line]).captures
        moves = parse(Int, moves)
        if command == "N"
            wpy += moves
        elseif command == "S"
            wpy -= moves
        elseif command == "E"
            wpx += moves
        elseif command == "W"
            wpx -= moves
        elseif command ∈ ["R", "L"] && moves == 180
            wpx, wpy = -wpx, -wpy
        elseif command == "R"
            if moves == 90
                wpx, wpy = wpy, -wpx
            elseif moves == 270
                wpx, wpy = -wpy, wpx
            end
        elseif command == "L"
            if moves == 90
                wpx, wpy = -wpy, wpx
            elseif moves == 270
                wpx, wpy = wpy, -wpx
            end
        else
            spx += moves * wpx
            spy += moves * wpy
        end
    end
    abs(spx) + abs(spy)
end
