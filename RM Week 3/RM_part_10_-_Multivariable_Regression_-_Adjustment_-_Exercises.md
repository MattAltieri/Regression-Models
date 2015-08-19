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

