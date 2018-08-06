primeNum <- function(n){
    # initialise empty prime vector (note vector is NULL not really empty)
    prime <- c()
    # one is not a prime number return message
    if(n == 1) {
        return("one is not a prime number")
    } else {
        # if n is greater than one
        # for improvement we can check for prime numbers between a range of numbers
        # therefore we can commit, instead of a value n, two numbers lowerN and upperN
        # after that we can set the for loop instead in range of 2:n to lowerN:upperN
        for(num in 2:n) {
            # number is prime until proofen wrong
            isPrime = TRUE
            for(i in 2:(num - 1)) {
                # if number is two continue because two is prime number
                if (num == 2) {
                    isPrime = TRUE
                } else if ((num %% i) == 0) {
                    # if number can be divided by any other number set
                    # isPrime to false, because than the checked number is no
                    # prime number
                    isPrime = FALSE
                }
            }
            if(isPrime) {
                # append prime vector with the cecked prime numbers
                prime <- c(prime, num)
            }
        }
    }
    return(prime)
}

print(primeNum(100))
