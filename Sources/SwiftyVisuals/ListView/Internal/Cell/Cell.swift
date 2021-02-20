//
//  ListItem.swift
//  ListViewApp
//
//  Created by Nuno Alves de Sousa on 19/01/2021.
//

import SwiftUI

/// A conteiner for views presented in a ´ListView´
struct Cell: View, Hashable, Identifiable, Equatable {
    let view: AnyView
    let menuItems: AnyView?
    let id: AnyHashable
    
    var body: some View {
        view
    }
    
    init<T: View>(id: AnyHashable = AnyHashable(UUID()), @ViewBuilder _ view: @escaping () -> T) {
        self.view = view().eraseToAnyView()
        self.menuItems = nil
        self.id = id
    }
    
    init<T: View & ContextMenuProvider>(
        id: AnyHashable = AnyHashable(UUID()),
        @ViewBuilder _ viewWithContextMenu: @escaping () -> T )
    {
        self.view = viewWithContextMenu().eraseToAnyView()
        self.menuItems = viewWithContextMenu().menuItems.eraseToAnyView()
        self.id = id
    }
    
    static func == (lhs: Cell, rhs: Cell) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
