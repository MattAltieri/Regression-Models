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
round(summary(fit)$coef, 3)
```

```
            Estimate Std. Error z value Pr(>|z|)
(Intercept)    4.820      0.007 676.243        0
pp            -0.055      0.007  -7.643        0
mmc           -0.010      0.003  -3.818        0
law           -0.115      0.026  -4.495        0
```

```r
round(summary(fit2)$coef, 3)
```

```
            Estimate Std. Error t value Pr(>|t|)
(Intercept)    4.805      0.014 333.435    0.000
pp            -0.054      0.015  -3.643    0.000
mmc           -0.008      0.005  -1.538    0.126
law           -0.131      0.048  -2.726    0.007
```

---

## Question 3

Refer to question 1. Fit your Poisson log-linear model with `drivers` as a log offset (to consider the proportion of drivers killed of those killed or seriously injured)


```r
fit3 <- glm(DriversKilled ~ pp + mmc + law, poisson, sb, offset=log(drivers))
summary(fit3)
```

```

Call:
glm(formula = DriversKilled ~ pp + mmc + law, family = poisson, 
    data = sb, offset = log(drivers))

Deviance Residuals: 
    Min       1Q   Median       3Q      Max  
-3.3195  -0.7002  -0.0226   0.6843   2.9095  

Coefficients:
             Estimate Std. Error  z value Pr(>|z|)    
(Intercept) -2.612798   0.007123 -366.835   <2e-16 ***
pp          -0.007255   0.007200   -1.008    0.314    
mmc          0.003378   0.002631    1.284    0.199    
law          0.028484   0.025513    1.116    0.264    
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

(Dispersion parameter for poisson family taken to be 1)

    Null deviance: 217.70  on 191  degrees of freedom
Residual deviance: 213.07  on 188  degrees of freedom
AIC: 1493.8

Number of Fisher Scoring iterations: 4
```

---

## Question 4

Refer to Question 1. Use the `anova` function to compare the models with just `law`, `law` and `PetrolPrice`, and all three predictors.


```r
anova(glm(DriversKilled ~ law + pp + mmc, poisson, sb), "chisq")
```

```
Analysis of Deviance Table

Model: poisson, link: log

Response: DriversKilled

Terms added sequentially (first to last)

     Df Deviance Resid. Df Resid. Dev
NULL                   191     984.50
law   1  114.434       190     870.06
pp    1   77.178       189     792.88
mmc   1   14.561       188     778.32
```
