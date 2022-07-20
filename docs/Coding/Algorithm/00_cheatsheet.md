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

```C++
// Left
```
