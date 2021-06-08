# An Overview of Linear Algebra

Linear algebra progresses from vectors to matrices to subspaces.

## Vectors

What do you do with vectors? Take combinations.

We can multiply vectors by scalars, add, and subtract. Given vectors $\mathbf{u}$, $\mathbf{v}$ and $\mathbf{w}$ we can form the `linear combination` $x_1 \mathbf{u} + x_2\mathbf{v} + x_3\mathbf{w} = \mathbf{b}$.

An example in $\mathbb{R}^3$ would be:

$$
\mathbf{u} = \begin{bmatrix} 1 \\ -1 \\ 0 \end{bmatrix}, \mathbf{v} = \begin{bmatrix} 0 \\ 1 \\ -1 \end{bmatrix}, \mathbf{w} = \begin{bmatrix} 0 \\ 0 \\ 1 \end{bmatrix}
$$

The collection of all multiples of $\mathbf{u}$ forms a line through the origin. The collection of all multiples of $\mathbf{v}$ forms another line. The collection of all combinations of $\mathbf{u}$ and $\mathbf{v}$ forms a plane. Taking all combinations of some vectors creates a `subspace`.

We could continue like this, or we can use a matrix to add in all multiples of $\mathbf{w}$.

## Matrices

Create a matrix $A$ with vectors $\mathbf{u}$, $\mathbf{v}$ and $\mathbf{w}$ in its colums:

$$
A =
\begin{bmatrix}
1 & 0 & 0 \\
-11 & 1 & 0 \\
0 & -1 & 1
\end{bmatrix}
$$

The product:

$$
A \mathbf{x} = 
\begin{bmatrix}
1 & 0 & 0 \\
-1 & 1 & 0 \\
0 & -1 & 1
\end{bmatrix}
\begin{bmatrix}
x_1 \\
x_2 \\
x_3
\end{bmatrix}
= 
\begin{bmatrix}
x_1 \\
-x_1 + x_2 \\
-x_2 + x_3
\end{bmatrix}
$$

equals the sum $x_1\mathbf{u} + x_2\mathbf{v} + x_3\mathbf{w} = \mathbf{b}$. The product of a matrix and a vector is a combination of the columns of the matrix. (This particular matrix A is a `difference matrix` because the components of $A\mathbf{x}$ are differences of the components of that vector.)
