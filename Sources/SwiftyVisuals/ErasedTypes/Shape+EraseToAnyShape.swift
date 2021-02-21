//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 21/02/2021.
//

import SwiftUI

public extension Shape {
    /// Return a shape-erased version of the current shape
    func eraseToAnyShape() -> AnyShape {
        AnyShape(self)
    }
}
