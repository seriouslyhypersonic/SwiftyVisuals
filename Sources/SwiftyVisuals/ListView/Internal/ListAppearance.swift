//
//  AppearanceConfiguration.swift
//  ListViewApp
//
//  Created by Nuno Alves de Sousa on 27/01/2021.
//

import SwiftUI

enum ListAppearance {
    struct Configuration {
        var showIndicators: Bool = true
        var cellTransition: AnyTransition = AnyTransition.scale.combined(with: .slide)
        var alignment: HorizontalAlignment = .center
        var spacing: CGFloat? = nil
        
        var editModeSpacing: CGFloat = 15
        var editModePadding: CGFloat = 25
    }
    
    case normal(configuration: Configuration), editing(configuration: Configuration)
    
    var spacing: CGFloat? {
        switch self {
        case .normal(let configuration): return configuration.spacing
        case .editing(let configuration): return configuration.editModeSpacing
        }
    }
    
    var padding: CGFloat {
        switch self {
        case .editing(let configuration): return configuration.editModePadding
        default: return 0
        }
    }
}
