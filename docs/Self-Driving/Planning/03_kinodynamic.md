# Kinodynamic Path Finding

## Introduction

The `kinodynamic` planning problem is to synthesize a robot subject to simultaneous 

- `kinematic` constraints, such as `avoiding obstacles`
- `dynamic` constraints, such as modulus `bounds on velocity, acceleration, and force`

A kinodynamic solution is a mapping from time to generalized forces or accelerations.

We choose kinodynamic planning because:

- Straight-line connections between pairs of states are typically not valid trajectories due to the system's `differential constraints`.
- The smoother the path we found, the easier we optimize it.
- Coars-to-fine process
- Trajectory only optimizes locally
- Infeasible path means nothing to nonholonomic system

![why kino](images/kinodynamic/why.png)

The typical models we used are:

- [Unicycle model](http://planning.cs.uiuc.edu/node658.html):

![unicycle](images/kinodynamic/unicycle.png)

- [Bicycle model](http://planning.cs.uiuc.edu/node659.html):

![bicycle](images/kinodynamic/bicycle.png)

## State Lattice Planning

As learned in [search-based path finding](01_search.md), we have many weapons to attack graph search. But to assume the robot a mass point is not satisfactory any more, we require a graph with `feasible motion connections` now.

The search-based path finding is actually a discretization of control space with the assumption that the robot can move in 4/8 directions:

![search](images/kinodynamic/search.png)

And the sample-based path finding is a discretization of state sapce where the state is $\mathbb{R}^2$, only position $(x, y)$ is considered.

![sample](images/kinodynamic/sample.png)

We can manually create(build) a graph with all edges executable by robot in two ways:

- forward direction: discrete (sample) in `control` space
- reverse direction: discrete (sample) in `state` space

This is the basic motivation for all kinodynamic planning, and state lattice planning is the most straight-forward one.

### Build the Graph, Sample in Control vs. State Space

For a robot model:

$$
\dot{s} = f(s, u)
$$

- The robot is differentially driven
- We have an inital state $s_0$ of the robot
- We can generate feasible local motions by:
    - Select a $u$, fix a time duration $T$, forward simulate the system(numerical integration)
    - ![forward](images/kinodynamic/forward.png)
    - Select a $s_f$, find the connection (a trajectory) between $s_0$ and $s_f$
    - ![reverse](images/kinodynamic/reverse.png)

### Sample in Control Space

![cs1](images/kinodynamic/cs1.png)
![cs2](images/kinodynamic/cs2.png)

- [Search-based Motion Planning for Quadrotors using Linear Quadratic Minimum Time Control](https://arxiv.org/abs/1709.05401)

The lattice graph obtained by searching is:

![lattice graph](images/kinodynamic/lattice_graph.png)

Note that:

- During searching, the graph can be built when necessary.
- Create nodes(state) and edges(motion primitive) when nodes are newly discovered.
- Save computational time/space.

And for vehicle, things are different.

The `state` can be:

$$
s = \begin{bmatrix} x \\ y \\ \theta \end{bmatrix}
$$

`Input`:

$$
u = \begin{bmatrix} v \\ \phi \end{bmatrix}
$$

`System equation`:

$$
\begin{bmatrix} \dot{x} \\ \dot{y} \\ \dot{\theta} \end{bmatrix}
=
\begin{bmatrix} v \cdot cos\theta \\ v \cdot sin\theta \\ \frac{R}{L} \cdot tan\phi \end{bmatrix}
$$

where:

- $\theta$ is heading angle
- $\phi$ is steering angle
- $R$ is steering radius
- $L$ is the length from front to rear axle

For every $s \in T$ from the search tree, we pick a control vector $u$ and integrate the equation over short duration, and finally add collision-free motions to the search tree.

![control space vehicle](images/kinodynamic/cs_vehicle.png)

### Sample in State Space

We build a lattice graph with:

- Given an origin
- For 8 neighbor nodes around the origin, feasible paths are found
- Extend outward to 24 neighbos.
- Complete lattice

Following is build with `Reeds-Shepp Car Model`:

![lattice graph state](images/kinodynamic/lg_state.png)

- [Generating Near Minimal Spanning Control Sets for Constrained Motion Planning in Discrete State Spaces](http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.70.686&rep=rep1&type=pdf)

And for two or more layers lattice graph, only first layer is different:

![two layer state](images/kinodynamic/2l_state.png)

- [Optimal Rough Terrain Trajectory Generation for Wheeled Mobile Robot](http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.375.9234&rep=rep1&type=pdf)

### Comparison

![comparison](images/kinodynamic/comparison.png)

- Trajectories are denser in the direction of the initial angular velocity
- Very similar outputs for several distinct inputs

- [State Space Sampling of Feasible Motions for High-Performance Mobile Robot Navigation in Complex Environments](https://www.ri.cmu.edu/pub_files/pub4/howard_thomas_2008_1/howard_thomas_2008_1.pdf)

## Boundary Value Problem(BVP)

Boundary Value Problem is the basis of state sampled lattice planning. It has no general solution, we have to design case by case. It often envolves complicated numerical optimization.

The basic problem is to design a trajectory (in x direction, for example) such that:

- $x(0) = a$
- $x(T) = b$

![bvp problem](images/kinodynamic/bvp_problem.png)

We can take the trajecotry $5^{th}$ order polynomial trajectory:

$$
x(t) = c_{5}t^{5} + c_{4}t^{4} + c_{3}t^{3} + c_{2}t^{2} + c_{1}t + c_{0}
$$

The boundary condition will be:

|  | Position | Velocity | Acceleration |
| --- | --- | --- | --- |
| t = 0 | a | 0 | 0 |
| t = T | b | 0 | 0 |

The problem will be solved with:

$$
\begin{bmatrix}
a \\ b \\ 0 \\ 0 \\ 0 \\ 0
\end{bmatrix}
=
\begin{bmatrix}
0 & 0 & 0 & 0 & 0 & 1 \\
T^5 & T^4 & T^3 & T^2 & T & 1 \\
0 & 0 & 0 & 0 & 1 & 0 \\
5T^4 & 4T^3 & 3T^2 & 2T & 1 & 0 \\
0 & 0 & 0 & 2 & 0 & 0 \\
20T^3 & 12T^2 & 6T & 2 & 0 & 0 \\
\end{bmatrix}
\begin{bmatrix}
c_5 \\ c_4 \\ c_3 \\ c_2 \\ c_1 \\ c_0
\end{bmatrix}
$$

### Optimal Boundary Value Problem(OBVP)

If $T$ is fixed, we can get the unique solution of:

$$
\begin{bmatrix}
c_5 \\ c_4 \\ c_3 \\ c_2 \\ c_1 \\ c_0
\end{bmatrix}
$$

But if $T$ is a variable, we can get more than one solutions. This is an optimal boundary value problem.

The general step for this problem is:

1. Modelling
2. Solving with `Pontryain's Minimum Principle`

We take the quadratic as an example.

### Fixed Final State

#### 1. Modeling

a. Cost Function:

$$
J_{\sum} = \sum_{k=1}^{3}J_{k}, J_{k} = \frac{1}{T} \int_0^T j_{k}^2(t) dt \tag{1}
$$

b. State:

$$
S_{k} = \begin{bmatrix} p_{k} \\ v_{k} \\ a_{k} \end{bmatrix} \tag{2}
$$

c. Input:

$$
u_{k} = j_{k} \tag{3}
$$

d. System Model:

$$
\dot {S_{k}} = f_s(s_k, u_K) = \begin{bmatrix} v_k \\ a_k \\ j_k \end{bmatrix} \tag{4}
$$

e. Start and End State:

$$
S(0) = \begin{bmatrix} p(0) \\ v(0) \\ a(0) \end{bmatrix} \tag{5}
$$

$$
S(f) = \begin{bmatrix} p(f) \\ v(f) \\ a(f) \end{bmatrix} \tag{6}
$$

The $k$ in equation is the dimension(x, y, z) of state, and we assume that three dimensions are independent, so we throw away the $k$ in the following equations.

And we also define that the quadratic must arrive the final position with the state of $S(f)$, which causes some difference with undefined dimensions' case, we'll discuss this condition later.

- [A Computationally Efficient Motion Primitive for Quadrocopter Trajectory Generation](https://ieeexplore.ieee.org/document/7299672)
- [Dynamic Programming and Optimal Control](http://www.athenasc.com/dpbook.html)

#### 2. Solving

By `Pontryain's minimum principle`, we first inctroduce the `costate`:

$$
\lambda = \begin{bmatrix} \lambda_1 \\ \lambda_2 \\ \lambda_3 \end{bmatrix} \tag{7}
$$

And define the `Hamiltonian function`:

$$
\begin{align}
H(s, u, \lambda) &= \frac{1}{T} j^2 + \lambda^T f_s(s, u) \\
                 &= \frac{1}{T} j^2 + \lambda_1v + \lambda_2a + \lambda_3j \\ 
\end{align} \tag{8}
$$

The `Pontryain's minimum principle` says:

$$
\dot {S}^*(t) = f(S^*(t), u^*(t)) \tag{9}
$$

with $S^*(0) = S(0)$, where:

- `*`, means optimal.

And $\lambda(t)$ is the solution of:

$$
\dot{\lambda}(t) = - \nabla H(S^*(t), u^*(t), \lambda(t)) \tag{10}
$$

with the boundary condition of:

$$
\lambda(T) = - \nabla h(S^*(T)) \tag{11}
$$

and the optimal control input is:

$$
u^*(t) = arg \min_{u(t)} H(S^*(t), u(t), \lambda(t)) \tag{12}
$$

#### 3. Details

From equation (8) and (10), calculating the partial derivatives of $(p, v, a)$, we get:

$$
\dot{\lambda}(t) = \begin{bmatrix} 0 \\ -\lambda_1 \\ -\lambda_2 \end{bmatrix}
$$

We define $\lambda_1 = \alpha$, and calculate the integration of $\lambda_2$ and $\lambda_3$:

$$
\lambda (t) = \begin{bmatrix} \alpha \\ -\alpha t + \beta  \\ \frac{1}{2} \alpha t^2 + \beta t + \gamma \end{bmatrix}
$$

As for that $\alpha$, $\beta$ and $\gamma$ are all unknown variables, we can organize the formula above to:

$$
\lambda (t) = \frac{1}{T} \begin{bmatrix} -2 \alpha \\ 2 \alpha t + 2 \beta  \\ - \alpha t^2 - 2 \beta t - 2 \gamma \end{bmatrix}
$$

According to (12), $u^*(t)$ is the $u(t)$ value when formula (8) get minimum value with the costate $[\lambda_1, \lambda_2, \lambda_3]'$, so:

$$
u(t) = \frac{1}{T} (j^2 -(\alpha t^2 + 2\beta t + 2\gamma) j + - 2\alpha v + 2\alpha ta + 2 \beta a)
$$

As we have known (3), to minimize the $u(t)$, we let the derivative of $j$ to $0$:

$$
2j - (\alpha t^2 + 2\beta t + 2\gamma) = 0
$$

$$
u^*(t) = j^* = \frac{1}{2} + \beta t + \gamma \tag{13}
$$

We already have the start state (5), according to (2), $S^{*}(t)$ is the `1/2/3` order integration of $u^{*}(t) = j$:

$$
S^{\star}(t) = 
\begin{bmatrix}
\frac{1}{120} \alpha t^5 + \frac{1}{24} \beta t^4 + \frac{1}{6} \gamma t^3 + \frac{1}{2} a_0 t^2 + v_0 t + p_0 \\
\frac{1}{24} \alpha t^4 + \frac{1}{6} \beta t^3 + \frac{1}{2} \gamma t^2 + a_0 T + v_0 \\
\frac{1}{6} \alpha t^3 + \frac{1}{2} \beta t^2 + \gamma t + a_0 \\
\end{bmatrix} \tag{14}
$$

The optimal $S^\star (t)$ should meet the end state (6), so:

$$
\begin{bmatrix}
\frac{1}{120} \alpha T^5 + \frac{1}{24} \beta T^4 + \frac{1}{6} \gamma T^3 + \frac{1}{2} a_0 T^2 + v_0 T + p_0 \\
\frac{1}{24} \alpha T^4 + \frac{1}{6} \beta T^3 + \frac{1}{2} \gamma T^2 + a_0 T + v_0 \\
\frac{1}{6} \alpha T^3 + \frac{1}{2} \beta T^2 + \gamma T + a_0 \\
\end{bmatrix}
=
\begin{bmatrix}
p_f \\
v_f \\
a_f \\
\end{bmatrix} \tag{15}
$$

The equation above is actually a combination of three independent equations, we can move some iterms from left of equal sign to right:

$$
\begin{bmatrix}
\frac{1}{120} \alpha T^5 + \frac{1}{24} \beta T^4 + \frac{1}{6} \gamma T^3 \\
\frac{1}{24} \alpha T^4 + \frac{1}{6} \beta T^3 + \frac{1}{2} \gamma T^2 \\
\frac{1}{6} \alpha T^3 + \frac{1}{2} \beta T^2 + \gamma T\\
\end{bmatrix}
=
\begin{bmatrix}
p_f - \frac{1}{2} a_0 T^2 - v_0 T - p_0 \\
v_f - a_0 T - v_0 \\
a_f - a_0 \\
\end{bmatrix}
$$

we let:

$$
\begin{bmatrix}
\Delta p \\
\Delta v \\
\Delta a \\
\end{bmatrix}
=
\begin{bmatrix}
p_f - \frac{1}{2} a_0 T^2 - v_0 T - p_0 \\
v_f - a_0 T - v_0 \\
a_f - a_0 \\
\end{bmatrix}
$$

in linear algebra form:

$$
\begin{bmatrix}
\frac{1}{120} T^5 & \frac{1}{24} T^4 & \frac{1}{6} T^3 \\
\frac{1}{24} T^4 & \frac{1}{6} T^3 & \frac{1}{2} T^2 \\
\frac{1}{6} T^3 & \frac{1}{2} T^2 & \gamma T\\
\end{bmatrix}
\begin{bmatrix}
\alpha \\
\beta \\
\gamma \\
\end{bmatrix}
=
\begin{bmatrix}
\Delta p \\
\Delta v \\
\Delta a \\
\end{bmatrix}
$$

We can calculate the inverse of first matrix with [Gauss-Jordan Elimination](https://blog.yongcong.wang/Math/Linear-Algebra/04_multi_inverse/#gauss-jordan-elimination):

$$
\begin{bmatrix}
\alpha \\
\beta \\
\gamma \\
\end{bmatrix}
=
\frac{1}{T^5}
\begin{bmatrix}
720 & -360T & 60T^2 \\
-360T & 168T^2 & -24T^3 \\
60T^2 & -24T^3 & 3T^4
\end{bmatrix}
\begin{bmatrix}
\Delta p \\
\Delta v \\
\Delta a \\
\end{bmatrix} \tag{16}
$$

And then take the result to (1), we will get the equation about $J$:

$$
J = \gamma ^ 2 + \beta \gamma T + \frac{1}{3} \beta ^ 2 T ^ 2 + \frac{1}{3} \alpha \gamma T^2 + \frac{1}{4} \alpha \beta T ^ 3 + \frac{1}{20} \alpha ^ 2 T ^ 4 \tag{17}
$$

$J$ only depends on $T$, and the boundary states are known, so we can get the optimal T.

This is a polynomial function root finding problem, we can solve it with:

##### 1. Quartic Equation Root Finding

There are many methods to find roots of [quartic equation](https://en.wikipedia.org/wiki/Quartic_equation), we need to ignore negtive and virtual root. But the root is very complex. Not recommanded.

##### 2. Use Companion Matrix to Find Determinant

In linear algebra, the Frobenius companion matrix of the monic polynomial:

$$
p(t) = c_0 + c_1 t + \cdots + c_{n - 1} t^{n - 1} + t^n
$$

is the square matrix defined as

$$
C(p) =
\begin{bmatrix}
0 & 0 & \cdots & 0 & -c_0 \\
1 & 0 & \cdots & 0 & -c_1 \\
0 & 1 & \cdots & 0 & -c_2 \\
\vdots & \vdots  & \vdots & \vdots & \vdots \\
0 & 0 & \cdots & 1 & -c_{n-1} \\
\end{bmatrix}
$$

We can calculate the determinant of $C(p)$ and take all positive root to equation (17) to get the optimal $T$, this can be done within `Eigen` library.

##### 3. Eigen PolynomialSolver

This is a solver in `Eigen`, more in [example](http://www.ce.unipr.it/people/medici/eigen-poly.html).

## Kinodynamic RRT*

## Hybrid A*

