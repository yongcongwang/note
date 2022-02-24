# Segment Tree

```C++
/// Segment tree for range sum
class SegmentTree {
 public:
  /// Reset data and change list to the size of 4n, where n is the size of array
  SegmentTree(const vector<int>& a) : d(4 * a.size(), 0), c(4 * a.size(), 0) {
    build(0, a.size() - 1, 1, a);
    // for (auto e : d) cout << e << ", "; cout << endl;
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

  /// Update the range [l, r] to v in the tree d[p], which is the range [s, e]
  void update(int l, int r, int v, int s, int e, int p) {
    if (l <= s && e <= r) {  // [s, e] is in the range [l, r]
      d[p] += (e - s + 1) * v;
      c[p] = v;
      return;
    }

    // range half to update
    int m = s + (e - s) / 2;
    if (c[p]) {  // has lazy change
      // update current node
      d[p * 2] += c[p] * (m - s + 1);
      d[p * 2 + 1] += c[p] * (e - m);
      // trans the change to its children
      c[p * 2] += c[p];
      c[p * 2 + 1] += c[p];
      // clear current node change
      c[p] = 0;
    }

    if (l <= m) update(l, r, v, s, m, p * 2);
    if (r > m) update(l, r, v, m + 1, e, p * 2 + 1);
    d[p] = d[p * 2] + d[p * 2 + 1];
  }

  /// Get sum of range [l, r] in the tree d[p], which is the range [s, e]
  int get(int l, int r, int s, int e, int p) {
    if (l <= s && e <= r) return d[p];

    int m = s + (e - s) / 2, sum = 0;
    if (c[p]) {  // has lazy change
      // update current node
      d[p * 2] += c[p] * (m - s + 1);
      d[p * 2 + 1] += c[p] * (e - m);
      // trans the change to its children
      c[p * 2] += c[p];
      c[p * 2 + 1] += c[p];
      // clear current node change
      c[p] = 0;
    }

    if (l <= m) sum += get(l, r, s, m, p * 2);
    if (r > m) sum += get(l, r, m + 1, e, p * 2 + 1);
    return sum;
  }

 private:
  vector<int> d{};
  vector<int> c{};
};
```
