# Class diagram

In software engineering, a diagram in the UML(Unified Modeling Language) is a type of static structure diagram that describes the structure of a system by showing the system's classes, their attributes, operations(or methods), and the relationship among objects.

![diagram](images/diagram.png)

# Visibility
To specify the visibility of a class member(i.e. attribute or method), these notations must be placed before the member's name:
- `+`: Public
- `-`: Private
- `#`: Protected
- `~`: Package

# Relationships
A relationship is a general term covering the specific types of logical connections found on class and object diagrams.

![diagram_relationship](images/diagram_relationship.png)


## Instance-level Relationships

### Dependency
`Dependency` is the relationship of `... uses a ...` that indicates that one class depends on another because it uses it at some point in time. One class depends on another if the independent class is a
- parameter
- local variable

of a method of the dependent class.

### Association
`Association` is the relationship of `... has a ...` which represents a family of links. An association can link any number of classes. It represents the static relationship shared among the objects of two classes.
There are four types of association:
- Bi-directional, which has two ends;
- Uni-directional, which has one end;
- Aggregation;
- Composition.

### Aggregation
`Aggregation` is the relationship of `... owns a ...` which is more specific than association. It is an association that represents a part-whole or part-of relationship. Furthermore, there is hardly a difference between aggregations and associations during implementation, and the diagram may skip aggregation relations altogether.

### Composition
`Composition` is the relationship of `... part of ...`. The main difference between aggregation and composition is:  
- composition: when the container is destroyed, the contents are also destroyed.
- aggregation: when the container is destroyed, the contents are usually not destroyed.

## Class-level Relationships

### Realization/Implementation
A `realization` relationship is between two model elements, in which one model element(the client) realizes (implements or executes) the behavior that the other model element(the supplier) specifies.

### Generalization/Inheritance
A `Generalization` relationship indicates that one of the two related classes(the subclass) is considered to be a specialized form of the other(the super type) and the superclass is considered a `generalization` of the subclass.
