//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 23/02/2021.
//

import Foundation

public extension Numeric where Self: Comparable {
    /// Check if a numeric value is in the closed interval [min, max]
    /// - Parameters:
    ///   - min: the minimum value of the interval
    ///   - max: the maximum value of the interval
    func isBetween(min: Self, max: Self) -> Bool {
        return self >= min && self <= max
    }
}
