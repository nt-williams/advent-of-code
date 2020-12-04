read_batch <- function(file) {
  batch <- readLines(file)
  id <- 1
  ids <- rep(NA, length(batch))
  for (i in seq_along(batch)) {
    id <- id + ifelse(batch[i] == "", 1, 0)
    ids[i] <- id
  }
  lapply(split(batch, ids), function(x) trimws(paste(x, collapse = " ")))
}

get_param <- function(field) {
  sub(":.*", "", field)
}

check_byr <- function(byr) {
  yr <- as.integer(sub(".*:", "", byr))
  yr >= 1920L && yr <= 2002L
}

check_iyr <- function(iyr) {
  yr <- as.integer(sub(".*:", "", iyr))
  yr >= 2010L && yr <= 2020L
}

check_eyr <- function(eyr) {
  yr <- as.integer(sub(".*:", "", eyr))
  yr >= 2020L && yr <= 2030L
}

check_hgt <- function(hgt) {
  if (!grepl("cm|in", hgt)) {
    return(FALSE)
  }
  ms <- sub(".*:", "", hgt)
  ht <- as.integer(sub("cm|in", "", ms))
  if (grepl("cm", ms)) {
    return(ht >= 150L && ht <= 193L)
  }
  ht >= 59L && ht <= 76L
}

check_hcl <- function(hcl) {
  cl <- sub(".*:", "", hcl)
  if (!grepl("#", cl)) {
    return(FALSE)
  }
  col <- sub("#", "", cl)
  if (gsub("[0-9]|[a-f]", "", col) != "" || nchar(col) != 6) {
    return(FALSE)
  }
  TRUE
}

check_ecl <- function(ecl) {
  col <- c("amb", "blu", "brn", "gry", "grn", "hzl", "oth")
  sum(unlist(lapply(col, function(x) grepl(x, ecl)))) == 1
}

check_pid <- function(pid) {
  id <- sub(".*:", "", pid)
  if (gsub("[0-9]", "", id) != "" || nchar(id) != 9) {
    return(FALSE)
  }
  TRUE
}

valid_passports <- function(passports) {
  fields <- c("byr:", "iyr:", "eyr:", "hgt:", "hcl:", "ecl:", "pid:")
  p1 <- p2 <- rep(NA, length(passports))
  for (i in seq_along(passports)) {
    p1[i] <- all(unlist(lapply(fields, function(x) grepl(x, passports[i]))))
    if (p1[i]) {
      params <- unlist(strsplit(passports[[i]], " "))
      p2[i] <- all(unlist(lapply(params, function(x) {
        switch(sub(":.*", "", x), 
               byr = check_byr(x), 
               iyr = check_iyr(x), 
               eyr = check_eyr(x), 
               hgt = check_hgt(x), 
               hcl = check_hcl(x), 
               ecl = check_ecl(x), 
               pid = check_pid(x))
      })))
    } else {
      p2[i] <- FALSE
    }
  }
  cat("Puzzle 1:", sum(p1), "\n")
  cat("Puzzle 2:", sum(p2), "\n")
}

valid_passports(read_batch("data/day4"))
