# Algorithm Cheetsheet

## Quick Sort
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

## MergeS Sort

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

## Binary Search
//           Left                             Right
// |---------------------------| |------------------------------|
//                   right end | | left end

// Left end
// Devide range [l, r] to [l, mid] and [mid + 1, r], and l locates at (mid + 1)
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
// Devide range [l, r] to [l, mid - 1] and [mid, r], and l locates at (mid)
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
