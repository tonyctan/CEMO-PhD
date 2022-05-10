# %%
# Data import
import pandas as pd
df_boston = pd.read_csv('~/data/Boston House Prices.csv', sep='\t')
df_boston
# %%

# %%
# Declear dependent and independent variables
import statsmodels.api as sm
y = df_boston['Value'] # dependent variable
x = df_boston['Rooms'] # independent variable
x = sm.add_constant(x) # adding a constant (a column of 1) to x
# %%

# %%
# Run a simple linear regression model
mod_0 = sm.OLS(y,x).fit() # fitting the model
mod_0.predict(x)
mod_0.summary()
# %%

# %%
# Rooms coef: 9.1021
# Constant coef: - 34.6706
# Linear equation: 𝑦 = 𝑎𝑥 + 𝑏
y_pred_0 = -34.6706 + 9.1021 * x['Rooms']
# %%

# %%
# Plot simple linear regression model
import seaborn as sns
import matplotlib.pyplot as plt
# plotting the data points
sns.scatterplot(x=x['Rooms'], y=y)
#plotting the line
sns.lineplot(x=x['Rooms'],y=y_pred_0, color='red')
#axes
plt.xlim(0)
plt.ylim(0)
plt.show()
# %%

# %%
# Run a multiple linear regression model
#y = df_boston['Value'] # dependent variable
X = df_boston[['Rooms', 'Distance']] # independent variable
X = sm.add_constant(X) # adding a constant
mod_1 = sm.OLS(y, X).fit() # fitting the model
mod_1.summary()
# %%

# %%
# Use machine learning
from sklearn import linear_model

#y = df_boston['Value'] # dependent variable
#X = df_boston[['Rooms', 'Distance']] # independent variable

mod_l = linear_model.LinearRegression()
mod_l.fit(X, y) # fitting the model
mod_l.predict(X)
# %%

# Need to call each model element one by one
# %%
mod_l.score(X, y)
# %%
mod_l.coef_
# %%
mod_l.intercept_
# %%
