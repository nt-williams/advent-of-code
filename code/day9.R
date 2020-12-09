find_valid <- function(numbers, preamble) {
  start <- preamble + 1
  valid <- rep(NA, length(numbers))
  range_begin <- 1
  range_end <- preamble
  for (i in start:length(numbers)) {
    prev <- numbers[range_begin:range_end]
    valid[i] <- is_valid(numbers[i], prev)
    range_begin <- range_begin + 1
    range_end <- range_end + 1
  }
  valid
}

is_valid <- function(number, previous) {
  miv <- sum(previous[order(unique(previous))][1:2])
  mav <- sum(previous[order(unique(previous), decreasing = TRUE)][1:2])
  if (number < miv || number > mav) {
    return(FALSE)
  }
  if (number %in% rowSums(t(combn(previous, 2)))) {
    return(TRUE)
  }
  return(FALSE)
}

nmb <- scan("data/day9")

# puzzle 1
status <- find_valid(nmb, 25)
target <- nmb[which(status == FALSE)]

# puzzle 2
search <- nmb[1:(which(status == FALSE) - 1)]

for (i in 1:length(search)) {
  vals <- cumsum(search[i:length(search)])
  if (any(vals == target)) {
    cont <- search[i:(i + which(vals == target))]
    print(sum(min(cont), max(cont)))
  }
}
