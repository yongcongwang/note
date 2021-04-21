# Sorting algorithms

## Assumption
To simplify matters, we will assume that the algorithms we describe will all be interchangeable:

1. All array positions contain data to be sorted;
2. The `N` is the number of elements passed to our sorting routines;
3. the `>` and `<` operators exists, which can be used to place a consistant ordering on the input.

Sorting under these conditions is known as comparision-based sorting.

## Bubblesort
Bubblesort is the simplest sorting algorithm that works by repeatedly swapping the adjacent elements if they are in wrong order. The algorithm is a comparison sort, is named for the way smaller or larger elements "bubble" to the top of the list. Although the algorithm is simple, it is too slow and impractical for most problems even when compared to Insertionsort. Bubblesort can be practical if the input is in mostly sorted order with some out-of-order elements nearly in position.

```C++
template <typename T>
void bubbleSort(std::vector<T> arr) {
  for (std::size_t i = 0, size = arr.size(); i < size - 1; ++i) {
    for (std::size_t j = 0; j < size - 1 - i; ++j) {
      if (arr[j] > arr[j + 1]) {
        swap(arr[j], arr[j + 1]);
      }
    }
  } 
}
```

## Insertionsort
One of the simplest sorting algorithms is the insertion sort.
Insertion sort consists of N - 1 passes. For pass p = 1 through N - 1, insertion sort ensures that the elements in position 0 through p are in sorted order. Insertion sort makes use of the fact that elements in position 0 through p - 1 are already known to be in sorted order.
```C++
template <typename T>
void insertSort(std::vector<T> &arr) {
  for (std::size_t i = 0, j, size = arr.size(); i < size; ++i) {
    T tmp = arr[i];
    for (j = i; j > 0 && tmp < arr[j - 1]; --j) {
      arr[j] = arr[j - 1];
    }
    arr[j] = tmp;
  }
}
```
Becuase of the nested loops, each of which can take N iterations, insertion sort is $O(N^2)$. Furthermore, this bound is tight, because input in reverse order can achieve this bound.

## Shellsort
Shellsort, named after its inventor, Donald Shell, was one of the first algorithms to break the quadratic time barrier, althoungh it was not until several years after its initial discovery that a subquadratic time bound was proven.
It works by comparing elements that are distant; the distance between comparisons decreases as the algorithm runs until the last phase, in which adjacent elements are compared. For this reason, Shellsort is sometimes referred to as diminishing increment sort.
Shellsort uses a sequence, h1, h2,…, ht, called increment sequence. Any increment sequence will do as long as h1 = 1, but some choices are better than others.

A popular(but poor) choice for increment sequence is to use the sequence suggested by Shell: $h_t = [N / 2]$ and $h_k = [h_{k + 1} / 2]$.
```C++
template <typename T>
void shellSort(std::vector<T> &arr) {
  for (std::size_t gap = arr.size() / 2; gap > 0; gap /= 2) {
    for (std::size_t i = gap, cnt = arr.size(); i < cnt; ++i) {
      auto tmp = arr[i];
      auto j = i;
      for (; j >= gap && tmp < arr[j - gap]; j -= gap) {
        arr[j] = arr[j - gap];
      }
      arr[j] = tmp;
    }
  }
}
```

The performance of Shellsort is quite acceptable in practice, even for N in the tens of thousands. The simplicity of the code makes it the algorithm of choice for sorting up to moderately large input.

## Heapsort
Priority queues can be used to sort in $O(NlogN)$ time. The algorithm based on this idea is known as heapsort and gives the best Big-Oh running time we have seen so far. The basic strategy is to build a binary heap of N elements. This stage takes $O(N)$ time. We then preform N deleteMin operations. The elements leave the heap smallest first, in sorted order. By recording these elements in a second array and then copying the array back, we sort N elements. Since each deleteMin takes $O(logN)$ time, the total running time is $O(NlogN)$.

The main problem with this algorithm is that it uses an extra array. Thus, the memory requirement is doubled. This could be a problem in some instances. Notice that the extra time spent copying the second array back to the first is only $O(N)$, so that this is not likely to affect the running time significantly. The problem is space.

A clever way to avoid using a second array makes use of the fact that after each deleteMin, the heap shrinks by 1. Thus the cell that was last in the heap can be used to store the element that was just deleted.

Using this strategy, after the last deleteMin the array will contain the elements in decreasing sorted order. If we want the elements in the more typical increasing sorted order, we can change the ordering property so that the parent has a larger elements than the child. Thus, we have a max-heap.

```C++
inline int getLeftChild(int hole) {
  return hole * 2 + 1;
}

template <typename T>
void percolateDown(std::vector<T> &arr, int hole, int heap_size) {
  T tmp = arr[hole];
  for (int child = getLeftChild(hole); child < heap_size; child = getLeftChild(hole)) {
    if (child != heap_size - 1 && arr[child + 1] > arr[child]) {
      ++child;
    }
    if (tmp < arr[child]) {
      arr[hole] = arr[child];
    } else {
      break;
    }
    hole = child;
  }
  arr[hole] = tmp;
}

template <typename T>
void heapSort(std::vector<T> &arr) {
  // build heap
  for (int cnt = arr.size(), i = cnt / 2; i >= 0; --i) {
    percolateDown(arr, i, cnt);
  }
  printArray(arr);
  // delete max
  for (int i = arr.size() - 1; i >= 0; --i) {
    swap(arr[0], arr[i]);
    percolateDown(arr, 0, i);
  }
}
```

