# %%

# Make sure you have pandas (data import), statsmodels (regression),
# seaborn (plots) and scikit-learn (machine learning) installed.
# If not, install them using
# pip install pandas statsmodels seaborn

# Data import
import pandas as pd
df_boston = pd.read_csv('~/data/Boston House Prices.csv', sep='\t')
df_boston

# Declear dependent and independent variables
import statsmodels.api as sm
y = df_boston['Value'] # dependent variable
x = df_boston['Rooms'] # independent variable
x = sm.add_constant(x) # adding a constant (a column of 1) to x

# Run a simple linear regression model
lm = sm.OLS(y,x).fit() # fitting the model
lm.predict(x)
lm.summary()

# Rooms coef: 9.1021
# Constant coef: - 34.6706
# Linear equation: 𝑦 = 𝑎𝑥 + 𝑏
y_pred = -34.6706 + 9.1021 * x['Rooms']

# Plot simple linear regression model
import seaborn as sns
import matplotlib.pyplot as plt
# plotting the data points
sns.scatterplot(x=x['Rooms'], y=y)
#plotting the line
sns.lineplot(x=x['Rooms'],y=y_pred, color='red')
#axes
plt.xlim(0)
plt.ylim(0)
plt.show()

# Run a multiple linear regression model
y = df_boston['Value'] # dependent variable
X = df_boston[['Rooms', 'Distance']] # independent variable
X = sm.add_constant(X) # adding a constant
lm = sm.OLS(y, X).fit() # fitting the model
lm.summary()

# Use machine learning
from sklearn import linear_model

y = df_boston['Value'] # dependent variable
X = df_boston[['Rooms', 'Distance']] # independent variable

lm = linear_model.LinearRegression()
lm.fit(X, y) # fitting the model
lm.predict(X)

# Need to call each model element one by one
lm.score(X, y)
lm.coef_
lm.intercept_

# %%
