---
title: An Intuitive Idea of Limits
mathjax: true
comments: true
date: 2019-11-08 00:14:33
categories:
  - math
---
Calculus wouldn't exist without the concept of limits. It's pretty tricky to define a limit properly, but we can get an intuitive understanding of limits even without going into gory details.
<!-- more -->
## Basic Idea
Limits solve this problem: what does $f(x)$ looks like when $x$ is really really close to $a$, but not equal to $a$?

For example, we have a function like this:
$$
f(x) = x - 1 \qquad when \quad x \ne 2
$$
![limit](/images/2019-11-06-An-Intuitive-Idea-of-Limits/limit.png)

What is $f(2)$? We can find $f(x)$ is really really close to $2$, when $x$ is really really close to $2$, for example, $f(2.00001) = 1.00001$, $f(1.99999) = 0.99999$. So we just write the limit of $f(x)$ at $2$ as:
$$
\lim_{x \to 2}f(x) = 1
$$
which read as "the limit, as $x$ goes to $2$, of $f(x)$ is equal to $1$".
This means when $x$ is near $2$(but not equal to it), the value of $f(x)$ is near $1$.

The above function $f$ has a domain without $2$, but what if the domain is all real number? We defines a new function $g(x)$:
$$
g(x) = \begin{cases}
x - 1 \qquad & if \quad x \ne 2 \\
3 \qquad & if \quad x = 2
\end{cases}
$$

What is $\lim_{x \to 2}g(x)$? The trick is that the value of $g(2)$ is irrelevant. It's only the values of $g(x)$ where $x$ is close to $2$, not actually `at` 2, which matter. So 
$$
\lim_{x \to 2}g(x) = 1
$$
even though $g(2) = 3$.

## Left-hand and Right-hand Limits
We have known how to describe a limit at certain point when the graph of the function is a continous line, but how to describe the following situation?
![left_right_limit](/images/2019-11-06-An-Intuitive-Idea-of-Limits/left_right_limit.png)

Now what happens when you approach $x = 3$ from the left? Iamgine you're the hiker in the picture, climbing up and down the hill. The value of $h(x)$ tells you how high up you are when your horizontal position is at $x$. When you walk rightward from the left of the picture, then when your horizontal position is close to $3$, your height is close to $1$, which means that the `left-hand limit` of $x = 3$ is equal to $1$, written as:
$$
\lim_{x \to 3^-}h(x) = 1
$$
And the `right-hand limit` is:
$$
\lim_{x \to 3^+}h(x) = -2
$$
The little minus sign after $3$ in the first limit above means that the limit is a left-hand limit, and the little plus sign in the second limit means that it's a right-hand limit.
When both left-hand and right-hand limits at $x = a$ `exist and euqal to each other` we can say the regular two-side limit at $x = a$ exists. In math-speak:

$$
\lim_{x \to a^-}f(x) = L \quad and \quad \lim_{x \to a^+}f(x) = L \quad \Rightarrow \quad \lim_{x \to a}f(x) = L
$$

And if left-hand limit and right-hand limit are not equal, we just write:
$$
\lim_{x \to 3}h(x) \quad DNE (does\;not\;exist)
$$

## Vertical Asymptote
Let's look at the graph of $f(x) = \frac{1}{x}$:
![1_x](/images/2019-11-06-An-Intuitive-Idea-of-Limits/1_x.png)
When $x$ towards $0$
