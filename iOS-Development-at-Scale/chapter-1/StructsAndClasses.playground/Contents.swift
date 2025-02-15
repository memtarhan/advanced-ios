import Foundation

// MARK: - Value and Reference Types

enum DogBreed {
    case other
    case germanShepard
    case bizon
    case husky
}

class Dog {
    // parameters - part of the state.
    // the dog's name
    var name: String
    // the dog's breed, which could control barking volume
    var breed: DogBreed
    // when the dog was last fed, updates when the dog is fed
    var lastFed: Date?
    // initializer
    init(name: String,
         breed: DogBreed,
         lastFed: Date?) {
        self.name = name
        self.breed = breed
        self.lastFed = lastFed
    }

    // method - part of the behavior
    // setting the time fed to time now
    func feed() {
        lastFed = Date()
    }

    // method - part of the behavior
    func bark() {
        switch breed {
        case .germanShepard:
            print("barking loud")
        default:
            print("barking moderate")
        }
    }
}

let dog = Dog(name: "Steve",
              breed: .germanShepard,
              lastFed: nil)
dog.bark()

// Similarly, we could model this behavior with a struct:
struct DogStruct {
    var name: String
    var breed: DogBreed
    var lastFed: Date?
    init(name: String,
         breed: DogBreed,
         lastFed: Date?) {
        self.name = name
        self.breed = breed
        self.lastFed = lastFed
    }

    // method - part of the behavior
    // setting the time fed to time now
    mutating func feed() {
        lastFed = Date()
    }

    // method - part of the behavior
    func bark() {
        switch breed {
        case .germanShepard:
            print("barking loud")
        default:
            print("barking moderate")
        }
    }
}

/*
 Classes are reference types, while
 structs are value types. For value types, such as structs, each instance
 keeps a unique copy of its own data. Other value types include enums,
 arrays, strings, dictionaries, and tuples. In contrast to value types,
 reference types share a single copy of the data and reference that copy via
 a pointer. The only reference type in Swift is the class; however, everything
 inheriting from NSObject is a reference type

 */

var dogClass = Dog(name: "Esperanza",
                   breed: .bizon,
                   lastFed: nil)
var refDog = dogClass
refDog.name = "hope"
// False - we have a reference type
print(dogClass.name != refDog.name ?
    "True - we have a value type" :
    "False - we have a reference type")
var dogStruct = DogStruct(name: "Esperanza",
                          breed: .bizon,
                          lastFed: nil)
var valDog = dogStruct
valDog.name = "hope"
// True - we have a value type
print(dogStruct.name != valDog.name ?
    "True - we have a value type" :
    "False - we have a reference type")

/*
 When utilizing a class, it was possible to change the dog’s name for the
 initial variable; however, with the struct, it was not. In practice, this extra
 layer of protection protects against unintended mutations. The protection
 from unintentional modification is especially helpful in ensuring thread
 safety. Even so, value types are not entirely safe because it is possible to
 add a reference type inside a value type. When a reference type is added
 inside a value type such as adding a class instance to an array (a value
 type), the class (reference type) is modifiable. The following example
 explores how this could happen:
 */

var dog1 = Dog(name: "Esperanza",
               breed: .bizon,
               lastFed: nil)

var dog2 = Dog(name: "Bella",
               breed: .germanShepard,
               lastFed: nil)
let arr = [dog1, dog2]
var dTemp = arr[0]
// Esparanzabadvalue!
arr[0].name.append("badvalue!")
print(dTemp.name)

let dog4 = Dog(name: "Esperanza",
               breed: .bizon,
               lastFed: nil)
dog4.name = "test"
let dog5 = dog4
dog4.name = "Max"
print("Dog4: \(dog4.name) Dog5: \(dog5.name)")
// dog4 = dog5 - error cannot assign to a let constant

// Summarizing Value and Reference Types

/*
 1. If dealing with a simple struct, value semantics are
 guaranteed by default.

 2. If dealing with a struct containing composite
 properties (composite value type), it is necessary to
 ensure they also exhibit value semantics.

 3. If dealing with a class (reference type), it will have
 reference semantics by default. However, making
 the class immutable using the let keyword and
 constant properties will cause the class to exhibit
 value semantics. Again, the properties of the class
 and those properties themselves must have value
 semantic types
 */

// MARK: - Inheritance for Classes

class Animal {
    // even wild animals have names (you just don't know them)
    var name: String
    var breed: DogBreed
    // changing to lastEaten since wild animals don't get fed
    var lastEaten: Date?
    init(name: String,
         breed: DogBreed,
         lastEaten: Date?) {
        self.name = name
        self.breed = breed
        self.lastEaten = lastEaten
    }

    func eat() {
        lastEaten = Date()
    }

    // lions roar, cats, purr, dogs bark so subclasses will define this
    func makeNoise() {
        fatalError("requires implementation in subclass")
    }
}

// Now we can define a Dog as a subclass of an animal
class DogSubClass: Animal {
    override func makeNoise() {
        if breed == .germanShepard {
            print("barking loud")
        } else {
            print("barking moderate")
        }
    }
}

/*
 A Brief Note on Static and Dynamic Polymorphism
 Static polymorphism occurs at compile time and allows for functions
 to have the same name and different implementations. The decision of
 exactly what method implementation to utilize is determined via static
 dispatch.
 Dynamic polymorphism occurs at runtime and allows for functions
 to have the same name and different implementations. The decision of
 exactly what method implementation to run is determined by inspecting
 the actual object in memory at runtime.
 
 */

/*
 Inheritance vs. Polymorphism
 •
 Inheritance allows developers to reuse existing code in
 a program.
 •
 Polymorphism allows developers to dynamically
 decide what form of a function to invoke.
 Inheritance is a mechanism we can use to achieve polymorphism in
 our code via the use of a class hierarchy.
 */

// MARK: - Wrap-up

/*
 Classes and Protocols
 ---------------------------------------------------
 • Define properties to store values.
 • Define methods to provide functionality.
 • Define subscripts to give access to their values using
 subscript syntax.
 • Define initializers to set up their initial state.
 • Extend expanding their functionality beyond a default
 implementation.
 • Provide standard functionality.

 Classes Have Capabilities That Structs Do Not Have
 ---------------------------------------------------
 • Inheritance: This enables one class to inherit the
 characteristics of another.
 • Typecasting: This allows a program to interpret the type
 of a class instance at runtime.
 • einitializers: These enable an instance of a class to
 free up any resources it has assigned.
 • Reference counting: This allows more than one
 reference to a class instance.
 */
