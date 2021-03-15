//
//  SwiftUIView.swift
//  
//
//  Created by Nuno Alves de Sousa on 10/03/2021.
//

import Foundation

extension Comparable {
    /// Clamp a value to the limits of a closed range
    /// - Parameter limits: the range the value will be clamped to
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}
