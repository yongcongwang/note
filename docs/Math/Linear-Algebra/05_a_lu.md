# Factorization into $A=LU$

One goal of today's lecture is to understand Gaussian elimination int terms of matrices; to find a matrix $L$ such that $A = LU$. We start with some useful facts about matrix multiplication.

## Inverse of a product

The inverse of a matrix product $AB$ is $B^{-1}A^{-1}$.

## Transpose of a product

We obtain the `transpose` of a matrix by exchanging its rows and columns. In other words, the entry in row $i$ column $j$ of $A$ is the entry in row $j$ column $i$ of $A^T$.

The transpose of a matrix product $AB$ is $B^TA^T$. For any invertible matrix $A$, the inverse of $A^T$ is $(A^{-1})^T$.

## $A = LU$

We've seen how to use elimination to convert a suitable matrix $A$ into upper triangular matrix $U$. This leads to the factorization $A = LU$, which is very helpful in understanding the matrix $A$.

Recall that (when there are no row exchanges) we can describe the elimination of the entries of matrix $A$ in terms of multiplication by a succession of elimination matrices $E_{ij}$, so that $A \to E_{21}A \to E_{31}E_{21}A \to \cdots \to U$. In the two by two case this looks like:

$$
E_{21} \quad A \quad = \quad U
$$

$$
\begin{bmatrix}
1 & 0 \\ -4 & 1
\end{bmatrix}
\begin{bmatrix}
2 & 1 \\ 8 & 7
\end{bmatrix}
=
\begin{bmatrix}
2 & 1 \\ 0 & 3
\end{bmatrix}
$$

We can convert this to a factorization $A = LU$ by "canceling" the matrix $E_{21}$; multiply by its inverse to get $E_{21}^{-1}E_{21}A = E_{21}^{-1}U$.

$$
A \quad = \quad L \quad U
$$

$$
\begin{bmatrix}
2 & 1 \\ 8 & 7
\end{bmatrix}
=
\begin{bmatrix}
1 & 0 \\ 4 & 1
\end{bmatrix}
\begin{bmatrix}
2 & 1 \\ 0 & 7
\end{bmatrix}
$$

The matrix $U$ is `upper triangular` with pivots on the diagonal. The matrix $L$ is `lower triangular` and has ones on the diagonal. Sometimes we will also want to factor out a diagonal matrix whose entries are the pivots:

$$
A \qquad = \qquad L \qquad D \qquad U'
$$

$$
\begin{bmatrix}
2 & 1 \\ 8 & 7
\end{bmatrix}
=
\begin{bmatrix}
1 & 0 \\ 4 & 1
\end{bmatrix}
\begin{bmatrix}
2 & 0 \\ 0 & 3
\end{bmatrix}
\begin{bmatrix}
1 & 1/2 \\ 0 & 1
\end{bmatrix}
$$

In the three dimensional case, if $E_{32}E_{31}E_{21}A = U$ then $A = E_{21}^{-1}E_{31}^{-1}E_{32}^{-1}U = LU$.

For example, suppose $E_{31}$ is the identity matrix and $E_{32}$ and $E_{21}$ are as shown below:

$$
E_{32} \qquad E_{21} \qquad = \qquad E
$$

$$
\begin{bmatrix}
1 & 0 & 0 \\
0 & 1 & 0 \\
0 & -5 & 1
\end{bmatrix}
\begin{bmatrix}
1 & 0 & 0 \\
-2 & 1 & 0 \\
0 & 0 & 1
\end{bmatrix}
=
\begin{bmatrix}
1 & 0 & 0 \\
-2 & 1 & 0 \\
10 & -5 & 1
\end{bmatrix}
$$

The $10$ in the below left corner arises because we subtracted twice the first row from the second row from the second row, then subtracted five times the new second row from the third.
