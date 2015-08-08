# Regression to the Mean - Exercises



## Question 1

You have two noisy scales and a bunch of people that you'd like to weight. You weigh each person on both scales. The correlation was 0.75. If you normalize each set of wieghts, what would you have to multiply the weight on one scale to get a good estimate of the weight on the other scale?

$$
\rho = 0.75
S_x = 1
S_y = 1
x = y \times \rho\frac{S_y}{S_x} \\
x = y \times 0.75\frac{1}{1}\\
x = y \times 0.75
$$

**ANSWER:** 0.75

---

## Question 2

Consider the previous problem. Someone's weight was 2 standard deviations above the mean of the group on the first scale. How many standard deviations above the mean would you estimate them to be on the second?

$$
\rho = 0.75 \\
S_x = 1 \\
S_y = 1 \\
x = 2 \\
y = x \times \rho\frac{S_y}{S_x} \\
y = 2 \times 0.75\frac{1}{1} \\
y = 2 \times 0.75
$$


```r
rho <- 0.75
x <- 2
y <- x * rho
y
```

```
[1] 1.5
```

**ANSWER:** 1.5

---

## Question 3

You ask a collection of husbands and wives to guess how many jellybeans are in a jar. The correlation is 0.2. The standard deviation for the husbands is 10 beans while the standard deviation for the wives is 8 beans. Assume that the data were centered so that 0 is the mean for each. The centered guess for a husband was 30 beans (above the mean) what would be your best estimate of the wife's guess?

$$
\rho = 0.2 \\
S_h = 10 \\
S_w = 8 \\
h = 30 \\
w = h \times \rho\frac{S_w}{S_h}
$$


```r
rho <- .2
sh <- 10
sw <- 8
h <- 30
w <- h * rho * sw/sh
w
```

```
[1] 4.8
```

**ANSWER:** 4.8
