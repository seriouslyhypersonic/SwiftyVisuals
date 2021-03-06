//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 06/03/2021.
//

import SwiftUI

struct OpacityMask: AnimatableMask {
    func makeBody(isPresented: Bool) -> some View {
        Rectangle().opacity(isPresented ? 1 : 0)
    }
}
