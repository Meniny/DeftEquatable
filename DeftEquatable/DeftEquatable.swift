//
//  DeftEquatable.swift
//  DeftEquatable
//
//  Created by Elias Abel on 4/06/2015.
//  Copyright (c) 2015 Meniny. All rights reserved.
//

import Foundation

// MARK: _InternalDeftEquatable

public protocol _InternalDeftEquatable {
    func _isEqual(to other: Any) -> Bool
}

extension _InternalDeftEquatable where Self: Equatable {
    public func _isEqual(to other: Any) -> Bool {
        guard let other = other as? Self else {
            return false
        }
        
        return self == other
    }
}

// MARK: - DeftEquatableGeneric

public protocol DeftEquatableGeneric: _InternalDeftEquatable {}

// MARK: - AutoEquatabeEnum

public protocol DeftEquatableEnum: Equatable, DeftEquatableGeneric {
    static func areAssociatedValuesEqual(_ lhs: Any, _ rhs: Any) -> Bool
}

extension DeftEquatableEnum {
    public static func areAssociatedValuesEqual(_ lhs: Any, _ rhs: Any) -> Bool {
        if let lhs = lhs as? _InternalDeftEquatable, let rhs = rhs as? _InternalDeftEquatable {
            return lhs._isEqual(to: rhs)
        }
        
        let lhsMirror = Mirror(reflecting: lhs)
        let rhsMirror = Mirror(reflecting: rhs)
        
        return areChildrenEqual(lhsMirror: lhsMirror, rhsMirror: rhsMirror)
    }
}

// MARK: - AutoEquatabeEnum

public protocol DeftEquatable: Equatable, DeftEquatableGeneric {}

extension DeftEquatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        let lhsMirror = Mirror(reflecting: lhs)
        
        if lhsMirror.displayStyle == .enum {
            fatalError("Enums are NOT allowed to conform to DeftEquatable. <\(Self.self)> should conform to DeftEquatableEnum instead.")
        }
        
        let rhsMirror = Mirror(reflecting: rhs)
        
        return areChildrenEqual(lhsMirror: lhsMirror, rhsMirror: rhsMirror)
    }
}

// MARK: OptionalType Protection

public protocol OptionalType {}
extension Optional: OptionalType {}

extension DeftEquatable where Self: OptionalType {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        fatalError("Optional should NOT conform to DeftEquatable.")
    }
}

// MARK: Collection Protection

extension DeftEquatable where Self: Collection {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        fatalError("Collections (aka \(typeNameWithOutGenerics(Self.self))) should NOT conform to DeftEquatable.")
    }
}

// MARK: - Private Helpers

private func areChildrenEqual(lhsMirror: Mirror, rhsMirror: Mirror) -> Bool {
    let lhsProperties = lhsMirror.children.map { $0.1 }
    let rhsProperties = rhsMirror.children.map { $0.1 }
    
    for (lhsProperty, rhsProperty) in zip(lhsProperties, rhsProperties) {
        if !isPropertyEqual(lhsProperty: lhsProperty, rhsProperty: rhsProperty) {
            return false
        }
    }
    
    return true
}

private func isPropertyEqual(lhsProperty: Any, rhsProperty: Any) -> Bool {
    if let lhsProperty = lhsProperty as? _InternalDeftEquatable, let rhsProperty = rhsProperty as? _InternalDeftEquatable {
        return lhsProperty._isEqual(to: rhsProperty)
    }
    
    return isNonInternalDeftEquatableEqual(lhs: lhsProperty, rhs: rhsProperty)
}

private func isNonInternalDeftEquatableEqual(lhs: Any, rhs: Any) -> Bool {
    
    // Function Check
    
    if isAFunction(value: lhs) && isAFunction(value: rhs) {
        return true
    }
    
    let lhsMirror = Mirror(reflecting: lhs)
    let rhsMirror = Mirror(reflecting: rhs)
    
    // Tuple Check
    
    if lhsMirror.displayStyle == .tuple && rhsMirror.displayStyle == .tuple {
        return areChildrenEqual(lhsMirror: lhsMirror, rhsMirror: rhsMirror)
    }
    
    // Collection Check
    
    if lhsMirror.displayStyle == .collection && rhsMirror.displayStyle == .collection {
        return areChildrenEqual(lhsMirror: lhsMirror, rhsMirror: rhsMirror)
    }
    
    // Dictionary Check
    
    if lhsMirror.displayStyle == .dictionary && rhsMirror.displayStyle == .dictionary {
        return areChildrenEqual(lhsMirror: lhsMirror, rhsMirror: rhsMirror)
    }
    
    // Optional Check
    
    if lhsMirror.displayStyle == .optional && rhsMirror.displayStyle == .optional {
        let lhsValue = lhsMirror.children.first?.value
        let rhsValue = rhsMirror.children.first?.value
        
        if let lhsValue = lhsValue, let rhsValue = rhsValue {
            return isPropertyEqual(lhsProperty: lhsValue, rhsProperty: rhsValue)
        }
        
        return lhsValue == nil && rhsValue == nil
    }
    
    fatalError("type \(type(of: lhs)) must conform to DeftEquatable")
}

private func isAFunction(value: Any) -> Bool {
    return String(describing: value) == "(Function)"
}

private func typeNameWithOutGenerics<T>(_: T.Type) -> String {
    let type = String(describing: T.self)
    
    if let typeWithoutGeneric = type.split(separator: "<").first {
        return String(typeWithoutGeneric)
    }
    
    return type
}

// MARK: Common Types Conforming to DeftEquatable

extension String: DeftEquatable {}
extension Int: DeftEquatable {}
extension Double: DeftEquatable {}
extension Float: DeftEquatable {}
extension Set: DeftEquatable {}
