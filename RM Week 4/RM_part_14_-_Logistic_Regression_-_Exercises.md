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


```r
fit <- glm(cbind(DriversKilled, drivers - DriversKilled) ~ pp + mmc + law, binomial, sb)
summary(fit)$coef
```

```
                Estimate  Std. Error     z value  Pr(>|z|)
(Intercept) -2.536637162 0.007399129 -342.829174 0.0000000
pp          -0.007828905 0.007478975   -1.046789 0.2951971
mmc          0.003644902 0.002732722    1.333799 0.1822698
law          0.030785128 0.026526920    1.160524 0.2458355
```

```r
anova(fit)
```

```
Analysis of Deviance Table

Model: binomial, link: logit

Response: cbind(DriversKilled, drivers - DriversKilled)

Terms added sequentially (first to last)

     Df Deviance Resid. Df Resid. Dev
NULL                   191     234.93
pp    1   0.0075       190     234.92
mmc   1   3.6473       189     231.27
law   1   1.3423       188     229.93
```

```r
1 - exp(summary(fit)$coef[,1])
```

```
 (Intercept)           pp          mmc          law 
 0.920867939  0.007798339 -0.003651553 -0.031263891 
```

```r
exp(confint(fit))
```

```
                 2.5 %     97.5 %
(Intercept) 0.07799027 0.08028545
pp          0.97776134 1.00685099
mmc         0.99829157 1.00904294
law         0.97887037 1.08614238
```

**ANSWER:** This model suggests a 3 % increase in the % of drivers killed once the law was enacted, holding gas price & distance driven fixed.

---

## Question 3

Refer to question 1. Use the `anova` function to compare models with just `law`, `law` and `PetrolPrice`, and all three predictors.


```r
fit <- glm(dk119 ~ law + pp + mmc, binomial, sb)
anova(fit, "chisq")
```

```
Analysis of Deviance Table

Model: binomial, link: logit

Response: dk119

Terms added sequentially (first to last)

     Df Deviance Resid. Df Resid. Dev
NULL                   191     266.08
law   1   5.6891       190     260.40
pp    1   6.7760       189     253.62
mmc   1   0.0024       188     253.62
```
