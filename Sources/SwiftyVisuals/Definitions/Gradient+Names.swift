//
//  Gradient+Names.swift
//  ListViewApp
//
//  Created by Nuno Alves de Sousa on 17/02/2021.
//

import SwiftUI

public extension LinearGradient {
    /// A  diagonal linear gradient from purple (bottom leading) to green (top trailling)
    static var purpleToGreenDiagonally: LinearGradient {
        .init(
            gradient: Gradient(colors: [.purple, .pink, .green]),
            startPoint: .bottomLeading,
            endPoint: .topTrailing
        )
    }
    
    // A diagnoal linear gradient from dark (bottom leading) to light (top trailling) blue
    static var blueGradient:  LinearGradient {
        .init(
            gradient: Gradient(colors: [Color.blueDark, Color.blueNavy, Color.blueLight]),
            startPoint: .bottomLeading,
            endPoint: .topTrailing)
    }
}
