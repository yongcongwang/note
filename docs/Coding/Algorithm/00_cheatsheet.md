# Algorithm Cheatsheet

## Sort

### Quick Sort
```C++
void quick_sort(int a[], int l , int r) {
  if (l >= r) return;

  int i = l - 1, j = r + 1, p = a[l + r >> 1];
  while (i < j) {
    while (a[++i] < p);
    while (a[--j] > p);
    if (i < j) swap(a[i], a[j]);
  }
  quick_sort(a, l, j);
  quick_sort(a, j + 1, r);
}
```

### Merge Sort

```C++
int tmp[N];
void merge_sort(int a[], int l, int r) {
  if (l >= r) return;

  int mid = l + r >> 1;
  merge_sort(a, l, mid);
  merge_sort(a, mid + 1, r);

  int i = l, j = mid + 1, k = l;
  while (i <= mid && j <= r) tmp[k++] = a[i] < a[j] ? a[i++] : a[j++];
  while (i <= mid) tmp[k++] = a[i++];
  while (j <= r) tmp[k++] = a[j++];

  for (int k = l; k <= r; ++k) a[k] = tmp[k];
}
```

- [leetcode](https://leetcode.cn/problems/sort-an-array/)


## Serach

### Binary Search

```C++
//           Left                             Right
// |---------------------------| |------------------------------|
//                   right end | | left end

// Left end
// Devide [l, r] to [l, mid] + [mid + 1, r], l locates at mid + 1
int bs(int a[], int l, int r) {
  while (l < r) {
    int mid = l + r >> 1;
    if (resultl_is_in(mid)) {
      r = mid;
    } else {
      l = mid + 1;
    }
  }
  return l;
}

// Right end
// Devide [l, r] to [l, mid - 1] + [mid, r], l locates at mid
int bs(int a[], int l, int r) {
  while (l < r) {
    // avoid the case [l, r] = [0, 1]
    int mid = l + r + 1 >> 1;
    if (is_result_in(mid)) {
      l = mid;
    } else {
      r = mid - 1;
    }
  }
  return l;
}

/// Float
constexpr double eps = 1e-6;
double bs(double l, double r) {
  while (r - l > eps) {
    double mid = (l + r) / 2;
    if (Valid(mid)) {
      r = mid;
    } else {
      l = mid;
    }
  }
  return l;
}
```

- [leetcode](https://leetcode.cn/problems/find-first-and-last-position-of-element-in-sorted-array/)

## Expression

### Addition

```C++
/// digits of A, B and C are in reverse order
vector<int> add(vector<int>& A, vector<int>& B) {
  if (A.size() < B.size()) return add(B, A);

  vector<int> C{};
  int t{0};
  for (int i = 0; i < A.size(); ++i) {
    t += A[i];
    if (i < B.size()) t += B[i];
    C.push_back(t % 10);
    t /= 10;
  }
  if (t) C.push_back(t);

  return C;
}
```

- [acwing](https://www.acwing.com/problem/content/793/)

### Subtraction

```C++
/// digits of A, B and C are in reverse order
/// and A is bigger than B
vector<int> add(vector<int>& A, vector<int>& B) {
  vector<int> C{};
  for (int i = 0, t = 0; i < A.size(); ++i) {
    t = A[i] - t;
    if (i < B.size()) t -=B[i];
    C.push_back((t + 10) % 10);
    t = t < 0 ? 1 : 0;
  }
  while (C.size() > 1 && C.back() == 0) C.pop_back();
  return C;
}
```

- [problem](https://www.acwing.com/problem/content/794/)

### Multiplication

```C++
/// digits of A and C are in reverse order
vector<int> mul(vector<int>& A, int b) {
  vector<int> C{};
  for (int i = 0, t = 0; i < A.size() || t; ++i) {
    if (i < A.size()) t += A[i] * b;
    C.push_back(t % 10);
    t /= 10;
  }
  while (C.size() > 1 && C.back() == 0) c.pop_back();
  return C;
}
```

- [problem](https://www.acwing.com/problem/content/795/)

### Division

```C++
/// digits of A and C are in reverse order
pair<vector<int>, int> div(vector<int>& A, int b) {
  vector<int> C{};
  int r{0};
  for (int i = A.size() - 1; i >= 0; --i) {
    r = r * 10 + A[i];
    C.push_back(r / b);
    r %= b;
  }
  reverse(C.begin(), C.end());
  while (C.size() > 1 && C.back() == 0) C.pop_back();
  return {C, r};
}
```

- [problem](https://www.acwing.com/problem/content/796/)

## Prefix

### Prefix Sum

```C++
for (int i = 1; i <= n; ++i) p[i] = p[i - 1] + a[i - 1];
```

- [problem](https://leetcode.cn/problems/range-sum-query-immutable/)

### Prefix Sum 2D

```C++
for (int i = 1; i <= n; ++i) for (int j = 1; j <= m; ++j)
    p[i][j] = a[i - 1][j - 1] + p[i][j - 1] + p[i - 1][j] - p[i - 1][j - 1];
```

- [problem](https://leetcode.cn/problems/range-sum-query-2d-immutable/)

### Prefix Diff

```C++
void insert(int p[], int l, int r, int c) {
  p[l] += c;
  p[r + 1] -= c;
}

/// get each element
for (int i = 1; i <= n; ++i) p[i] += p[i - 1];
```

- [problem](https://www.acwing.com/problem/content/799/)

### Prefix Diff 2D

```C++
void insert(int p[][N], int x1, int y1, int x2, int y2, int c) {
  p[x1][y1] += c;
  p[x2 + 1][y1] -= c;
  p[x1][y2 + 1] -= c;
  p[x2 + 1][y2 + 1] += c;
}

// Get each element
for (int i = 1; i <= n; ++i) for (int j = 1; j <= m; ++j)
  b[i][j] += b[i - 1][j] + b[i][j - 1] - b[i - 1][j - 1];
```

- [problem](https://www.acwing.com/problem/content/800/)

## Bit Operator

### K bit

```C++
int kbit(int x, int k) { return x >> k & 1; }
```

- [problem](https://www.acwing.com/problem/content/803/)

### Lowbit

```C++
int lowbit(int x) { return x & -x; }
```

## Two Pointers

```C++
/// 1 array
/// nnnnnnnnnnnnnnnnnnnnnn
///     ^          ^
///     | j        | i    
/// 2 array
/// nnnnnnnnnnnnnnnnnnnnnn
///     ^           
///     | i               
/// nnnnnnnnnnnnnnnnnnnnnn
///                ^
///                | j    
for (int i = 0, j = 0; i < n; ++i) {
  // add i here

  while (j < i && check(i, j)) ++j;  // remove j

  // record answer here
}
```

- [problem](https://www.acwing.com/problem/content/801/)
- [problem](https://www.acwing.com/problem/content/802/)

## Discrete

```C++
vector<int> a{};  // to be discrete
sort(a.begin(), a.end());
a.erase(unique(a.begin(), a.end()), a.end());

// get index after discrete
int find(int x) {
  int l = 0, r = a.size() - 1;
  while (l < r) {
    int mid = l + (r - l) / 2;
    if (a[mid] >= x) {
      r = mid;
    } else {
      l = mid + 1;
    }
  }
  return l;
}
```

- [problem](https://www.acwing.com/problem/content/804/)

## Merge Range

```C++
using PII = pair<int, int>;
void merge(vector<PII> &segs) {
  sort(segs.begin(), segs.end());

  vector<PII> ans{};
  int s = -2e9, e = -2e9;
  for (auto [ss, se] : segs) {
    if (e < ss) {
      if (e != -2e9) ans.push_back({s, e});
      tie(s, e) = pair{ss, se};
    } else {
      e = max(e, se);
    }
  }
  if (s != -2e9) ans.push_back({s, e});

  return ans;
}
```

- [problem](https://www.acwing.com/problem/content/805/)

## Linked List

```C++
// head index , element, next element index, index to empty memory
int head, e[N], ne[N], idx;

void init() {
  head = -1;
  idx = 0;
}

// add a node with value of v to head
void to_head(int v) {
  e[idx] = v, ne[idx] = head, head = idx++;
}

// remove node after ith node
void remove(int i) {
  ne[i] = ne[ne[i]];
}

// insert a node with value of v after kth node
void insert(int k, int v) {
  e[idx] = v, ne[idx] = ne[k], ne[k] = idx++;
}

// traval the linked list
for (int i = head; i != -1; i = ne[i]) cout << e[i];
```

- [problem](https://www.acwing.com/problem/content/828/)

## Double Linked List

```C++

int e[N], l[N], r[N], idx;

// idx 0 for left node, idx 1 for right node
void init() {
  r[0] = 1, l[1] = 0;
  idx = 2;
}

// insert a node at i's right
void insert(int i, int v) {
  e[idx] = v;
  l[idx] = i, r[idx] = r[i];
  l[r[i]] = idx, r[i] = idx++;
}

// remove i node
void remove(int i) {
  r[l[i]] = r[i];
  l[r[i]] = l[i];
}

// travel
for (int i = 0; i != 1; i = r[i]) cout << e[i];
```

- [problem](https://www.acwing.com/problem/content/828/)

## Stack

```C++
int stk[N], idx = 0;

void push(int x) { stk[++idx] = x; }

void pop() { --idx; }

int top() { return stk[idx]; }

bool empty() { return idx == 0; }
```

- [problem](https://www.acwing.com/problem/content/description/830/)

## Queue

```C++
/// loop
int q[N], h = 0, t = 0;

void push(int x) {
  q[t] = x;
  if (t == N) t = 0;
}

void pop() {
  h++;
  if (h == N) h = 0;
}

void front() { return q[h]; }

bool empty() { return h == t; }
```

## Monotonous stack

```C++
int stk[N], t = 0;

for (auto n : a) {
  while (t && stk[t] >= n) --t;
  stk[++t] = n;
}
```
