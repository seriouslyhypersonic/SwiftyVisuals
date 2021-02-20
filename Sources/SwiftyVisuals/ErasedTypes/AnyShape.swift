//
//  AnyShape.swift
//  ListViewApp
//
//  Created by Nuno Alves de Sousa on 15/02/2021.
//

import SwiftUI

/// A type-erased shape
public struct AnyShape: Shape {
    let _path: (CGRect) -> Path
    
    init<S: Shape>(_ shape: S) {
        self._path = shape.path
    }
    
    public func path(in rect: CGRect) -> Path {
        _path(rect)
    }
}
