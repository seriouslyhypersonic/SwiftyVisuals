//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 06/03/2021.
//

import SwiftUI

public extension AnyAnimatableMask {
    /// A rectangular mask that expands from one of its edges
    static func rectangle(from edge: Edge) -> Self {
        AnyAnimatableMask(RectagularMask(edge: edge))
    }
    
    /// An opacity mask that transitions from transparent to opaque on insertion, and from opaque to transparent on removal.
    static var opacity: Self {
        return AnyAnimatableMask(OpacityMask())
    }
}
