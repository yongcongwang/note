---
title: How to Solve Data Structure Problems
date: 2020-08-17 16:20:11
mathjax: true
categories:
  - coding
---

This article only covers basic data structures, the complex structure is not discussed here.

# The Storage of Data Structure 
There are only two kinds of methods that data structure is stored:
- Array, which is sequential storage;
- Linked list, which may be placed anywhere in memory.

Many other data structures can be implemented by the two methods above. 

<!-- more -->

## Queue and Stack
`Queue` and `Stack` can be storaged either array or linked list:
- Using array, you should consider about expending and shrinking the capacity of array;
- Using linked list, you don't need to care about the capacity, but it needs more memory to store the pointer of node.

## Graph
`Graph` can be stored either array or linked list:
- Using array, it's easy to check the connection, but it may consume more memory if the graph is sparse.
- Using linked list, memory is saved, but the efficience of operation is lower than array.

## Hash Table
- Using array, needs less memory but operation is complex;
- Using linked list, needs more memory to store pointers but operation is simple.

## Tree
You can store a tree in an array or use linked list to construct a normal `tree`.

## Conclusion
There are so many data structures, but in storage, array and linked list are based.

- Array stored in a continous memory, you can use index to get the element quickly. But if you want to expend the size of meomry, you need to create a bigger meomry and copy all elements to new memory, the time complexity is $O(N)$; as for `insert` and `delete`, you need to move all items behind the element, the time complexity is $O(N)$.

- Linked list can be stored in uncoutinous memory, it use a pointer to point next element, so it doesn't have the problem of expending capacity. If we know the previous and next elements of an item, we can delete/add an item in $O(1)$ time. But you can not random access becouse of the uncoutinous memory. And you need more meory to store pointers pointing to other elements.

# The Operation of Data Structure
For all data structures, the basic operators are:
- Add;
- Delete;
- Get;
- Change.

We use different data structure in defferent scenarios, but purposes are the same: to add/delete/get/change data more quickly.

# The Solution of Data Structure
The problems about data structure are all about add/delete/get/change, so the solution is how to `traverse` and `access` elements.
There are two kinds of methods to traverse and access elements:
- Linear, which is represented by `for/while` loop;
- Non-linear, which is represented by `recursion`.

## Array Traverse
```C++
void traverse(vector<int> arr) {
  for (int i = 0; i < arr.size(); ++i) {
    // access arr[i]
  }
}
```

## Linked List Traverse
```C++
struct ListNode {
  int val;
  ListNode* next;
};

void traverse(ListNode* head) {
  while (head != nullptr) {
    // access head->val
    head = head->next;
  }
}

void traverse(ListNode* head) {
  // access head->val
  traverse(head->next);
}
```

## Binary Tree Traverse
```C++
struct TreeNode {
  int val;
  TreeNode* left;
  TreeNode* right;
};

void traverse(TreeNode* root) {
  // access root->val
  traverse(root->left);
  traverse(root->right);
}
```
