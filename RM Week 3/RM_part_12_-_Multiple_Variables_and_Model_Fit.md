# Multiple Variables and Model Fit



## Multivariable Regression

- We have an entire class on prediction and machine learning, so we'll focus on modeling
    - Prediction has a different set of criteria, needs for interpretability, and standards for generalizability
    - In modeling, our interest lies in parsimonious, interpretable representations of the data that enhance our understanding of the phenomena under study.
    - A model is a lense through which to look at your data (Scott Zeger)
    - Under this philosophy, what's the right model? Whatever model connects the data to a true, parsimonious statement about what you're studying
- There are nearly uncountable ways that a model can be wrong. In this lecture, we'll focus on variable inclusion and exclusion
- Like nearly all aspects of statistics, good modeling decisions are context dependent
    - A good model for prediction versus one studying mechanisms versus one for trying to establish causal effects may not be the same


---

## The Rumsfeldian Triplet

_"There are known knowns. These are things we know that we know. There are known unknowns. That is to say, there are things that we know we don't know. But there are also unknown unknowns. There are things that we don't know we don't know."_ -- Donald Rumsfeld

In our context

- **Known knowns:** Regressors that we know we should check to include in the model, and have available to us.
- **Known unknowns:** Regressors that we would like to include in the model, but don't have.
- **Unknown unknowns:** Regressors that we don't even know about that we should have included in the model.

---

## General Rules

- Omitting variables results in bias in the coefficients of interest - unless their regressors are uncorrelated with the omitted ones.
    - This is why we randomize treatments. It attempts to uncorrelate our treatment indicator with variables that we don't have to put in the model
    - If there's too many unobserved confounding variables, even randomization won't help you.
- Including variables that we shouldn't have increases standard errors of the regression variables
    - Actually, including any new variable increases actual (not estimated) standard errors of other regressors. So we don't want to idly throw variables into the model.
- The model must tend toward perfect fit as the number of non-redundant regressors approaches $n$
- $R^2$ increases monotonically as more regressors are included
- The _SSE_ decreases monotonically as more regressor are included

---

## Plot of $R^2$ versus $n$

For simulations, as the number of variables included increases to $n = 100$. No actual regression relationship exists in any simulation.

<div class="rimage center"><img src="fig/unnamed-chunk-1-1.png" title="" alt="" class="plot" /></div>

---

## Variance Inflation


```r
n <- 100
nosim <- 1000
x1 <- rnorm(n)
x2 <- rnorm(n)
x3 <- rnorm(n)
betas <- sapply(1:nosim, function(i) {
    y <- x1 + rnorm(n, sd=.3)
    c(coef(lm(y ~ x1))[2],
      coef(lm(y ~ x1 + x2))[2],
      coef(lm(y ~ x1 + x2 + x3))[2])
})
round(apply(betas, 1, sd), 5)
```

```
     x1      x1      x1 
0.02957 0.02957 0.02954 
```

---

## Variance Inflation


```r
n <- 100
nosim <- 1000
x1 <- rnorm(n)
x2 <- x1 / sqrt(2) + rnorm(n) / sqrt(2)
x3 <- x1 * 0.95 + rnorm(n) * sqrt(1 - 0.95^2)
betas <- sapply(1:nosim, function(i) {
    y <- x1 + rnorm(n, sd=.3)
    c(coef(lm(y ~ x1))[2],
      coef(lm(y ~ x1 + x2))[2],
      coef(lm(y ~ x1 + x2 + x3))[2])
})
round(apply(betas, 1, sd), 5)
```

```
     x1      x1      x1 
0.03447 0.04658 0.08794 
```

---

## Variance Inflation Factors

- Notice variance inflation was much worse when we included a variable that was highly related to `x1`
- We don't know $\sigma$, so we can only estimate the increase in the actual standard error of the coefficients for including a regressor
- However, $\sigma$ drops out of the relative standard errors. If one sequentially adds variables, one can check the variance or sd inflation for including each one
- When the other regressors are actually orthogonal (uncorrelated) to the regressor of interest, then there is no variance inflation
- The variance inflation factor (VIF) is the increase in the variance for the $i^{th}$ regressor compared to the ideal setting where it is orthogonal (uncorrelated) to the other regressors
    - The square root of the VIF is the increase in the sd
