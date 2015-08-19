# Multivariable Regression - Adjustment - Exercises



## Question 1

Load the dataset `Seatbelts` as part of the `datasets` package via `data(Seatbelts)`. Use `as.data.frame` to convert the object to a dataframe. Fit a linear model of driver deaths with `kms` and `PetrolPrice` as predictors. Interpret your results.


```r
library(datasets)
data(Seatbelts)
sb <- as.data.frame(Seatbelts)
fit <- lm(DriversKilled ~ kms + PetrolPrice, sb)
round(summary(fit)$coef, 4)
```

```
             Estimate Std. Error t value Pr(>|t|)
(Intercept)  215.7461    14.6656 14.7110   0.0000
kms           -0.0017     0.0006 -2.8469   0.0049
PetrolPrice -643.7895   148.2896 -4.3414   0.0000
```

```r
# Numbers need to be centered and maybe scaled
summary(sb$kms)
```

```
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   7685   12680   14990   14990   17200   21630 
```

```r
summary(sb$PetrolPrice)
```

```
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
0.08118 0.09258 0.10450 0.10360 0.11410 0.13300 
```

```r
library(dplyr)
sb <- mutate(sb,
             pp=(PetrolPrice - mean(PetrolPrice)) / sd(PetrolPrice),
             mm=kms/1000,
             mmc=mm - mean(mm))
fit2 <- lm(DriversKilled ~ pp + mmc, sb)
round(summary(fit2)$coef, 4)
```

```
            Estimate Std. Error t value Pr(>|t|)
(Intercept) 122.8021     1.6629 73.8503   0.0000
pp           -7.8387     1.8055 -4.3414   0.0000
mmc          -1.7495     0.6145 -2.8469   0.0049
```

**ANSWER:** There are on average 123 drivers killed for the average gas price & distance driven. For every 1 standard deviation increase in gas price, we expect 7 to 8 fewer deaths when holding the distance traveled constant. For every 1000 km driven (holding gas prices constant) we expect 1 to 2 fewer deaths. All results are significant w/ 95% confidence.

---

## Question 2

Compare the `kms` coefficient with and without the inclusion of the `PetrolPrice` variable in the model.


```r
cor(sb$pp, sb$mmc)
```

```
[1] 0.3839004
```

```r
fit3 <- lm(DriversKilled ~ mmc, sb)
summary(fit2)$coef
```

```
              Estimate Std. Error   t value      Pr(>|t|)
(Intercept) 122.802083  1.6628507 73.850336 2.395106e-141
pp           -7.838674  1.8055491 -4.341435  2.304713e-05
mmc          -1.749546  0.6145401 -2.846919  4.902428e-03
```

```r
summary(fit3)$coef
```

```
              Estimate Std. Error  t value      Pr(>|t|)
(Intercept) 122.802083  1.7391997 70.60839 2.665611e-138
mmc          -2.773787  0.5935049 -4.67357  5.596266e-06
```

```r
anova(fit2, fit3)
```

```
Analysis of Variance Table

Model 1: DriversKilled ~ pp + mmc
Model 2: DriversKilled ~ mmc
  Res.Df    RSS Df Sum of Sq      F    Pr(>F)    
1    189 100339                                  
2    190 110345 -1    -10006 18.848 2.305e-05 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

**ANSWER:** Holding gas price constant, distance driven is related to a decrease of 1 to 2 driver deaths per 1000 km driven, with a $p$-value of .0049. When not fixing gas prices, distance driven is related to a decrease of 2 to 3 drivers deaths, with a $p$-value of effectively 0. Correlation between distance driven & gas prices suggest some interaction here.

---

## Question 3

Compare the `PetrolPrice` coefficient with and without the inclusion of the `kms` variable in the model.


```r
cor(sb$pp, sb$mmc)
```

```
[1] 0.3839004
```

```r
fit4 <- lm(DriversKilled ~ pp, sb)
summary(fit2)$coef
```

```
              Estimate Std. Error   t value      Pr(>|t|)
(Intercept) 122.802083  1.6628507 73.850336 2.395106e-141
pp           -7.838674  1.8055491 -4.341435  2.304713e-05
mmc          -1.749546  0.6145401 -2.846919  4.902428e-03
```

```r
summary(fit4)$coef
```

```
              Estimate Std. Error   t value      Pr(>|t|)
(Intercept) 122.802083   1.693656 72.507096 2.061333e-140
pp           -9.812019   1.698084 -5.778288  3.044208e-08
```

```r
anova(fit2, fit4)
```

```
Analysis of Variance Table

Model 1: DriversKilled ~ pp + mmc
Model 2: DriversKilled ~ pp
  Res.Df    RSS Df Sum of Sq      F   Pr(>F)   
1    189 100339                                
2    190 104642 -1   -4302.9 8.1049 0.004902 **
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

**ANSWER:** Holding distance driven as constant, gas prices are related to a decrease of 7 to 8 driver deaths per 1 std deviation change in gas prices, with a $p$-value of .00002. When not fixing distance driven, gas prices are related to a decrease of 9 to 10 drivers deaths, with a $p$-value of effectively 0. Correlation between distance driven & gas prices suggest some interaction here.

---

## Just for fun


```r
fit5 <- lm(DriversKilled ~ pp + mmc + pp * mmc, sb)
summary(fit5)$coef
```

```
               Estimate Std. Error    t value      Pr(>|t|)
(Intercept) 122.2793560  1.8227763 67.0841256 2.941988e-133
pp           -7.8454995  1.8079837 -4.3393642  2.330201e-05
mmc          -1.8567390  0.6338759 -2.9291836  3.819105e-03
pp:mmc        0.4658707  0.6609899  0.7048076  4.818022e-01
```

```r
anova(fit2, fit3, fit4, fit5)
```

```
Analysis of Variance Table

Model 1: DriversKilled ~ pp + mmc
Model 2: DriversKilled ~ mmc
Model 3: DriversKilled ~ pp
Model 4: DriversKilled ~ pp + mmc + pp * mmc
  Res.Df    RSS Df Sum of Sq       F    Pr(>F)    
1    189 100339                                   
2    190 110345 -1  -10006.3 18.7979 2.366e-05 ***
3    190 104642  0    5703.5                      
4    188 100075  2    4567.3  4.2901   0.01507 *  
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```
