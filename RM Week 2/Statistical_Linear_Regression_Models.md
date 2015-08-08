# Statistical Linear Regression Models



## Basic Regression Model with Additive Gaussian Errors

- Least squares is an estimation tool, how do we inference?
- Consider developing a probabilistic model for linear regression

$$
Y_i = \beta_0 + \beta_1 X_i + \epsilon_i
$$

- Here the $\epsilon_i$ are sumed iid $N\left(0,\sigma^2\right)$
- Note $E\left[Y_i ~|~ X_i = x_i\right] = \mu_i = \beta_0 + \beta_1 x_i$
- Note $Var\left(Y_i ~|~ X_i = x_i\right) = \sigma^2$

---

## Recap

- Model $Y_i = \mu_i + \epsilon_i = \beta_0 + \beta_1 X_i + \epsilon_i$ where $\epsilon_i$ are $N\left(0,\sigma^2\right)$
- ML estimates of $\beta_0 \mbox{ and } \beta_1$ are the least squares estimates

$$
\hat\beta_1 = Cor\left(Y,X\right)\frac{Sd\left(Y\right)}{Sd\left(X\right)} \\
\hat\beta_0 = \bar Y - \hat\beta_1 \bar X
$$

- $E\left[Y ~|~ X = x\right] = \beta_0 + \beta_1 x$
- $Var\left(Y ~|~ X = x\right) = \sigma^2$

---

## Interpretting Regression Coefficients: the Intercept

- $\beta_0$ is the expected value of the response when the predictor is 0

$$
E\left[Y ~|~ X = 0\right] = \beta_0 + \beta_1 \times 0 = \beta_0
$$

- Note, this isn't always of interest, for example when $X = 0$ is impossible or far outside the range of data ($X$ is blood pressure, or height, etc)
- Consider that

$$
\begin{eqnarray*}
Y_i & = & \beta_0 + \beta_1 X_i + \epsilon_i \\
& = & \beta_0 + a\beta_1 + \beta_1\left(X_i - a\right) + \epsilon_i \\
& = &
\tilde\beta_0 + \beta_1\left(X_i - a\right) + \epsilon_i
\end{eqnarray*}
$$

So, shifting yourr $X$ values by value $a$ changes the intercept, but not the slope
- Often $a$ is set to $\bar X$ so that the intercept is interpretted as the expected response at the average $X$ value

---

## Interpretting Regression Coefficients: the Slope

- $\beta_1$ is the expected change in response for 1 unit change in the predictor

$$
E\left[Y ~|~ X = x + 1\right] - E\left[Y ~|~ X = x\right] = \beta_0 + \beta_1\left(x + 1\right) - \left(\beta_0 + \beta_1 x\right) = \beta_1
$$

- Consider the impact of changing the units of $X$

$$
\begin{eqnarray*}
Y_i & = & \beta_0 + \beta_1 X_i + \epsilon_i \\
& = & \beta_0 + \frac{\beta_1}{a}\left(X_i a\right) + \epsilon_i \\
& = & \beta_0 + \tilde\beta_1\left(X_i a\right) + \epsilon_i
\end{eqnarray*}
$$

- Therefore, multiplication of $X$ by a factor of $a$ results in dividing the coefficients by a factor of $a$
- Example: $X$ is height in $m$ and $Y$ is weight in $kg$. Then $\beta_1$ is $kg/m$. Converting $X$ to $cm$ implies multiplying $X$ by $100cm/m$. To get $\beta_1$ in the right units, we have to divide by $100cm/m$.

$$
Xm \times \frac{100cm}{m} = \left(100X\right)cm \\
\beta_1\frac{kg}{m} \times \frac{1m}{100cm} = \left(\frac{\beta_1}{100}\right)\frac{kg}{cm}
$$

---

## Using Regression Coefficients for Prediction

- If we would like to guess the outcome at a particular value of the predictor, say $X$, the gression model guesses

$$
\hat\beta_0 + \hat\beta_1 X
$$

---

## Example

`diamond` dataset from `UsingR`

Data is diamond prices (Singapore dollars) and diamond weights in carats (standard measure of diamond mass, 0.2$g$). To get the data use `library(UsingR); data(diamond)`

---

## Plot of the data

<div class="rimage center"><img src="fig/unnamed-chunk-1-1.png" title="" alt="" class="plot" /></div>

---

## Fitting the Linear Regression Model


```r
fit <- lm(price ~ carat, data=diamond)
coef(fit)
```

```
(Intercept)       carat 
  -259.6259   3721.0249 
```

- We estimate an expected 3721.02 (SIN) dollar increase in price for every carat increase in mass of diamond
- The intercept -259.63 is the expected price of a 0 carat diamond

---

## Getting a More Interpretable Intercept


```r
fit2 <- lm(price ~ I(carat - mean(carat)), data=diamond)
coef(fit2)
```

```
           (Intercept) I(carat - mean(carat)) 
              500.0833              3721.0249 
```

Thus $500.1 is the expected price for the average sized diamond of the data (0.2042 carats)

---

## Changing scale

- A one carat increase in a diamond is pretty big, what about changing units to 1/10$^{th}$ of a carat?
- We can do this by just dividing the coefficient by 10
    - We expect a 372.102 (SIN) dollar change in price for every 1/10$^{th}$ of a carat increase in mass of diamond
- Showing that it's the same if we rescale the $X$s and refit


```r
fit3 <- lm(price ~ I(carat * 10), data=diamond)
coef(fit3)
```

```
  (Intercept) I(carat * 10) 
    -259.6259      372.1025 
```

---

## Predicting the Price of a Diamond


```r
newx <- c(0.16, 0.27, 0.34)
coef(fit)[1] + coef(fit)[2] * newx
```

```
[1]  335.7381  745.0508 1005.5225
```

```r
predict(fit, newdata=data.frame(carat=newx))
```

```
        1         2         3 
 335.7381  745.0508 1005.5225 
```

---

Predicting values at the observed $X$s (red) and at the new $X$s (lines)

<div class="rimage center"><img src="fig/unnamed-chunk-6-1.png" title="" alt="" class="plot" /></div>
