//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 20/02/2021.
//

import SwiftUI

// A structure that contains values for horizontal and vertical padding
public struct Padding {
    var top: CGFloat
    var bottom: CGFloat
    var leading: CGFloat
    var trailing: CGFloat
    
    public init(leading: CGFloat = 0, trailing: CGFloat = 0, top: CGFloat = 0, bottom: CGFloat = 0) {
        self.leading = leading
        self.trailing = trailing
        self.top = top
        self.bottom = bottom
    }
    
    public init(horizontal: CGFloat, vertical: CGFloat) {
        self.init(leading: horizontal, trailing: horizontal, top: vertical, bottom: vertical)
    }
    
    public init(horizontal: CGFloat) {
        self.init(horizontal: horizontal, vertical: .zero)
    }
    
    public init(vertical: CGFloat) {
        self.init(horizontal: .zero, vertical: vertical)
    }
    
    public init(equal padding: CGFloat) {
        self.init(horizontal: padding, vertical: padding)
    }
}

public extension View {
    func padding(_ padding: Padding) -> some View {
        self.padding(.top, padding.top)
        .padding(.bottom, padding.bottom)
        .padding(.leading, padding.leading)
        .padding(.trailing, padding.trailing)
    }
}
