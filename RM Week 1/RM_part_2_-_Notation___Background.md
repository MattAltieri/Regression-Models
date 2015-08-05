# Some Basic Notation and Background

## Some Basic Definitions

- In this module, we'll cover some basic definitions and notation used throughout the class
- We will try to minimize the amount of mathematics required for this class
- No calculus is required

## Notation for data

- We write $X_1,X_2,...,X_n$ to describe $n$ data points
- As an example, consider the dataset {1, 2, 5}. Then:
    - $X_1 = 1,X_2 = 2,X_3 = 5$ and $n = 3$
- We often use a different letter than $X$, such as $Y_1,...,Y_n$
- We will typically use Greek letters for things we don't know, such as $\mu$ for a mean that we'd like to estimate

## The Empirical Mean

- Define the empirical mean as

$$
\bar X = \frac{1}{n}\sum_{i=1}^n X_i
$$

- Notice if we subtract the mean from data points, we get data that has mean 0. That is, if we define

$$
\tilde X_i = X_i - \bar X
$$

The mean of $\tilde X$ is 0

- This process is called "centering" the random variables
- Recall from the previous lecture that the mean is the least squares solution for minimizing

$$
\sum_{i=1}^n \left(X_i - \mu\right)^2
$$

## The Empirical Standard Deviation and Variance

- Define the empirical variance as

$$
\begin{eqnarray*}
S^2 \
& = & \frac{1}{n - 1} \sum_{i=1}^n \left(X_i - \bar X\right)^2 \\
& = & \frac{1}{n - 1} \left(\sum_{i=1}^n X_i^2 - n\bar X^2\right)
\end{eqnarray*}
$$

- The empirical standard deviation is defined as $S = \sqrt S^2$. Notice that the standard deviation has the same units as the data
- The data defined by $X_i/s$ have empirical standard deviation 1. This is called "scaling" the data

## Normalization

- The data defined by

$$
Z_ = \frac{X_i - \bar X}{s}
$$

have empircal mean zero and empirical standard deviation 1

- The process of centering then scaling the data is called "normalizing" the data
- Normalized data are centered at 0 and have units equal to standard deviations of the original data
- Example, a value of 2 from normalized data means that data point was two standard deviations larger than the mean

## The Empirical Covariance

- Consider now when we have pairs of data, $\left(X_i,Y_i\right)$
- Their empirical covariance is now

$$
\begin{eqnarray*}
Cov\left(X,Y\right) \
& = & \frac{1}{n - 1} \sum_{i=1}^n \left(X_i - \bar X\right)\left(Y_i - \bar Y\right) \\
& = & \frac{1}{n - 1} \left(\sum_{i=1}^n X_i Y_i - n \bar X \bar Y\right)
\end{eqnarray*}
$$

- The correlation is defined as

$$
Cor\left(X,Y\right) = \frac{Cov\left(X,Y\right)}{S_x S_y}
$$

where $S_x$ and $S_y$ are the estimates of standard deviations for the $X$ observations and $Y$ observations, respectively

## Some Facts About Correlation

- $Cor\left(X,Y\right) = Cor\left(Y,X\right)$
- $-1 \le Cor\left(X,Y\right) \le 1$
- $Cor\left(X,Y\right) = 1$ and $Cor\left(X,Y\right) = -1$ only when the $X$ or $Y$ observations fall perfectly on a positive or negative sloped line, respectively
- $Cor\left(X,Y\right)$ measures the strength of the linear relationship between the $X$ and $Y$ data, with stronger relationships as $Cor\left(X,Y\right)$ heads towards -1 or 1
- $Cor\left(X,Y\right) = 0$ implies no linear relationship
