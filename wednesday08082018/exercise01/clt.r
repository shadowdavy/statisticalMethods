library("MASS")

set.seed(123) ## set the seed for reproducibility
sets <- 10000 # set of samples

numberHist <- 1:6 # number of histograms which will be produced
N <- c(1, 5, 10, 16, 32, 100) # number of samples
# limits for uniform distribution
a <- 0
b <- 4
# calculate mean and variance of uniform distribution
mu = 0.5 * (a + b)
var = (b - a)^2 / 12

png("CLT_Histograms.png")
p <- par(mfrow = c(3, 2))
for (i in numberHist) {
    # produce a matrix of samples and build row mean to plot into a normalizes histogram
    samples <- matrix(runif(sets * N[i], a, b),,nrow = sets, ncol = N[i])
    sampleMean <- rowMeans(samples)
    truehist(sampleMean, main = N[i])
    # overplot a normal distribution
    x <- seq(0, 4, length = 1000)
    lines(x, dnorm(x, mu, sqrt(var)/sqrt(N[i])), lwd = 2)
}
par(p)
