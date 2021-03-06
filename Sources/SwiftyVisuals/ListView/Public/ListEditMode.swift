//
//  ListEditMode.swift
//  ListViewApp
//
//  Created by Nuno Alves de Sousa on 28/01/2021.
//

import SwiftUI

/// The editing state of a `ListView`
public final class ListEditMode: ObservableObject {
    @Published public private(set) var isActive: Bool
    @Published private(set) var modelID = UUID()
    @Published var contentOffset: CGFloat = 0
    
    public func activate() { isActive = true }
    public func dismiss() { isActive = false }
    public func toggle() { isActive.toggle() }
    
    init(_ isEditing: Bool = false) {
        self.isActive = isEditing
    }
}
