##### a #####
N <- function(x, s) matrix(c(sum(s ** (-2)), sum(x * s ** (-2)), sum(x * s ** (-2)), sum(x **  2 * s ** (-2))), nrow=2, ncol=2) # Normal equation matrix
rhs <- function(y, x, s) matrix(c(sum(y * s ** (-2)), sum(y * x * s ** (-2))), nrow=2, ncol=1) # Right-hand side of normal equation

dat_pt <- read.table("hogg_table1.txt", header=T)
dat_pt

# Best fitting parameters
#b <- solve(N(dat_pt$x[5:20], dat_pt$sigy[5:20]), rhs(dat_pt$y[5:20], dat_pt$x[5:20], dat_pt$sigy[5:20]))[1,]
#m <- solve(N(dat_pt$x[5:20], dat_pt$sigy[5:20]), rhs(dat_pt$y[5:20], dat_pt$x[5:20], dat_pt$sigy[5:20]))[2,]

cov_matrix <-  function(x, s) solve(N(x, s)) # In the linear regression problem it turns out that the inverse of N equals the covariance matrix.

# Uncertainties of the best fitting parameters
#b_uncertainty <- sqrt(cov_matrix(dat_pt$x[5:20], dat_pt$sigy[5:20])[1,1])
#m_uncertainty <- sqrt(cov_matrix(dat_pt$x[5:20], dat_pt$sigy[5:20])[2,2])

#covariance <- cov_matrix(dat_pt$x[5:20], dat_pt$sigy[5:20])[1,2] # Covariance of the best fitting parameters

Q <- function(y, x, s) sum((y - b - m * x) ** 2/(s ** (2))) # Chi squared

# Print out
#cat("b = ", b,"+/-", b_uncertainty,"\n")
#cat("m = ", m,"+/-", m_uncertainty,"\n")
#cat("Cov[b,m] = ", covariance,"\n")
#cat("chi2 = ", Q(dat_pt$y[5:20], dat_pt$x[5:20], dat_pt$sigy[5:20]),"\n")


##### b #####
#plot_val <- seq(min(dat_pt$x[5:20]), max(dat_pt$x[5:20]), length=100000) # x-values for plotting the best fitting line
#plot(dat_pt$x[5:20], dat_pt$y[5:20], xlab="x", ylab="y")
#arrows(dat_pt$x[5:20], dat_pt$y[5:20] - dat_pt$sigy[5:20], dat_pt$x[5:20], dat_pt$y[5:20] + dat_pt$sigy[5:20], length=0.05, angle=90, code=3) # Plot of the points with uncertainty
#lines(plot_val, m * plot_val + b, type="l") # Best fitting line

##### c #####
#ymod <- m * plot_val + b # y-values of the best fitting line
#ymod_uncertainty <- sqrt((plot_val * m_uncertainty) ** 2 + b_uncertainty ** 2 + 2 * plot_val * covariance) # Uncertainty of location of best fitting line (The used formula results from error propagation neglecting the error of x)
#polygon(c(plot_val, rev(plot_val)), c(ymod - ymod_uncertainty, rev(ymod + ymod_uncertainty)), col = 'grey80', border = F) # Illustration of theuncertainty of the location of the fitting line
#points(dat_pt$x[5:20], dat_pt$y[5:20], xlab="x", ylab="y")
#arrows(dat_pt$x[5:20], dat_pt$y[5:20]-dat_pt$sigy[5:20], dat_pt$x[5:20], dat_pt$y[5:20]+dat_pt$sigy[5:20], length=0.05, angle=90, code=3)
#lines(plot_val, ymod, type="l")

##### d #####
# Best fitting parameters
b <- solve(N(dat_pt$x, dat_pt$sigy), rhs(dat_pt$y, dat_pt$x, dat_pt$sigy))[1,]
m <- solve(N(dat_pt$x, dat_pt$sigy), rhs(dat_pt$y, dat_pt$x, dat_pt$sigy))[2,]

# Uncertainties of the best fitting parameters
b_uncertainty <- sqrt(cov_matrix(dat_pt$x, dat_pt$sigy)[1,1])
m_uncertainty <- sqrt(cov_matrix(dat_pt$x, dat_pt$sigy)[2,2])

covariance <- cov_matrix(dat_pt$x, dat_pt$sigy)[1,2] # Covariance of the best fitting parameters

# Print out
cat("b = ", b,"+/-", b_uncertainty,"\n")
cat("m = ", m,"+/-", m_uncertainty,"\n")
cat("Cov[b,m] = ", covariance,"\n")
cat("chi2 = ", Q(dat_pt$y, dat_pt$x, dat_pt$sigy),"\n")

plot_val <- seq(min(dat_pt$x), max(dat_pt$x), length=100000) # x-values for plotting the best fitting line

ymod <- m * plot_val + b # y-values of the best fitting line
ymod_uncertainty <- sqrt((plot_val * m_uncertainty) ** 2 + b_uncertainty ** 2 + 2 * plot_val * covariance) # Uncertainty of location of best fitting line (The used formula results from error propagation neglecting the error of x)

plot(dat_pt$x, dat_pt$y, xlab="x", ylab="y")
polygon(c(plot_val, rev(plot_val)), c(ymod - ymod_uncertainty, rev(ymod + ymod_uncertainty)), col = 'grey80', border = F) # Illustration of theuncertainty of the location of the fitting line
points(dat_pt$x, dat_pt$y	)
arrows(dat_pt$x, dat_pt$y-dat_pt$sigy, dat_pt$x, dat_pt$y + dat_pt$sigy, length=0.05, angle=90, code=3)
lines(plot_val, ymod, type="l")

##### e ##### 
lm(formula = y ~ x, data = data_pt, subset = (5:20), weights=1.0/data_pt$sigy^2)
