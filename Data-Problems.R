# Problem 1
#Create a vector V with 8 elements (7,2,1,0,3,-1,-3,4). 
v <- c(7, 2, 1, 0, 3, -1, -3, 4);

#Transform that vector into a rectangular matrix A of dimensions 4X2 (4- rows, 2-columns). 
A <- matrix(v, nrow = 4, ncol = 2)
A;

# Create a matrix transpose to the above matrix A. Call that matrix AT. 
AT = t(A)
AT;

# Calculate matrix products: A*AT and AT*A. Present the results. What are the dimensions of those two product matrices.
A %*% AT;
AT %*% A;

# Square matrixes sometimes have an inverse matrix. 
# Try calculating inverse matrices (or matrixes, if you prefer) of above matrices (matrixes) A*AT and AT*A. 
AATSquare <- A %*% AT;
ATASquare <- AT %*% A;
solve(AATSquare); # Singular matrix
solve(ATASquare);

# Extend the above vector V with the ninth number of value -2. Do it elegantly by concatenating two vectors ().
v <- c(v, -2);
v;

# Transform that extended vector into a 3X3 matrix B. 
B <- matrix(v, nrow = 3, ncol = 3);
B;

# Calculate the inverse matrix of matrix B. 
# Call it Binv. 
# Demonstrate that the product of B and Binv is the same as the product of Binv and B and is equal to  what?
Binv = solve(B);
round(B) %*% round(Binv);
round(Binv) %*% round(B);
#      [,1] [,2] [,3]
#[1,]    1    0    0
#[2,]    0    1    0
#[3,]    0    0    1

# Determine the eigenvectors of matrixes B.
eigen(B);
eigen(Binv);

# Construct a new matrix C which is made by using each eigenvector of matrix B as a column. 
C <- (eigen(B))
C;
temp <- c(matrix(C[2]))
C <- matrix(unlist(temp), nrow = 3 , ncol = 3)
round(C)

# Calculate the product of matrix C and matrix B and the product of matrix B and C. 
round(C) %*% round(B)
round(B) %*% round(C)

# Is there any significance to the elements of the product matrixes.


# Transform matrix B into a matrix with names columns and named rows. 
dimnames(B) <- list(rownames(B, do.NULL = F, prefix = "rows"),
                    colnames(B, do.NULL = F, prefix = "columns"))
B
  
# Transformed that fully “named” matrix into a data.frame. 
B <- data.frame(B)
B
  
# Ask the object you just created what is its class.
str(B)
typeof(B)

#Problem 2
# Consider file 2006Data.csv upload to the class site in Assignment 01 folder. 
# File represents actual measurement of power consumption in a country somewhere in a California. 
# Import data contained in that file into a data frame. 
# You are expected to Google and find a function that will let you perform that import. 
dataFile <- read.csv("2006Data.csv", header = T);

# Create a scatter plot of power consumption vs. temperature and power consumption vs. hour of the day. 
powerConsumption <- dataFile$Power;
temperature <- dataFile$Temperature;
hrOfDay <- dataFile$Hour;
plot(temperature, powerConsumption, ylab = "Power Consumption", xlab = "Temperature", main = "Power Consumption vs. Temperature Scatter Plot" );
plot(hrOfDay, powerConsumption, ylab = "Power Consumption", xlab = "Hour of Day", main = "Power Consumption vs. Hour of Day Scatter Plot" );


# Subsequently create a boxplot with power on the vertical axis and hour of the day on the horizontal axis. 
# The objective is to present the distribution (variation) of power consumption for every hour of the day. 
boxplot(powerConsumption~hrOfDay, ylab = "Power Consumption", xlab = "Hour of Day", plot = T, horizontal = F, col = c("lightblue", "red"), main = "Power Consumption vs. Hour of Day Boxplot");

# Problem 3. 
# Separate temperature scale in a reasonable number of intervals: 50 or 100. 
range(temperature);
breaks <- seq(1.47, 93, by = 1.8679)
breaks;
temperature.cut <- cut(temperature, breaks, right = F);

temperature.freq <- table(temperature.cut);
temperature.freq;

# Calculate average power consumption, minimum power consumption and maximum power consumptions for every interval.
powerConsumption.mean <- tapply(powerConsumption, temperature.cut, FUN = mean)
powerConsumption.mean

powerConsumption.min <- tapply(powerConsumption, temperature.cut, FUN = min)
powerConsumption.min

powerConsumption.max <- tapply(powerConsumption, temperature.cut, FUN = max)
powerConsumption.max

# Present those three sets of values on a single scatter graph (perhaps in different colours).
plot(powerConsumption.min, col = "blue", pch = 16, ylab = "Power Consumption", ylim = range(1:101), cex = 0.6);
points(powerConsumption.mean, col = "red", pch = 16, cex = 0.6);
points(powerConsumption.max, col = "green", pch = 16, cex = 0.6);
legend(45,30,legend = c("Min","Mean","Max"), col = c("blue", "red", "green"),pch = 16, cex = 0.6)

# Calculate three covariance matrixes between temperature and each of those power indicators (min, average, max).
a <- c(powerConsumption.max)
b <- c(powerConsumption.min)
c <- c(powerConsumption.mean)

matrix1 <- cov(mean(temperature.freq), cbind(powerConsumption.max, powerConsumption.min, powerConsumption.mean))
matrix1
  
  