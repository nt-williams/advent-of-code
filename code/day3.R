map <- readLines(file.path("data", "day3"))
bitmap <- gsub("#", "1", gsub("\\.", "0", map))
bitmap <- do.call(rbind, lapply(strsplit(bitmap, ""), as.numeric))

rule_factory <- function(rule_i, rule_j) {
  function(i, j, max_j) {
    out <- c(i + rule_i, j + rule_j)
    if (out[2] > max_j) {
      out[2] <- rule_j - (max_j - j)
    }
    return(out)
  }
}

start <- c(1, 1)
counter <- c()
end <- nrow(bitmap)

move <- function(map, coord, counter, end, .rule) {
  new_pos <- .rule(coord[1], coord[2], ncol(map))
  counter <- append(counter, map[new_pos[1], new_pos[2]])
  
  if (.rule(new_pos[1], new_pos[2], ncol(map))[1] <= end) {
    return(move(map, new_pos, counter, end, .rule))
  }
  sum(counter)
}

# puzzle 1
move(bitmap, start, counter, end, rule_factory(1, 3))

# puzzle 2
# Right 1, down 1.
# Right 3, down 1.
# Right 5, down 1.
# Right 7, down 1.
# Right 1, down 2.
rules <- purrr::map2(c(1, 1, 1, 1, 2), c(1, 3, 5, 7, 1), rule_factory)
prod(purrr::map_dbl(rules, ~ move(bitmap, start, counter, end, .x)))
