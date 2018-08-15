ntoss <- 10
x     <- 0:ntoss
nx    <- length(x)
dp    <- 0.001
p     <- seq(0.0,1.0,dp)
np    <- length(p)

numformat <- function(val) { sub("^(-?)0.", "\\1.", sprintf("%.3f", val)) }

prior1 <- function(p) if (p <  0.5) return(2.0) else return(0.0)
prior2 <- function(p) if (p >= 0.5) return(2.0) else return(0.0)
like1  <- function(x,p) return(dbinom(x,ntoss,p))
like2  <- function(x,p) return(dbinom(x,ntoss,p))
aprio1 <- 0.5
aprio2 <- 0.5

d1 <- matrix(ncol=nx,nrow=np)
d2 <- matrix(ncol=nx,nrow=np)

for (i in 1:np) {
  d1[i,] <- like1(x,p[i])*prior1(p[i]) 
  d2[i,] <- like2(x,p[i])*prior2(p[i]) 
}

evidence1 <- dp*colSums(d1)
evidence2 <- dp*colSums(d2)
bayes12   <- evidence1/evidence2

print(numformat(evidence1))
print(numformat(evidence2))
print(round(log10(bayes12),1))

plot(p,d1[,1],type='n', ylab="Likelihood x Prior")
lines(p,d1[,1], col='red')
for (i in 1:ntoss+1) lines(p,d1[,i], col='red')
for (i in 1:ntoss+1) lines(p,d2[,i], col='blue')
text(0.2,1.0,"Model 1", col='red',adj=0.5)
text(0.8,1.0,"Model 2", col='blue',adj=0.5)
text(0.07,1.7,"x=0",adj=0.5)
text(0.5 ,0.55,"x=5",adj=0.5)
text(0.92,1.7,"x=10",adj=0.5)

p1 <- vector(length=nx)
p2 <- vector(length=nx)
for (i in 1:11) {
  d     <- d1[,i]
  p1[i] <- p[d==max(d)]
  d     <- d2[,i]
  p2[i] <- p[d==max(d)]
}

print(round(p1,2))
print(round(p2,2))

