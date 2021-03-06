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
