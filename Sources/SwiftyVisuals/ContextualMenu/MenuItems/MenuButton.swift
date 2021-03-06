//
//  File 2.swift
//  
//
//  Created by Nuno Alves de Sousa on 01/03/2021.
//

import SwiftUI

public struct MenuButton: Identifiable, MenuItemConvertible {
    let text: String
    let symbol: AnyView?
    let action: () -> Void
    let type: Appearance
    
    
    public let id: AnyHashable = UUID()
    
    public init(text: String, type: Appearance = .default, action: @escaping () -> Void = {}) {
        self.text = text
        self.symbol = nil
        self.action = action
        self.type = type
    }
    
    public init<Symbol: View>(text: String, symbol: Symbol, type: Appearance = .default, action: @escaping () -> Void = {}) {
        self.text = text
        self.symbol = symbol.eraseToAnyView()
        self.action = action
        self.type = type
    }
    
    public func asMenuItems() -> [ContextualMenu.MenuItem] {
        [.init(item: ContextualMenu.MenuItem.ItemType.button(self))]
    }
    
    public enum Appearance {
        case `default`, destructive
    }
}
