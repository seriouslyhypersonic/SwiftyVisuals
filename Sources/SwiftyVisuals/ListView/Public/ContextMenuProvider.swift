//
//  ContextMenuProvider.swift
//  
//
//  Created by Nuno Alves de Sousa on 20/02/2021.
//

import SwiftUI

/// Conforming views will be able to provide context menus that can be displayed in a `ListView`
public protocol ContextMenuProvider {
    associatedtype MenuItemsView: View
    var menuItems: MenuItemsView { get }
}
