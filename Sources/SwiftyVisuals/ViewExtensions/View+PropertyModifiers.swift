//
//  View+PropertyModifiers.swift
//  ListViewApp
//
//  Created by Nuno Alves de Sousa on 15/02/2021.
//

import SwiftUI

extension View {
    // TODO: IMPORTANT - Check if lack of .id(UUID()) requires using EnvironmentKey's
    // https://stackoverflow.com/questions/64363228/swiftui-viewmodifier-for-custom-view
    
    /// Customize `View` parameters using a `ViewModifier`-like intereface.
    /// - Note: This function returns a copy of the current `View` with the `State` property refered to by the
    ///         `WritableKeyPath` updated to the new `value`
    func modifyState<V>(_ key: WritableKeyPath<Self, State<V>>, value: V) -> Self {
        var view = self
        view[keyPath: key] = State(wrappedValue:  value)
        return view
    }
    
    /// Customize `View` parameters using a `ViewModifier`-like intereface.
    /// - Note: This function returns a copy of the current `View` with the property refered to by the ` `WritableKeyPath`
    ///         updated to the new `value
    func modify<V>(_ key: WritableKeyPath<Self, V>, value: V) -> Self {
        var view = self
        view[keyPath: key] = value
        return view
    }
}
