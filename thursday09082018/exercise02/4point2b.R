source("f.R")
source("i_N.R")
source("f_square_exp.R")
source("sigma_I_N.R")

N <- 20000
d <- 1

x <- matrix(runif(N * d), nrow=d, ncol=N)
I <- I_N(x, N)
uncertainty <- sigma_I_N(x, N)

cat("dimension = ", d, "\n")
cat("numerical result = ", I, "\n")
cat("uncertainty = ", uncertainty, "\n")

