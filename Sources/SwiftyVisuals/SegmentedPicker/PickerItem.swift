//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 09/03/2021.
//

import SwiftUI

/// A view that is used as label for a picker option
public struct PickerItem: PickerItemConvertible, View {
    let content: (Bool) -> AnyView
    
    public init<Content: View>(@ViewBuilder _ content: @escaping (Bool) -> Content) {
        self.content = { content($0).eraseToAnyView() }
    }
    
    public var body: some View {
        EmptyView()
    }
    
    func makeBody(isSelected: Bool) -> AnyView {
        content(isSelected)
    }
    
    public func asPickerItems() -> [PickerItem] { [self] }
}
