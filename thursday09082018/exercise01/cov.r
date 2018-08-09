# import data
data <- read.table("weathergraz.txt", header = TRUE, sep = "")

png("data_plot.png")
plot(data$morning, data$afternoon, xlab = "morning hours", ylab = "afternoon hours")

n_row = dim(data)[1] # dimension rows
# dimension for columns  for looping over the columns but ignoring the first column with months
n_col = 2 # for morning and afternoon column

#calculating mean vector for morning hours and afternoon hours
mean <- matrix(0, nrow = 2, ncol = 1)
for(col in 1:n_col) {
    for(row in 1:n_row) {
        # the plus 1 in the data column is for accessing the data columns
        # in the text file -> accsess morning and afternoon data and scip
        # month column for the mean vector calculation
        mean[col] = mean[col] + data[row, col + 1]
    }
    mean[col] = mean[col] / n_row
}
# mean vector has enries first column morning mean second column afternoon mean
print(mean)

# calculating covariance matrix
# calculating difference matrix and variance / deviation
# to calculate the covariance matrix, we first calculate a difference matrix,
# which entries are of form (data x_i - mean)
diffMat <- matrix(0, nrow = n_row, ncol = n_col)
var <- matrix(0, nrow = n_col, ncol = 1)
dev <- matrix(0, nrow = n_col, ncol = 1)
for(col in 1:n_col) {
    for(row in 1:n_row) {
        diffMat[row, col] = data[row, col + 1] - mean[col]
        #calculating variance for corrolation matrix
        var[col] = var[col] + (data[row, col + 1] - mean[col])^2
    }
    #calculating deviation
    dev[col] = sqrt(1/(n_row - 1) * var[col])
}

# calculating covariance matrix by matrix element by element product of the
# difference matrix with the transposed difference matrix
covMat <- (n_row - 1)^(-1) * t(diffMat) %*% diffMat
print(covMat)

# calculate the covariance matrix with R build in function cov()
# we need to calculate every entry by hand because R do not build a matrix
covVec <- c(cov(data$morning, data$morning),
            cov(data$morning, data$afternoon),
            cov(data$afternoon, data$morning),
            cov(data$afternoon, data$afternoon))
cov_buildIn <- matrix(covVec, nrow = 2, ncol = 2)
print(cov_buildIn)


# calculating corrolation matrix
# the deviation dev is calculated parallel with the difference matrix
corMat <- matrix(0, nrow = dim(covMat)[1], ncol = dim(covMat)[2])
for(i in 1:dim(covMat)[1]) {
    for(j in 1:dim(covMat)[2]) {
        corMat[i, j] = covMat[i, j] / (dev[i]*dev[j])
    }
}
print(corMat)

# calculate corrolation matrix with R build in function using cov2cor,
# which builds a matrix instead of a single value
cov2cor(covMat)
