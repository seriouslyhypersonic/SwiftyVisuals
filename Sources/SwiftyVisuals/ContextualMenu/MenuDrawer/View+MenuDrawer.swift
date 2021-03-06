//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 02/03/2021.
//

import SwiftUI

public extension View {
    /// Attaches a `ContextualMenu` to the view and presents it as a sliding drawer
    /// - Parameter contextualMenu: A container for views that present `ContextualMenu.MenuItems` menu items
    func menuDrawer(_ contextualMenu: ContextualMenu?) -> some View {
        MenuDrawer(contextualMenu: contextualMenu) { self }
    }
    
    /// Attaches a `ContextualMenu` to the view and presents it as a sliding drawer
    /// - Parameter builder: a closure that builds a `ContextualMenu` container for views that present
    /// `ContextualMenu.MenuItems` menu items
    func menuDrawer(@MenuBuilder builder: @escaping () -> ContextualMenu?) -> some View {
        MenuDrawer(contextualMenu: builder()) { self }
    }
    
    func menuDrawer(menuItems: [ContextualMenu.MenuItem]) -> some View {
        MenuDrawer(
            contextualMenu: menuItems.isEmpty
                ? nil
                : ContextualMenu(items: menuItems)
        ) { self }
    }
}
