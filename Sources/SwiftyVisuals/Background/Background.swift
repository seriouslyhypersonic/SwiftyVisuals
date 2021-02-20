//
//  Background.swift
//  ListViewApp
//
//  Created by Nuno Alves de Sousa on 17/02/2021.
//

import SwiftUI

/// A background view that ignores the safe area of the device and places another view on top
public struct Background<BackgroundView: View, ForegroundView: View>: View {
    let background: () -> BackgroundView
    let foreground: () -> ForegroundView
    
    init(_ background: @escaping () -> BackgroundView, foreground: @escaping () -> ForegroundView ) {
        self.background = background
        self.foreground = foreground
    }
    
    public var body: some View {
        ZStack {
            background().ignoresSafeArea()
            foreground()
        }
    }
}

// An init to load ready-to-use, type-erased, views
public extension Background where BackgroundView == AnyView {
    init(fill: BackgroundFill = .blueGradient, _ foreground: @escaping () -> ForegroundView ) {
        self.background = { fill.view() }
        self.foreground = foreground
    }
    
    /// A set of ready-to-use background views
    enum BackgroundFill {
        case purpleGreenGradient, blueGradient
        
        func view() -> AnyView {
            switch self {
            case .purpleGreenGradient: return LinearGradient.purpleToGreenDiagonally.eraseToAnyView()
            case .blueGradient: return LinearGradient.blueGradient.eraseToAnyView()
            }
        }
    }
}

struct Background_Previews: PreviewProvider {
    static var previews: some View {
        Background() { EmptyView() }
        
        Background { Color.cyan } foreground: { EmptyView() }
    }
}
