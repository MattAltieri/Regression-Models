# Introduction to Regression

## A Famous Motivating Example

![](galton.jpg)

###### (Perhaps surprisingly, this example is still relevant)

![](height.png)

[http://www.nature.com/ejhg/journal/v17/n8/full/ejhg20095a.html](http://www.nature.com/ejhg/journal/v17/n8/full/ejhg20095a.html)

[Predicting height: the Victorian approach beats modern genomics](http://www.wired.com/2009/03/predicting-height-the-victorian-approach-beats-modern-genomics/)

## Recent Simply Statistics Post

(Simply Statistics is a blog by Jeff Leek, Roger Peng, and Rafael Irizarry, who wrote this post, link on the image)

<a href="http://simplystatistics.org/2013/01/28/data-supports-claim-that-if-kobe-stops-ball-hogging-the-lakers-will-win-more/">
<img class=center src=http://simplystatistics.org/wp-content/uploads/2013/01/kobelakers1-1024x1024.png height=250></img>
</a>

- "Data supports claim that if Kobe stops ball hogging the Lakers will win more"
- "Linear regression suggests that an increase of 1% in % of shots taken by Kobe results in a drop of 1.16 points (+/- 0.22) in score differential"
- How was it done? Do you agree with the analysis?

## Questions for This class

- Consider trying to answer the following kinds of questions:
    - To use the parents' heights to predict childrens' heights
    - To try to find a parsimonious, easily described mean relationship between parent and children's heights
    - To investigate the variation in children's heights that appear unrelated to parents' heights (residual variation)
    - To quantify what impact genotype information has beyond parental height in explaining child height
    - To figure out how/whether and what assumptions are needed to generalize findings beyond the data in question
    - Why do children of very tall parents tend to be tall, but a little shorter than their parents and why children of very short parents tend to be short, but a little taller than their parents? (This is a famous question called "Regression to the Mean")
    
## Galton's Data

- Leet's look at the data first, used by Francis Galton in 1885
- Galton was a statistician who invented the term and concepts of regression and correlation, founded the journal Biometrika, and was the cousin of Charles Darwin
- You may need to run `install.packages("UsingR")` if the `UsingR` library is not installed
- Let's look at the marginal (parents disregarding children and children disregarding parents) distributions first
    - Parent distribution is all heterosexual couples
    - Correcction for gender via multiplying female heights by 1.08
    - Overplotting is an issue from discretization


```r
library(UsingR)
data(galton)
library(reshape)
long <- melt(galton)
ggplot(long, aes(x=value, fill=variable)) +
    geom_histogram(color="black", binwidth=1) +
    facet_grid(. ~ variable)
```

![](RM_part_1_-_Introduction_files/figure-html/unnamed-chunk-1-1.png) 

## Finding the middle via least squares

- Consider only the children's heights
    - How could one describe the "middle"?
    - One definition, let $Y_i$ be the height of child $i$ for $i = 1,...,n = 928$, then define the middle as the value of $\mu$ that minimizes
    
$$
\sum_{i=1}^n(Y_i-\mu )^2    
$$

- This is physical center of mass of the histogram
- You might have quessed that the answer $\mu =\bar Y$

## Experiment

###### Use R Studio's `manipulate` to see what value of $\mu$ minimizes the sum of the squared deviations


```r
library(manipulate)
myHist <- function(mu) {
    mse <- mean((galton$child - mu)^2)
    ggplot(galton, aes(x=child)) +
        geom_histogram(fill="salmon", color="black", binwidth=1) +
        geom_vline(xintercept=mu, size=3) +
        ggtitle(paste("mu = ", mu, ", MSE = ", round(mse, 2), sep=""))
}
manipulate(myHist(mu), mu=slider(62, 74, step=0.5))
```

## The Least Squares Estimate is the Empirical Mean


```r
ggplot(galton, aes(x=child)) +
    geom_histogram(fill="salmon", color="black", binwidth=1) +
    geom_vline(xintercept=mean(galton$child), size=3)
```

![](RM_part_1_-_Introduction_files/figure-html/unnamed-chunk-3-1.png) 

## The Math (Not Required for This Class)

$$
\begin{eqnarray*}
\sum_{i=1}^n(Y_i-\mu )^2
& = & \sum_{i=1}^n(Y_i-\bar Y +\bar Y-\mu )^2 \\
& = & \sum_{i=1}^n(Y_i-\bar Y)^2 + 2\sum_{i=1}^n(Y_i-\bar Y)(\bar Y-\mu ) + \sum_{i=1}^n(\bar Y-\mu )^2 \\
& = & \sum_{i=1}^n(Y_i-\bar Y)^2 + 2(\bar Y-\mu )\sum_{i=1}^n(Y_i-\bar Y) + \sum_{i=1}^n(\bar Y-\mu )^2 \\
& = & \sum_{i=1}^n(Y_i-\bar Y)^2 + 2(\bar Y-\mu )(\sum_{i=1}^nY_i-n\bar Y) + \sum_{i=1}^n(\bar Y-\mu )^2 \\
& = & \sum_{i=1}^n(Y_i-\bar Y)^2 + \sum_{i=1}^n(\bar Y-\mu )^2 \\
& \ge & \sum_{i=1}^n(Y_i-\bar Y)^2
\end{eqnarray*}
$$

## Comparing Childrens' Heights and Their Parents' Heights


```r
ggplot(galton, aes(x=parent, y=child)) + geom_point()
```

![](RM_part_1_-_Introduction_files/figure-html/unnamed-chunk-4-1.png) 

###### Size of point reresents number of points at that (X, Y) combination


```
## Warning: package 'dplyr' was built under R version 3.1.3
```

```
## 
## Attaching package: 'dplyr'
## 
## The following object is masked from 'package:reshape':
## 
##     rename
## 
## The following objects are masked from 'package:Hmisc':
## 
##     combine, src, summarize
## 
## The following object is masked from 'package:MASS':
## 
##     select
## 
## The following objects are masked from 'package:stats':
## 
##     filter, lag
## 
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

![](RM_part_1_-_Introduction_files/figure-html/unnamed-chunk-5-1.png) 

## Regression Through the Origin

- Suppose that $X_i$ are the parents' heights
- Consider picking the slope $\beta$ that minimizes

$$
\sum_{i=1}^n\left(Y_i-X_i\beta\right)^2
$$

- This is exactly using the origin as a pivot point picking the line that minimizes the sum of the squared vertical distances of the points to the line
- Use R Studio's `manipulate` function to experiment
- Subtract the means so that the origin is the mean of the parent and children's height


```r
y <- galton$child - mean(galton$child)
x <- galton$parent - mean(galton$parent)
freqData <- as.data.frame(table(x, y))
names(freqData) <- c("child", "parent", "freq")
freqData$child <- as.numeric(as.character(freqData$child))
freqData$parent <- as.numeric(as.character(freqData$parent))
myPlot <- function(beta) {
    g <- ggplot(filter(freqData, freq > 0), aes(x=parent, y=child)) +
        scale_size(range=c(2, 20), guide="none") +
        geom_point(color="grey50", aes(size=freq+20, show_guide=F)) +
        geom_point(aes(color=freq, size=freq)) +
        scale_color_gradient(low="lightblue", high="white") +
        geom_abline(intercept=0, slope=beta, size=3)
    mse <- mean((y - beta * x)^2)
    g + ggtitle(paste("beta = ", beta, "MSE = ", round(mse, 3)))
}
manipulate(myPlot(beta), beta=slider(0.6, 1.2, step=0.02))
```

## The Solution

###### In the next few lectures we'll talk about why this is the solution


```r
lm(I(child - mean(child))~ I(parent - mean(parent)) - 1, data=galton)
```

```
## 
## Call:
## lm(formula = I(child - mean(child)) ~ I(parent - mean(parent)) - 
##     1, data = galton)
## 
## Coefficients:
## I(parent - mean(parent))  
##                   0.6463
```

![](RM_part_1_-_Introduction_files/figure-html/unnamed-chunk-8-1.png) 
