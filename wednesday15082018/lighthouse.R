##### Infer posterior PDF of the position of lighthouse signal measurements

# Data can be found the corresponding file.
# Lighthouse position-related likelihood results from change of variables: theta-->x
# Lighthouse prior over theta is just uniform over the angle range: -1/pi<theta<1/pi

library(nnet) # for which.is.max

metro <- function(nmh,x0,step,prob,...) {

  #set.seed(12345)  # if reproducibility is required
  #step # factor in proposal

  x      <- vector(length=nmh)

  nAccept <- 0
  x[1]    <- x0
  i       <- 2
  # Programmed as while loop to be able to mimic errors
  # made by students. A for-loop is more adequate here. 
  while (i <=nmh) {
    xcur  <- x[i-1]
    xprop <- xcur + runif(1,-1.0,1.0)*step
    # ln Metropolis ratio
    lnMR <- log(prob(xprop,...)/prob(xcur,...))
    if( lnMR >=0 || lnMR > log(runif(1,min=0,max=1))) {
      nAccept <- nAccept + 1
      x[i]    <- xprop
      i <- i+1
    } else {
#      Comment out next two lines for mimicking no insert of rejected points
       x[i] <- xcur
       i <- i+1
    }
  }
  cat("metro: naccepted = ", nAccept, "\n")
  return(list(chain=x, naccepted=nAccept))
}

post <- function(y_temp,xdat) {
  if(y_temp < 0) {return(-Inf)} # the effect of the prior
  prod(y_temp/((xdat-xtrue)^2+y_temp^2))*prior1(y_temp)
}

prior1 <- function(y) {
  yguess <- 2.0*unit
  ysigma <- 0.3*unit
  return(exp(-0.5 *((y-yguess)/ysigma)^2))
}

prior2 <- function(y) return(1)

prior3 <- function(y) return(1/y)

medianLH <- function(y,delta_y,p_y) {
  return(y[which.is.max(-(cumsum(p_y)*delta_y-0.5)^2)])
}

fitGauss <- function(x,y,mu0,sig0,scale0){
  f = function(p){
    d = p[3]*dnorm(x,mean=p[1],sd=p[2])
    sum((d-y)^2)
  }
  return(optim(c(mu0,sig0,scale0),f))
}


unit <- 1.0 # is the result scale invariant?

# read Data
xdat <- as.matrix(read.table("lighthouse.dat")) * unit


# set model parameters
xtrue=1.25*unit

# Define sampling grid to compute posterior (will be normalized
# over this range too)
delta_y <- 0.0001*unit
ylim    <- c(0.0001, 3.0)*unit
y=seq(from=ylim[1], to=ylim[2], by=delta_y)
p_y <- seq(from=ylim[1], to=ylim[2], by=delta_y)


for(j in 1:length(y)) {
	p_y[j] <- post(y[j],xdat)
}

p_y <- p_y/(delta_y*sum(p_y))


mean_y   <- delta_y * sum(p_y * y)
map_y    <- y[p_y==max(p_y)]
median_y <- medianLH(y,delta_y,p_y) 
sd_y     <- sqrt( delta_y * sum((y-mean_y)^2 * p_y) )
cut      <- p_y > 0.95*max(p_y)
quadra   <- fitGauss(y[cut],p_y[cut],map_y,sd_y,1.0*unit)

# plot
x0 <- map_y + 0.5
y0 <- max(p_y)
par(mfrow=c(1,1), mgp=c(2.0,0.8,0), mar=c(3.5,3.5,1,1), oma=0.1*c(1,1,1,1))
plot(y, p_y, xlab="y0", ylab="P(y0|D)",type="l",xlim=c(0,max(y)), main="Gaussian prior")
text(x0, 0.9*y0,  paste("MAP    = ",round(map_y,digits=3)),cex=0.8,adj = c(0,0))
text(x0, 0.85*y0, paste("mean   = ",round(mean_y,digits=3)),cex=0.8,adj = c(0,0))
text(x0, 0.80*y0, paste("median = ",round(median_y,digits=3)),cex=0.8,adj = c(0,0))
text(x0, 0.75*y0, paste("sig(y) = ",round(sd_y,digits=3)),cex=0.8,adj = c(0,0))
text(x0, 0.70*y0, paste("QApp, 5% topmost points"),cex=0.8,adj = c(0,0))
text(x0, 0.65*y0, paste(round(quadra$par[1],digits=3),
                        round(quadra$par[2],digits=4),
                        round(quadra$par[3],digits=3))
                        ,cex=0.8,adj = c(0,0))
abline(v=map_y, col="grey",lwd=2)
lines(y, quadra$par[3]*dnorm(y, mean=quadra$par[1], sd=quadra$par[2]),lty=2,col="blue")

legend("topleft", c("Posterior","Quadr. Approx."), lty = c(1,2),col=c("black", "blue"),bty="n")



# mean sum(y*p_y)/sum(p_y)
# xx <- metro(100000,1.0,0.3,xdat)
# tail(xx$chain, -100000)
