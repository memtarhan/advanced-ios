import Foundation

// MARK: - Generic Functions

func swap<T>(_ a: inout T, _ b: inout T) {
    let temp = a
    a = b
    b = temp
}

// call the function as normal
var x = 0
var y = 5
swap(&x, &y)

print(x)
print(y)

func printFun<T, U, V>(_ a: T, _ b: U, _ c: V) {
    print("\(a), \(b), \(c)")
}

printFun("Hey", 27, [1, 2, 3, 4])

/*

 Notes on Placeholder Types
 ---------------------------

 1. Any character is eligible for use as a placeholder
 type; however, T is commonly used (other
 traditionally used placeholder types are U and V).

 2. It is essential to use upper camel case when
 signifying a placeholder type to represent that they
 are not values.

 3. It is legal to specify multiple type parameters with
 the syntax: <T, U>.
 
 */

// MARK: - Generic Types

/*
 In addition to generic functions, Swift allows for creating generic types.
 These classes, enums, and structs are customized to work with any type.
 An excellent example of generics in action is the Swift collection types
 (array, dictionary). Creating generic types is quite similar to creating a
 generic function, except that the placeholder type is defined on the type
 itself. As an example, let’s look at creating a generic Queue in Swift:
 */
// The placeholder type is defined on the struct.
struct Queue<T> {
    var items: [T] = []
    mutating func push(_ item: T) {
        // TODO:
    }

    mutating func pop() -> T? {
        // TODO:
        nil
    }
}

// The concrete definition of the placeholder type is required when instantiating the struct .
var q = Queue<Int>()

/*
 Generics are also utilized in protocols to create richer type
 experiences. To express generic types in protocols, Swift utilizes
 typealiases and associatedtypes. An associated type is used in the protocol,
 while the typealias specifies the type used in the protocol’s concrete
 implementation. In other languages, typealiases are primarily syntactic
 sugar to wrap a long, more complex type in an easier-to-understand way;
 however, in Swift, typealiases also serve as a semantic requirement on
 types adopting a protocol with an associated type.
 */

// protocol Animal { }
// struct Dog: Animal { }
// now we could have
// let myDog: Animal = Dog()
// and
// let arr = [myDog]
// now say we add an associated type to define the type of food that the animal is eating.
// grass versus meat.
protocol Animal {
    // declare a requirement
    associatedtype Food
    func eat(food: Food) -> Void
}

struct Grass {}
struct Meat {}
struct Dog: Animal {
    // meet the requirement
    typealias Food = Meat
    func eat(food: Food) {
        print("Eating the food: ")
    }
}

struct Antelope: Animal {
    // meet the requirement
    typealias Food = Grass
    func eat(food: Food) {
        print("Eating the food: ")
    }
}

struct AnyAnimal<T>: Animal {
    private let _eat: (T) -> Void
    init<U: Animal>(_ animal: U) where U.Food == T {
        _eat = animal.eat
    }

    func eat(food: T) {
        _eat(food)
    }
}
