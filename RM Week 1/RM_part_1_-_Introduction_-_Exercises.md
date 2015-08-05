# Introduction to Regression - Exercises

## Question 1

Consider the dataset given by `x = c(0.725, 0.429, -0.372, 0.863)`. What value of $\mu$ minimizes $\sum_{i=1}^n\left(X_i - \mu\right)^2$?


```r
x <- c(0.725, 0.429, -0.372, 0.863)
mean(x)
```

```
## [1] 0.41125
```

**ANSWER:** 0.41125

## Question 2

Reconsider the previous question. Suppose that weights were given, `w = c(2, 2, 1, 1)` so that we wanted to minimize $\sum_{i=1}^n\left(W_i \times \left(X_i - \mu\right)^2\right)$ for $\mu$. What value would we obtain?

$$
\begin{eqnarray*}
\sum_{i=1}^n\left(W_i \left(X_i - \mu\right)^2\right) \
& = & 2\left(0.725 - \mu\right)^2 + 2\left(0.429 - \mu\right)^2 + \left(-0.372 - \mu\right)^2 + \left(0.863 - \mu\right)^2 \\
& = & \left(0.725 - \mu\right)^2 + \left(0.725 - \mu\right)^2 + \left(0.429 - \mu\right)^2 + \left(0.429 - \mu\right)^2 + \left(-0.372 - \mu\right)^2 + \left(0.863 - \mu\right)^2
\end{eqnarray*}
$$


```r
w <- c(2, 2, 1, 1)
sum(w*x)/sum(w)
```

```
## [1] 0.4665
```

**ANSWER:** 0.4665

## Question 3

Take the Galton and obtain the regression through the origin slope estimate where the centered parental height is the outcome and the child's height is the predictor


```r
library(UsingR)
data(galton)
lm(formula=I(parent - mean(parent)) ~ I(child - mean(child)) - 1, data=galton)
```

```
## 
## Call:
## lm(formula = I(parent - mean(parent)) ~ I(child - mean(child)) - 
##     1, data = galton)
## 
## Coefficients:
## I(child - mean(child))  
##                 0.3256
```

```r
#or
y <- galton$parent
y.centered <- y - mean(y)
x <- galton$child
x.centered <- x - mean(x)
sum(y.centered * x.centered) / sum(x.centered^2)
```

```
## [1] 0.3256475
```

**ANSWER:** 0.3256
