//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 01/03/2021.
//

import Foundation

public struct MenuGroup: MenuItemConvertible {
    var label: String?
    var items: [ContextualMenu.MenuItem]
    
    init(label: String? = nil, items: [ContextualMenu.MenuItem]) {
        self.label = label
        self.items = items
    }
    
    public init(label: String? = nil, @ContextualMenu.MenuItemsBuilder builder: () -> [ContextualMenu.MenuItem]) {
        self.label = label
        self.items = builder()
    }
    
    public func asMenuItems() -> [ContextualMenu.MenuItem] {
        [.init(item: ContextualMenu.MenuItem.ItemType.group(label: label, items: items))]
    }
}
