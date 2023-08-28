# Import Excel file into R. This will produce a tibble.
Ydata <- readxl::read_excel("/media/tony/Data/MAE4000/Ydata.xlsx")
str(Ydata) # Read the top-left corner of the output: "tibble"

# Turn tibble into a data frame in order to throw away meta data
Ydata <- data.frame(Ydata)
str(Ydata) # Read the top-left corner of the output: "data.frame"
head(Ydata, 10)

# Transform wide data into long format
Ydata_long <- reshape(
    data = Ydata,
    varying = list(2:ncol(Ydata)), # Must be a list, not a vector c(...)
    idvar = "ID",
    sep = "_",
    direction = "long",
    # Decoration part: make the col and row names more meaningful
    v.names = "Score", # Name the column title.
    timevar = "Item", # Name the title of the item column
    times = colnames(Ydata)[2:ncol(Ydata)], # Specify the content
    new.row.names = 1:I(nrow(Ydata_long)*(ncol(Ydata_long) - 1))
)
head(Ydata_long, 21)
tail(Ydata_long, 21)

# If you prefer a person-centred version, sort the data by ID
Ydata_long <- Ydata_long[order(Ydata_long$ID), ]
head(Ydata_long, 42)
tail(Ydata_long, 42)
