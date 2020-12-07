library(purrr)
library(stringr)

parse_rules <- function(file) {
  lines <- readLines(file)
  rulebook <- list()
  for (line in lines) {
    rule <- unlist(strsplit(line, " contain "))
    rulebook[[str_extract(rule[1], ".+(?= bags)")]] <- bag_amount(rule[2])
  }
  rulebook
}

bag_amount <- function(line) {
  sp <- unlist(strsplit(line, ", "))
  count <- as.numeric(str_extract(sp, "\\d"))
  names(count) <- trimws(str_extract(sp, "(?<=\\d ).+(?= bag|bags)"))
  count
}

shiny_gold <- function(bag) {
  if ("shiny gold" %in% bag) {
    return(TRUE)
  } else {
    return(any(map_lgl(names(rules[[bag]]), shiny_gold)))
  }
}

count_bags <- function(bag) {
  if (is.na(rules[[bag]][1])) {
    return(0)
  } else {
    return(sum(map2_dbl(names(rules[[bag]]), rules[[bag]], ~ .y + .y * count_bags(.x))))
  }
}

rules <- parse_rules("data/day7")

# puzzle 1
sum(map_lgl(names(rules)[names(rules) != "shiny gold"], shiny_gold))

# puzzle 2
count_bags("shiny gold")
