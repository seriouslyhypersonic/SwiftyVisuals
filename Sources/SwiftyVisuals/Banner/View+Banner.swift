//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 25/02/2021.
//

import SwiftUI

public extension View {
    func banner<Content: View>(isPresented: Bool = true, edge: Edge = .top, _ content: @escaping () -> Content ) -> some View {
        self.modifier(Banner(isPresented: isPresented, edge: edge, content: content))
    }
}