- Remember, variance inflation is only part of the picture. We want to include certain variables, even if they dramatically increase our variance

---

## Revisiting Our Previous Simulation


```r
y <- x1 + rnorm(n, sd=.3)
a <- summary(lm(y ~ x1))$cov.unscaled[2,2]
c(summary(lm(y ~ x1 + x2))$cov.unscaled[2,2],
  summary(lm(y ~ x1 + x2 + x3))$cov.unscaled[2,2]) / a
```

```
[1] 1.901001 7.160999
```

```r
temp <- apply(betas, 1, var)
temp[2:3] / temp[1]
```

```
      x1       x1 
1.825375 6.507430 
```

---

## Swiss Data


```r
data(swiss)
fit1 <- lm(Fertility ~ Agriculture, swiss)
a <- summary(fit1)$cov.unscaled[2,2]
fit2 <- update(fit1, Fertility ~ Agriculture + Examination)
fit3 <- update(fit1, Fertility ~ Agriculture + Examination + Education)
c(summary(fit2)$cov.unscaled[2,2],
  summary(fit3)$cov.unscaled[2,2]) / a
```

```
[1] 1.891576 2.089159
```

---

## Swiss Data VIFs


```r
library(car)
fit <- lm(Fertility ~ ., swiss)
vif(fit)
```

```
     Agriculture      Examination        Education         Catholic Infant.Mortality 
        2.284129         3.675420         2.774943         1.937160         1.107542 
```

```r
sqrt(vif(fit)) # for sd
```

```
     Agriculture      Examination        Education         Catholic Infant.Mortality 
        1.511334         1.917138         1.665816         1.391819         1.052398 
```

---

## What about Residual Variance Estimation?

- Assuming that the model is linear with additive iid errors (with finite variance), we can mathematically describe the impact of omitting necessary variables or including unnecessary ones.
    - If we underfit the model, the variance estimate is biased
    - If we correctly or overfit the model, including all necessary covariates and/or unnecessary covariates, the variance estimate is unbiased
    - However, the variance of the variance is larger if we include unnecessary variables

---

## Covariate Model Selection

- Automated covariate selection is a difficult topic. It depends on how rich of a covariate space one wants to explore.
    - The space of models explodes quickly as you add interactions and polynomial terms
- In the prediction class, we'll cover many modern methods for traversing large model spaces for the purposes of prediction
- Principal components or factor analytic models on covariates are often useful for reducing complex covariate spaces
- Good sideisgn can often eliminate the need for complex model searches and analyses; though often control over the design is limited
- If the models of interest are nested and without lots of parameters differentiating them, it's fairly uncontroversial to use nested likelihood ratio tests (Example to follow)
- My favorite approach is as follows. Given a coefficient that I'm interested in, I like to use covariate adjustment and multiple models to probe that effect to evaluate it for robustness and to see what other covariates knock it out. This isn't a terribly systematic approach, but it tends to teach you a lot about the data as you get your hands dirty.

---

## How to Do Nested Model Testing in R


```r
fit1 <- lm(Fertility ~ Agriculture, swiss)
fit3 <- update(fit, Fertility ~ Agriculture + Examination + Education)
fit5 <- update(fit, Fertility ~ Agriculture + Examination + Education + Catholic + Infant.Mortality)
anova(fit1, fit3, fit5)
```

```
Analysis of Variance Table

Model 1: Fertility ~ Agriculture
Model 2: Fertility ~ Agriculture + Examination + Education
Model 3: Fertility ~ Agriculture + Examination + Education + Catholic + 
    Infant.Mortality
  Res.Df    RSS Df Sum of Sq      F    Pr(>F)    
1     45 6283.1                                  
2     43 3180.9  2    3102.2 30.211 8.638e-09 ***
3     41 2105.0  2    1075.9 10.477 0.0002111 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```
