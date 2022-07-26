# Algorithm Cheatsheet

## Sort

### Quick Sort
```C++
void quick_sort(int a[], int l , int r) {
  if (l >= r) return;

  int i = l - 1, j = r + 1, p = a[l + (r - l) / 2];
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

  int mid = l + (r - l) / 2;
  merge_sort(a, l, mid);
  merge_sort(a, mid + 1, r);

  int i = l, j = mid + 1, k = l;
  while (i <= mid && j <= r) tmp[k++] = a[i] < a[j] ? a[i++] : a[j++];
  while (i <= mid) tmp[k++] = a[i++];
  while (j <= r) tmp[k++] = a[j++];

  for (int k = l; k <= r; ++k) a[k] = tmp[k];
}

```
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
```

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
    t = t < 0 ? -1 : 0;
  }
  while (C.size() > 1 && C.back() == 0) C.pop_back();
  return C;
}
```

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

### Division

```C++
/// digits of A and C are in reverse order
pair<vector<int>, int> div(vector<int>& A, int b) {
  vector<int> C{};
  int r{0};
  for (int i = A.size() - 1; i >= 0; --i) {
    r = r * 10 + A[i];
    C.push_back(r / b);
    r %= 10;
  }
  reverse(C.begin(), C.end());
  while (C.size() > 1 && C.back() == 0) C.pop_back();
  return {C, r};
}
```
