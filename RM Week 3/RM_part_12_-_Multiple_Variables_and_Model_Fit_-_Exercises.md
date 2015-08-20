# Multiple Variables and Model Fit - Exercises



## Question 1

Load the dataset `Seatbelts` as part of the `datasets` package via `data(Seatbelts)`. Use `as.data.frame` to convert the object to a dataframe. Fit a linear model of driver deaths with `kms`, `PetrolPrice`, and `law` as predictors.


```r
require(datasets)
require(dplyr)
data(Seatbelts)
sb <- as.data.frame(Seatbelts)
sb <- mutate(sb,
             pp=(PetrolPrice - mean(PetrolPrice)) / sd(PetrolPrice),
             mm=kms / 1000,
             mmc=mm - mean(mm))
fit <- lm(DriversKilled ~ pp + mmc + law, sb)
summary(fit)
```

```

Call:
lm(formula = DriversKilled ~ pp + mmc + law, data = sb)

Residuals:
   Min     1Q Median     3Q    Max 
-50.69 -17.29  -4.05  14.33  60.71 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept) 124.2263     1.8012  68.967  < 2e-16 ***
pp           -6.9199     1.8514  -3.738 0.000246 ***
mmc          -1.2233     0.6657  -1.838 0.067676 .  
law         -11.8892     6.0258  -1.973 0.049955 *  
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 22.87 on 188 degrees of freedom
Multiple R-squared:  0.201,	Adjusted R-squared:  0.1882 
F-statistic: 15.76 on 3 and 188 DF,  p-value: 3.478e-09
```

---

## Question 2

Perform a model selection exercise to arrive at a final model.


```r
library(car)
vif(fit)
```

```
      pp      mmc      law 
1.252053 1.397145 1.405821 
```

```r
fit0 <- update(fit, DriversKilled ~ law)
fit1 <- update(fit, DriversKilled ~ law + mmc)
fit2 <- update(fit, DriversKilled ~ law + pp)
fit3 <- update(fit, DriversKilled ~ law + mmc + pp)
anova(fit0, fit1, fit2, fit3)
```

```
Analysis of Variance Table

Model 1: DriversKilled ~ law
Model 2: DriversKilled ~ law + mmc
Model 3: DriversKilled ~ law + pp
Model 4: DriversKilled ~ law + mmc + pp
  Res.Df    RSS Df Sum of Sq      F   Pr(>F)   
1    190 109754                                
2    189 105608  1    4145.3 7.9276 0.005388 **
3    189 100069  0    5538.9                   
4    188  98303  1    1766.0 3.3774 0.067676 . 
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

```r
rbind(summary(fit0)$coef[2,],
      summary(fit1)$coef[2,],
      summary(fit2)$coef[2,],
      summary(fit3)$coef[2,])
```

```
      Estimate Std. Error   t value     Pr(>|t|)
[1,] -25.60895   5.341655 -4.794198 3.288375e-06
[2,] -17.55372   6.028888 -2.911602 4.028394e-03
[3,] -16.32618   5.555579 -2.938700 3.706585e-03
[4,] -11.88920   6.025785 -1.973055 4.995497e-02
```

```r
anova(fit0, fit3)
```

```
Analysis of Variance Table

Model 1: DriversKilled ~ law
Model 2: DriversKilled ~ law + mmc + pp
  Res.Df    RSS Df Sum of Sq      F    Pr(>F)    
1    190 109754                                  
2    188  98303  2     11450 10.949 3.177e-05 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

```r
shapiro.test(fit0$residuals)
```

```

	Shapiro-Wilk normality test

data:  fit0$residuals
W = 0.9593, p-value = 2.45e-05
```

```r
shapiro.test(fit3$residuals)
```

```

	Shapiro-Wilk normality test

data:  fit3$residuals
W = 0.9741, p-value = 0.001267
```

**ANSWER:** A model which includes `law`, `kms`, and `PetrolPrice` is the more effective model given the available data. However, given that our residuals fail tests for normality at 95%, there are concerns about the model fit. 
