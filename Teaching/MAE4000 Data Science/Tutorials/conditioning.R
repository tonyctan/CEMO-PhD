# Generate 100 random numbers from a normal distribution with mean 0 and standard deviation 1
x <- rnorm(100)
y <- rnorm(100)
m1 <- lm(y ~ x)
summary(m1) 
