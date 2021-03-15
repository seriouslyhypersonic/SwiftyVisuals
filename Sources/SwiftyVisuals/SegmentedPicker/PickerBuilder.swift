//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 09/03/2021.
//

import SwiftUI

// Array conformance to return an empty array from 'buildIf' implementation in case of nil value
extension Array: PickerItemConvertible where Element == PickerItem {
    public func asPickerItems() -> [PickerItem] { self }
}

// ForEach conformance to enable looping in a PickerBuilder
extension ForEach: PickerItemConvertible where Content: PickerItemConvertible {
    public func asPickerItems() -> [PickerItem] {
        data.flatMap { element in
            content(element).asPickerItems()
        }
    }
}

/// A custom parameter attribute that constructs an array of `PickerItem`s from closures
@_functionBuilder
public struct PickerBuilder {
    static public func buildBlock() -> [PickerItemConvertible] { [] }
    
    static public func buildBlock(_ values: PickerItemConvertible...) -> [PickerItem] {
        values.flatMap { $0.asPickerItems() }
    }
    
    static public func buildIf(_ value: PickerItemConvertible?) -> PickerItemConvertible {
        value ?? []
    }
    
    static public func buildEither(first: PickerItemConvertible) -> PickerItemConvertible {
        first
    }
    
    static public func buildEither(second: PickerItemConvertible) -> PickerItemConvertible {
        second
    }
    
//    static public func buildBlock<ItemView: View>(_ view: ItemView) -> PickerItemConvertible{
//        PickerItem { view }
//    }
    
    static public func buildBlock<Data, ID, Content>(
        _ forEach: ForEach<Data, ID, Content>
    ) -> [PickerItem] where
        Data: RandomAccessCollection, ID: Hashable, Content: PickerItemConvertible
    {
        forEach.asPickerItems()
    }
}
