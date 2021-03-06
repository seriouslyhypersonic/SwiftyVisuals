//
//  Numeric+ToString.swift
//  MeteoApp
//
//  Created by Nuno Alves de Sousa on 22/02/2021.
//

import Foundation

public extension Numeric where Self: BinaryInteger {
    /// Convert a numeric type type to string with a specified precision
    /// - Parameter places: the numeric type
    func toString(_ places: Int = 0) -> String {
        String(format: "%.\(places)f", Double(self))
    }
}

public extension Numeric where Self: BinaryFloatingPoint {
    /// Convert a numeric type type to string with a specified precision
    /// - Parameter places: the numeric type
    func toString(_ places: Int = 0) -> String {
        String(format: "%.\(places)f", Double(self))
    }
}
