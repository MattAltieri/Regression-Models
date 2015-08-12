# diamond data
library(UsingR)
data(diamond)
y <- diamond$price
x <- diamond$carat
n <- length(y)
df <- n - 2
beta1 <- cor(y,x) * sd(y) / sd(x)
beta0 <- mean(y) - beta1 * mean(x)
e <- y - beta0 - beta1 * x
sigma <- sqrt(sum(e^2) / df)
ssx <- sum((x - mean(x))^2) # sum of the squares of x
seBeta0 <- sqrt(1 / n + mean(x)^2 / ssx) * sigma
seBeta1 <- sigma / sqrt(ssx)
tBeta0 <- beta0 / seBeta0
tBeta1 <- beta1 / seBeta1
pBeta0 <- 2 * pt(abs(tBeta0), df=df, lower.tail=F)
pBeta1 <- 2 * pt(abs(tBeta1), df=df, lower.tail=F)
coefTable <- rbind(c(beta0,seBeta0,tBeta0,pBeta0),
                   c(beta1,seBeta1,tBeta1,pBeta1))
colnames(coefTable) <- c("Estimate","Std. Error","t value","P(>|t|)")
rownames(coefTable) <- c("(Intercept)","x")
coefTable
summary(lm(y ~ x))$coefficients

# father.son
data(father.son)
y <- father.son$sheight
x <- father.son$fheight
n <- length(y)
df <- n - 2
beta1 <- cor(y,x) * sd(y) / sd(x)
beta0 <- mean(y) - beta1 * mean(x)
e <- y - beta0 - beta1 * x
sigma <- sqrt(sum(e^2) / df)
ssx <- sum((x - mean(x))^2)
seBeta0 <- sqrt(1 / n + mean(x)^2 / ssx) * sigma
seBeta1 <- sigma / sqrt(ssx)
tBeta0 <- beta0 / seBeta0
tBeta1 <- beta1 / seBeta1
pBeta0 <- 2 * pt(abs(tBeta0), df=df, lower.tail=F)
pBeta1 <- 2 * pt(abs(tBeta1), df=df, lower.tail=F)
coefTable <- rbind(c(beta0,seBeta0,tBeta0,pBeta0),
                   c(beta1,seBeta1,tBeta1,pBeta1))
colnames(coefTable) <- c("Estimate","Std. Error","t value","P(>|t|)")
rownames(coefTable) <- c("(Intercept)","x")
coefTable
summary(lm(y ~ x))$coefficients

# galton
data(galton)
y <- galton$child
x <- galton$parent
n <- length(y)
df <- n - 2
beta1 <- cor(y,x) * sd(y) / sd(x)
beta0 <- mean(y) - beta1 * mean(x)
e <- y - beta0 - beta1 * x
sigma <- sqrt(sum(e^2) / df)
ssx <- sum((x - mean(x))^2)
seBeta0 <- sqrt(1 / n + mean(x)^2 / ssx) * sigma
seBeta1 <- sigma / sqrt(ssx)
tBeta0 <- beta0 / seBeta0
tBeta1 <- beta1 / seBeta1
pBeta0 <- 2 * pt(abs(tBeta0), df=df, lower.tail=F)
pBeta1 <- 2 * pt(abs(tBeta1), df=df, lower.tail=F)
coefTable <- rbind(c(beta0,seBeta0,tBeta0,pBeta0),
                   c(beta1,seBeta1,tBeta1,pBeta1))
colnames(coefTable) <- c("Estimate","Std. Error","t value","P(>|t|)")
rownames(coefTable) <- c("(Intercept)","x")
coefTable
summary(lm(y ~ x))$coefficients