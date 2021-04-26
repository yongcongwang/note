# Limit Problems of Polynomials
When you're talking about the limit of a ratio of two polynomials, it's really important to notice where the limit is being taken. In particular, the techniques for dealing with $x \to \infty$ and $x \to a$ (some finite $a$) are completely different.

## Limits Involving Rational Functions as $x \to a$
If the denominator is not $0$, you can just substitute the variable $x$ with its value:

$$
\lim_{x \to -1} \frac{x^2 - 3x + 2} {x - 2} = \frac{(-1)^2 - 3(-1) + 2}{-1 - 2} = \frac{6}{-3} = -2
$$

But if you want to find:

$$
\lim_{x \to 2} \frac{x^2 - 3x + 2} {x - 2}
$$

the substitutiong method may not work, you'll get $(4 - 6 + 2) / (2 - 2)$, which is $0 / 0$. This is called an **indeterminate form**. The technique we used to solve this is called `factoring`:

$$
\lim_{x \to 2} \frac{x^2 - 3x + 2} {x - 2} = \lim_{x \to -2} \frac{(x - 2)(x - 1)} {x - 2} = \lim_{x - 2}
$$
