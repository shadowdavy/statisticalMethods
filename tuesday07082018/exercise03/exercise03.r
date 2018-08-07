# Poisson distribution
# set sequence for different values of k and lambda, lambda in step of 2
stepLambda <- seq(1, 10, by=2)
k <- seq(0, 20)
# set colors
color <- c("blue", "brown", "red", "gold", "darkgreen", "darkmagenta", "aquamarine4", "chocolate3", "chartreuse3")
i = 1 # variable for color change
# save plot as png file
png("poisson_distribution.png")
# plot poisson distribution for different values of k and lambda
plot(k, dpois(k, 1), col=color[1]) # lambda = 1
for (lambda in stepLambda) {
        points(k, dpois(k, lambda), col=color[i])
        lines(k, dpois(k, lambda), col=color[i])
        i = i + 1
}
# insert a legend
legend("topright", legend=stepLambda, inset=.05, title="lambda", lwd=2, lty=c(1, 1, 1, 1, 2), col=color)


# Beta distribution
# set sequence for different values of alpha and beta, (alpha, beta > 0)
alpha <- c(0.5, 1, 2, 5)
beta <- c(0.5, 1, 2, 3, 5)
# set colors
color <- c("blue", "brown", "red", "gold", "darkgreen", "darkmagenta", "aquamarine4", "chocolate3", "chartreuse3")
# save plot as png file
png("beta_distribution.png")
# plot beta distribution for different values of alpha and beta
# plot not all variations of alpha and beta, take a few where alpha = beta,
# alpha > beta and alpha < beta to show dependency
x <- seq(0, 1, length=50)
# alpha = beta
plot(x, dbeta(x, alpha[1], beta[1]), col=color[1], ylim=c(0, 3))
lines(x, dbeta(x, alpha[1], beta[1]), col=color[1])
points(x, dbeta(x, alpha[3], beta[3]), col=color[2])
lines(x, dbeta(x, alpha[3], beta[3]), col=color[2])
# alpha > beta
points(x, dbeta(x, alpha[4], beta[2]), col=color[3])
lines(x, dbeta(x, alpha[4], beta[2]), col=color[3])
# alpha < beta
points(x, dbeta(x, alpha[2], beta[4]), col=color[4])
lines(x, dbeta(x, alpha[2], beta[4]), col=color[4])
points(x, dbeta(x, alpha[3], beta[5]), col=color[5])
lines(x, dbeta(x, alpha[3], beta[5]), col=color[5])
# insert a legend
legendValue = c("alpha=0.5, beta=0.5", "alpha=2, beta=2", "alpha=5, beta=1", "alpha=1, beta=3", "alpha=2, beta=5")
legend("topright", legend=legendValue, inset=.05, lwd=2, lty=c(1, 1, 1, 1, 2), col=color)


# Chi-squared distribution
# set sequence for different values of k (degrees of freedom)
k <- c(1, 1.5, 2, 4, 6, 9)
# set colors
color <- c("blue", "brown", "red", "gold", "darkgreen", "darkmagenta", "aquamarine4", "chocolate3", "chartreuse3")
col = 1 # variable for color change
# save plot as png file
png("chiSquared_distribution.png")
x <- seq(0, 10, length=50)
# plot chi squared distribution for different values of k
plot(x, dchisq(x, 1), col=color[1], ylim=c(0, 0.5)) # k = 1
for (i in k) {
    points(x, dchisq(x, i), col=color[col])
    lines(x, dchisq(x, i), col=color[col])
    col = col + 1
}
# insert a legend
legend("topright", legend=k, inset=.05, title="k", lwd=2, lty=c(1, 1, 1, 1, 2), col=color)