## Mergesort
Mergesort runs in $O(NlogN)$ worse-case running time, and the number of comparisons used is nearly optimal. It is a fine example of a recursive algorithm.

The fundamental operation in this algorithm is merging two sorted lists. Because the lists are sorted, this can be done in one pass through the input, if the output is put in a third list. The basic merging algorithm takes two input array A and B, an output array C, and three counters, Actr, Bctr, and Cctr, which are initially set to the beginning of their respective arrays. The smaller of A[Actr] and B[Bctr] is copied to the next entry in C, and the appropriate counters are advanced. When either input list is exhausted, the remainder of the other list is copied to C.

```C++
template <typename T>
void merge(vector<T> &arr, vector<T> &temp_arr,
           int left_pos, int right_pos, int right_end) {
  int start = left_pos;
  int temp_pos = left_pos;
  int left_end = right_pos - 1;
  while (left_pos <= left_end && right_pos <= right_end) {
    if (arr[left_pos] < arr[right_pos]) {
      temp_arr[temp_pos++] = arr[left_pos++];
    } else {
      temp_arr[temp_pos++] = arr[right_pos++];
    }
  }

  while (left_pos <= left_end) {
    temp_arr[temp_pos++] = arr[left_pos++];
  }
  while (right_pos <= right_end) {
    temp_arr[temp_pos++] = arr[right_pos++];
  }

  for (int i = start; i <= right_end; ++i) {
    arr[i] = temp_arr[i];
  }
}

template <typename T>
void merge_sort(vector<T> &arr, vector<T> &temp_arr,
               int left, int right) {
  if (left >= right) return;
  int center = left + (right - left) / 2;
  merge_sort(arr, temp_arr, left, center);
  merge_sort(arr, temp_arr, center + 1, right);
  merge(arr, temp_arr, left, center + 1, right);
}

template <typename T>
void MergeSort(vector<T> &arr) {
  vector<T> temp_arr(arr);
  merge_sort(arr, temp_arr, 0, arr.size() - 1);
}
```

Mergesort is a classic example of the techniques used to analyze recursive routines: We have to write a recurrence relation for the running time. We will assume that N is a power of 2 so that we always split into even halves. For N = 1, the time to mergesort is constant, which we will denote by 1. Otherwise, the time to mergesort N numbers is equal to the time to do two recursive mergesort of size N/2, plus the time to merge, which is linear:

$$T(1) = 1$$

$$T(N) = 2T(N/2) + N$$

Although mergesort’s running time is $O(NlogN)$, it has the significant problem that merging two sorted lists uses linear extra memory. The additional work involved in copying to the temporary array and back, throughtout the algorithm, slows the sort considerably. This copying can be avoided by judiciously switching the roles of a and tmpArray at alternate levels of the recursion.
The running time of mergesort, when compared with other $O(NlogN)$ alternatives, depends heavily on the relative costs of comparing elements and moving elements in the array(and the temporary array). These costs are language dependent.

## Quicksort
As its name implies for C++, quicksort has historically been the fastest known generic sorting algorithm in practice. Its average running time is $O(NlogN)$. It is very fast, mainly due to a very tight and highly optimized inner loop. It has $O(N^2)$ worst-case performance, but this can be made exponentially unlikely with a little effort. By combining quicksort with heapsort, we can achieve quicksort’s fast running time on almost all inputs, with heapsort’s $O(NlogN)$ worst-case running time.
The quicksort algorithm is simple to understand and prove correct, although for many years it had the reputation of being an algorithm that could in theory be highly optimized but in practice was impossible to code correctly. Like mergesort, quicksort is a divide-and-conquer recursive algorithm.

The classic quicksort algorithm to sort an array S consists of the following four easy steps:

1. If the number of elements in S is 0 or 1, then return;
2. Pick any element v in S. This called the pivot;
3. Partition S-{v}(the remaining elements in S) into two disjoint groups: $S_1 = {x \in S - {v} | x \le v}$, and $S_x = {x \in S - {v} | x \ge v}$;
4. Return {quicksort($S_1$) followed by v followed by quicksort($S_2$)}.

For very small arrays($N \le 20$), quicksort does not perform as well as insertion sort. Furthermore, because quicksort is recursive, these cases will occur frequently. A comman solution is not to sue quicksort recursively for small arrays, but instead use a sorting algorithm that is efficient for small arrays, such as insertion sort. Using this strategy can actually save about 15 percent in the running time(over doing no cutoff at all). A good cutoff range is $N = 10$, although any cutoff between 5 and 20 is likely to produce similar results. This also saves nastly degenerate cases, such as taking the median of three elements when there are only one or two.

```C++
template <typename T>
int partition(vector<T>& arr, int left, int right) {
  T& pivot = arr[left];
  left++;
  while (left < right) {
    while (left < right && arr[left] <= pivot) ++left;
    while (left < right && arr[right] >= pivot) --right;
    if (left < right) {
      swap(arr[left], arr[right]);
      left++;
      right--;
    }
  }
  if (left == right && arr[right] > pivot) right--;
  swap(pivot, arr[right]);
  return right;
}

template <typename T>
void quick_sort(std::vector<T> &arr, int left, int right) {
  if (left >= right) return;
  int pi = partition(arr, left, right);
  quick_sort(arr, left, pi - 1);
  quick_sort(arr, pi + 1, right);
}

template <typename T>
void QuickSort(std::vector<T> &arr) {
  quick_sort(arr, 0, arr.size() - 1);
}
```
