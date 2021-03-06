//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 26/02/2021.
//

import SwiftUI

/// A type erased `FoldButtonLabel`
struct AnyFoldLabel: FoldLabel {
    let _makeButton: (Bool) -> AnyView
    
    init<T: FoldLabel>(_ foldButtonLabel: T) {
        self._makeButton = { foldButtonLabel.makeLabel(isFolded: $0).eraseToAnyView() }
    }
    
    func makeLabel(isFolded: Bool) -> some View {
        _makeButton(isFolded)
    }
    
}
