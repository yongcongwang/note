This is a summary of algorithms which solve problems in coding interview.

## Data structure
For any data structure, the basic operation is no more than `traversal` and `access`, and more specific point are:

- Add;
- Delete;
- Search;
- Modify.

How to `traverse` and `access`? For the reason that data stored in two form:
- linear(e.g., array);
- nonlinear(e.g., linked list).

So the frame to solve the data structure problems is to traverse all the elements.

### Array
```C++
void traverse(int[] arr) {
  for (int i = 0; i < arr.length; i++) {
    // iteratively visit arr[i]
  }
}
```

### Linked list
Linked list has both iterative and recursive structure:
```C++
/* Basic node of the single linked list */
class ListNode {
  int val;
  ListNode next;
}

void traverse(ListNode head) {
  for (ListNode p = head; p != null; p = p.next) {
    // iteratively p.val
  }
}

void traverse(ListNode head) {
  // recusively head.val
  traverse(head.next)
}
```

### Binary tree
Binary tree typically is nonlinear recursive traversal structure:
```C++
/* Basic node of the binary tree */
class TreeNode {
  int val;
  TreeNode left, right;
}

void traverse(TreeNode root) {
  // pre-order traverse
  traverse(root.left)
  // in-order traverse
  traverse(root.right)
  // post-order traverse
}
```

## Dynamic planning
The normal for of dynamic programming problem is to `calculate the maximum or minimum`.

The core of the problem is `enumeration`. We are asked to calculate the max or min, so we enumerate all the posible answers and find the the max/min answer.

But the enumeration of dynamic programming is a bit special, because they may contains `overlapped subproblems`, which make the enumeration low efficiency. We need a `memo` or `dp table` to optimize the process of enumeration to avoid unneccessary calculations.

The hardest part of this process is to write out the `state transition equation`. We can use the following steps to consider the state transition equation:

1. Find out [state] which changes every iteration;
2. Define dp array `dp[state1][state2][...]` value meanings;
3. Find out [option] which we can choose to change the state;
4. Find out the base case.

The normal frame is:
```C++
## Init base case
dp[0][0][...] = base
## State transition
for state1 in all_values_state1_can_be:
    for state2 in all_values_state2_can_be:
        for ...
            dp[state1][state2][...] = extremum(option1, option2...)
```

## Backtracking
Solving a backtracking problem is actually a traversal process of a decision tree. You only need to think about following steps:

1. Path: the selection that have been made;
2. Selection list: the selection you can currently make;
3. End condition: under which you reach the bottom of the decision tree.

The frame is:
```C++
result = []
def backtrack(Path, SeletionList):
    if meet the End Conditon:
        result.add(Path)
        return
    
    for seletion in Seletion List:
        select
        backtrack(Path, Seletion List)
        deselect
````

## Bread First Search
The problem BFS solved is to find the `shortest path` from `start` to `end` in a `graph`.
```C++
// Calculate the shortest path from start to end
int BFS(Node start, Node target) {
    Queue<Node> q; // core data structure
    Set<Node> visited; // avoid search backward

    q.offer(start); // add the start
    visited.add(start);
    int step = 0; // remember the path

    while (q not empty) {
        int sz = q.size();
        // expand from current nodes
        for (int i = 0; i < sz; i++) {
            Node cur = q.poll();
            // check the target point
            if (cur is target)
                return step;
            // add the surrounding point
            for (Node x : cur.adj())
                if (x not in visited) {
                    q.offer(x);
                    visited.add(x);
                }
        }
        // update steps
        step++;
    }
}
```

## Binary Search
We can use binary search to search:

- A single value;
- Left boundary;
- Right boundary.

Here are frames:
```C++
int binary_search(int[] nums, int target) {
    int left = 0, right = nums.length - 1; 
    while(left <= right) {
        int mid = left + (right - left) / 2;
        if (nums[mid] < target) {
            left = mid + 1;
        } else if (nums[mid] > target) {
            right = mid - 1; 
        } else if(nums[mid] == target) {
            // Return directly
            return mid;
        }
    }
    // Return directly
    return -1;
}

int left_bound(int[] nums, int target) {
    int left = 0, right = nums.length - 1;
    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (nums[mid] < target) {
            left = mid + 1;
        } else if (nums[mid] > target) {
            right = mid - 1;
        } else if (nums[mid] == target) {
            // Don't return! Lock left border
            right = mid - 1;
        }
    }
    // Check whether left border out of bounds lastly
    if (left >= nums.length || nums[left] != target)
        return -1;
    return left;
}


int right_bound(int[] nums, int target) {
    int left = 0, right = nums.length - 1;
    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (nums[mid] < target) {
            left = mid + 1;
        } else if (nums[mid] > target) {
            right = mid - 1;
        } else if (nums[mid] == target) {
            // Don't return! Lock right border
            left = mid + 1;
        }
    }
    // Check whether right border out of bounds lastly
    if (right < 0 || nums[right] != target)
        return -1;
    return right;
}

```

## Slide window
The sliding window algorithm idea is like this:

1. We start with two pointers, left and right initially pointing to the first element of the string S;
2. We use the right pointer to expand the window [left, right] until we get a desirable window that contains all of the characters of T;
3. Once we have a window with all the characters of T;
4. If the window is not desirable any more, we repeat step 2 on wards.

The main idea is: Move right pointer to find a valid window, when a valid wimdow is found, move left pointer to find a smaller window(optimal solution).

The frame is:

```C++
string s, t;
// Looking for the "minimum substring" of t in s
int left = 0, right = 0;
string res = s;

while(right < s.size()) {
    window.add(s[right]);
    right++;
    // When we found a valid window, move left to find smaller window.
    while (found a valid window) {
        // If the window's substring is shorter, update the res
        res = minLen(res, window);
        window.remove(s[left]);
        left++;
    }
}
return res;
```

Refinement pseudocode above:
```C++
string s, t;
// Two pointers
int left = 0, right = 0;
string res = s;

// Initialize the map
unordered_map<char, int> window;
unordered_map<char, int> needs;
for (char c : t) needs[c]++;

// The number of characters that meet the requirement
int match = 0;

while (right < s.size()) {
    char c1 = s[right];
    if (needs.count(c1)) {
        window[c1]++; // Add to window
        if (window[c1] == needs[c1])
            // The number of occurrences of the character c1 meets the requirement
            match++;
    }
    right++;

    // When we found a valid window
    while (match == needs.size()) {
        // Update res here if finding minimum
        res = minLen(res, window);
        // Increase left pointer to make it invalid/valid again
        char c2 = s[left];
        if (needs.count(c2)) {
            window[c2]--; // Remove from window
            if (window[c2] < needs[c2])
                // The number of occurrences of the character c2 no longer meets the requirement
                match--;
        }
        left++;
    }
}
return res;
```
