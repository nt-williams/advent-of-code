# Day 5 Advent of Code R Solution
# This is the binary solution, but this is a beat of cheat because I first solved without binary.
find_seat <- function(file) {
  codes <- scan(file, what = character())
  s <- gsub("B|R", "1", gsub("F|L", "0", codes))
  row <- strtoi(substr(s, 1, 7), 2)
  col <- strtoi(substr(s, 8, 10), 2)
  row * 8 + col
}

ids <- sort(find_seat("data/day5"))

# puzzle 1 
max(ids)

# puzzle 2
for (i in 1:(length(ids) - 1)) {
  if (ids[i + 1] - ids[i] == 2) {
    print(ids[i] + 1)
  }
}
