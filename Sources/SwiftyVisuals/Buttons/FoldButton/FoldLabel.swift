//
//  SwiftUIView.swift
//  
//
//  Created by Nuno Alves de Sousa on 26/02/2021.
//

import SwiftUI

/// A label that can be used by a `FoldButton`
public protocol FoldLabel {
    associatedtype ButtonLabel: View
    
    func makeLabel(isFolded: Bool) -> ButtonLabel
}
