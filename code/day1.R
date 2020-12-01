# Day 1 Advent of Code

library(purrr)

expenses <- read.table(file.path("data", "entry"))

# puzzle 1 ----------------------------------------------------------------

comb2 <- expand.grid(expenses$V1, expenses$V1)
comb2_sums <- map2_dbl(comb2$Var1, comb2$Var2, ~ .x + .y)
vals <- comb2[which(comb2_sums == 2020), ]
paste("The answer is:", Reduce(`*`, vals[1, ]))

# puzzle 2 ----------------------------------------------------------------

rmn <- (2020 - comb2_sums)
fnd <- rmn %in% expenses$V1
vals <- data.frame(comb2[which(fnd), ], Var3 = rmn[fnd])
paste("The answer is:", Reduce(`*`, vals[1, ]))
