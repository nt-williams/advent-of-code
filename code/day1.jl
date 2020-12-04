# Julia solution to Day 1 of Advent of Code

using DelimitedFiles
using Printf

expense = readdlm("data/day1")
n = size(expense)[1,]

for i = 1:n
    rmn = 2020 - expense[i]
    if rmn in expense
        @printf "Answer 1 is %f \n" expense[i] * rmn
        break
    end
end

for i = 1:n, j = 1:n
    rmn = 2020 - expense[i] - expense[j]
    if rmn in expense
        @printf "Answer 2 is %f \n" expense[i] * expense[j] * rmn
        break
    end
end
