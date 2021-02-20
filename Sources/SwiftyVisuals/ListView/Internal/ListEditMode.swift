//
//  ListEditMode.swift
//  ListViewApp
//
//  Created by Nuno Alves de Sousa on 28/01/2021.
//

import SwiftUI

class ListEditMode: ObservableObject {
    @Published private(set) var isActive: Bool
    @Published private(set) var modelID = UUID()
    @Published var contentOffset: CGFloat = 0
    
    func activate() { isActive = true }
    func dismiss() { isActive = false }
    func toggle() { isActive.toggle() }
    
    init(_ isEditing: Bool = false) {
        self.isActive = isEditing
    }
}
