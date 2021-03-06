//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 05/03/2021.
//

import SwiftUI

/// A View that can be used to progressively mask other views
public protocol AnimatableMask {
    associatedtype MaskView: View
    
    func makeBody(isPresented: Bool) -> MaskView
    
    func combined(with mask: AnyAnimatableMask) -> AnyAnimatableMask
}

public extension AnimatableMask {
    /// Combines this `AnimatableMask` with another, returning another, returning a new `AnimatableMask` that is the result of
    ///  both masks being applied.
    /// - Parameter other: the `AnimatableMask` mask the current mask will be combined with
    func combined(with other: AnyAnimatableMask) -> AnyAnimatableMask {
        AnyAnimatableMask(CombinedAnimatableMask(first: self, second: other))
    }
}
