An `abstract data type`(ADT) is a set of objects together with a set of operations. Objects such as lists, sets, and graphs along with their operations can be viewed as ADTs, just as integers, reals, and boolens are data types.

There is no rule telling us which operations must be supported for each ADT; this is a design decision. In this article we only discuss about three ADT:
- List;
- Stack;
- Queue.

# The List ADT
We will deal with a general list of the form $A_0, A_1, A_2, \cdots, A_{N-1}$. We say that:
- the size of this list is $N$;
- $A_i$ follows(or succecds) A_{i-1}($i < N$) and $A_{i-1}$ precedes $A_{i}$($i > 0$);
- the first element of the List is $A_0$;
- the last element of the List is $A_{N-1}$;
- the position of $A_i$ is $i$;

Associate with these `definations` is a set of operations that we would like to perform on the List ADT:
- printList: print each element of the List;
- makeEmpty: clear the List;
- find: return the position of the first occurrence of an iterm;
- insert: insert some element from some position in the List;
- remove: remove some element from some position in the List;
- findKth: return the element in kth position.

There are generally two ways to implement the List ADT:
- array;
- linked list.

## Array(Vector) implementation of List
All these instructions can be implemented just using an array. Although arrays are created with a fixed capacity, the `vector` class, which internally stores an array, allows the array to grow by doubling its capacity when needed.
The time complexity of array is:
- insertion and deletion: $O(N)$;
- search and access: $O(1)$.

```C++
template <typename Object>
class Vector {
 public:
  explicit Vector(int size = 0)
      : size_(0), capacity_(size_ + 10), objects_(new Object[capacity_]) {}

  Vector(const Vector& rhs)
      : size_(rhs.size_), capacity_(rhs.capacity_),
        objects_(new Object[capacity_]) {
    for (std::size_t i = 0; i < size_; ++i) {
      objects_[i] = rhs.objects_[i];
    }
  }

  Vector& operator=(const Vector& rhs) {
    Vector copied(rhs);
    std::swap(*this, copied);
    return *this;
  }

  ~Vector() { 
    delete[] objects_;
  }

  Vector(Vector&& rhs)
      : size_(rhs.size_), capacity_(rhs.capacity_), objects_(rhs.objects_) {
    rhs.size_ = 0;
    rhs.capacity_ = 0;
    rhs.objects_ = nullptr;
  }

  Vector& operator=(Vector&& rhs) {
    std::swap(size_, rhs.size_);
    std::swap(capacity_, rhs.capacity_);
    std::swap(objects_, rhs.objects_);
    return *this;
  }

 public:
  void resize(int new_size) {
    if (new_size > capacity_) {
      reserve(new_size * 2);
    }

    size_ = new_size;
  }

  void reserve(int new_capacity) {
    if (new_capacity < size_) {
      return;
    }

    Object *new_array = new Object[new_capacity];
    for (int i = 0; i < size_; ++i) {
      new_array[i] = objects_[i];
    }

    capacity_ = new_capacity;
    std::swap(objects_, new_array);
    delete[] new_array;
  }

  Object& operator[](int index) {
    if (index < 0 || size_ == 0 || index >= size_) {
      throw std::out_of_range("invalid index!");
    }
    return objects_[index];
  }

  const Object& operator[](int index) const {
    if (index < 0 || size_ == 0 || index >= size_) {
      throw std::out_of_range("invalid index!");
    }
    return objects_[index];
  }

  bool empty() const {
    return size_ == 0;
  }

  int size() const {
    return size_;
  }

  int capacity() const {
    return capacity_;
  }

  void push_back(const Object& x) {
    if (size_ == capacity_) {
      reserve(2 * capacity_ + 1);
    }

    objects_[size_] = x;
    ++size_;
  }

  void push_back(const Object&& x) {
    if (size_ == capacity_) {
      reserve(2 * capacity_ + 1);
    }

    objects_[size_] = std::move(x);
    ++size_;
  }

  void pop_back() {
    --size_;
  }

  const Object& back() const {
    if (size_ == 0) {
      throw std::out_of_range("invalid index!");
    }
    return objects_[size_ - 1];
  }

  const Object& front() const {
    if (size_ == 0) {
      throw std::out_of_range("invalid index!");
    }
    return objects_[0];
  }

 public:
  typedef Object* iterator;
  typedef const Object* const_iterator;

  iterator begin() {
    return &objects_[0];
  }

  const_iterator begin() const {
    return &objects_[0];
  }

  iterator end() {
    return &objects_[size_];
  }
  const_iterator end() const {
    return &objects_[size_];
  }

 private:
  int size_;
  int capacity_;
  Object* objects_;
};
```

## Linked list implementation of List
In order to avoid the linear cost of insertion and deletion, we need to ensure that the list is not stored contiguously, since otherwise entire parts of the list will need to be moved.
The linked list consists of a series of nodes, which are not necessarily adjacent in memory. Each node contains the element and a link to a node containing its successor. We call this the `next` link.
The time complexity of linked list operation is:
- insertion and deletion: $O(1)$;
- search and access: $O(N)$.

