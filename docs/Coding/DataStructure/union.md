# Union

```C++
class UnionFind {
 public:
  Union(int n) : size(n - 1, 1), cnt{n} {
    for (int i = 0; i < n; ++i) parent.push_back(i);
  }

 public:
  int find(int x) {
    if (parent[x] != x) parent[x] = find(parent[x]);
    return parent[x];
  }

  bool unite(int x, int y) {
    int xx = find(x);
    int yy = find(y);
    if (xx == yy) return false;
    if (size[xx] > size[yy]) swap(xx, yy);
    parent[xx] = yy;
    size[yy] += size[xx];
    cnt--;
    return true;
  }

  int count() const {
    return cnt;
  }

 private:
  vector<int> parent{};
  vector<int> size{};
  int cnt{0};
};

struct Edge{
  int from{0};
  int to{0};
  int cost{0};
};
```
