# Stack

Stacks and queues are dynamic sets in which the element removed from the set by `Delete` operation is prespecified.

In a `stack`, the element deleted from the set is the most recently inserted: the stack implements a `last-in, first-out` or `LIFO`, policy.

![stack](images/stack.png)

The `Insert` operation on a stack is often called `Push`, and the `Delete` operation, which does not take an element, is often called `Pop`. These names are allusions to physical stacks, such as the spring-loaded stacks of plates used in cafeteriass. The order in which plates are popped from the stack is the reverse of the order in which they were pushed onto the stack, since only the top plate is accessible.

## Implementation

You can use

- array
- linked list

to implement a `stack`.

## Problems

### Implementation

- [155. Min Stack](https://leetcode-cn.com/problems/min-stack/)
- [225. Implement Stack using Queues](https://leetcode-cn.com/problems/implement-stack-using-queues/)

### Expression Evaluation and Syntax Parsing

- [20. Valid Parentheses](https://leetcode-cn.com/problems/valid-parentheses/)
- [71. Simplify Path](https://leetcode-cn.com/problems/simplify-path/)
- [150. Evaluate Reverse Polish Notation](https://leetcode-cn.com/problems/evaluate-reverse-polish-notation/)
- [224. Basic Calculator](https://leetcode-cn.com/problems/basic-calculator/)
- [227. Basic Calculator II](https://leetcode-cn.com/problems/basic-calculator-ii/)

### Monotonous Stack

- [42. Trapping Rain Water](https://leetcode-cn.com/problems/trapping-rain-water/)
- [84. Largest Rectangle in Histogram](https://leetcode-cn.com/problems/largest-rectangle-in-histogram/)

