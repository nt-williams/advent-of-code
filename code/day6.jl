function read_answers(file)
	lines = readlines(file)
	answers = [[]]
	for line in lines
		if line == ""
			push!(answers, [])
		else
			push!(last(answers), line)
		end
	end
	answers
end

answers = read_answers("data/day6")

# puzzle 1
[length(unique(split(join(i), ""))) for i in answers] |> sum

# puzzle 2
c = 0
for a in answers
	letters, l = split(join(a), ""), length(a)
	for i in unique(letters)
		global c += count(x -> x == i, letters) == l
	end
end
