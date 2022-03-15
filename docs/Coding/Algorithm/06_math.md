# Math

## Greatest Common Divisor(GCD)

Greatest common divisor(GCD) of two positive integers is the largest positive integer that divides both numbers without remainder. It is useful for reducing fractions to be in its lowest terms.

```C++
int gcd(int x, inty) { return y ? gcd(y, x % y) : x; }
```

## Least Common Multiple(LCM)

Least common multiple(LCM) of two integer is the smallest integer that is a multiple of both numbers.

```C++
int lcm(int x, int y) { return x / gcd(x, y) * y; }
```

## Probability

### Conditional Probability

The conditional probability of an event $A$, given an event $B$ with $P(B) > 0$, is defined by:

$$
P(A|B) = \frac{P(A \cap B)} {P(B)}
$$

$$
A(A \cap B) = P(B) * P(A|B)
$$

### Multiplication Rule

Assuming that all of the conditioning events have positive probability, we have:

$$
P(\cap^{n}_{i = 1} A_{i}) = P(A_1) P(A_2 | A_1) P(A_3 | A_1 \cap A_2) \cdots P(A_n | \cap^{n - 1}_{i = 1} A_{i})
$$

### Total Probability Theorem

Let $A_1, \cdots, A_n$ be disjoint events that form a partition of the sample space (each possible outcome is included in one and only one of the events $A_1, \cdots, A_n$) and assume that $P(A_i) > 0$, for all $i = 1, \cdots, n$. Then, for any event B, we have:

$$
\begin{align}
P(B) &= P(A_1 \cap B) + \cdots + P(A_n \cap B) \\
     &= P(A_1)P(B|A_1) + \cdots + P(A_n)P(B|A_n) \\
\end{align}
$$

### Bayes' Rule

Let $A_1, A_2, \cdots, A_n$ be disjoint events that form a partition of the sample space, and assume that $P(A_i) > 0$, for all $i$. Then, for any event B such that $P(B) > 0$, we have:

$$
\begin{align}
P(A_i | B) &= \frac{P(A_i) P(B | A_i)} {P(B)} \\
           &= \frac{P(A_i) P(B | A_i)} {P(A_1)P(B|A_1) + \cdots + P(A_n)P(B|A_n)}
\end{align}
$$
