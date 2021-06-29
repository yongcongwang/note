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
