This page contains my personal notes and summaries on [DeepLearning.ai](https://deeplearning.ai) specialization courses. [DeepLearning.ai](https://deeplearning.ai) contains five courses which can be taken on [Coursera](https://www.coursera.org/specializations/deep-learning):
- Neural Network and Deep Learning;
- Improving Deep Neural Networks: Hyperparameter tuning, Regularization and Optimization;
- Structuring Machine Learning Projects;
- Convolutional Neural Networks;
- Sequence Models.

# Neural Network and Deep Learning
## Introduce to deep learning
### What is a Neural Network
![nn](/images/2020/deep_learning/neuron.jpg)

At a very simple level, neurons are basically computational units that take inputs(dendrites) as electrical inputs(called "spikes") that are channeled to outputs(axons). A single neuron will calculate weighted sum of input($W.T \cdot X$) and we can set a threshold to predict output in a perceptron. If weighted sum of input across the threshold, perceptron fires and if not then perceptron doesn't predict.

The disadvantage of perceptron is that it only outputs binary values. To make output of perceptron flips we add a bias, here comes: $W.T \cdot X + b$. We need some system which can modify the output slightly accordding to small change in weight and bias, here comes activation functions($g(X.T \cdot X + b)$).

`Sigmoid` is a kind of activation functions, we can make slight change in output with sigmoid function, and the single neuron with sigmoid activation function will act as `Logistic Regression`.

`ReLU` which stands for rectified linear unit, is the most popular activation function right now that makes deep neural network trains faster.

### Supervised learning with neural networks
There are different types of neural networks for supervised learning:
- `CNN`(Convolutional Neural Network) is useful in computer vision;
- `RNN`(Recurrent Neural Network) is useful in speech recognition or NLP(Nature Language Process);
- `Standard NN` is useful for structured data;
- Hybrid/custom NN or a Collection of NNs types

### Why is deep learning taking off
![scale drives deep learning progress](/images/2020/deep_learning/scale_drive_deep_learning_progress.png)

Deep learning is taking off for 3 reasons:
1. Data scale:
 - For small data NN can performs as traditional algorithms like Linear regression or SVM(Support vector mechine);
 - For bigger data a small NN performs better than traditional algos;
 - For really big data, a large NN is better than middle NN that is better than small NN;
 - Hopefully we have a lot of data because the world is using the computer a little bit more.
2. Computation:
 - GPUs;
 - Powerful CPUs;
 - Distributed computing;
 - ASICs.
3. Algorithm:
 - Creative algorithms have appeared that changed the way NN works: For example, using `ReLU` is so much better than using `Sigmoid` function in training a NN because it helps with the vanishing gradient problem.

## Neural Network Basics
This part we learn to set up a machine learning problem with a neural network mindset. Learn to use vectorization to speed up your models.

### Logistic regression
Algorithm is used for classification of 2 classes. We use the equation:
$$
y = wx + b
$$
to calculate the output. 
If $x$ is a vector, the equation becomes:
$$
y = w^Tx + b
$$
If we need $y$ to be in $[0, 1]$(probability):
$$
y = sigmoid(w^Tx + b)
$$

### Logistic regression cost function
The cost function can be the square root error:
$$
L(\hat{y}, y) = \frac{1}{2} \cdot (\hat{y} - y)^2
$$
but we won't use this notation because it leads to optimization problem which is non convex, means it contains local optimum points.

Alternately, we use the function:
$$
L(\hat{y}, y) = - (y \cdot \log(\hat{y}) + (1 - y) \cdot \log(1 - \hat{y}))
$$
this leads to two cases:
- if $y = 1$, $L(\hat{y}, 1) = -log(\hat{y})$, we want $\hat{y}$ to be the largest, and the largest value of $\hat{y}$ is $1$;
- if $y = 0$, $L(\hat{y}, 1) = -log(1 - \hat{y})$, we want $1 - \hat{y}$ to be the largest, and the smallest value of $\hat{y}$ is $0$;

Then the cost function will be:
$$
J(w, b) = \frac{1}{m}\sum^{m}\_{i=1}{(L(\hat{y}^{[i]}, y^{[i]}))}
$$
The difference between loss function and cost function:
- the loss function calculates the error for a single training example;
- the cost function calculates the average of the loss function of the entire training set.

### Gradient Descent
Our target is to predict $w$ and $b$ that minimize the cost function while the cost function itself is convex.

The gradient descent repeats:
$$
w = w - \alpha \cdot dw
$$
$$
b = b - \alpha \cdot db
$$
to reach the minimum of cost function, while the $\alpha$ is the `learning rate` and $dw$ is the derivative of $w$, $db$ is the derivative of $b$.

### Vectorization
Deep learning shines when the dataset is big. However, `for loop` will make you wait a lot for a result. That's why we need vectorization to get rid of  some of our `for loop`s.

### General steps
The main steps for building a Neural Network are:
- Define the model structure(such as number of input features and outputs);
- Initialize the model's parameters;
- Loop:
 - Calculate current loss(forward propagation);
 - Calculate current gradient(backward propagation)
 - Update parameters(gradient descent)

Tunning the learning rate(which is an example of a "hyperparameter") can make a big difference to the algorithm.

## Shallow neural network
This part we learn to build a neural network with one hidden layer, using forward propagation and backward propagation.

### Neural network overview
![shallow_nn](/images/2020/deep_learning/shallow_nn.png)

In the left logistic regression we had:
$$
z = W^TX + B \Rightarrow a = sigmoid(z) \Rightarrow L(a, Y)
$$
where $W$, $X$ and $B$ are matirx.

In neural networks with one layer we will have:
$$
Z_1 = W_1^TX + B \Rightarrow A1 = sigmoid(Z_1) \Rightarrow Z_2 = W_2^TA_1 + B_2 \Rightarrow A_2 = sigmoid(Z_2) \Rightarrow L(A2,Y)
$$

Neural Network is a stack of logistic regression objects.

### Neural network notations

#### General comments
- Superscript $(i)$ will denote the $i^{th}$ training example while the superscript $[i]$ will denote the $l^{th}$ layer.

#### Sizes
- $m$: number of examples in the dataset;
- $n_x$: input size;
- $n_y$: output size(or number of classes);
- $n_h^{[l]}$: number of hidden units of the $l^{th}$ layer;
- $L$: number of layers in the network.

#### Objects
- $X$: the input matrix
- $x^{(i)}$: the $i^{th}$ example represented as a column vector;
- $Y$: the label matrix;
- $y^{(i)}$: the output label for the $i^{th}$ example;
- $W^{[l]}$: the $l^{th}$ lyaer weight matrix;
- $b^{[l]}$: the bias vector of $l^{th}$ layer;
- $\hat{y}$: the predicted output vector. It can also be denoted $a^{[L]}$ where $L$ is the number of layers in the network.

#### Forward propagation
- $a = g^{[l]}(W_xx^{(i)} + b_1) = g^{[l]}(z_1)$, where $g^{[l]}$ denotes the $l^{th}$ layer activation function;
- $J(x, W, b, y)$ or $J(\hat{y}, y)$ denotes the cost function.

### Activation functions
![activation functions](/images/2020/deep_learning/activation.png)

#### sigmoid
So far we are using sigmoid, but it works not so well:
- sigmoid can lead us to gradient decent problem where the updates are so slow;
- the range of function is $[0, 1]$.

#### tanh
`tanh` is a shifted version of sigmoid with the range $[-1, 1]$. It usually works better than sigmoid activation for hidden units because the mean of its outputs is closer to $0$, and so it centers the data better for the next layer.

#### ReLU
`sigmoid` or `tanh` function disadvantage is that if the input is too small or too high, the slope will be near zero which will cause the gradient decent problem.

One of the popular activation functions that solved the slow gradient decent is the ReLU function.

#### Leaky ReLU
The difference between Leaky ReLU and ReLU is that if the input is negtive the slope will be so small. It works as ReLU but most people use ReLU.

### Why we need non-linear activation functions
Linear activation will output linear activations, that means whatever hidden layers you add, the activation will be always linear like logistic regression, so it's useless in a lot of complex problems.

You might use linear activation function in one place, the output layer, if the output is real number(regression problem). But even in this case if the output value is non-negtive you could still use ReLU instead.

### Derivative of activation functions

- Derivation of sigmoid activation function:

$$
g(z) = \frac{1}{1 + e^{-z}}
$$

$$
g'(z) = \frac{1}{1 + e^{-z}} \cdot (1 - \frac{1}{1 + e^{-z}}) = g(z) \cdot (1 - g(z))
$$

- Derivation of tanh activation function:

$$
g(z) = \frac{e^z - e^{-z}}{e^z + e^{-z}}
$$

$$
g'(z) = 1 - tanh^2(z) = 1 - g^2(z)
$$

- Derivation of ReLU activation function:

$$
g(z) = max(0, z)
$$

$$
g'(z) = 
\begin{cases}
0, \quad \mbox{if} \quad z < 0 \\\\
1, \quad \mbox{if} \quad z >= 0
\end{cases}
$$

- Derivation of leaky ReLU activation function:

$$
g(z) = max(0.01 \cdot z, z)
$$

$$
g'(z) = 
\begin{cases}
0.01, \quad \mbox{if} \quad z < 0 \\\\
1, \quad \mbox{if} \quad z >=0
\end{cases}
$$

### Random initialization
In logistic regression it wasn't important to initialize the weights randomly, while in neural network we have to initialize them randomly.

While initializing bias with $0$ is OK, neural network won't work if we initialize all weights with zeros:

- all hidden units will be completely identical(symmetric) and compute exactly the same function;
- on each gradient descent iteration all the hidden units will always update the same.

We need small values because in sigmoid(or tanh) activation function, for example, if the weights is too large you are more likely to end up with very large values of $Z$. Which causes your tanh or sigmoid activation function to be saturated, thus slowing down learning. If you don't have any sigmoid or tanh activation function throughout your neural network, this is less of an issue.

## Deep neural network
Shallow Neural Network is a Neural Network with $1$ or $2$ layers. Deep Neural Network is a Neural Network with $3$ or more layers.

### Getting your matrix dimensions right
With the equation:
$$
Z = W^TX + B
$$
where $X$ has the shape of $(x, n^{[l-1]})$.

- Dimension of $W$ is $(n^{[l]}, n^{[l-1]})$;
- Dimension of $B$ is $(n^{[l]}, 1)$;
- $dw$ has the same shape as $W$;
- $db$ has the same shape as $B$;
- Dimension of $Z^{[l]}$, $A^{[l]}$, $dZ^{[l]}$, $dA^{[l]}$ is $(n^{[l]}, m)$.

### Hyperparameters
The main parameters of Neural Network is:
- $w$;
- $b$.

Hyperparameters are the parameters that control the algorithm:
- learning rate;
- Number of iteration;
- Number of hidden layers;
- Number of hidden units;
- Choice of activations.

# Improving Deep Neural Networks: Hyperparameter Tuning, Regularition and Optimization

## Practical aspects of deep learning

### Train/dev/test Sets
It's impossible to get all your hyperparameters right on a new application from the first time, so, the idea is to go through the loop:
```C++
   Idea --> Code --> Experiment
    ^                     |
    |                     |
    -----------------------
```
You can go through the loop many times to figure out your hyperparameters.

Generally, we divid the data into three parts:
- Train set, which used to train the neural network and is usually the largest set;
- Develop(dev) set, which is used to validate the traing result;
- Testi set, which is used to test the trained neural network.

You will try to build a model upon `train set` then try to optimize hyperparamters on `dev set` as much as possible. After your model is ready, you can evaluate the model with `test set`.

The ratio of splitting the models is:
- `6:2:2`, if the size of the dataset is $100$ to $1000000$;
- `98:1:1 or 99.5:0.25:0.25`, if the size of the dataset is $> 1000000$.

You should make sure the `dev set` and `test set` comes from the same distribution.

### Bias/variance
Bias and variance techiques are easy to learn but difficult to master.
Generally, your model is:
- `underfitting`, if it has a `high bias`;
- `overfitting`, if it has a `high variance`.
![bias and variance](/images/2020/deep_learning/bias_and_variance.png)

You can plot the result as the figure above, but if this is not possible, another idea to get bias/ variance is to check the error:
- High variance(overfitting):
 - Training error: 1%;
 - Dev error: 11%.
- High bias(underfitting):
 - Training error: 15%;
 - Dev error: 14%.
- High bias (underfitting) && High variance(overfitting):
 - Training error: 15%;
 - Test error: 30%.
- Best:
 - Training error: 0.5%;
 - Test error: 1%.

These conclusions come from the assumption that human has $0%$ error. If the problem isn't meeting this assumption, you will need to use human error as baseline.

### Basic recipe for high bias and variance
If your algorithm has a high bias, you can:
- Try to make your neural network bigger(more hidden units or more layers);
- Try a different model that fits your data well;
- Try more batches;
- Try difference(advanced) optimization algorithms.

If your algorithm has a high variance, you can:
- Use more data;
- Try regularization;
- Try a different model that is suitable for your data.

No matter what the problem is, training a bigger neural network never hurts, although this may lead to longer runing time.

## Regularizing your neural network
For variance(overfitting) problems, we can try a bigger training data to fix it. But some times you can't just get more training data, or it would be quite expensive to get more data. In this case regularization will often help to prevent overfitting, or reduce the errors in your network.

### Regularization

#### Regularization for logistic regression
- $L_1$ regularization
$$
J(w,b) = \frac{1}{m} \sum_{i = 1}^mL(\hat{y^{(i)}}, y^{(i)}) + \frac{\lambda}{2m} \lVert w \rVert_2^2
$$
$$
\lVert w \rVert_2^2 = \sum_{j = i}^{n_x}|w_j|
$$
where $\lambda$ is called regularization parameter(hyperparameter), you can try different value and choose the one with best performance.

- $L_1$ regularization(for arcane technical math, this is called `Frobenius norm`)
$$
J(w,b) = \frac{1}{m} \sum_{i = 1}^mL(\hat{y^{(i)}}, y^{(i)}) + \frac{\lambda}{2m} \lVert w \rVert_1
$$
$$
\lVert w \rVert_1 = \sum_{j = i}^{n_x}w_j^2 = w^Tw
$$

#### Regularization for neural network
The normal cost function that we want to minimize is:
$$
J(w^{[1]}, b^{[1]}, ..., w^{[L]}, b^{[L]}) = \frac{1}{m} \sum_{i = 1}^{m}L(\hat{y^{(i)}}, y^{(i)})
$$

Then the $L_2$ regularization is:
$$
J(w^{[1]}, b^{[1]}, ..., w^{[L]}, b^{[L]}) = \frac{1}{m} \sum_{i = 1}^{m}L(\hat{y^{(i)}}, y^{(i)}) + \frac{1}{2m} \sum_{l = 1}^{L} \lVert w^{[l]} \rVert^2
$$

The old way we do back propagation is:
$$
dw^{[l]} = (back propagation)
$$
$$
w^{[l]} = w^{[l]} - \alpha \cdot dw^{[l]}
$$
Then we change to:
$$
dw^{[l]} = (back propagation) + \frac{\lambda}{m} \cdot w^{[l]}
$$
So:
$$
\begin{align}
w^{[l]} 
& = w^{[l]} - \alpha \cdot dw^{[l]} \\\\
& = w^{[l]} - \alpha * ((back propagation) + \frac{\lambda}{m} \cdot w^{[l]}) \\\\
& = w^{[l]} - \alpha * (back propagation) - \alpha * (\frac{\lambda}{m} \cdot w^{[l]}) \\\\
& = (1 - \frac{\alpha\lambda}{m}) \cdot w^{[l]} - \alpha * (back propagation)
\end{align}
$$

In practice this will penalize large weights and effectively limits the freedom in your model, because the them $(1 - \frac{\alpha\lambda}{m}) \cdot w^{[l]}$ causes the `weight to decay` in propartion to its size.

#### Why regularization reduces overfitting
Here are some intuitions:
- If $\lambda$ is too large: a lot of $w$ part will be close to $0$, which makes the neural network more simple;
- If $\lambda$ is good enough: it will reduce some weights that makes the neural network overfitting.

And for $tanh$ activation function:
- If $\lambda$ is too large, $w$ part will be small(close to $0$), which will use the linear part of the $tanh$ activation function, so we will go from non-linear activation to roughly linear which would make the neural network a roughly linear classifier.
- If $\lambda$ is good enough, it will just make some of $tanh$ activations roughly linear which will prevent overfitting.

### Dropout regularization
In most case, we use $L_2$ regularization. The dropout regularization eliminates some neurons/weights on each iteration based on a probability. A most common techinque to implement dropout is called `Inverted dropout`:
```Python
keep_prob = 0.8   # 0 <= keep_prob <= 1
l = 3  # this code is only for layer 3
# the generated number that are less than 0.8 will be dropped. 80% stay, 20% dropped
d3 = np.random.rand(a[l].shape[0], a[l].shape[1]) < keep_prob

a3 = np.multiply(a3,d3)   # keep only the values in d3

# increase a3 to not reduce the expected value of output
# (ensures that the expected value of a3 remains the same) - to solve the scaling problem
a3 = a3 / keep_prob
```

#### Understanding dropout

- Dropout knocks out units in neural network randomly, so it works like on every iteration you're working with a smaller neural network which has a regulizing effect.
- Neural network can not rely on any one feature because it may be knocked out, so it has to spread out weights.
- Dropout can have different `keep_prob` per layer.
- The input layer dropout has to be near $1$(or just $1$) because you don't want to eliminate a lot of featrues.
- A lot of researchers are using dropout with Computer Vision(CV), bacause they have a very big input size and almost nerver have enough data, so overfitting is the usual problem. And dropout is a regularization technique to prevent overfitting.

### Other regularization methods

#### Data augmentation
- In a computer vision data, you can:
 - flip all your pictures horizontally which will give you more data instances;
 - apply a random position and rotation to an image to get more data.
- In OCR you can impose random ratation and distortions to digits/letters.
- New data obtained using this technique isn't as good as the real independent data, but still can be used as a regularization techniques.

#### Early stopping
We plot the `training set cost` and the `dev set cost` together for each iteration. At some iteration the `dev set cost` will stop decreasing and will start `increasing`. We will pick the point at wich the training set error and dev set error are best(lowest training cost with lowest dev cost).
![](/images/2020/deep_learning/early_stop.png)

We prefer to use $L_2$ regularization instead of early stop because this technique simultaneously tries to mimimize the cost function and not to overfit which contradicts the orthogonalization approch. But its advantage is that you don't need to search a hyperparameter.

#### Model ensembles
You can train multiple independent models and average their results, this can get you extra 2% performance and reduces the generalization error.

## Setting up your optimization problem

### Normallizing inputs
Normalizing inputs will speed up the training process a lot.
![normalize](/images/2020/deep_learning/normalize_trainning_set.png)

Normalization are going on these steps:

1. Get the mean of the training set: $mean = \frac{1}{m} * \sum_{i=1}^mx^{(i)}$
2. Subtract the mean from each input: $X = X - mean$, this will make your inputs centered around $0$.
3. Get the variance of the training set: $variance = \frac{1}{m} * \sum_{i = 1}^m(x^{(i)})^2$
4. Normalize the variance: $X = X / variance$

So why we normalize our inputs?
- If we don't normalize the inputs our cost function will be deep and its shape will be inconsistent(elongated), then optimizing it will take a long time.
- If we normalized the inputs, the shape of the cost function will be consistent(look more symmetric like circle in 2D exmaple) and we can use a larger learning rate $\alpha$, the optimization will be faster.

### Vanishing/exploding gradients
The vanishing/exploding gradients occurs when your derivates becomes very small or very big. To understand the problem, suppose that we have a deep neural network with number of layer $L$, and all the activation functions are `linear` and each $b = 0$, then:
$$
\hat{y} = w^{[L]}w^{[L - 1]}w^{[L - 2]} \cdots w^{[2]} w^{[1]} x
$$
and if we have 2 hidden units per layer and $x_1 = x_2 = 1$, we will result in:
$$
\hat{y} = w^{[L]} \begin{bmatrix}x & 0 \\\\ 0 & x \end{bmatrix}^{L-1} = x^L \\\\
$$
as:
$$
w^{[L]} = \begin{bmatrix}x & 0 \\\\ 0 & x \end{bmatrix}^{L-1}
$$

If $x < 1$, $\hat{y}$ will be very small; if $x > 1$, $\hat{y}$ will be really big.
This example explains that the activations (and similarly derivatives) will be decreased/increased exponentially as a function of number of layers.

### Weight initialization for deep networks
A partial solution to the vanishing/exploding gradients in neural network is better or more careful choice of the random initialization of weights.
In a simgle neuron: $Z = w_1x_1 + w_2x_2 + \cdots + w_nx_n$, if the number of node $n_x$ is large, we want $w$ to be smaller to not explode the cost, which turns out that we need the variance(equal to $\frac{1}{n_x}$) to be the range of $W$.
So we initialize $W$ like this(better to use with `tanh` activation):
```Python
np.random.rand(shape) * np.sqrt(1/n[l-1])
```
or variation of this:
```Python
np.random.rand(shape) * np.sqrt(2/(n[l-1] + n[l]))
```
Setting initialization part inside sqrt to `2/n[l-1]` for `ReLU` is better:
```Python
np.random.rand(shape) * np.sqrt(2/n[l-1])
```
This is one of the best way of partially solution to Vanishing / Exploding gradients (ReLU + Weight Initialization with variance) which will help gradients not to vanish/explode too quickly.

# Optimization algorithms
Training neural network with a large data is slow, so it's necessary to optimize the algorithm to run faster.

## Mini-batch gradient descent
Suppose we have a data set with the size of `50m`, training it will take a huge processing time for one step because 50 million won't fit in the memory at once. To deal with this we can use `mini-batch` to process some of our items even before finishing the 50 million items. The process is:

- Split $X$(with the size `m`) into `mini-batch` of size `b`:
 - $X^{ \\{ 1 \\} } = 0,  \cdots, b$
 - $X^{ \\{ 2 \\} } = b + 1, \cdots, 2b$
 - $ \cdots $
 - $X^{ \\{ \frac{m}{b} \\} } = (\frac{m}{b} - 1) * b, \cdots, \frac{m}{b} * b\cdots 2b$
- Split $Y$ into `mini-batch` of size `b`, so we get the definition of `mini-batch`: $t: X^{\\{ t \\}}, Y^{\\{ t \\}}$
- Like old `batch gradient descent`, with `mini-batch gradient descent` we run the gradient descent on the mini datasets:
```python
for t = 1 : Sum_of_mini-batches  # this is called an epoch
	AL, caches = forward_prop(X{t}, Y{t})
	cost = compute_cost(AL, Y{t})
	grads = backward_prop(AL, caches)
	update_parameters(grads)
```

### Understanding mini-batch gradient descent
Unlike batch gradient descent where cost function decreases each iteration, mini-batch's cost function won't go down with each step, it may contain ups and downs but generally it goes down.

![mini-batch](/images/2020/deep_learning/mini_batch.png)

The gradient descent type depends on mini-batch size:
- $mini-batch-size = m$: batch gradient descent, which is too long per iteration(epoch);
- $mini-batch-size = 1$: stochastic gradient descent(SGD), which:
 - is too noisy regarding cost minimization(can be reduced by using smaller learning rate);
 - won't ever converge(reach the minimum cost);
 - loses speedup from vectorization.
- $mini-batch-size = (1, m)$: mini-batch gradient descent, which:
 - has faster learning speed:
   - it can take the advantage of vectorization;
   - it makes progress without waiting to process the entire training set.
 - doesn't always exactly converge(oscelates in a very small region)

How to choose the `mini-batch` size? Here are the suggestions:
- $m < 2000$: Batch gradient descent;
- It has to be the power of $2$(64, 128, ..., 1024, ...), because of the way computer memory is layed and accessed your code might run faster;
- Make sure that the `mini-batch` fits in CPU/GPU memory.

## Exponentially weighted average
If you have data like the temparature of day throughout the year:
$$
\begin{array}{l}
\theta_1 = 40 \\\\
\theta_2 = 49 \\\\
\theta_3 = 45 \\\\
\cdots \\\\
\theta_{180} = 60
\end{array}
$$
This data is samll in winter but big in summer. It's noisy if we plot it out.
Now we use the `exponentially weighted averages` equation
$$
v_t = \beta * v_{t - 1} + (1 - \beta) * \theta_t
$$
The result is:
$$
\begin{array}{l}
v_0 = 0 \\\\
v_1 = \beta * v_0 + (1 - \beta) * \theta_1 \\\\
v_2 = \beta * v_0 + (1 - \beta) * \theta_2 \\\\
v_3 = \beta * v_0 + (1 - \beta) * \theta_3 \\\\
\cdots
\end{array}
$$

If we plot this it will represent averages about $\frac{1}{1 - \beta}$ entries:
- $\beta = 0.9$ will average last 10 entries;
- $\beta = 0.98$ will average last 50 entries;
- $\beta = 0.5$ will average last 2 entries.

The reason why `exponentially weighted averages` is useful for further optimizing gradient descent is that, it can give different weights to recent data points($\beta$) based on value of $\beta$. If $\beta$ is high(around 0.9),  it smoothens out the averages of skewed data points, which will reduce oscillations in gradient descent and hence make faster and smoother path towards minima.
![exponentially_weighted_averages](/images/2020/deep_learning/exponentially_weighted_averages.png)

The advantage of this algorithm is that its implementation is efficient and fast because it has only one param: $\beta$.

### Bias correction in exponentially weighted averages
Because $v_0 = 0$, the bias of the weighted averages is shifted and the accuracy suffers at the start. We use following equation to solve the bias issue:
$$
v_t = \frac{\beta * v_{t - 1} + (1 - \beta) * \theta_t}{1 - \beta^t}
$$

As $t$ becomes larger the $1 - \beta^t$ term will become close to $1$.

## Gradient descent with momentum
The momentum algorithm almost always works faster than standard gradient descent. The simple idea is to calculate the exponentially weighted averages for your gradients and then update your weights with the new values:
$$
\begin{array}{l}
v_{dW} = \beta \cdot v_{dW} + (1 - \beta) \cdot dW \\\\
v_{db} = \beta \cdot v_{db} + (1 - \beta) \cdot db \\\\
W = W - \alpha \cdot v_{dW} \\\\
b = b - \alpha \cdot v_{db}
\end{array}
$$

where $\alpha$ is learning rate, $\beta$ is another `hyperparameter`, $\beta = 0.9$ is very common and works very well in most cases.

> In practice we don't bother implementating `bias correction`

## RMSprop
`RMSprop` stands for `Root Mean Square prop`. It speeds up the gradient descent:
$$
\begin{array}{l}
s_{dW} = \beta \cdot s_{dW} + (1 - \beta) \cdot dW^2 \\\\
s_{db} = \beta \cdot s_{db} + (1 - \beta) \cdot db^2 \\\\
W = W - \alpha \cdot \frac{dW}{\sqrt{s_{dW}}} \\\\
b = b - \alpha \cdot \frac{dW}{\sqrt{s_{db}}}
\end{array}
$$

RMSprop will make the cost function move slower on the vertical direction and faster on the horizontal direction:

![rms_prop](/images/2020/deep_learning/rmsprop.png)

To ensure $s_{dw}$ is not zero, we add $\epsilon$ (e.g. $\epsilon = 10^{-8}$)to the demoninator: 
$$
W = W - \alpha \cdot \frac{dW}{\sqrt{s_{dW}} + \epsilon}
$$

## Adam optimization algorithm
`Adam` stands for `Adaptive Moment Estimation`. Adam and RMSprop are among the optimization algorithms that works very well with a lot of neural network architecture. Adam simply puts RMSprop and momentum together:
$$
\begin{align}
v_{dW} &= \beta_1 \cdot v_{dW} + (1 - \beta_1) \cdot dW \\\\
v_{db} &= \beta_1 \cdot v_{db} + (1 - \beta_1) \cdot db \\\\
s_{dW} &= \beta_2 \cdot s_{dW} + (1 - \beta_2) \cdot dW^2 \\\\
s_{db} &= \beta_2 \cdot s_{db} + (1 - \beta_2) \cdot db^2 \\\\
v_{dW} &= \frac{v_{dW}}{1 - \beta_1^t} \\\\
v_{db} &= \frac{v_{db}}{1 - \beta_1^t} \\\\
s_{dW} &= \frac{s_{dW}}{1 - \beta_1^t} \\\\
s_{db} &= \frac{s_{db}}{1 - \beta_1^t} \\\\
W &= W - \alpha \cdot \frac{v_{dW}}{\sqrt{s_{dW}} + \epsilon} \\\\
b &= b - \alpha \cdot \frac{v_{db}}{\sqrt{s_{db}} + \epsilon}
\end{align}
$$

In equation:
- (5) and (6) are momentum;
- (7) and (8) are RMSprop;
- (9) - (12) are bias correction;
- $\alpha$ is learning rate and needs to be tuned;
- $\beta_1$ is the parameter of momentum, $0.9$ is recommanded by default;
- $\beta_2$ is the parameter of RMSprop, $0.999$ is recommanded by default;
- $\epsilon = 10^{-8}$ recommanded by default.

## Learning rate decay
Learning rate decay is to reduce the learning rate slowly. As mentioned before, mini-batch gradient descent won't reach the optimum point(converge). But by making the learning rate decay with iterations it will be much closer to it because the steps near the optimum are smaller.

One technique equations is:
$$
\alpha = \frac{1}{1 + k_{decay} \cdot t} \cdot \alpha_0
$$
where $k_{decay}$ is decay rate, $t$ is the epoch number.
Other learning rate decay can be:
$$
\alpha = 0.95^{t} \cdot \alpha_0
$$
or
$$
\alpha = \frac{k}{\sqrt{t}} \cdot \alpha_0
$$
Learning rate decay has less priority than other optimization methods.

# Hyperparameter tuning and batch nomalization

## Tuning process
When we train a neural network, we usually need to tune our hyperparameters to get the best out of them. The importance rank of these hyperparameters is:
1. Learning rate, $\alpha$;
2. Momentum, $\beta$;
3. Mini-batch size, $b$;
4. Number of hidden units;
5. Number of layers;
6. Learning rate decay;
7. Ragularization $\lambda$;
8. Activation functions;
9. Adam $\beta_1$, $\beta_2$ and $\epsilon$.

One of the ways to tune is to sample a grid with $N$ hyperparameter settings and then try all setting combinations on your problem. You should try random values, not the grid.
You can use `Coarse to fine sampling scheme`:
> When you find some hyperparameters values that give you a better performance, zoom into a smaller region around these values and sample more densely within this space.

## Using an appropriate scale to pick hyperparameters
Assume that you have a specific range for a hyperparameter from `a` to `b`, it's better to search for the right ones using logarithmic scale rather than in linear scale:
- $a_{log} = log(a)$: if $a = 0.001$ then $a_{log} = -4$
- $b_{log} = log(b)$: if $b = 1$ then $a_{log} = 0$

Then: $r = (a_{log} - b_{log}) * rand + b_{log}$, the range will be [-4, 0] and result $r = 10^r$.

For example, we have known that the best range for `Momentum` $\beta$ is $[0.9, 0.999]$, you should search for $1 - \beta$ in the range $[0.001, 0.1]$, and use $a = 0.001$ and $b = 0.1$. Then:
- $a_{log} = -3$
- $b_{log} = -1$
- $r = (a_{log} - b_{log}) * rand + b_{log}$
- $\beta = 1 - 10^r$

### Hyperparameters tuning in practice: Pandas vs. Caviar
Intuitions about hyperparameter settings from one application area may or may not trasfer to a different one.

If you don't have much computational resources you can use `Panda` approach:
- Day 0 you might initialize your parameter as random and then start training;
- Then you watch your learning curve gradually decrease over the day;
- And each day you nudge your parameters a little during training.

If you have enough computational resources, you can use `Caviar` approach: 
- Run some models in parallel and at the end of the day you check the result.

### Normalizing activations in a network
Normalizing input by subtracting the mean and dividing by variance helps a lot for the shape of the cost function and for reaching the minimum point faster.  The question is:
> for any hidden layer can we normalize $A^{[l]}$ to train $W^{[l+1]}$ and $b^{[l+1]}$ faster?
This is what batch normalization is about.

There are some debates about whether you should normalize values before the activation function $Z^{[l]}$ or after applying the activation function $A^{[l]}$. In practice, nomalizing $Z^{[l]}$ is much more often.
The algorithm porcess is:
- Given $Z^{[l]} = [z^{(1)}, \cdots, z^{(m)}]$;
- Compute $mean = \frac{1}{m} * \sum^m\_{i=1}{z^{[i]}}$
- Compute $variance = \frac{1}{m} * \sum_{i=1}^m(z^{[i]}-mean)^2$
- Then $Z_{norm}^{[i]} = \frac{z^{[i]}}{\sqrt{variance + epsilon}}$
  - forcing the inputs to distribution with 0 mean and variance of 1
- Then $\tilde{z}^{[i]} = \gamma * z_{norm}^{[i]} + \beta$
  - Make inputs belong to other distribution(with other mean and variance);
  - $\gamma$ and $\beta$ are learnable parameters of the model;
  - Make the neural network learn the distribution of the outputs;
  - Note: if $\gamma = \sqrt{variance + epsilon}$ and $\beta = mean$, then $\tilde{z}^{[i]} = z^{[i]}$

### Fitting Batch normalization into a neural network
Batch normalization is usually applied with mini-batches.
If we use batch normalization parameters $b^{[1]}, \cdots, b^{[l]}$ doesn't count because they will be eliminated after mean subtraction step. So the parameters will be:
- $W^{[l]}$;
- $\beta^{[l]}$;
- $\alpha^{[l]}$.

### Why does batch normalization work?
- The first reason is the same reason as why we normalize $X$;
- The second reason is that batch normalization reduces the problem of input values changing(shifting);
- Batch normalization does some regularization:
  - Each mini-batch is scaled by the mean/variance computed of that mini-batch;
  - This adds some noise to the value $Z^{[l]}$ within that mini-batch, so similar to dropout it adds some noise to each hidden layer's activation;
  - This has a slight regularization effect;
  - Using bigger size of the mini-batch you are reducing noise and therefore regularization effect;
  - Don't rely on batch normalization as a regularization, it's intended for normalization of hidden units, activations and therefore speeding up learning. For regularization use other regularization techniques.

### Batch normalization at test time
When we train a neural network with batch normalization, we compute the mean and the variance of the mini-batch. But in testing we might need to process examples one each time, whose mean and variance won't make sense. So we have to compute the average across the mini-batch, this is called `Running average`.

### Softmax Regression
The neural networks we trained so far are binary classifications, but there are a generalization of logistic regression called `Softmax regression` that is used for multiclass classification/regression. In the last layer of the neural network we use the `Softmax regression` activation instead of `sigmoid` to classify the classes.
$$
t = e^{Z^{[L]}}
$$
$$
A_{[L]} = \frac{e^{Z^{[L]}}}{\sum{t}}
$$

### Trainning a Softmax classifier
There is an activation called `hard max` which get $1$ for the maximum value and $0$ for others. The `softmax` named because it's not so `hard`, it can be values in $[0, 1]$.

Softmax is a generalization of logistic activation function to `C` classes. If `C = 2` then `softmax` reduces to logistic regression.

The loss function used which `softmax`:
$$
L(y, \hat{y}) = - \sum_{j=0}^{C-1}(y^{[j]} * log(\hat{y}^{[j]}))
$$

The cost function used with `softmax`:
$$
J(w^{[1]}, b^{[1]}, \cdots) = -\frac{1}{m} * \sum_{i=0}^{m}(L(y^{[i]}, \hat{y}^{[i]}))
$$

Back propagation with `softmax`:
$$
dZ^{[L]} = \hat{Y} - Y
$$

The derivative of softmax is:
$$
\hat{Y} * (1 - \hat{Y})
$$

![example](https://github.com/mbadry1/DeepLearning.ai-Summary/raw/master/2-%20Improving%20Deep%20Neural%20Networks/Images/07-_softmax.png)

# Structuring mechine learning projects

You have a lot of ideas for how to improve the accuracy of your deep learning systems:
- Collect more data;
- Collect more diverse training set;
- Train algorithm longer with gradient descent;
- Try different optimization algorithm(e.g. Adam);
- Try bigger network;
- Try smaller network;
- Try drop out;
- Add L2 regularization;
- Change network architecture(activation functions, number of hidden units, etc.).

This chapter will give you some strategies to help analyze your problem to go in a direction that will help you get better result.

## Orthogonalization

Some deep learning developers know exactly what hyperparameter to tune to try to achieve one effect. This is a process we call orthogonalization. In orthogonalization, you have some controls, but each control does a specific task and doesn't affect other controls.

For a supervised learning system to do well, you usually need to tune the knobs of your system to make sure that four things hold true:
1. You'll have to fit trainning set well on cost function(near human level performance if posiible);
2. Fit dev set well on cost function;
3. Fit test set well on cost function;
4. Performs well in real world.

## Single number evaluation metric

It's better and faster to set a single number evaluation metric for your project before you start i.

### Precision and recall
Suppose we run the classifier on 10 images which are 5 cats and 5 non-cats. The classifier idetifies that there are 4 cats, but it identified 1 wrong cat.
The confusion matrix is:

| iterm | Predicted cat | Predicted non-cat |
| --------------- | -------------- | ------------------ |
| Actual cat | 3 | 2 |
| Actual non-cat | 1 | 4 |

The 
- `Precision`: perception of true cats in the recognized result: $P = \frac{3}{3+1}$;
- `Recall`: perception of the true recognition cats of the all cat predictions: $R = \frac{3}{3+2}$;
- `Accuracy`: $A = \frac{3 + 4}{10}$.

Using a precision/recall for evaluation is good in a lot of cases, but separately they don't tell you which algorithm is better. A better idea is to combine precision and recall in one single number evaluation metric called `F1`:
$$
F_1 = \frac{2}{\frac{1}{P} + \frac{1}{R}}
$$

Sometimes it's hard to get a single number evaluation metrix, ex:

| Classifier | F1 | Running time |
|------------|----|--------------|
| A | 90% | 80ms |
| B | 92% | 95ms |
| C | 92% | 1500ms |

So we can solve this problem by choosing a single optimizing metric and set that other metrics are satisfying, ex:

| Metric type | Metric |
|---|---|
| optimizing metric | Maximizing F1 |
| satisfying metric | running time < 100ms |

The general rule is:
- Set $1$ optimizing metric;
- Set $N-1$ satisfying metric.

## Train/dev/test distributions
- Dev and test sets have to come from the same distribution;
- Choose dev set and test set to reflect data you expect to get in the future and consider important to do well on;
- Setting up the dev set as well as the validation metric really depends on what target you want to aim at.

## Size of the dev and test sets
- The old way(number < 100000) of splitting the data was 70% training, 30%  test or 60% training, 20% dev, 20% test;
- If you have more data, a reasonable split would be 98% training, 1% dev, 1% set.

## Human level performance
We compare to human-level performance because of two main reason:
1. Because of advances in deep learning, machine learning algorithms are suddenly working much better and so it has become much more feasible in a lot of application areas for machine learning algorithms to actually become competitive with human-level performance.
2. It turns out that the workflow of designing and building a machine learning system is much more efficient when you're trying to do something that humans can also do.

After an algorithm reaches the human-level performance the progress and accuracy slow down.

![accuracy](https://raw.githubusercontent.com/AlbertHG/Coursera-Deep-Learning-deeplearning.ai/master/03-Structuring%20Machine%20Learning%20Projects/md_images/4.jpg)

You won't surpass an error called "Bayes optimal error", and there isn't much error range between human-level error and Bayes optimal error.
Humans are good at a lot of tasks. So as long as Mechine learning error is worse than human's, you can:
- Get labeled data from humans;
- Gain insight from manual error analysis: why did a person get it right?
- Better analysis of bias/variance.

## Avoidable bias
Suppose that the cat classification algorithm gives these results:

| Humans | 1% | 7.5% |
|---|---|---|
| Trainning error | 8% | 8% |
| Dev error | 10% | 10% |

In the left example, we have to focus on the `bias` because the human level error is 1%;
in the right example, we have to focus on the `variance` because the human level error is 7.5%.
The human-level error is a proxy for Bayes optimal error, Bayes optimal error is always less, but human-level in most case is not far from it. You can't do better than Bayes error unless you are overfitting.

- `Avoidable bias = Traning error - Human(Bayes) error`
- `Variance = Dev error - Trainning error`

Having an estimate of human-level performance gives you an estimate of Bayes error, this allows you to more quickly make decision which error you should focus to reduce:
- If `avoidable bias` difference is the bigger, then it's a `bias` problem, and you should use a strategy for `bias` resolving;
- If `variance` difference is bigger, then you should use a strategy for `variance` resolving.

## Improving your model performance
There are two fundamental assumptions of supervised learning:
1. You can fit the training set pretty well, this is roughly saying that you can achieve `low avoidable bias`.
2. The training set performance generalizes pretty well to the dev/test set. This is roughly saying that the `variance` is not too bad.

Depends on the error difference, we have following guidelines:
- If `avoidable bias` is large, you can:
 1. Train bigger model;
 2. Train longer/better optimization algorithm(e.g. Momentum, RMSprop, Adam);
 3. Find better neural network architecture or hyperparameters.
- If `variance` is large you can:
 1. Get more training data;
 2. Regularization(L2, Dropout, data augmentation);
 3. Find better neural network architecture or hyperparameters.

## Carrying out error analysis
Error analysis is the process of manually examining mistakes that your algorihtm is making. It can give you insights into what you should do next.
For example, if you have 10% error on your dev set and you want to decrease error. You discovered that some of the mislabled data are dog pictures that look like cats, you should:
1. Get 100 mislabeled dev set examples at random;
2. Count up how many are dogs.
3. Check the result:
 - If 5 of 100 are dogs, then training your classifier to do better on dogs will decrease your error up to 9.5%, which means it may not worth it.
 - If 50 of 100 are dogs, then you could decrease your error up to 5%, which is reasonable and you should work on that.

Sometimes you can evaluate multiple error analysis ideas in parallel and choose the best idea:

| Image | Dot | Great Cats | Blurry | Instagram Filters | Comments |
|---|---|---|---|---|---|
| 1 | Y |   |   | Y | Pitbull |
| 2 | Y |   | Y | Y |   |
| 3 |   |   |   |   | Rainy day at zoo |
| 4 |   | Y |   |   |   |
| ... | |   |   |   |   |
| total

# Sequence models

## Recurrent neural networks
This type of model has been proven to perform extremely well on temporal data. It has several variants including LSTM, GRU and Bidirectional RNN.

### Why sequence models
Sequence models like RNN and LSTMs have greatly transformed learning on sequences in the past few years. Here are some sequence data examples in applications:

- Speech recognition(sequence to sequence):
 - X: wave sequence
 - Y: text sequence
- Music generation(one to sequence):
 - X: nothing or an integar
 - Y: wave sequence
- Sentiment classification(sequence to sequence):
 - X: text sequence
 - Y: integar rating from one to five
- DNA sequence analysis(sequence to sequence):
 - X: DNA sequence
 - Y: DNA labels
- Machine translation(sequence to sequence):
 - X: text sequence(in one language)
 - Y: text sequence(in another language)
- Video activity recognition(sequence to one):
 - X: video frames
 - Y: label(activity)
- Name entity recognition(sequence to sequence):
 - X: text sequence
 - Y: label sequence

All these problems with different input and output(sequence or not) can be addressed as supervised learning with labeled data X/Y as the training set.

### Notation
We now discuss the notation we used in this course.

We name entity recognition:
- X: "Harry Potter and Hermoine Granger invented a new spell."
- Y:  1     1      0   1        1       0        0 0   0

Both elements have a shape of $(9, 1)$. $1$ means it's a name and $0$ means it's not a name.

We will index the first element of $x$ by $x^{<1>}$, the second $x^{<2>}$ and so on:

$$
x^{<1>}, x^{<2>}, \cdots, x^{\<n\>}
$$

Similarly, we will index the first element of $y$ by $y^{<1>}$ and the second $y^{<2>}$ and so on:

$$
y^{<1>}, y^{<2>}, \cdots, y^{\<n\>}
$$

We use:
- $T_x$ to represent the size of input sequence;
- $T_y$ to represent the size of output sequence;
- $x^{(i)\<t\>}$ is the $t$th element of the sequence of input vector $i$;
- $y^{(i)\<t\>}$ is the $t$th element in the output sequence of $i$th training exmaple;
- $T_x^{(i)}$ is the sequence length for training example $i$, it can be different across the examples;
- $T_y^{(i)}$ is the length for output sequence in the $i$th training example.

One of the challenges of natural language processing(NLP) is how can we represent a word.

We need a `vocabulary` list that contains all the words in our target sets, for example:
$$
\begin{bmatrix}
a \\\\ \vdots \\\\ And \\\\ \vdots \\\\ Harry \\\\ \vdots \\\\ Potter \\\\ \vdots \\\\ Zulu
\end{bmatrix}
$$
Each word will have a unique index that it can be represented with, and the sorting here is in alphabetical order.
vocabulary sizes in modern applications are from $30000$ to $50000$, $100000$ is not uncommon, some of the bigger companies use even a million.

And then you create a `one-hot` encoding sequence for each word in your dataset given the vocabulary you have created.
$$
\begin{bmatrix}
0 \\\\ \vdots \\\\ 0 \\\\ \vdots \\\\ 1 \\\\ \vdots \\\\ 0 \\\\ \vdots \\\\ 0
\end{bmatrix}
$$

While converting, if a word is not in your dictionary, you can add a token in the vocabulary with name `<UNK>` wich stands for unknown text and use its index for your `one-hot` vector.

## Recurrent neural network model

Why not using a standard network for sequence tasks? There are two problems:
1. inputs and outputs can be different lengths in different example.
2. this doesn't share features learned across different positions of text/sequence.

Recurrent neural network doesn't have either of the two mentioned problems.

Let's build a `RNN` to solve the `name entity recognition` task:
![rnn](/images/2020/deep_learning/rnn.png)

In this problem, $T_x = T_y$. In other problems they may be not equal.

$a^{<0>}$ is usually initialized with zeros, but some other problems may initialize it randomly.

There are three weight matrices here with shape:
- $W_{ax}$: (NumberOfHiddenNeurons, $n_x$);
- $W_{aa}$: (NumberOfHiddenNeurons, NumberOfHiddenNeurons)
- $W_{ya}$: ($n_y$, NumberOfHiddenNeurons)

The weight matrix $W_{aa}$ is the memory that RNN is trying to maintain from previous layers.

A lot of papers and books write the same architecture in right figure way.

The limitation fo the discussed architecture is that it can not learn from elements later in the sequence.

The forward propagation is as follows:
$$
a^{<0>} = \vec{0}
$$
$$
a^{<1>} = g_1(w_{aa}a^{<0>} + w_{ax}x^{<1>} + b_a) \gets tanh | Relu
$$
$$
y^{<1>} = g_2(w_{ya}a^{<1>} + b_y) \gets sigmoid
$$
$$
a^{\<t\>} = g(w_{aa}a^{\<t-1\>} + w_{ax}x^{\<t\>} + b_a)
$$
$$
y^{\<t\>} = g_2(w_{ya}a^{\<t\>} + b_y)
$$

where:
- The activation function of $a$ is usually $tanh$ or $ReLU$;
- The activation function for $y$ is depending on your task and choosing $sigmoid$ or $softmax$.

Inorder to help us develop complex RNN architecture, the last equations needs to be simplified a lot:
Simplify:
$$
a^{\<t\>} = g(w_{aa}a^{\<t-1\>} + w_{ax}x^{\<t\>} + b_a)
$$
to:
$$
a^{\<t\>} = g(w_{a}[a^{\<t-1\>}, x^{\<t>}]^T + b_a)
$$
where
$$
w_a = \begin{bmatrix} w_{aa}, w_{ax}\end{bmatrix}
$$

In the equation,
- $w_a$ is $w_{aa}$ and $w_{ax}$ stacked horizontally;
- $[a^{\<t-1>}, x^{\<t>}]^T$ is $a^{\<t-1>}$ and $x^{\<t>}$ stacked vertically;
- the shape of $w_a$ is $(NumberOfHiddenNeurons, NumberOfHiddenNeurons + n_x)$;
- the shape of $[a^{\<t-1>}, x^{\<t>}]^T$ is $(NumberOfHiddenNeurons + n_x, NumberOfHiddenNeurons)$.

Following is the architecture for a single cell:
![rnn_forward](/images/2020/deep_learning/rnn_forward.png)

## Backpropagation through time
Usually deep learning frameworks do backpropagation automatically for you, but it's useful to know how it works in RNN.

To calculate backpropagation, and update RNN parameters with gradient descent methods, we define the cross-entropy loss function:
$$
L^{\<t>}(\hat y^{\<t>}, y^{\<t>}) = -y^{\<t>}log(\hat y^{\<t>}) - (1 - y^{\<t>})log(1-\hat y^{\<t>})
$$
This equation is the loss for one example, and the loss for the whole sequence is given by the summation over all the calculated single example losses:
$$
L(\hat y, y) = \sum_{t=1}^{T_x}{L^{\<t>}(\hat y^{\<t>}, y^{\<t>})}
$$
![rnn_backpropa](/images/2020/deep_learning/rnn_backpropa.jpg)

The backpropagation here is called `backpropagation through time` because we pass activation $a$ from one sequence element to another like backwards in time.

## Different types of RNN
So far we have seen only one RNN architecture in which $T_x = T_y$. Other architectures can be:
![type](/images/2020/deep_learning/rnn_type.png)

## Vanishing gradient
One of the problems with naive RNNs is that they run into `vanishing gradient` problem. An RNN that process a sequence data with the size of 10000 time steps has 10000 deep layers which is very hard to optimize.

Let's take an example. Suppose we are working with language modeling problem and there are two sequences that model tries to learn:
- The `cat`, which already ate ..., `was` full.
- The `cats`, which already ate ..., `were` full.

What we need to learn is that `was` came with `cat` and `were` came with `cats`. The naive RNN is not very good at capturing very long-term dependencies like this.

As we discussed before, deeper networks are getting into vanishing gradient problem, this also happens with RNNs with long sequence size. For computing the word `was`, we need to compute the gradient for everything behind. Multiplying fractions tends to vanish the gradient, while the multiplication of large number tends to explode it.

The conclusion is:
> RNNs are not good at long-term dependencies.

Exploding gradients can be easily seen when your weight values become `Nan`. So one of the methods to solve exploding gradient is to apply `gradient clipping`, which means if your gradient is more than some threshold, rescale some of your gradient vecotr so that it's not too big.

The solution for `exploding gradient` problems:
- Truncated backpropagation
 - Not to update all the weights in the way back
 - Not optimal. You won't update all the weights
- Gradient clipping

The solution for `vanishing gradient` problems:
- Weight initialization
 - Like He initialization
- Echo state networks
- Use LSTM/GRU networks
 - Most popular

## Gated Recurrent Unit(GRU)
GRU is an RNN type that can help solve the vanishing gradient problem and can remember the long-term dependencies.
The basic RNN unit can be visualized to:
![gru](/images/2020/deep_learning/gru.jpg)
The drawing for GRU is similar. Each layer in GRU has a new variable `C` called `memory cell` which can tell whether meorize something or not.
In GRUs, $C^{\<t>} = a^{\<t>}$, the equations are:
$$
\tilde c^{\<t>} = tanh(W_c[c^{\<t-1>}, x^{\<t>}] + b_c)
$$
$$
\Gamma_u = \sigma(W_u[c^{\<t-1>}, x^{\<t>}] + b_u)
$$
$$
c^{\<t>} = \Gamma_u \times \tilde c^{\<t>} + (1 - \Gamma_u) \times c^{\<t-1>}
$$

The $\Gamma_u$ is called `update gate`, and it's value is between 0 and 1.
![gru](/images/2020/deep_learning/gru_gate.jpg)

Because the update gate U is usually a small number like $0.000001$, GRUs doesn't suffer the vanishing gradient problem.

The GRU above is the simplified GRU unit, the full one is:
$$
\tilde c^{\<t>} = tanh(W_c[\Gamma_r \times c^{\<t-1>}, x^{\<t>}] + b_c)
$$
$$
\Gamma_u = \sigma(W_u[c^{\<t-1>}, x^{\<t>}] + b_u)
$$
$$
\Gamma_r = \sigma(W_r[c^{\<t-1>}, x^{\<t>}] + b_r)
$$
$$
c^{\<t>} = \Gamma_u \times \tilde c^{\<t>} + (1 - \Gamma_u) \times c^{\<t-1>}
$$

## Long Short Term Memory(LSTM)
LSTM is another type of RNN that can enable you to account for long-term dependencies. It's more powerful and general than GRU.
In LSTM, $C^{\<t>} != a^{\<t>}$:
$$
\tilde{C}^{\<t>} = tanh(W_c[a^{\<t-1>}, x^{\<t>}] + b_c)
$$
$$
 \Gamma_u = \delta(W_u[a^{\<t-1>}, x^{\<t>}] + b_u)
$$
$$
 \Gamma_f = \delta(W_f[a^{\<t-1>}, x^{\<t>}] + b_f)
$$
$$
 \Gamma_o = \delta(W_o[a^{\<t-1>}, x^{\<t>}] + b_o)
$$
$$
C^{\<t>} = \Gamma_u \times \tilde{C}^{\<t>} + \Gamma_f \times C^{\<t-1>}
$$
$$
a^{\<t>} = \Gamma_o \times tanh C^{\<t>}
$$
In LSTM, we have:
- update gate: $\Gamma_u$;
- forget gate: $\Gamma_f$;
- output gate: $\Gamma_o$;
- candidate cell variable: $\tilde{C}^{\<t>}$.

![lstm](/images/2020/deep_learning/lstm.png)
 One of the advantages of GRU is that it's simpler and can be used to build much bigger network but the LSTM is more powerful and general.

## Bidirectional RNN
There are still some idea to let you build much more powerful sequence models. One of them is bidirectional RNNs and another is Deep RNN.

One directional RNN can only learned the information before this position, but BiRNN fixes this issue.
![birnn](/images/2020/deep_learning/birnn.png)
- BiRNN is an acyclic graph.
- Part of the forward propagation goes from left to right and part from right to left. It learns from boths side.
- To make prediction we use $\tilde y^{\<t>}$ with two activation that come from left and right.
- The blocks here can be any RNN block including the basic RNNs, LSTMs or GRUs.
- For a lot of NLP or text processing problems, a BiRNN with LSTM appears to be commonly used.
- The disadvantage of BiRNNs is that you need the entire sequence before you can process it. For example, in live speech recognition if you use BiRNNs you will need to wait for the speaker to stop to take the entire sequence and then make your predictions.

## Deep RNNs
In a lot of cases the standard one layer RNNs will solve your problem. But in some problems its useful to stack some RNN layers to make a deeper network.
For example, a deep RNN with 3 layers would look like this:
![deep_rnn](/images/2020/deep_learning/deep_rnn.png)

In feed-forward deep nets, there could be 100 or even 200 layers. In deep RNNs stacking 3 layers is already considered deep and expensive to train.

