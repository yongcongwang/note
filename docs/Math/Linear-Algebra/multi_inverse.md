# Multiplication and Inverse Matrices

## Matrix Multiplication
We discuss four different ways of thinking about the product of two matrices. 

$$
AB = C
$$

If $A$ is an $m \times n$ matrix and $B$ is an $n \times p$ matrix, then $C$ is an $m \times p$ matrix. We use $c_{ij}$ to denote the entry in row i and column j of matrix $C$.

### Standard (row times column)
The standard way of describing a matrix product is to say that $c_{ij}$ equals the dot product  of row i of matrix A and column j of matrix B:

$$
c_{ij} = \sum_{k = 1}^{n} a_{ik}b_{kj}
$$

### Columns
The product of matrix A and column j of matrix B equals column j of matrix C. This tells us that the columns of C aare combinations of columns of A.

### Rows
The product of row i of matrix A and matrix B equals row i of matrix C. So the rows of C are combinations of rows of B.

### Column Times Row
A column of A is an $m \times 1$ vector and a row of B is a $1 \times p$ vector. Their product is a matrix:

$$
\begin{bmatrix} 2 \\ 3 \\ 4 \end{bmatrix} \begin{bmatrix} 1 & 6 \end{bmatrix} = \begin{bmatrix} 2 & 12 \\ 3 & 18 \\ 4 & 24 \end{bmatrix}
$$

The columns of this matrix are multiplies of the column of A and the rows are multiplies of the row of B. If we think of the entries in these rows as the coordinates $(2, 12)$ or $(3, 18)$ or $(4, 24)$, all these points lie on the same line; similarly for the two column vectors. Later we'll see that this is equaivalent to saying that the `row space` of this matrix is a single line, as is the `column space`.

The product of A and B is the sum of these "column times rows" matrices:

$$
AB = \sum_{k = 1}^{n} \begin{bmatrix} a_{1k} \\ \vdots \\ a_{mk}\end{bmatrix} \begin{bmatrix} b_{k1} & \cdots & b_{kn}\end{bmatrix}
$$

### Blocks
If we subdivide A and B into blocks that match properly, we can write the product $AB = C$ in terms of products of the blocks:

$$
\begin{bmatrix} A_1 & A_2 \\ A_3 & A_4 \end{bmatrix} \begin{bmatrix} B_1 & B_2 \\ B_3 & B_4 \end{bmatrix} =\begin{bmatrix} C_1 & C_2 \\ C_3 & C_4 \end{bmatrix}
$$

Here $C_1 = A_1B_1 + A_2B_3$

## Inverses

### Square Matrices

### Gauss-Jordan Elimination
