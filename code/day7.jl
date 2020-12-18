function read_rules(file)
	lines = readlines(file)
	rules = Dict()
	for line in lines
		bag, contents = split(line, " bags contain ")
		if occursin("no other", contents)
			rules[bag] = nothing
			continue
		end
		rules[bag] = Dict{String, Int}()
		for value in split(contents, ", ")
			n, style = match(r"(\d+\s)([a-z]+ [a-z]+)", value).captures
			rules[bag][style] = parse(Int, n)
		end
	end
	rules
end

function contains_gold(rules, bag)
	 if rules[bag] === nothing
		 return false
	 end
	 for contents in collect(keys(rules[bag]))
		 if (contents == "shiny gold") || containsGold(rules, contents)
			 return true
		 end
	 end
	 return false
 end

 function count_bags(rules, color)
     contents = rules[color]
     if contents === nothing
         return 0
     else
         return sum([
             contents[key] * solve(rules, key) + contents[key]
             for key in collect(keys(contents))
         ])
     end
 end

rules = read_rules("data/day7")

# puzzle 1
[contains_gold(rules, bag) for bag in collect(keys(rules))] |> sum

# puzzle 2
count_bags(rules, "shiny gold")
