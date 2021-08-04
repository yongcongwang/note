# Projections onto Subspaces

## Projections

If we have a vector $\mathbf{b}$ and a line determined by a vector $\mathbf{a}$, how do we find the point on the line that is closet to $\mathbf{b}$?

![projection](images/projection/proj_2d.png)

We can see from the figure that this closet point $\mathbf{p}$ is at the intersection formed by a line through $\mathbf{b}$ that is orthogonal to $\mathbf{a}$. If we think of $\mathbf{p}$ as an approximation of $\mathbf{b}$, then the length of $\mathbf{e} = \mathbf{b} - \mathbf{p}$ is the error in that approximation.

We could try to find $\mathbf{p}$ using trigonometry or calculus, but it's easier to use linear algebra. Since $\mathbf{p}$ lies on the line through $\mathbf{a}$, we know $\mathbf{p} = m\mathbf{a}$ for some number $m$. We also know that $\mathbf{a}$ is perpendicular to $\mathbf{e} = \mathbf{b} = \mathbf{x}\mathbf{a}$:

$$
\begin{align}
\mathbf{a}^T (\mathbf{b} - \mathbf{x}\mathbf{a}) &= 0 \\
\mathbf{x}\mathbf{a}^T\mathbf{a} &= \mathbf{a}^T\mathbf{b} \\
\mathbf{x} &= \frac{\mathbf{a}^T\mathbf{b}}{\mathbf{a}^T\mathbf{a}}
\end{align}
$$

and

$$
\mathbf{p} = x\mathbf{a} = \frac{\mathbf{a}^T\mathbf{b}}{\mathbf{a}^T\mathbf{a}} \mathbf{a}
$$

Doubing $\mathbf{b}$ will double $\mathbf{p}$, doubling $\mathbf{a}$ does not affect $\mathbf{p}$.

## Projection Matrix

We'd like to write this projection in terms of a `projection matrix` $P$: $\mathbf{p} = P\mathbf{b}$.

As

$$
\mathbf{p} = x\mathbf{a} = \frac{\mathbf{a}^T\mathbf{b}}{\mathbf{a}^T\mathbf{a}} \mathbf{a}
$$

so the matrix is:

$$
P = \frac{\mathbf{a}\mathbf{a}^T}{\mathbf{a}^T\mathbf{a}} = 
$$

Note that $\mathbf{a}\mathbf{a}^T$ is a $3 \times 3$ matrix, not a number; matrix multiplication is not commutative.

The column space of $P$ is spanned by $\mathbf{a}$ because for any $\mathbf{b}$, $P\mathbf{b}$ lies on the line determined by $\mathbf{a}$. The rank of $P$ is $1$. 
