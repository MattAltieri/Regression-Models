# Generalized Linear Models



## Linear Models

- Linear models are the most useful applied statistical technique. However, they are not without their limitations
    - Additive response models don't make much sense if the response is discrete, or strictly positive
    - Additive error models often don't make sense, for example if the outcome has to be positive
    - Transformations are often hard to interpret
    - There's value in modeling the data on the scale that it was collected
    - Particularly interpretable transformations, natural logarithms in specific, aren't applicable for negative or zero values

---

## Generalized linear models

- Introduced in a 1972 RSSB papaer by Nelder and Wedderburn
- Involves three components
    - An _exponential family_ model for the response
    - A systematic component via a linear predictor
    - A link function that connects the means of the response to the linear predictor

---

## Example, Linear Models

- Assume that $Y_i \sim N\left(\mu_i,\sigma^2\right)$ (the Gaussian distribution is an exponential family distribution)
- Define the linear predictor to be $\eta_i = \sum_{k=1}^p X_{ik} \beta_k$
- The link function as $g$ so that $g\left(\mu\right) = \eta$
    - For linear models $g\left(\eta\right) = \mu$ so that $\mu_i = \eta_i$
- This yields the same likelihood model as our additive error Gaussian linear model
$$
Y_i = \sum_{k=1}^p X_{ik} \beta_k + \epsilon_i
$$
where $\epsilon_i \stackrel{iid}{\sim} N\left(0,\sigma^2\right)$

---

## Example, Logistic Regression

- Assume that $Y_i \sim Bernoulli\left(\mu_i\right)$ so that $E\left[Y_i\right] = \mu_i$ where $0 \le \mu_i \le 1$
- Linear predictor $\eta_i = \sum_{k=1}^p X_{ik} \beta_k$
- Link function $g\left(\mu\right) = \eta = \log\left(\frac{\mu}{1 - \mu}\right)$
    - $g$ is the (natural) log odds, referred to as the **logit**
- Note then we can invert the logit function as
$$
\mu_i = \frac{exp\left(\eta_i\right)}{1 + \exp\left(\eta_i\right)} \mbox{ and } 1 - \mu_i = \frac{1}{1 + \exp\left(\eta_i\right)}
$$
Thus the likelihood is
$$
\Pi_{i=1}^n \mu_i^{y_i} \left(1 - \mu_i\right)^{1-y_i} = \exp\left(\sum_{i=1}^n y_i \eta_i\right) \Pi_{i=1}^n \left(1 + \eta_i\right)^{-1}
$$

---

## Example, Poisson Regression

- Assume that $Y_i \sim Poisson\left(\mu_i\right)$ so that $E\left[Y_i\right] = \mu_i$ where $0 \le \mu_i$
- Linear predictor $\eta_i = \sum_{k=1}^p X_{ik} \beta_k$
- Link function $g\left(\mu\right) = \eta = \log\left(\mu\right)$
- Recall that $e^x$is the inverse of $\log\left(x\right)$ so that
$$
\mu_i = e^{\eta_i}
$$
Thus, the likelihood is
$$
\Pi_{i=1}^n \left(y_i !\right)^{-1} \mu_i^{y_i} e^{-\mu_i} \propto \exp\left(\sum_{i=1}^n y_i \eta_i - \sum_{i=1}^n \mu_i \right)
$$

---

## Some Things to Note

- In each case, the only way in which the likelihood depends on the data is through
$$
\sum_{i=1}^n y_i \eta_i = \sum_{i=1}^n y_i \sum_{k=1}^p X_{ik} \beta_k = \sum_{k=1}^p \beta_k \sum_{i=1}^n X_{ik} y_i
$$
Thus if we don't need the full data, only $\sum_{i=1}^n X_{ik} y_i$. This simplification is a consequence of chosing so-called "canonical"" link functions.
- This has to be derived. All models achieve their maximum at the root of the so-called normal equations
$$
0 = \sum_{i=1}^n \frac{\left(Y_i - \mu_i\right)}{Var\left(Y_i\right)} W_i
$$
where $W_i$ are the derivative of the inverse of the link function

---

## About Variances

$$
0 = \sum_{i=1}^n \frac{\left(Y_i - \mu_i\right)}{Var\left(Y_i\right)} W_i
$$

- For the linear model $Var\left(Y_i\right) = \sigma^2$ is constant
- For Bernoulli case $Var\left(Y_i\right) = \mu_i(1 - \mu_i)$
- For the Poisson case $Var(Y_i) = \mu_i$
- In the latter cases, it is often relevant to have a more flexible variance model, even if it doesn't correspond to an actual likelihood
$$
0 = \sum_{i=1}^n \frac{(Y_i - \mu_i)}{\phi\mu_i (1 - \mu_i)} W_i \mbox{ and } 0 = \sum_{i=1}^n \frac{(Y_i - \mu_i)}{\phi\mu_i} W_i
$$
- These are called _quasi-likelihood_ normal equations

---

## Odds and Ends

- The normal equations have to be solved iteratively, resulting in $\hat\beta_k$ and, if included, $\hat\phi$
- Predicted linear predictor responses can be obtained as $\hat\eta = \sum_{k=1}^p X_k \hat\beta_k$
- Predicted mean responses as $\hat\mu = g^{-1}(\hat\eta)$
- Coefficients are interpretted as
$$
g(E[Y ~|~ X_k = x_k + 1, X_{\sim k} = x_{\sim k}]) - g(E[Y ~|~ X_k = x_k, X_{\sim k} = x_{\sim k}]) = \beta_k
$$
or the change in the link function of the expected response per unit of change in $X_k$ holding other regressors constant
- Variations on Newton/Raphson's algorithm are used to do it
- Asymptotics are used for inference usually
- Many of the ideas from linear models can be brought over to GLMs
