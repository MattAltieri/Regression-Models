# Some Basic Notation and Background - Exercises

## Question 1

Take the Galton dataset and find the mean, standard deviation, and correlation between the parental and child heights


```r
library(UsingR); data(galton)
x <- galton$parent
y <- galton$child
mx <- mean(x)
my <- mean(y)
sdx <- sd(x)
sdy <- sd(y)
corxy <- cor(x, y)
mx
```

```
## [1] 68.30819
```

```r
sdx
```

```
## [1] 1.787333
```

```r
my
```

```
## [1] 68.08847
```

```r
sdy
```

```
## [1] 2.517941
```

```r
corxy
```

```
## [1] 0.4587624
```

```r
# -OR-
summary(galton)
```

```
##      child           parent     
##  Min.   :61.70   Min.   :64.00  
##  1st Qu.:66.20   1st Qu.:67.50  
##  Median :68.20   Median :68.50  
##  Mean   :68.09   Mean   :68.31  
##  3rd Qu.:70.20   3rd Qu.:69.50  
##  Max.   :73.70   Max.   :73.00
```

```r
cor(galton)
```

```
##            child    parent
## child  1.0000000 0.4587624
## parent 0.4587624 1.0000000
```

#### ANSWERS

**Mean Parent Height:** 68.30819

**Std. Dev. of Parent Height:** 1.787333

**Mean Child Height:** 68.08847

**Std. Dev. of Child Height:** 2.517941

**Correlation between parent and child height:** 0.4587624

---

## Question 2

Center the parent and child variables and verify that the centered variable means are 0


```r
xc <- x - mx
round(mean(xc), 5)
```

```
## [1] 0
```

```r
yc <- y - my
round(mean(yc), 5)
```

```
## [1] 0
```

---

## Question 3

Rescale the parent and child variables and verify that the scaled variable standard deviations are 1


```r
xs <- x/sdx
round(sd(xs), 5)
```

```
## [1] 1
```

```r
ys <- y/sdy
round(sd(ys), 5)
```

```
## [1] 1
```

---

## Question 4

Normalize the parental and child heights. Verify that the normalized variables have mean 0 and standard deviation 1 and take the correlation between them


```r
xnorm <- xc / sdx
round(mean(xnorm), 5)
```

```
## [1] 0
```

```r
round(sd(xnorm), 5)
```

```
## [1] 1
```

```r
ynorm <- yc / sdy
round(mean(ynorm), 5)
```

```
## [1] 0
```

```r
round(sd(ynorm), 5)
```

```
## [1] 1
```

```r
cor(xnorm, ynorm)
```

```
## [1] 0.4587624
```
