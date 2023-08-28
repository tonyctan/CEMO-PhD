# Create two data frames
(X <- data.frame(
    ID = c(1, 1, 2, 3, 4, 5),
    X = rnorm(6)
))

(Y <- data.frame(
    ID = rep(1:2, times = 3),
    Y = 1:6
))

# Check for duplicates
duplicated(X)
duplicated(X$ID)

# What are the sizes of the data frames?
dim(X)
dim(Y)

# Try merging the data frames
(XY <- merge(
    X,
    Y,
    by = "ID", all = TRUE
))
length(unique(c(X$ID, Y$ID)))>
dim(XY) # Why is this not 6 rows?

# Try merging the data frames after removing duplicates
(XY_nodup <- merge(
    X[!duplicated(X$ID), ], # duplicated() returns a logical vector
    Y[!duplicated(Y$ID), ], # use these T/F to your advantage
    by = "ID", all = TRUE
))
dim(XY_nodup)






A <- read.table("/media/tony/Data/MAE4000/data2a.dat", header = TRUE, dec=",")
B <- read.csv("/media/tony/Data/MAE4000/data2b.csv", header = TRUE, sep=";")
head(A)
head(B)

# Compare A and B's column names
names(A)
names(B)
# These columns were in A but not in B: X4, X5, X6
# Pull out these 3 columns from A (along with ID)
A_extra <- A[, c("ID", "X4", "X5", "X6")]
# Stitch X4, X5, X6 from A to B_ordered_column
C <- merge(B, A_extra, by = "ID", all = TRUE)
head(C, 20)
