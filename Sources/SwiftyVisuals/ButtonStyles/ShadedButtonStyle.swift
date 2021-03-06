//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 02/03/2021.
//

import SwiftUI

struct ShadedButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(Color.primary.opacity(configuration.isPressed ? 0.10 : 0))
            .contentShape(Rectangle())
    }
}
