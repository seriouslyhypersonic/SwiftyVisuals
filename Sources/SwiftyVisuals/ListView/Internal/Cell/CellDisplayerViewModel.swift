//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 21/02/2021.
//

import SwiftUI

extension CellDisplayer {
    // MUST PROVIDE ID ON APPEAR, OTHERWISE ALL VIEW MODELS WILL BE EQUAL!
    class ViewModel: ObservableObject, Identifiable, Equatable {
        @Published var frame: CGRect = .zero
        @Published var slideOffset: CGFloat = 0
        
        @Published var cellDrag: CellDrag? = nil
        @Published var isDragging = false
        
        var id: AnyHashable = 0
        var slidFrame: CGRect { frame.offsetBy(dx: 0, dy: slideOffset) }
        
        static func == (lhs: CellDisplayer.ViewModel, rhs: CellDisplayer.ViewModel) -> Bool {
            lhs.id == rhs.id
        }
    }
}
