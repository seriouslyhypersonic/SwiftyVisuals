//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 01/03/2021.
//

import Foundation

public protocol MenuItemConvertible {
    func asMenuItems() -> [ContextualMenu.MenuItem]
}

public extension ContextualMenu {
    struct MenuItem: MenuItemConvertible, Identifiable {
        var item: ItemType
        public let id: AnyHashable = UUID()
        
        public func asMenuItems() -> [MenuItem] {
            [self]
        }
    }
}

public extension ContextualMenu.MenuItem {
    enum ItemType {
        case button(MenuButton)
        case group(label: String?, items: [ContextualMenu.MenuItem])
    }
}
