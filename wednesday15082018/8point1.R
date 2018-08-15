library(rmutil) # Package for two dimensional integration

xk <- read.table("../tuesday14082018/lighthouse.dat") # Recorded locations
samp <- 1000 # Sampling of 2D grid
y0range <- seq(0,3, length=samp)
x0range <- seq(-10,10, length=samp)

L <- function(x0, y0) prod(1/(2 * pi) * y0 / (x0 ** 2 - 2*x0 * xk + y0 ** 2 + xk ** 2)) # Likelihood
uninfo_prior <- 1 # Not normalised uninformative prior
cauchy_prior <- function(x, y) 1/(y * (1 + x ** 2)) # Not normalised Cauchy prior

uninfo_posterior <- function(x0, y0)  L(x0, y0)*uninfo_prior # Not normalised posterior for the uninformative prior
cauchy_posterior <- function(x0, y0) L(x0, y0)*cauchy_prior(x0, y0) # Not normalised posterior wrt Cauchy prior

uninfo_posterior_val <- matrix(ncol=samp, nrow=samp) # Initialisation of the matrix containing the not normalised posterior values for the uninformative prior
cauchy_posterior_val <- matrix(ncol=samp, nrow=samp) # Initialisation of the matrix containing the not normalised posterior values for the Cauchy prior
for (i in 1:samp) { # Computation of posterior for y0 between zero and three & x0 between zero and ten
	for (j in 1:samp) {
		uninfo_posterior_val[i, j] <- uninfo_posterior(x0range[i], y0range[j]) 
		cauchy_posterior_val[i, j] <- cauchy_posterior(x0range[i], y0range[j])
	}
}
uninfo_norm_posterior <- uninfo_posterior_val/int2(uninfo_posterior, a=c(-Inf,0), b=c(Inf,Inf)) # Normalised posterior regarding uninformative posterior
cauchy_norm_posterior <- cauchy_posterior_val/int2(cauchy_posterior, a=c(-Inf,0), b=c(Inf,Inf)) # Normalised posterior for Cauchy prior

##### Uninformative prior #####
uninfo_map <- c(x0range[which.max(uninfo_posterior_norm) %/% samp], y0range[which.max(uninfo_posterior_norm) %/% samp]) # MAP
uninfo_mean <- c(sum(colSums(uninfo_posterior_norm * x0range))*(max(x0range)-min(x0range))/length(x0range), sum(rowSums(uninfo_posterior_norm * y0range))*(max(y0range)-min(y0range))/length(y0range)) # Mean  
uninfo_median <- c(x0range[which.min((cumsum(colSums(uninfo_posterior_norm))/samp ** 2*(max(x0range)-min(x0range))-.5)**2)], y0range[which.min((cumsum(rowSums(uninfo_posterior_norm))/samp ** 2*(max(y0range)-min(y0range))-.5)**2)]) # Median
uninfo_sig <- c((sum(colSums(uninfo_posterior_norm * x0range ** 2)) * (max(x0range)-min(x0range))/length(x0range) - uninfo_mean[1] ** 2)**.5, (sum(rowSums(uninfo_posterior_norm * Y0range ** 2)) * (max(Y0range)-min(Y0range))/length(Y0range) - uninfo_mean[2] ** 2)**.5) # Standard deviation

cat("Uninformative prior\n---------------------")
cat("MAP = ", uninfo_map," miles\n")
cat("mean = ", uninfo_mean," miles\n")
cat("median = ", uninfo_median," miles\n")
cat("sigma = ", uninfo_sig," miles\n")

##### Cauchy prior #####
cauchy_map <- c(x0range[which.max(cauchy_posterior_norm) %/% samp], y0range[which.max(cauchy_posterior_norm) %/% samp]) # MAP
cauchy_mean <- c(sum(colSums(cauchy_posterior_norm * x0range))*(max(x0range)-min(x0range))/length(x0range), sum(rowSums(cauchy_posterior_norm * y0range))*(max(y0range)-min(y0range))/length(y0range)) # Mean  
cauchy_median <- c(x0range[which.min((cumsum(colSums(cauchy_posterior_norm))/samp ** 2*(max(x0range)-min(x0range))-.5)**2)], y0range[which.min((cumsum(rowSums(cauchy_posterior_norm))/samp ** 2*(max(y0range)-min(y0range))-.5)**2)]) # Median
cauchy_sig <- c((sum(colSums(cauchy_posterior_norm * x0range ** 2)) * (max(x0range)-min(x0range))/length(x0range) - cauchy_mean[1] ** 2)**.5, (sum(rowSums(cauchy_posterior_norm * Y0range ** 2)) * (max(Y0range)-min(Y0range))/length(Y0range) - cauchy_mean[2] ** 2)**.5) # Standard deviation

cat("Cauchy prior\n---------------------")
cat("MAP = ", cauchy_map," miles\n")
cat("mean = ", cauchy_mean," miles\n")
cat("median = ", cauchy_median," miles\n")
cat("sigma = ", cauchy_sig," miles\n")

##### a #####
contour(x0range, y0range, uninfo_norm_posterior, xlab=expression('x'[0]), ylab=expression('y'[0]), main="Uninformative prior") # Contour plot of posterior using uninformative prior
#persp(x0range, y0range, uninfo_norm_posterior, xlab=expression('x'[0]), ylab=expression('y'[0]), zlab="posterior", main="Uninformative prior") # 3D surface plot of posterior for uninformative prior
#contour(x0range, y0range, cauchy_norm_posterior, xlab=expression('x'[0]), ylab=expression('y'[0]), main="Cauchy prior") # Contour plot of posterior using Cauchy prior
#persp(x0range, y0range, uninfo_norm_posterior, xlab=expression('x'[0]), ylab=expression('y'[0]), zlab="posterior", main="Cauchy prior") # 3D surface plot of posterior for Cauchy prior
