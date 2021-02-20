//
//  DeleteButtonLabel.swift
//  ListViewApp
//
//  Created by Nuno Alves de Sousa on 17/02/2021.
//

import SwiftUI

/// A view that presents symbols appropriate for delete actions
struct DeleteButtonLabel: View {
    let symbol: DeleteSymbol
    let font: Font
    
    init(symbol: DeleteSymbol = .minusCircleFill, font: Font = .title2) {
        self.symbol = symbol
        self.font = font
    }
    
    var body: some View {
        Image(systemName: symbol.rawValue)
            .font(font)
            .padding(symbolPadding)
    }
    
    var symbolPadding: CGFloat {
        switch symbol {
        case .minus, .xMark: return 3
        default: return 0
        }
    }
    
    enum DeleteSymbol: String {
        case minus = "minus"
        case minusCircle = "minus.circle"
        case minusCircleFill = "minus.circle.fill"
        case xMark = "xmark"
        case xMarkCircle = "xmark.circle"
        case xMarkCircleFill = "xmark.circle.fill"
    }
}

struct DeleteButtonLabel_Previews: PreviewProvider {
    
    static var previews: some View {
        Button { } label : { DeleteButtonLabel(font: .title) }
                .buttonStyle(DestructiveButtonStyle())
    }
}
