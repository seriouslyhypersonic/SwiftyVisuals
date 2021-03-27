//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 25/02/2021.
//

import SwiftUI

public extension View {
    /// Add a custom banner that is revealed from an edge of the screen
    /// - Parameters:
    ///   - isPresented: a binding to weather the banner should be shown
    ///   - edge: the eadge of the screen where the banner is revealed from
    ///   - content: a clorsure returning the banner content
    func banner<Content: View>(
        isPresented: Binding<Bool> = .constant(true),
        edge: Edge = .top,
        _ content: @escaping () -> Content ) -> some View
    {
        self.modifier(Banner(isPresented: isPresented, edge: edge, content: content))
    }
}
