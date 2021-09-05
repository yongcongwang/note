# Algorithm Analysis

An `algorithm` is a clearly specified set of simple instructions to be followed to solve a problem. The important step of algorithm analysis is to determine how much in the way of resource, such as time or spaces, the algorithm requires.

## Mathematical Definitions

We use following definitions to estimate the resource use of an algorithm:

- $T(N) = O(f(N))$, if there are positive constants $c$ and $n_0$ such that $T(N) <= c \cdot f(N)$ when $N >= n_0$.
- $T(N) = \Omega(g(N))$, if there are positive constants $c$ and $n_0$ such that $T(N) >= c \cdot g(N)$ when $N >= n_0$.
- $T(N) = \Theta(h(N))$, if $T(N) = O(h(N))$ and $T(N) = \Omega(h(N))$.
- $T(N) = o(p(N))$, if for all positive constant $c$, there exists an $n_0$ such that $T(N) < c \cdot p(N)$ when $N > n_0$. In other words, $T(N) = o(p(N))$ if $T(N) = O(p(N))$ and $T(N) \ne \Theta(p(N))$

When we say that $T(N) = O(f(N))$, we are guaranteeing that the function $T(N)$ grows at a rate no faster than $f(N)$, $f(N)$ is an `upper bound` on $T(N)$; since this implies that $f(N) = \Omega(T(N))$, we say that $T(N)$ is a `lower bound` on $f(N)$.

Here are some important rules to know:

1. If $T_1(N) = O(f(N))$ and $T_2(N) = O(g(N))$, then:
 - $T_1(N) + T_2(N) = O(f(N) + g(N))$
 - $T_1(N) * T_2(N) = O(f(N) * g(N))$
2. If $T(N)$ is a polynomial of degree $k$, then $T(N) = \Theta(N^k)$
3. $\log^k(N) = O(N)$ for any constant $k$.

## General Rules
Since we are giving the running time in terms of `Big-Oh`, there are lots of shortcuts that can be taken without affecting the final answer.

### For Loops
The running time of a `for` loop is at most the running time of the statements inside the `for` loop times the number of iterations.

### Nested Loops
The total running time of a statement inside a group of nested loops is the running time of the statement multiplied by the product of the sizes of all the loops.

### Consecutive Statements
Just add them all. The maximum is the one that counts.

### If/else
The running of an `if/else` statement is never more than the running time of the larger of the running time of two statements.

### Stratagy of Analyzing Recursion
If the recursion is really just a thinly veiled `for` loop, the analysis is usually trivial.

If the recursion is properly used, it is difficult to convert the recursion into a simple loop structure. In this case, the analysis will involve a recurrence relation that needs to be solved.

We firstly let $T(N)$ be the running time for current function, and then running time involved with recursion is represented, for example:
$$
T(N) = T(N - 1) + T(N - 2)
$$
And then we can solve the equation and analysis the approximate running time.

### Logarithms in the Running Time
An algorithm is $O(N)$ if it take constant time to cut the problem size by a fraction (which is usually $\frac{1}{2}$). Otherwise, if constant time is required to merely reduce the problem by a constant amount(such as 1), the algorithm is $O(N)$.
