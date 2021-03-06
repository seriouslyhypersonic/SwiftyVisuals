//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 06/03/2021.
//

import SwiftUI

/// An `AnimatableMask`  that combines two `AnimatableMask` by masking the first with the second
struct CombinedAnimatableMask: AnimatableMask {
    let first: AnyAnimatableMask
    let second: AnyAnimatableMask
    
    init<First: AnimatableMask, Second: AnimatableMask>(first: First, second: Second) {
        self.first = AnyAnimatableMask(first)
        self.second = AnyAnimatableMask(second)
    }
    
    func makeBody(isPresented: Bool) -> some View {
        first.makeBody(isPresented: isPresented)
            .mask(second.makeBody(isPresented: isPresented))
    }
}
