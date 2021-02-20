//
//  AlignmentModifiers.swift
//  TempoDemo
//
//  Created by Nuno Alves de Sousa on 21/12/2020.
//

import SwiftUI

// MARK: - View Alignment Modifier

struct TopView: ViewModifier {
    func body(content: Content) -> some View {
        VStack(spacing: 0) {
            content
            Spacer()
        }
    }
}

struct BottomView: ViewModifier {
    func body(content: Content) -> some View {
        VStack(spacing: 0) {
            Spacer()
            content
        }
    }
}

struct LeadingView: ViewModifier {
    func body(content: Content) -> some View {
        HStack(spacing: 0) {
            content
            Spacer()
        }
    }
}

struct TrailingView: ViewModifier {
    func body(content: Content) -> some View {
        HStack(spacing: 0) {
            Spacer()
            content
        }
    }
}

enum AlignmentGuide {
    case top, bottom
    case leading, trailing
    case topLeading, topTrailing
    case bottomLeading, bottomTrailing
}
