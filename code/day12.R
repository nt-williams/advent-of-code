readLines("data/day12")
gsub("[A-Z]", "", "F10")
gsub("[0-9]+", "", "F10")

move_ship <- function(directions) {
  xpos = 0
  ypos = 0
  angle = 0
  dx <- c("0" = 1, "90" = 0, "180" = -1, "270" = 0)
  dy <- c("0" = 0, "90" = 1, "180" = 0, "270" = -1)
  for (i in seq_along(directions)) {
    amount <- as.numeric(gsub("[A-Z]", "", directions[i]))
    command <- gsub("[0-9]+", "", directions[i])
    if (command == "N") {
      ypos <- ypos + amount
      next
    }
    if (command == "S") {
      ypos <- ypos - amount
      next
    }
    if (command == "E") {
      xpos <- xpos + amount
      next
    }
    if (command == "W") {
      xpos <- xpos - amount
      next
    }
    if (command == "R") {
      angle <- (angle + amount) %% 360
      next
    }
    if (command == "L") {
      angle <- (angle - amount) %% 360
      next
    }
    if (command == "F") {
      xpos <- xpos + dx[[as.character(angle)]] * amount
      ypos <- ypos + dy[[as.character(angle)]] * amount
      next
    }
  }
  c(xpos, ypos)
}
