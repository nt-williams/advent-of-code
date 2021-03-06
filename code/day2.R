# Day 2 advent of code R solution

psw <- read.table(file.path("data", "day2"))
names(psw) <- c("rule", "target", "pw")

# puzzle 1 ----------------------------------------------------------------

check_psw <- function(rule, target, pw) {
  bnds <- as.numeric(unlist(strsplit(rule, "-")))
  n <- stringr::str_count(pw, sub(":", "", target))
  if (n <= bnds[2] && n >= bnds[1]) return(TRUE)
  return(FALSE)
}

cat("Part 1 answer is:", sum(purrr::pmap_lgl(psw, check_psw)), "\n")

# puzzle 2 ----------------------------------------------------------------

check_psw2 <- function(rule, target, pw) {
  bnds <- as.numeric(unlist(strsplit(rule, "-")))
  loc <- unlist(gregexpr(sub(":", "", target), pw))
  if (sum(bnds %in% loc) == 1) return(TRUE)
  return(FALSE)
}

cat("Part 2 answer is:", sum(purrr::pmap_lgl(psw, check_psw2)), "\n")
