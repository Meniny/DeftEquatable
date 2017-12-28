//
//  AppDelegate.swift
//  Sample
//
//  Created by 李二狗 on 2017/12/28.
//  Copyright © 2017年 Meniny. All rights reserved.
//

import UIKit
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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
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
        
        return true
    }
}









