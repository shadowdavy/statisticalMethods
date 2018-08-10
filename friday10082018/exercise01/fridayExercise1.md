
cov[$x$, $x^2$] = E[$x \cdot x^2$] - E[$x$]E[$x^2$] = E[$x^3$] - E[$x$]E[$x^2$]

The expected value of a normal distribution is in our case vor N(0, 1): 

E[$x$] = $\mu$ = 0

We can calculate the expected value with E[$x$] = $\int_{-\infty}^\infty x f_X(x)\,\mathrm{d}x$.

In this cas we get for cov[$x$, $x^2$] = $\int_{-\infty}^\infty x^3 N(x | \mu, \sigma^2)\,\mathrm{d}x - \int_{-\infty}^\infty x N(x | \mu, \sigma^2)\,\mathrm{d}x \cdot \int_{-\infty}^\infty x^2 N(x | \mu, \sigma^2)\,\mathrm{d}x$, where $N(x | \mu, \sigma^2)$ is the normal distribution.

Because E[$x$] = $\mu$ = $\int_{-\infty}^\infty x N(x | \mu, \sigma^2)\,\mathrm{d}x$ = 0 $\Rightarrow \int_{-\infty}^\infty x N(x | \mu, \sigma^2)\,\mathrm{d}x \cdot \int_{-\infty}^\infty x^2 N(x | \mu, \sigma^2)\,\mathrm{d}x$ = 0. In case of E[$x^3$] = $\int_{-\infty}^\infty x^3 N(x | \mu, \sigma^2)\,\mathrm{d}x$ we have antisymmetry which gives us also zero. Therefore, our 

cov[$x, x^2$] = 0

To calculate the correlation we use cor[$x, x^2$] = $\frac{cov[x, x^2]}{\sigma_x \sigma_x^2}$. For cov[$x, x^2$] = 0 follows:

cor[$x, x^2$] = 0


An alternate method for calculating the expectation value would be the moment generating function $M(t)$.

$ E[x^n] = \frac{d^n \, M(t)}{dt^n} |_{t=0} $. In case of the normal distribution $M(t) = exp(t \mu + \frac{\sigma^2 t^2}{2})$. For $\mu = 0$ and $\sigma^2 = 1$ we get $M(t) = exp(\frac{t^2}{2})$. As mentiond above E[$x$] = 0 $\Rightarrow$ E[$x$]E[$x^2$] = 0. With the moment generating function we get for $x^3 \Rightarrow n = 3$ an expected value of $E[x^3] = \frac{d^3 exp(\frac{t^2}{2})}{dt^3}) |_{t = 0} = 0$. Therefore cov[$x, x^2$] = 0 and cor[$x, x^2$] = 0.


The uniform distibution is given by U(a, b) = 1 in the interval [a, b], otherwise 0. We can calculate the expected value as above using $E[x] = \int_{-\infty}^\infty x f(x)\,\mathrm{d}x$. For the uniform distibution we end up with

$E[x] = \int_{-\infty}^\infty x U(a, b)\,\mathrm{d}x = \int_{a}^b x U(a, b)\,\mathrm{d}x = \int_{0}^1 x U(a, b)\,\mathrm{d}x = \frac{1}{2}$.

Evaluating the integral for E[$x^2$], E[$x^3$], E[$x^4$] gives us

E[$x^2$] = $\frac{1}{3}$, E[$x^3$] = $\frac{1}{4}$, E[$x^4$] = $\frac{1}{5}$.

cov[$x$, $x^2$] = E[$x^3$] - E[$x$]E[$x^2$] = $\frac{1}{4} - \frac{1}{2}\frac{1}{3} = \frac{1}{12}$.

To calculate the correlation we first need to determine the variance for $x^2$, which we can do with

$var[x^2] = E[(x^2)^2] - E[x^2]^2 = E[x^4] - E[x^2]^2 = \frac{1}{5} - \frac{1}{9} = \frac{4}{45}$.

Therefor we get for

cor[$x, x^2$] = $\frac{cov[x, x^2]}{\sigma_x \sigma_x^2} = \frac{\frac{1}{12}}{\sqrt{\frac{1}{12}}\sqrt{\frac{4}{45}}} = \frac{1}{4}\sqrt{15}$

Correlation and independence are two different things. In case a) $x$ and $x^2$ may be uncorrelated but NOT independent.
