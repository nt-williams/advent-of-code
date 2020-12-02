# Julia solution to Day 2 of Advent of Code

using DelimitedFiles

pw = readdlm("data/day2")

# puzzle 1
function check_pw1(rule, target, password)
    bounds = [parse(Int, split(rule, "-")[i]) for i in 1:2]
    count(i -> (i == target[1]), password) in bounds[1]:bounds[2]
end

println(count(i -> (check_pw1(pw[i, 1], pw[i, 2], pw[i, 3])), 1:1000))

# puzzle 2
function check_pw2(rule, target, password)
    bounds = [parse(Int, split(rule, "-")[i]) for i in 1:2]
    count(i -> (password[i] == target[1]), bounds) == 1
end

println(count(i -> (check_pw2(pw[i, 1], pw[i, 2], pw[i, 3])), 1:1000))
