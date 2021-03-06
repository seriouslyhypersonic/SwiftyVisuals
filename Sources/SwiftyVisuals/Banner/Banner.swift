//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 25/02/2021.
//

import SwiftUI

struct Banner<BannerContent: View>: ViewModifier {
    var isPresented: Bool
    let edge: Edge
    let content: () -> BannerContent
    
    public func body(content: Content) -> some View {
        content.overlay(bannerView.align(alignment))
    }
    
    init(isPresented: Bool, edge: Edge, content: @escaping () -> BannerContent) {
        self.isPresented = isPresented
        self.edge = edge
        self.content = content
    }
    
    var bannerView: some View {
        ZStack {
            if isPresented {
                content()
                    .transition(AnyTransition.move(edge: edge).combined(with: .opacity))
                    .zIndex(1.0)
            }
        }
        .animation(.mediumInOut, value: isPresented)
    }
    
    var alignment: AlignmentGuide {
        switch edge {
        case .top: return .top
        case .bottom: return .bottom
        case .leading: return .leading
        case .trailing: return .trailing
        }
    }
}
