//
//  Banner.swift
//  
//
//  Created by Nuno Alves de Sousa on 25/02/2021.
//

import SwiftUI

// A container view that presents its contents from an edge of the screen
struct Banner<BannerContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    @State private var isShowing: Bool
    let edge: Edge
    let content: () -> BannerContent
    
    public func body(content: Content) -> some View {
        content.overlay(bannerView.align(alignment))
    }
    
    init(isPresented: Binding<Bool>, edge: Edge, content: @escaping () -> BannerContent) {
        self._isPresented = isPresented
        self._isShowing = State(wrappedValue: isPresented.wrappedValue)
        self.edge = edge
        self.content = content
    }
    
    var bannerView: some View {
        ZStack {
            if isShowing {
                content()
                    .transition(AnyTransition.move(edge: edge).combined(with: .opacity))
                    .zIndex(1.0)
            }
        }
        .onChange(of: isPresented) { _ in
            withAnimation(.mediumInOut) {
                isShowing = isPresented
            }
        }
    }
    
    var alignment: Alignment {
        switch edge {
        case .top: return .top
        case .bottom: return .bottom
        case .leading: return .leading
        case .trailing: return .trailing
        }
    }
}
