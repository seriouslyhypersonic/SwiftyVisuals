//
//  View+ConditionalModifiers.swift
//  ListViewApp
//
//  Created by Nuno Alves de Sousa on 15/02/2021.
//

import SwiftUI

public extension View {
    /// Conditionally apply a modifier or return `self`
    @inlinable @ViewBuilder
    func `if`<Transform: View>(_ condition: Bool, transform: (Self) -> Transform ) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    /// Conditionally apply a modifier
    @inlinable @ViewBuilder
    func `if`<TrueContent: View, FalseContent: View>(
        _ condition: Bool,
        if ifTransform: (Self) -> TrueContent,
        else elseTransform: (Self) -> FalseContent
    ) -> some View
    {
        if condition {
            ifTransform(self)
        } else {
            elseTransform(self)
        }
    }
    
    /// Conditionally apply a modifier or return `self`
    @inlinable @ViewBuilder
    func ifLet<Value, Transform: View>(_ value: Value?, transform: (Self, Value) -> Transform) -> some View {
        if let value = value {
            transform(self, value)
        } else {
            self
        }
    }
    
    /// Conditionally apply a modifier or return nothing
    @inlinable @ViewBuilder
    func ifLetElseNothing<Value, Transform: View>(_ value: Value?, transform: (Self, Value) -> Transform) -> some View {
        if let value = value {
            transform(self, value)
        }
    }
}
