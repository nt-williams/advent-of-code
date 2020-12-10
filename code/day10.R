differences <- function(jolts, rating) {
  jolts <- sort(jolts)
  d1 <- d3 <- 0
  while (rating < max(jolts)) {
    plaus <- seq(rating + 1, rating + 3)
    next_rating <- min(plaus[which(plaus %in% jolts)])
    if (next_rating - rating == 1) {
      d1 <- d1 + 1
    } else if (next_rating - rating == 3) {
      d3 <- d3 + 1
    }
    rating <- next_rating
  }
  d1 * (d3 + 1)
}

get <- function(x, name) {
  val <- x[[as.character(name)]]
  ifelse(is.null(val), 0, val)
}

ans <- list()
ans[["0"]] <- 1
for (j in sort(jolts)) {
  ans[[as.character(j)]] <- get(ans, j - 1) + get(ans, j - 2) + get(ans, j - 3)
}

jolts <- scan("data/day10")

# puzzle 1
differences(jolts, 0)

# puzzle 2
sprintf("%.0f", ans[[length(jolts) + 1]])
