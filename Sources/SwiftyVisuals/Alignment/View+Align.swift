//
//  View+AlignmentGuide.swift
//  ListViewApp
//
//  Created by Nuno Alves de Sousa on 15/02/2021.
//

import SwiftUI

extension View {
    /// Align a child view inside its parent using the provided alignment guide
    /// - Parameter alignment: the alignment guide used to position the child inside its parent view
    /// - Returns: the child view embbeded in a `HStack` and/or `VStack` according to the alignment guide.
    /// - Note: The child view is positioned using the available space of the parent view
    @ViewBuilder func align(_ alignment: AlignmentGuide) -> some View {
        switch alignment {
        case .top:
            self.modifier(TopView())
        case .bottom:
            self.modifier(BottomView())
        case .leading:
            self.modifier(LeadingView())
        case .trailing:
            self.modifier(TrailingView())
        case .topLeading:
            self.modifier(TopView()).modifier(LeadingView())
        case .topTrailing:
            self.modifier(TopView()).modifier(TrailingView())
        case .bottomLeading:
            self.modifier(BottomView()).modifier(LeadingView())
        case .bottomTrailing:
            self.modifier(BottomView()).modifier(TrailingView())
        }
    }
}
