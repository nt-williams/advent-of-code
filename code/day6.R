library(purrr)

read_answers <- function(file) {
  ans <- readLines(file)
  ids <- cumsum(ans == "")
  map(split(ans, ids), ~ .x[!(.x == "")])
}

ans <- read_answers("data/day6")

# puzzle 1
sum(map_dbl(ans, ~ length(unique(unlist(strsplit(paste0(.x, collapse = ""), ""))))))

# puzzle 2
sum(map_dbl(ans, ~ sum(table(unlist(strsplit(.x, ""))) == length(.x))))
