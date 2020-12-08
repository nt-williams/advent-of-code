parse_boot <- function(file) {
  strsplit(readLines(file), " ")
}

boot <- parse_boot("data/day8")

# puzzle 1
accum <- 0
instr <- c()
line <- 1
seen <- rep(FALSE, length(boot))
while (line <= length(boot)) {
  if (seen[line] == TRUE) {
    res <- list(instr, accum)
    break
  }
  
  if (boot[[line]][1] == "nop") {
    seen[line] <- TRUE
    instr <- c(instr, line)
    line <- line + 1
  } else if (boot[[line]][1] == "acc") {
    seen[line] = TRUE
    accum <- accum + as.integer(boot[[line]][2])
    instr <- c(instr, line)
    line <- line + 1
  } else if (boot[[line]][1] == "jmp") {
    seen[line] <- TRUE
    instr <- c(instr, line)
    line <- line + as.integer(boot[[line]][2])
  }
}

# puzzle 2
for (i in res[[1]]) {
  bootcopy <- boot
  if (bootcopy[[i]][1] == "nop") {
    bootcopy[[i]][1] <- "jmp"
  } else if (boot[[i]][1] == "jmp") {
    bootcopy[[i]][1] <- "nop"
  } else {
    next
  }
  
  accum <- 0
  line <- 1
  seen <- rep(FALSE, length(boot))
  fixed <- "yes"
  while (line <= length(boot)) {
    if (seen[line] == TRUE) {
      fixed <- "nope"
      break
    }
    
    if (bootcopy[[line]][1] == "nop") {
      seen[line] <- TRUE
      line <- line + 1
    } else if (bootcopy[[line]][1] == "acc") {
      seen[line] = TRUE
      accum <- accum + as.integer(bootcopy[[line]][2])
      line <- line + 1
    } else if (bootcopy[[line]][1] == "jmp") {
      seen[line] <- TRUE
      line <- line + as.integer(bootcopy[[line]][2])
    }
  }
  
  if (fixed == "yes") {
    break
  }
}
