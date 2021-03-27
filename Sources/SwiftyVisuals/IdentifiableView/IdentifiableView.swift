//
//  SwiftUIView.swift
//  
//
//  Created by Nuno Alves de Sousa on 27/03/2021.
//

import SwiftUI

/// A type-erased identifiable view
public struct IdentifiableView: View, Identifiable {
    public let id: AnyHashable
    let content: AnyView
    
    public init<Content: View>(id: AnyHashable = UUID(), content: Content) {
        self.id = id
        self.content = content.eraseToAnyView()
    }
    
    public var body: some View {
        content
    }
}

public extension View {
    /// Erase the current view to an `IdentifiableView`
    func toIdentifiableView(id: AnyHashable = UUID()) -> IdentifiableView {
        IdentifiableView(id: id, content: self)
    }
}
