# Segment Tree

```C++
/// Segment tree for range sum
class SegmentTree {
 public:
  /// Reset data and change list to the size of 4n, where n is the size of array
  SegmentTree(const vector<int>& a) : d(4 * a.size(), 0), b(4 * a.size(), 0) {
    build(0, a.size() - 1, 1, a);
  }

  /// Recursively build the tree
  void build(int s, int e, int p, const vector<int>& a) {
    if (s == e) {  // terminate if the range is one
      d[p] = a[s];
      return;
    }

    int m = s + (e - s) / 2;  // get mid of the range, avoid of overflow
    build(s, m, p * 2, a);
    build(m + 1, e, p * 2 + 1, a);
    d[p] = d[p * 2] + d[p * 2 + 1];
  }

  /// Update the range [l, r] to c in the tree d[p], which is the range [s, e]
  void update(int l, int r, int c, int s, int e, int p) {
    if (l <= s && e <= r) {  // [s, e] is in the range [l, r]
      d[p] += (e - s + 1) * c;
      b[p] = c;
      return;
    }

    // range half to update
    int m = s + (e - s) / 2;
    if (b[p]) {  // has lazy change, pushdown
      // update current node's left and right child's data and bias
      // range [l, r] add a num
      d[p * 2] += b[p] * (m - s + 1), d[p * 2 + 1] += b[p] * (e - m);
      d[p * 2] += b[p], b[p * 2 + 1] += b[p];
      // range [l, r] change to a num
      // d[p * 2] = b[p] * (m - s + 1), d[p * 2 + 1] = b[p] * (e - m);
      // d[p * 2] = b[p], b[p * 2 + 1] = b[p];
      b[p] = 0;  // clear current node's bias
    }

    if (l <= m) update(l, r, c, s, m, p * 2);
    if (r > m) update(l, r, c, m + 1, e, p * 2 + 1);
    d[p] = d[p * 2] + d[p * 2 + 1];
  }

  /// Query sum of range [l, r] in the tree d[p], which is the range [s, e]
  int query(int l, int r, int s, int e, int p) {
    if (l <= s && e <= r) return d[p];

    int m = s + (e - s) / 2, sum = 0;
    if (b[p]) {  // has lazy change, pushdown
      // update current node's left and right child's data and bias
      // range [l, r] add a num
      d[p * 2] += b[p] * (m - s + 1), d[p * 2 + 1] += b[p] * (e - m);
      d[p * 2] += b[p], b[p * 2 + 1] += b[p];
      // range [l, r] change to a num
      // d[p * 2] = b[p] * (m - s + 1), d[p * 2 + 1] = b[p] * (e - m);
      // d[p * 2] = b[p], b[p * 2 + 1] = b[p];
      b[p] = 0;  // clear current node's bias
    }

    if (l <= m) sum += query(l, r, s, m, p * 2);
    if (r > m) sum += query(l, r, m + 1, e, p * 2 + 1);
    return sum;
  }

 private:
  vector<int> d{};  // tree node data array
  vector<int> b{};  // tree node bias array
};
```
