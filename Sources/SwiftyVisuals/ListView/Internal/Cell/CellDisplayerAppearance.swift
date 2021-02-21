//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 21/02/2021.
//

import SwiftUI

extension CellDisplayer {
    enum Appearance: Equatable {
        case normal, editing(clipShape: AnyShape), dragging(clipShape: AnyShape)
        
        var scale: CGFloat {
            switch self {
            case .dragging: return Configuration.draggingScale
            default: return 1
            }
        }
        
        var clipShape: AnyShape {
            switch self {
            case .normal: return AnyShape(Rectangle())
            case .editing(let clipShape): return clipShape
            case .dragging(let clipShape): return clipShape
            }
        }
        
        static func == (lhs: CellDisplayer.Appearance, rhs: CellDisplayer.Appearance) -> Bool {
            switch (lhs, rhs) {
            case (.normal, .normal): return true
            case (.editing, .editing): return true
            case (.dragging, .dragging): return true
            default: return false
            }
        }
    }
}
