primeNum <- function(n){
    # initialise empty prime vector
    prime <- c()
    # one is not a prime number
    if(n == 1) {
        print("one is not a prime number")
        break
    } else {
        # number is prime until proofen wrong
        for(ifPrime in 2:n) {
            isPrime = TRUE
            for(i in 2:(ifPrime - 1)) {
                if (ifPrime == 2) {
                    isPrime = TRUE
                } else if ((ifPrime %% i) == 0) {
                    isPrime = FALSE
                }
            }
            if(isPrime) {
                prime <- c(prime, ifPrime)
            }
        }
    }
    return(prime)
}

print(primeNum(100))
