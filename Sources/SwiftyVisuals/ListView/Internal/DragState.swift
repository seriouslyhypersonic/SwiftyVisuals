//
//  DragState.swift
//  ListViewApp
//
//  Created by Nuno Alves de Sousa on 25/01/2021.
//

import SwiftUI

enum DragState: Equatable {
    case inactive
    case pressing
    case dragging(translation: CGSize, location: CGPoint?)
    
    var translation: CGSize {
        switch self {
        case .inactive, .pressing: return .zero
        case .dragging(let translation, _): return translation
        }
    }
    
    var location: CGPoint? {
        switch self {
        case .dragging(_ , let location): return location
        default: return nil
        }
    }
    
    var isActive: Bool { return self != .inactive }
    var isDragging: Bool {
        switch self {
        case .dragging: return true
        default: return false
        }
    }
}
