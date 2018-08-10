library(MASS) # Used package

p <- function(x) exp(-(x + 2*(cos(x)**2))**2) # Since the unknown proportionality constants/normalisation of the probability distribution p(x) cancels out in the computation of the acceptance probability we do not need it to compute the points of the Markov chain. However, we need the normalisation when comparing p(x) to the resulting histogram of the chain in part d
r <- function(x, y) min(1, p(x)/p(y)) # Acceptance probability (c)

N <- 1e6 # Number of elements in the chain

pchain <- matrix(nrow=N, ncol=1) # Matrix containing the elements of the chain

pchain[1,1] <- 0 # Random guess for the first point of the chain (a)
nAccept <- 1 # Number of acceptances + 1 respectively number of different points in the chain
for (i in 2:N) { # (b)
	xcur  <- pchain[i-1,1]
  xprop <- xcur + runif(1,-1,1)       # uncorrelated uniform change, symmetric
  if (r(xprop, xcur)>runif(1)) { # Acceptance
		pchain[i,1] <- xprop
		nAccept <- nAccept + 1 # New element in chain
	} else { # Rejection
		pchain[i,1] <- xcur
	}
}

truehist(pchain[,1], h=.02, xlab="x", ylab="p") # Histogram (d)
pval <- seq(-4,2,length=10000) # Plot values
lines(pval, p(pval)/1.10401, col="red", lwd=2) # Overplot of the normalised probability distribution (d)
legend(x="topright", legend=c("Elements of the chain","Underlying probability distribution"), col=c("cyan","red"), lty=1, cex=.8) # Legend
cat("Number of different points in the chain = ", nAccept, "\n")
