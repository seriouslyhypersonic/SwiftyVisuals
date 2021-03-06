//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 26/02/2021.
//

import SwiftUI

/// A fold button label that appliesa a rotation depending on the folding status
struct RotationFoldLabel: FoldLabel {
    let symbol: Image
    
    init(symbol: Image = Image(systemName: "chevron.up"))
    {
        self.symbol = symbol
    }
    
    func makeLabel(isFolded: Bool) -> some View {
        symbol.rotationEffect(isFolded ? .degrees(+180) : .zero)
    }
}
