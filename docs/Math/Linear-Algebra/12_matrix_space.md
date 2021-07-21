# Matrix spaces, Rand 1 and Small World Graphs

We've talked a lot about $\mathbB{R}^n$, but we can think about vector spaces made up of any sort of `vectors` that allow addition and scalar multiplication.

## New vector spaces

### 3 by 3 matrices

We were looking at the space $M$ of all 3 by 3 matrices. We identified some subspaces; the symmetric 3 by 3 matrices $S$, the upper triangular 3 by 3 matrices $U$ and the intersection $D$ of these two spaces - the space of diagonal 3 by 3 matrices.

The dimension of $M$ is 9; we must choose 9 numbers to specify an element of $M$. The space $M$ is very similar to $\mathbb{R}^9$. A good choice of basis is:

$$
\begin{bmatrix}
1 & 0 & 0 \\
0 & 0 & 0 \\
0 & 0 & 0 \\
\end{bmatrix}
,
\begin{bmatrix}
0 & 1 & 0 \\
0 & 0 & 0 \\
0 & 0 & 0 \\
\end{bmatrix}
,
\begin{bmatrix}
0 & 0 & 1 \\
0 & 0 & 0 \\
0 & 0 & 0 \\
\end{bmatrix}
, \cdots
\begin{bmatrix}
0 & 0 & 0 \\
0 & 0 & 0 \\
0 & 1 & 0 \\
\end{bmatrix}
,
\begin{bmatrix}
0 & 0 & 0 \\
0 & 0 & 0 \\
0 & 0 & 1 \\
\end{bmatrix}
$$

The subspace of symmetric matrices $S$ has dimension 6. When choosing an element of $S$ we pick three numbers on the diagonal and three in the upper right, which tell us what must appear in the lower left of the matrix. One basis for $S$ is the collection:

$$
\begin{bmatrix}
1 & 0 & 0 \\
0 & 0 & 0 \\
0 & 0 & 0 \\
\end{bmatrix}
,
\begin{bmatrix}
0 & 1 & 0 \\
1 & 0 & 0 \\
0 & 0 & 0 \\
\end{bmatrix}
,
\begin{bmatrix}
0 & 0 & 1 \\
0 & 0 & 0 \\
1 & 0 & 0 \\
\end{bmatrix}
,
\begin{bmatrix}
0 & 0 & 0 \\
0 & 1 & 0 \\
0 & 0 & 0 \\
\end{bmatrix}
,
\begin{bmatrix}
0 & 0 & 0 \\
0 & 0 & 1 \\
0 & 1 & 0 \\
\end{bmatrix}
,
\begin{bmatrix}
0 & 0 & 0 \\
0 & 0 & 0 \\
0 & 0 & 1 \\
\end{bmatrix}
$$

The dimension of $U$ is again 6; we have the same amount of freedom in selecting the entries of an upper triangular matrix as we did in choosing a symmetric matrix. A basis for $U$ is:

$$
\begin{bmatrix}
1 & 0 & 0 \\
0 & 0 & 0 \\
0 & 0 & 0 \\
\end{bmatrix}
,
\begin{bmatrix}
0 & 1 & 0 \\
0 & 0 & 0 \\
0 & 0 & 0 \\
\end{bmatrix}
,
\begin{bmatrix}
0 & 0 & 1 \\
0 & 0 & 0 \\
0 & 0 & 0 \\
\end{bmatrix}
,
\begin{bmatrix}
0 & 0 & 0 \\
0 & 1 & 0 \\
0 & 0 & 0 \\
\end{bmatrix}
,
\begin{bmatrix}
0 & 0 & 0 \\
0 & 0 & 1 \\
0 & 0 & 0 \\
\end{bmatrix}
,
\begin{bmatrix}
0 & 0 & 0 \\
0 & 0 & 0 \\
0 & 0 & 1 \\
\end{bmatrix}
$$

This happens to be a subset of the basis we chose for $M$, but there is no basis for $S$ that is subset of the basis we chose for M.

The subspace $D = S \cap U$ of diagonal 3 by 3 matrices has dimension 3. Because of the way we chose bases for $U$ and $S$, a good basis for $D$ is the intersection of those bases.

Is $S \cup U$, the set of 3 by 3 matrices which are either symmetric or upper triangular, a subspace of $M$? No. This is like taking two liness in $\mathbb{R}^2$ and asking if together they form a subspace; we have to fill in between them. If we take all possible sums of elements of $S$ and elements of $U$ we get what we call the sum $S + U$. This is a subspace of $M$. In fact, $S + U = M$. For unions and sums, dimensions follow this rule:

$$
\text{dim } S + \text{dim } U = \text{dim } S \cup U + \text{dim } S \cap U
$$
