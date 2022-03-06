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
