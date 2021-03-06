//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 05/03/2021.
//

import SwiftUI

/// A type-erased animatable mask
public struct AnyAnimatableMask: AnimatableMask {
    let _makeBody: (Bool) -> AnyView
    
    init<T: AnimatableMask>(_ mask: T) {
        self._makeBody = { mask.makeBody(isPresented: $0).eraseToAnyView() }
    }
    
    public func makeBody(isPresented: Bool) -> AnyView {
        _makeBody(isPresented)
    }
}
