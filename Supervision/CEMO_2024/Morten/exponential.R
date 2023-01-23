# Generate 1000 numbers between 0 and 1
x_seq <- seq(from = 0, to = 20, length.out = 1000)

# Generate some exponential distributions using x_seq as input
y_1 <- dexp(x_seq, rate = 1, log = FALSE)
y_5 <- dexp(x_seq, rate = 1 / 5, log = FALSE)
y_10 <- dexp(x_seq, rate = 1 / 10, log = FALSE)

# Set the ceiling of the plot
y_max <- 0.3

# Plot these distributions
plot(y_1 ~ x_seq,
    xlim = c(min(x_seq), max(x_seq)), ylim = c(0, y_max),
    type = "l", col = "red", lwd = 2,
    xlab = "x", ylab = "y",
    main = "Some Distributions"
)
par(new = TRUE)
plot(y_5 ~ x_seq,
    xlim = c(min(x_seq), max(x_seq)), ylim = c(0, y_max),
    type = "l", col = "blue", lwd = 2,
    xaxt = "n", ann = FALSE
)
par(new = TRUE)
plot(y_10 ~ x_seq,
    xlim = c(min(x_seq), max(x_seq)), ylim = c(0, y_max),
    type = "l", col = "green", lwd = 2,
    xaxt = "n", ann = FALSE
)

# Generate a normal distribution N(10,2^2)
y_norm <- dnorm(x_seq, mean = 15, sd = 2, log = FALSE)
par(new = TRUE)
plot(y_norm ~ x_seq,
    xlim = c(min(x_seq), max(x_seq)), ylim = c(0, y_max),
    type = "l", col = "black", lwd = 2,
    xaxt = "n", ann = FALSE
)
