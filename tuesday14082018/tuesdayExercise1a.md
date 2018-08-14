
To translate a probability density distribution P(X) of a random variable X to a PDF P(Y) with new random variable Y we can use the principle of conservation of probability:

$$\left| P(X) \, dX \right| = \left| P(Y) \, dY \right| \;\;\; ,$$

which we can write to

$$P(X) = P(Y) \, \left| \frac{dY}{dX} \right| \;\;\; .$$

With the usage of trigonometry we can derive the following equation:

$$tan(\Theta_k) = \frac{x_0 - x_k}{y_0} \; \Rightarrow \; \Theta_k = tan^{-1}\left( \frac{x_0 - x_k}{y_0} \right) \;\;\; .$$

The exercise states, that the light pulses are emitted randomly in every horizontal direction with no direction preferred and no existing correlation among the directions of the flashes. Therefore, we apply for the PDF $P(\Theta_k) = U(0, \pi)$ a uniform distribution from 0 to $\pi$ to get signals along the coast.
Now, to transform the PDF of the random variable $\Theta$ into the PDF of the random variable $x$, we apply the principle of conservation of probability, which gives us

$$P(x) = U(0, \pi) \, \left| \frac{d\Theta}{dx_k} \right| \;\;\; ,$$

where $$\left| \frac{d\Theta}{dx_k} \right| = \left| \frac{d}{dx_k} \, tan^{-1}\left( \frac{x_0 - x_k}{y_0} \right) \right| = \left| \frac{y_0}{(x_0 - x_k)^2 + y_0^2} \right| \;\;\; .$$

This gives us the full expression:

$$P(x) = U(0, \pi) \, \left| \frac{y_0}{(x_0 - x_k)^2 + y_0^2} \right| \;\;\; .$$ 
