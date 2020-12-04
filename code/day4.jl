function read_batch(file)
	lines = readlines(file)
	passports = [Dict{String, String}()]
	for line in lines
		if line == ""
			push!(passports, Dict())
		else
			for value in split(line, " ")
				pair = split(value, ":")
				last(passports)[pair[1]] = pair[2]
			end
		end
	end
	passports
end

function validate_passports(passports)
	pz1, pz2 = 0, 0
	for passport in passports
		fields = ["byr", "iyr", "eyr", "hgt", "ecl", "hcl", "pid"]
		if any([!haskey(passport, i) for i in fields])
			pz1 += 0; pz2 += 0
		else
			pz1 += 1
			if all([check_fields(passport, i) for i in fields])
				pz2 += 1
			else
				pz2 += 0
			end
		end
	end
	pz1, pz2
end

function check_fields(passport::Dict, field)
	if !haskey(passport, field)
		return false
	end

	value = get(passport, field, false)

	if field == "byr"
		return 1920 ≤ parse(Int, value) ≤ 2020
	elseif field == "iyr"
		return 2010 ≤ parse(Int, value) ≤ 2020
	elseif field == "eyr"
		return 2020 ≤ parse(Int, value) ≤ 2030
	elseif field == "hgt"
		m = match(r"(\d+)(in|cm)", value)
		if m == nothing
			return false
		end
		ht, ms = match(r"(\d+)(in|cm)", value).captures
		if ms == "in"
			return 59 ≤ parse(Int, ht) ≤ 76
		else
			return 150 ≤ parse(Int, ht) ≤ 193
		end
	elseif field == "ecl"
		return value ∈ ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
	elseif field == "hcl"
		return occursin(r"^#[0-9a-f]{6}$", value)
	elseif field == "pid"
		return occursin(r"^[0-9]{9}$", value)
	end
end

passports = read_batch("data/day4")
validate_passports(passports)