```C++
template <typename Object>
class List {
 private:
  struct Node {
    Node(const Object& val = Object{}, Node* p = nullptr, Node* n = nullptr)
        : val(val), next(n), prev(p) {}

    Object val;
    Node* next;
    Node* prev;
  };

 public:
  class const_iterator {
   public:
    const_iterator() : current{} {}

    const Object& operator*() const {
      return retrieve();
    }
    const_iterator& operator++() {
      current = current->next;
      return *this;
    }

    const_iterator operator++(int) {
      const_iterator old = *this;
      ++(*this);
      return old;
    }

    bool operator==(const const_iterator& rhs) const {
      return current == rhs.current;
    }

    bool operator!=(const const_iterator& rhs) const {
      return !(*this == rhs);
    }

   public:
    const_iterator begin() const {
      const_iterator itr{*this, head_};
      return ++itr;
    }

   protected:
    const List<Object> *the_list;
    Node* current;

    Object& retrieve() const {
      return current->val;
    }

    const_iterator(Node* p) : current(p) {}
    const_iterator(const List<Object>& lst, Node* p)
        : the_list{&lst}, current{p} {}

    void assert_is_valid() const {
      if (the_list == nullptr || current == nullptr ||
          current == the_list->head_) {
        throw std::bad_exception();
      }
    }

    friend class List<Object>;
  };

  class iterator : public const_iterator {
   public:
    iterator() = default;

    Object& operator*() {
      return const_iterator::retrieve();
    }

    const Object& operator*() const {
      return const_iterator::operator*();
    }

    iterator &operator++() {
      this->current = this->current->next;
      return *this;
    }

    iterator operator++(int) {
      iterator old = *this;
      ++(*this);
      return old;
    }

    iterator insert(iterator itr, const Object& x) {
      itr.assert_is_valid();
      if (itr.the_list != this) {
        throw std::bad_exception();
      }

      Node* p = itr.current;
      ++size_;
      return { *this, p->prev = p->prev->next = new Node{x, p->prev, p} };
    }

   protected:
    iterator(Node* p) : const_iterator(p) {}

    friend class List<Object>;
  };

 public:
  List() {
    init();
  }
  ~List() {
    clear();
    delete head_;
    delete tail_;
  }

  List(const List& rhs) {
    init();
    for (auto& x : rhs) {
      push_back(x);
    }
  }
  
  List& operator=(const List& rhs) {
    List copy = rhs;
    std::swap(*this, copy);
    return *this;
  }

  List(List&& rhs)
      : size_{rhs.size_}, head_(rhs.head_), tail_(rhs.tail_) {
    rhs.size_ = 0;
    rhs.head_ = nullptr;
    rhs.tail_ = nullptr;
  }

  List& operator=(List&& rhs) {
    std::swap(size_, rhs.size_);
    std::swap(head_, rhs.head_);
    std::swap(tail_, rhs.tail_);
    return *this;
  }

  void init() {
    size_ = 0;
    head_ = new Node;
    tail_ = new Node;
    head_->next = tail_;
    tail_->prev = head_;
  }

 public:
  iterator begin() {
    return {head_->next};
  }
  iterator end() {
    return {tail_};
  }
  const_iterator begin() const {
    return {head_->next};
  }
  const_iterator end() const {
    return {tail_};
  }

  int size() const {
    return size_;
  }

  bool empty() const {
    return size() == 0;
  }

  void clear() {
    while (!empty()) {
      pop_front();
    }
  }

  Object& front() {
    return *begin();
  }
  const Object& front() const {
    return *begin();
  }
  Object& back() {
    return *(--end());
  }
  const Object& back() const {
    return *(--end());
  }

  void push_front(const Object& x) {
    insert(begin(), x);
  }
  void push_front(const Object&& x) {
    insert(begin(), std::move(x));
  }
  void push_back(const Object& x) {
    insert(end(), x);
  }
  void push_back(const Object&& x) {
    insert(end(), std::move(x));
  }

  void pop_front() {
    erase(begin());
  }
  void pop_back() {
    erase(--end());
  }

  iterator insert(iterator itr, const Object& x) {
    Node* p = itr.current;
    ++size_;
    return { p->prev = p->prev->next = new Node{x, p->prev, p} };
  }

  iterator insert(iterator itr, const Object&& x) {
    Node* p = itr.current;
    ++size_;
    return { p->prev = p->prev->next = new Node{std::move(x), p->prev, p} };
  }

  iterator erase(iterator itr) {
    Node* p = itr.current;
    iterator res{ p->next };
    p->prev->next = p->next;
    p->next->prev = p->prev;
    delete p;
    --size_;

    return res;
  }

  iterator erase(iterator from, iterator to) {
    for (iterator itr = from; itr != to; ++itr) {
      itr = erase(itr);
    }

    return to;
  }

 private:
  int size_;
  Node* head_;
  Node* tail_;
};
```

# The Stack ADT
A `stack` is a list with the restriction that insertions and deletions can be performed in only one position, namely, the end of the list, called the `top`.
The foundamental operations on a stack are:
- push, which is equivalent to an insert;
- pop, which deletes the most recently inserted element.

Since a stack is a list, any list implementation will do. Clearly `array` and `linked list`  are okay.

All the operations the Stack needed are supported by `Vector` and `List`, so I do not show the implementation here.

# The Queue ADT
Like stack, `queues` are lists. With a queue, however, insertion is done at one end whereas deletion is performed at the other end.

The basic operations on a queue are:
- enqueue, which inserts an element at the end of the list(called the rear);
- dequeue, which deletes(and returns) the element at the start of the list(known as the front).

As with stacks, any list implementation is legal for queues. The linked list implementation is easy, we will now discuss an array implementation of queues.

For each queue data structure, we keep an `array` as:
```C++
|   |   |   | 5 | 2 | 7 | 1 |   |   |
              ^           ^
              |           |
            front        end
```

and the position `front` and `end`, which represent the ends of the queue.
We alse keep track of the number of elements that are actually in the queue, `currentSize`.
- To `enqueue` an element `x`, we increment the `currentSize` and `back`, then set `array[back] = x`;
- To `dequeue` an element `x`, we return the value `array[front]`, decrement the `currentSize` and then increment `front`.
