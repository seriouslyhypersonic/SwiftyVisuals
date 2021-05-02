//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 01/03/2021.
//

import SwiftUI

extension Array: MenuItemConvertible where Element == ContextualMenu.MenuItem {
    public func asMenuItems() -> [ContextualMenu.MenuItem] { self }
}

public extension ContextualMenu {
    /// A custom parameter attribute that constructs an array of  `MenuItem`s from closures
    @resultBuilder
    struct MenuItemsBuilder {
        static func buildBlock() -> [ContextualMenu.MenuItem] { [] }
        
        static public func buildBlock(_ values: MenuItemConvertible...) -> [ContextualMenu.MenuItem] {
            values.flatMap { $0.asMenuItems() }
        }
        
        static public func buildIf(_ value: MenuItemConvertible?) -> MenuItemConvertible {
            value ?? []
        }
        
        static public func buildEither(first: MenuItemConvertible) -> MenuItemConvertible {
            first
        }
        
        static public func buildEither(second: MenuItemConvertible) -> MenuItemConvertible {
            second
        }
    }
}

/// A custom parameter attribute that constructs a  `ContextualMenu` from closures
@resultBuilder
public struct MenuBuilder {
    static public func buildBlock() -> ContextualMenu { ContextualMenu(items: []) }
    
    static public func buildBlock(_ values: MenuItemConvertible...) -> ContextualMenu {
        ContextualMenu(items: values.flatMap { $0.asMenuItems() })
    }
    
    static public func buildIf(_ value: ContextualMenu?) -> ContextualMenu? {
        if let value = value {
            return value
        } else {
            return nil
        }
    }
    
    static public func buildEither(first: ContextualMenu) -> ContextualMenu {
        first
    }
    
    static public func buildEither(second: ContextualMenu) -> ContextualMenu {
       second
    }
}
