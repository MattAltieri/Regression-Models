# Poisson Regression - Exercises



## Question 1

Load the dataset `Seatbelts` as part of the `datasets` package via `data(Seatbelts)`. Use `as.data.frame` to convert the object to a dataframe. Fit a Poisson regression GLM with `DriversKilled` as the outcome and `kms`, `PetrolPrice`, and `law` as predictors. Interpret your results


```r
require(datasets)
require(dplyr)
data(Seatbelts)
sb <- as.data.frame(Seatbelts)
sb <- mutate(sb,
             pp=(PetrolPrice - mean(PetrolPrice)) / sd(PetrolPrice),
             mm=kms / 1000,
             mmc=mm - mean(mm))
fit <- glm(DriversKilled ~ pp + mmc + law, poisson, sb)
summary(fit)
```

```

Call:
glm(formula = DriversKilled ~ pp + mmc + law, family = poisson, 
    data = sb)

Deviance Residuals: 
    Min       1Q   Median       3Q      Max  
-4.7909  -1.6247  -0.3526   1.2900   4.8720  

Coefficients:
             Estimate Std. Error z value Pr(>|z|)    
(Intercept)  4.819845   0.007127 676.243  < 2e-16 ***
pp          -0.055361   0.007243  -7.643 2.12e-14 ***
mmc         -0.009981   0.002614  -3.818 0.000134 ***
law         -0.114877   0.025558  -4.495 6.96e-06 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

(Dispersion parameter for poisson family taken to be 1)

    Null deviance: 984.50  on 191  degrees of freedom
Residual deviance: 778.32  on 188  degrees of freedom
AIC: 2059.1

Number of Fisher Scoring iterations: 4
```

```r
exp(confint(fit))
```

```
                  2.5 %      97.5 %
(Intercept) 122.2222239 125.6851457
pp            0.9328039   0.9596687
mmc           0.9850107   0.9951557
law           0.8477821   0.9371219
```

```r
anova(fit)
```

```
Analysis of Deviance Table

Model: poisson, link: log

Response: DriversKilled

Terms added sequentially (first to last)

     Df Deviance Resid. Df Resid. Dev
NULL                   191     984.50
pp    1  149.318       190     835.18
mmc   1   36.362       189     798.82
law   1   20.494       188     778.32
```

---

## Question 2

Refer to question 1. Fit a linear model with the log of drivers killed as the outcome. Interpret your results.


```r
fit2 <- lm(log(DriversKilled) ~ pp + mmc + law, sb)
summary(fit)
```

```

Call:
glm(formula = DriversKilled ~ pp + mmc + law, family = poisson, 
    data = sb)

Deviance Residuals: 
    Min       1Q   Median       3Q      Max  
-4.7909  -1.6247  -0.3526   1.2900   4.8720  

Coefficients:
             Estimate Std. Error z value Pr(>|z|)    
(Intercept)  4.819845   0.007127 676.243  < 2e-16 ***
pp          -0.055361   0.007243  -7.643 2.12e-14 ***
mmc         -0.009981   0.002614  -3.818 0.000134 ***
law         -0.114877   0.025558  -4.495 6.96e-06 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

(Dispersion parameter for poisson family taken to be 1)

    Null deviance: 984.50  on 191  degrees of freedom
Residual deviance: 778.32  on 188  degrees of freedom
AIC: 2059.1

Number of Fisher Scoring iterations: 4
```

---
