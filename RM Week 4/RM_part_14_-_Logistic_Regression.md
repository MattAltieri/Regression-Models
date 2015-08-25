# Logistic Regression



## Key Ideas

- Frequently we care about outcomes that have two values
    - Alive/dead
    - Win/loss
    - Success/Failure
    - Etc
- Called binary, Bernoulli, or 0/1 outcomes
- Collection of exchangeable binary outcomes for the same covariate data are called binomial outcomes

---

## Example: Baltimore Ravens Win/Loss

#### Ravens Data


```r
# download.file("https://dl.dropboxusercontent.com/u/7710864/data/ravensData.rda", destfile="./data/ravensData.rda")
load("./data/ravensData.rda")
head(ravensData)
```

```
  ravenWinNum ravenWin ravenScore opponentScore
1           1        W         24             9
2           1        W         38            35
3           1        W         28            13
4           1        W         34            31
5           1        W         44            13
6           0        L         23            24
```

---

## Linear Regression

$$
RW_i = b_0 + b_1 RS_i + e_i
$$

$RW_i$ - 1 if a Ravens win, 0 if not

$RS_i$ - Number of points Ravens Scored

$b_0$ - Probability of a Ravens win if they scored 0 points

$b_1$ - Increase in probability of a Ravens win for each additional point

$e_i$ - Residual Variation

---

## Linear Regression in R


```r
lmRavens <- lm(ravensData$ravenWinNum ~ ravensData$ravenScore)
summary(lmRavens)$coef
```

```
                        Estimate  Std. Error  t value   Pr(>|t|)
(Intercept)           0.28503172 0.256643165 1.110615 0.28135043
ravensData$ravenScore 0.01589917 0.009058997 1.755069 0.09625261
```

---

## Odds

**Binary Outcome 0/1**

$$
RW_I
$$

**Probability (0,1)**

$$
\rm{Pr}(RW_i ~|~ RS_i,b_0,b_1)
$$

**Odds (0,$\infty$)**

$$
\frac{\rm{Pr}(RW_i ~|~ RS_i,b_0,b_1)}{1 - \rm{Pr}(RW_i ~|~ RS_i,b_0,b_1)}
$$

**Log Odds ($-\infty,\infty$)**

$$
\log\left(\frac{\rm{Pr}(RW_i ~|~ RS_i,b_0,b_1)}{1 - \rm{Pr}(RW_i ~|~ RS_i,b_0,b_1)}\right)
$$

---
