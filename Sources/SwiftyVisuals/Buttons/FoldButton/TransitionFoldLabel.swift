//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 26/02/2021.
//

import SwiftUI

/// A fold button label that appliesa a transitions betwwe two labels depending on the folding state
struct TransitionFoldLabel: FoldLabel {
    let foldLabel: Image
    let unfoldLabel: Image
    
    init(foldLabel: Image = Image(systemName: "chevron.up"),
         unfoldLabel: Image = Image(systemName: "chevron.down"))
    {
        self.foldLabel = foldLabel
        self.unfoldLabel = unfoldLabel
    }
    
    func makeLabel(isFolded: Bool) -> some View {
        Group {
            switch isFolded {
            case true: unfoldLabel
            case false: foldLabel
            }
        }
        .transition(.scale)
    }
}
