# Properties of Determinants

## Determinants

Now halfway through the course, we leave behind rectangular matrices and focus on square ones. Our next big topics are determinants and eigenvalues.

The `determinant` is a number associated with any square matrix; we'll write it as `det A` or $|A|$. The determinant encodes a lot of information about the matrix; the matrix is invertible exactly when the determinant is non-zero.

## Properties

Rather than start with a big formula, we'll list the properties of the determinant. We already know that $\begin{vmatrix} a & b \\ c & d  \end{vmatrix} = ad - bc$; these properties will give us a formula for the determinant of square matrices of all sizes.

### 1. $|I| = 1$

### 2. If you exchange two rows of a matrix, you reverse the sign of its determinant from positive to negative or from negative to positive.

### 3. (a) If we multiply one row of a matrix by $t$, the determinant is multiplied by $t$:

$$
\begin{vmatrix}
ta & tb \\
c & d \\
\end{vmatrix}
=
t
\begin{vmatrix}
a & b \\
c & d \\
\end{vmatrix}
$$

### 3. (b) The determinant behaves like a linear function on the rows of the matrix:

$$
\begin{vmatrix}
a + a' & b + b' \\
c & d \\
\end{vmatrix}
=
\begin{vmatrix}
a & b \\
c & d \\
\end{vmatrix}
+
\begin{vmatrix}
a' & b' \\
c & d \\
\end{vmatrix}
$$

Property 1 tells us that $\begin{vmatrix} 1 & 0 \\ 0 & 1 \end{vmatrix} = 1$. 
Property 2 tells us that $\begin{vmatrix} 0 & 1 \\ 1 & 0 \end{vmatrix} = -1$.
The determinant of a permutation matrix $P$ is $1$ or $-1$ depending o whether $P$ exchanges an even or odd number of rows.

From these three properties we can deduce many others:

### 4. If two rows of a matrix are equal, its determinant is zero.

This is because of property 2, the exchange rule. On the one hand, exchanging the two identical rows does not change the determinant. On the other hand, exchanging the two rows changes the sign of the determinant. Therefore the determinant must be $0$.

### 5. If $i \ne j$, subtracting $t$ times row $i$ from row $j$ doesn't change the determinant.

In two dimensions, this argument looks like:

$$
\begin{align}
\begin{vmatrix}
a & b \\
c - ta & d - tb \\
\end{vmatrix}
&=
\begin{vmatrix}
a & b \\
c & d \\
\end{vmatrix}
-
\begin{vmatrix}
a & b \\
ta & ta \\
\end{vmatrix}
\text{   property 3(b)} \\
&=
\begin{vmatrix}
a & b \\
c & d \\
\end{vmatrix}
- t
\begin{vmatrix}
a & b \\
a & a \\
\end{vmatrix}
\text{  property 3(a)} \\
&=
\begin{vmatrix}
a & b \\
c & d \\
\end{vmatrix}
\text{  property 4}
\end{align}
$$

The proof for higher dimensional matrices is similar.

### 6. If $A$ has a row that is all zeros, then $\det A = 0$.

We get this from property 3(a) by letting $t = 0$.

### 7. The determinant of a triangular matrix is the product of the diagonal entries(pivots) $d_1, d_2, \cdots, d_n$.

Property 5 tells us that the determinant of the triangular matrix won't change if we use elimination to convert it to a diagonal matrix with the entries $d_i$ on its diagonal. Then property 3(a) tells us that the determinant of this digonal matrix is the product $d_1d_2 \cdots d_n$ times the determinant of the identity matrix. Property 1 completes the arguments.

Note that we cannot use elimination to get a diagonal matrix if one of the $d_i$ is zero. In that case elimination will give us a row of zeros and property 6 gives us the conclusion we want.

### 8. $\det A = 0$ exactly when $A$ is singular.

If $A$ is singular, then we can use elimination to get a row of zeros, and property 6 tells us that determinant is zero.

If $A$ is not singular, then elimination produces a full set of pivots $d_1, d_2, \cdots, d_n$ and the determinant is $d_1d_2 \cdots d_n \ne 0$ (with minus signs from row exchanges).

We now have a very practical formula for the determinant of a non-singular matrix. In fact, the way computers find the determinants of large matrices is to first perform elimination (keeping track of whether the row exchanges is odd or even) and then multiply the pivots:

$$
\begin{bmatrix}
a & b \\ c & d
\end{bmatrix}
\to
\begin{bmatrix}
a & b \\ 0 & d - \frac{c}{d}b
\end{bmatrix}
$$

where $a \ne 0$, so

$$
\begin{vmatrix}
a & b \\ c & d
\end{vmatrix}
=
a(d - \frac{c}{a}b) = ad - bc
$$

### 9. $\det AB = (\det A)(\det B)$
