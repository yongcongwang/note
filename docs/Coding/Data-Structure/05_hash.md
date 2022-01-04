# Hash Table

A `hash table` is a data structure that implements an associative array abstract data type, a structure that can map `keys` to `values`.

![hash](images/hash.png)

A `hash table` use a `hash function` to compute an index of `buckets` with `keys` to store desired `values`.

Ideally, the hash function will assign each key to a unique bucket, but most hash table designs employ an imperfect hash function, which might cause `hash collisions` where the hash function generate the same index for more than one key. The resolution of collision may contain:

- `seperate chaining`, if collision occers, we store both elements in the same bucket;

![chain](images/hash_chain.png)

- `linear probing`, when collision occers, we look for a new empty bucket to store the element.

## Problems

### Implementation

### Duplication Detection(Hash Set)

### Associating Keys with more Information(Hash Map)

### Grouping Elements with Keys(Hash Map)

### Desining Key to Use Hash
