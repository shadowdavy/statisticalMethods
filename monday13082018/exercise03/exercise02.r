# import data
data <- read.table("hogg_table1.txt", header = TRUE, sep = "")

# remove outliesrs from dataset
# data_clean <- data[(data$x <= 80 && data$y >= 100) || (data$x >= 200 && data$y >= 400)]
# plot(data$x, data$y)

# assign y values to a matrix
datY <- matrix(data$y, ncol = 1)

# assign sigma y values to matrix like described in Hoggs et al.
dimRow <- dim(data)[1]

c <- matrix(0, nrow = dimRow, ncol = dimRow)
# fill sigma y values as diagonal matrix
for (i in 1:dimRow) {
  for (j in 1:dimRow)
    if (i == j) {
      c[i, j] <- data$sigy[i]
    }
}

a <- matrix(0, nrow = dimRow, ncol = 3)
# fill x values into matrix a like described in Hoggs et al.
# first fill the rows in the first column, than second and so on
for (i in 1:3) {
    for (j in 1:dimRow) {
        if (i == 1) {
            a[j, i] <- 1
        } else if (i == 2) {
            a[j, i] <- data$x[j]
        } else if (i == 3) {
            a[j, i] <- (data$x[j])**2
        }
    }
}

# solve(matrix) gives the inverse matrix as return
mat <- t(a) %*% solve(c) %*% a
fitParam <- solve(mat) %*% (t(a) %*% solve(c) %*% datY)
# first row is b, second is m and the third value is q following the quadratic
# function g(x) = qx^2 + mx + b
print(fitParam)

# check best fit with lm
fit_quad <- lm(y ~ x + I(x**2), data = data)
summary(fit_quad)

# plotting the data
plotFunc <- function(x) {
    return(fitParam[3] * x**2 + fitParam[2] * x + fitParam[3])
}

png("plotHogg.png")
plot(data$x, data$y)
# fit of process after Hoggs et al. -> overplot own quadratic function ???

# fit of lm function
lines(data$x, fitted(fit_quad), col = "red")
