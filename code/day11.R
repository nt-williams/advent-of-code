read_seats <- function(file) {
  do.call(rbind, strsplit(readLines(file), ""))
}

simulate <- function(seats, f) {
  stable <- FALSE
  while (isFALSE(stable)) {
    seatsc <- matrix(nrow = nrow(seats), ncol = ncol(seats))
    for (i in 1:nrow(seats)) {
      for (j in 1:ncol(seats)) {
        seatsc[i, j] <- f(seats, i, j)
      }
    }
    if (identical(seats, seatsc)) {
      stable <- TRUE
    }
    seats <- seatsc
  }
  seats
}

rules1 <- function(seats, y, x) {
  seat <- seats[y, x]
  if (seat == ".") {
    return(seat)
  }
  occ_adj <- occupied1(seats, y, x)
  if (seat == "#" && occ_adj >= 4) {
    return("L")
  }
  if (seat == "L" && occ_adj == 0) {
    return("#")
  }
  return(seat)
}

occupied1 <- function(seats, y, x) {
  direc <- list(c(-1, 1), c(-1, 0), c(-1, -1), c(0, -1), 
                c(0, 1), c(1, -1), c(1, 0), c(1, 1))
  occ_visible <- 0
  rows <- nrow(seats)
  cols <- ncol(seats)
  for (i in seq_along(direc)) {
    yc <- y + direc[[i]][1]
    xc <- x + direc[[i]][2]
    if (yc < 1 || yc > rows || xc < 1 || xc > cols) {
      next
    } else if (seats[yc, xc] == "#") {
      occ_visible <- occ_visible + 1
    }
  }
  occ_visible
}

rules2 <- function(seats, y, x) {
  seat <- seats[y, x]
  if (seat == ".") {
    return(seat)
  }
  occ_visible <- occupied2(seats, y, x)
  if (seat == "#" && occ_visible >= 5) {
    return("L")
  }
  if (seat == "L" && occ_visible == 0) {
    return("#")
  }
  return(seat)
}

occupied2 <- function(seats, y, x) {
  direc <- list(c(-1, 1), c(-1, 0), c(-1, -1), c(0, -1), 
                c(0, 1), c(1, -1), c(1, 0), c(1, 1))
  occ_visible <- 0
  rows <- nrow(seats)
  cols <- ncol(seats)
  for (i in seq_along(direc)) {
    yc <- y + direc[[i]][1]
    xc <- x + direc[[i]][2]
    if (yc < 1 || yc > rows || xc < 1 || xc > cols) {
      next
    }
    while (seats[yc, xc] == ".") {
      yc <- yc + direc[[i]][1]
      xc <- xc + direc[[i]][2]
      if (yc < 1 || yc > rows || xc < 1 || xc > cols) {
        break
      }
    }
    if (yc < 1 || yc > rows || xc < 1 || xc > cols) {
      next
    }
    if (seats[yc, xc] == "#") {
      occ_visible <- occ_visible + 1
    }
  }
  occ_visible
}

seats <- read_seats("data/day11")

# puzzle 1
sum(simulate(seats, rules1) == "#")

# puzzle 2
sum(simulate(seats, rules2) == "#")
