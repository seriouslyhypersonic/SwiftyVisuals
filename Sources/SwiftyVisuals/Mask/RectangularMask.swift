//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 05/03/2021.
//

import SwiftUI

struct RectagularMask: AnimatableMask {
    let edge: Edge
    
    func makeBody(isPresented: Bool) -> some View {
        GeometryReader { geo in
            switch edge {
            case .top:
                VStack {
                    Rectangle().frame(height: isPresented ? geo.frame(in: .local).size.height : 0)
                    if !isPresented { Spacer() }
                }
            case .bottom:
                VStack {
                    if !isPresented { Spacer() }
                    Rectangle().frame(height: isPresented ? geo.frame(in: .local).size.height : 0)
                }
            case .leading:
                HStack {
                    Rectangle().frame(width: isPresented ? geo.frame(in: .local).size.width : 0)
                    if !isPresented { Spacer() }
                }
            case .trailing:
                HStack {
                    if !isPresented { Spacer() }
                    Rectangle().frame(width: isPresented ? geo.frame(in: .local).size.width : 0)
                }
            }
        }
    }
}

public enum Masks {
    public struct Rectangle: View {
        let trim: CGFloat
        let edge: Edge
        
        public init(trim: CGFloat = 0, from edge: Edge = .trailing) {
            self.trim = trim
            self.edge = edge
        }
        
        public var body: some View {
            GeometryReader { geometry in
                switch edge {
                case .top:
                    VStack(spacing: 0) {
                        SwiftUI.Rectangle().frame(height: geometry.size.height * (1-trim))
                        Spacer()
                    }
                case .bottom:
                    VStack(spacing: 0) {
                        Spacer()
                        SwiftUI.Rectangle().frame(height: geometry.size.height * (1-trim))
                    }
                case .leading:
                    HStack(spacing: 0) {
                        Spacer()
                        SwiftUI.Rectangle().frame(width: geometry.size.width * (1-trim))
                    }
                case .trailing:
                    HStack(spacing: 0) {
                        SwiftUI.Rectangle().frame(width: geometry.size.width * (1-trim))
                        Spacer()
                    }
                }
            }
        }
        
        
        var needsSpacer: Bool { true }
    }
}
