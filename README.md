
<p align="center">
  <!-- <img src="" alt="DeftEquatable"> -->
  <br/><a href="https://cocoapods.org/pods/DeftEquatable">
  <img alt="Version" src="https://img.shields.io/badge/version-1.0.0-brightgreen.svg">
  <img alt="Author" src="https://img.shields.io/badge/author-Meniny-blue.svg">
  <img alt="Build Passing" src="https://img.shields.io/badge/build-passing-brightgreen.svg">
  <img alt="Swift" src="https://img.shields.io/badge/swift-4.0%2B-orange.svg">
  <br/>
  <img alt="Platforms" src="https://img.shields.io/badge/platform-macOS%20%7C%20iOS%20%7C%20watchOS%20%7C%20tvOS-lightgrey.svg">
  <img alt="MIT" src="https://img.shields.io/badge/license-MIT-blue.svg">
  <br/>
  <img alt="Cocoapods" src="https://img.shields.io/badge/cocoapods-compatible-brightgreen.svg">
  <img alt="Carthage" src="https://img.shields.io/badge/carthage-working%20on-red.svg">
  <img alt="SPM" src="https://img.shields.io/badge/swift%20package%20manager-working%20on-red.svg">
  </a>
</p>

# Introduction

## What's this?

With `DeftEquatable`, you **NEVER** implement `Equatable` manually again.

## Installation

#### CocoaPods

```ruby
pod 'DeftEquatable'
```

## Contribution

You are welcome to fork and submit pull requests.

## License

`DeftEquatable` is open-sourced software, licensed under the `MIT` license.

## Usage

```swift
import DeftEquatable

class MyClass: DeftEquatable {
    let myString: String
    let myInt: Int

    init(myString: String, myInt: Int) {
        self.myString = myString
        self.myInt = myInt
    }
}

class MyClassWithAnotherClass: DeftEquatable {
    let myClass: MyClass

    init(myClass: MyClass) {
        self.myClass = myClass
    }
}

enum GenericEnum: DeftEquatableEnum {
    case one
    case two
}

class MyClassWithGenericEnum: DeftEquatable {
    let myEnum: GenericEnum

    init(myEnum: GenericEnum) {
        self.myEnum = myEnum
    }
}

class MyClassWithArray<T>: DeftEquatable {
    let myArray: [T]

    init(myArray: [T]) {
        self.myArray = myArray
    }
}
```

```swift
let one = MyClass.init(myString: "somethings", myInt: 1)
let two = MyClass.init(myString: "somethings", myInt: 2)

let three = MyClassWithAnotherClass.init(myClass: two)
let four = MyClassWithAnotherClass.init(myClass: two)

let five = MyClassWithGenericEnum.init(myEnum: .one)
let six = MyClassWithGenericEnum.init(myEnum: .two)

let seven = MyClassWithArray<Int>.init(myArray: [1,2,3])
let eight = MyClassWithArray<Int>.init(myArray: [1,2,3])

print(one == two) // false
print(three == four) // true
print(five == six) // false
print(seven == eight) // true
```
