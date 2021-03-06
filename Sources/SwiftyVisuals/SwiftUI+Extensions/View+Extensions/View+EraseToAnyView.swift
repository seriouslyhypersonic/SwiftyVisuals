//
//  ViewExtensions.swift
//  ListViewApp
//
//  Created by Nuno Alves de Sousa on 18/01/2021.
//

import SwiftUI

extension View {
    /// Return a type-erased version of the curren view
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}
