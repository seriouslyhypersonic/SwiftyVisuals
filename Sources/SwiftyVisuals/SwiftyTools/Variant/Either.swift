//
//  File.swift
//  ListViewApp
//
//  Created by Nuno Alves de Sousa on 20/02/2021.
//

import Foundation

/// A variant type that at any given time stores only one non-nil value of two possible types
struct Either<First, Second> {
    private(set) var first: First?
    private(set) var second: Second?
    
    private init(first: First?, second: Second?) {
        self.first = first
        self.second = second
    }
    
    init(_ first: First) { self.init(first: first, second: nil) }
    init(_ second: Second) { self.init(first: nil, second: second) }
    
    /// Assigns a value of the `First` type and sets the value of the `Second` type to `nil`
    /// - Parameter first: the value of the `First` type
    mutating func set(_ first: First) {
        self.first = first
        second = nil
    }
    
    /// Assigns a value of the `Second` type and sets the value of the `First` type to `nil`
    /// - Parameter first: the value of the `First` type
    mutating func set(_ second: Second) {
        first = nil
        self.second = second
    }
    
    
    /// Gets the current value associated with the `First` or `Second` types of the variant
    /// - Parameter value: the request type
    /// - Returns: value of the requested type or `nil` if a value of another type is currently stored instead
    func get<Value>(_ value: Value.Type) -> Value? {
        switch value {
        case is First.Type: return first as? Value
        case is Second.Type: return second as? Value
        default:
            fatalError(
                """
                get value of \(Self.self) must be either '\(First.self)' or '\(Second.self)' but \
                '\(Value.self)' was used instead.
                """
            )
        }
    }
}
