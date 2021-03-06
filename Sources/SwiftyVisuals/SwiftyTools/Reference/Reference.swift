//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 25/02/2021.
//

import Foundation

/// A protocol that describes a reference type to a certain value
public protocol Reference: class {
    associatedtype Value
    var value: Value { get }
}
