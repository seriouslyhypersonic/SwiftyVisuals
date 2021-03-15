//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 09/03/2021.
//

import SwiftUI

public extension SegmentedPicker {
    func selector<Content: View>(_ content: Content) -> Self {
        modify(\.configuration.selector, value: content.eraseToAnyView())
    }
    
    func item(padding: Padding) -> Self {
        modify(\.configuration.padding, value: padding)
    }
    
    func itemPAdding(horizontal: CGFloat? = nil, vertical: CGFloat? = nil) -> Self {
        var chart = self
        if let horizontal = horizontal {
            chart.configuration.padding.leading = horizontal
            chart.configuration.padding.trailing = horizontal
        }
        if let vertical = vertical {
            chart.configuration.padding.top = vertical
            chart.configuration.padding.bottom = vertical
        }
        
        return chart
    }
}
