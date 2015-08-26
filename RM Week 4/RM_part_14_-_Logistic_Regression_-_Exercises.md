# Logistic Regression - Exercises



## Question 1

Load the dataset `Seatbelts` as part of the `datasets` package via `data(Seatbelts)`. Use `as.data.frame` to convert the object to a dataframe. Create a new outcome variable for whether or not greater than 119 drivers were killed that month. Fit a logistic regression GLM with this variable as the outcome and `kms`, `PetrolPrice`, and `law` as predictors. Interpret your parameters.


```r
require(datasets)
require(dplyr)
data(Seatbelts)
sb <- as.data.frame(Seatbelts)
sb <- mutate(sb,
             pp = (PetrolPrice - mean(PetrolPrice)) / sd(PetrolPrice),
             mm = kms / 1000,
             mmc = mm - mean(mm),
             dk119 = 1 * (DriversKilled > 119))
fit <- glm(dk119 ~ pp + mmc + law, binomial, sb)
1 - exp(summary(fit)$coef[,1])
```

```
(Intercept)          pp         mmc         law 
-0.02461150  0.34058863  0.00293403  0.45964149 
```

```r
exp(confint(fit))
```

```
                2.5 %    97.5 %
(Intercept) 0.7465210 1.4042372
pp          0.4682230 0.9137756
mmc         0.8863038 1.1218054
law         0.1639968 1.6223972
```

```r
anova(fit)
```

```
Analysis of Deviance Table

Model: binomial, link: logit

Response: dk119

Terms added sequentially (first to last)

     Df Deviance Resid. Df Resid. Dev
NULL                   191     266.08
pp    1  11.0327       190     255.05
mmc   1   0.2566       189     254.80
law   1   1.1782       188     253.62
```

**ANSWER:** We saw a 45% decrease in the odds that > 119 drivers were killed once the law was enacted, holding gas prices & distance traveled constant.

---

## Question 2

Fit a binomial model with `DriversKilled` as the outcome and `drivers` as the total count with `kms`, `PetrolPrice`, and `law` as predictors, interpret your results.



---
