import pandas as pd
import seaborn
import matplotlib.pyplot as plt
import numpy as np
import random


class Model:
    def __init__(self): # Initialize the model with data, features, and random weights
        self.df = pd.read_csv(self.loaddata())
        self.feature = self.df.drop(['Price','Id'],axis=1)
        self.weight = np.random.rand(1,25)

    def loaddata(self):

        route = r'C:\Users\Saad Malik\Desktop\241 Project 3\train.csv' # Specify the file path for loading data

        return route

    def size(self):

        print("Data has %s entries" % self.df.size) # Print the number of entries in the dataset

    def mean(self):

        print("Mean of the price data is %s" % self.df['Price'].mean()) # Print the mean of the "Price" data

    def max(self):

        print("Max of price data is %s" % self.df['Price'].max()) # Print the maximum value within the "Price" data

    def min(self):

        print("Min of price data is %s" % self.df['Price'].min()) # Print the minimum value within the "Price" data

    def standarddeviation(self):

        print("Standard Deviation of price data is %s" % self.df['Price'].std())
        # Print the standard deviation of the "Price" data

    def histogram(self):

        # Creating an efficient histogram of the "Price" data

        price = self.df['Price']
        plot = seaborn.histplot(data=self.df, x='Price')

        plt.xlabel("Distribution of Prices")
        plt.ylabel("Number of occurences")
        plt.title("ECE 241 Project 3 Histogram")
        plt.show()

    def pairwise(self):

        # Create a pairwise plot for the selected features

        plot = seaborn.pairplot(data=self.df, vars=["GrLivArea","BedroomAbvGr","TotalBsmtSF","FullBath"])
        plt.title("ECE 241 Project 3 Pairwise Graph")
        plt.show()

    def prediction(self):

        p = self.feature.multiply(self.weight) # Perform the linear regression prediction

        return p.sum(axis=1)

    def loss(self):

        # Calculate the Mean Squared Error loss

        p = self.prediction()
        y_y = (p - self.df['Price'])
        loss = (y_y.pow(2)) / (y_y.size)

        return loss

    def gradient(self):

        # Calculate the Gradient fot updating weights

        p = self.prediction()
        y_y = (p - self.df['Price'])
        ftt = self.feature.T
        gradient = (ftt.multiply(y_y) * (2 / (y_y.size))).sum(axis=1)

        return gradient.T

    def update(self, alpha):

        # Update weights using Gradient Descent

        g = self.gradient()

        for i in range(len(self.weight)):
            for j in g:
                self.weight[i] = self.weight[i] - (alpha * j)
        return self.weight

    def train(self, alpha, iterations=500):

        # Train the Model and store Mean Squared Error (MSE) for each iteration

        MSEList = []

        for x in range(iterations):
            self.update(alpha)
            currentloss = self.loss().sum()
            MSEList.append(currentloss)
        return MSEList


# The following is the code for attempting the specified questions as stated within the project guidelines.
# The objective is to attain the required information for the compilation of our report. T

x = Model()
y = Model()
z = Model()

# Question 1 - Read file
# Question 2
x.size()
x.mean()
x.min()
x.max()
x.standarddeviation()
# Question 3
x.histogram()
# Question 4
x.pairwise()
# Question 5 - 9 (Nothing to be done)
# Question 10
run_x = x.train(0.2)
xiterations = range(len(run_x))
plotx = plt.plot(xiterations, run_x, label='Learning Rate', color='pink')
plt.legend()
plt.show()
plt.close()
# Question 11/12
run_y = y.train(10 ** -9)
run_z = z.train(10 ** -8.5)
yiterations = range(len(run_y))
ziterations = range(len(run_z))
ploty = plt.plot(yiterations, run_y, label='Learning Rate', color='purple')
plotz = plt.plot(ziterations, run_z, label='Learning Rate', color='crimson')
plt.legend()
plt.show()
plt.close()
# Question 13
