//
//  AnyButtonStyle.swift
//  ListViewApp
//
//  Created by Nuno Alves de Sousa on 26/01/2021.
//

import SwiftUI

// TODO: THIS IS FOR TYPE ERASURE ONLY
//internal func _abstract(file: StaticString = #file, line: UInt = #line) -> Never {
//    fatalError("Method must be overriden", file: file, line: line)
//}

/// A type erased `PrimitiveButtonStyle`
struct AnyPrimitiveButtonStyle: PrimitiveButtonStyle {
    private let _makeBody: (Configuration) -> AnyView
    
    init<Style: PrimitiveButtonStyle>(_ style: Style) {
        self._makeBody = { style.makeBody(configuration: $0).eraseToAnyView() }
    }
    
    func makeBody(configuration: Configuration) -> AnyView {
        return _makeBody(configuration)
    }
}

/// A type erased `ButtonStyle`
struct AnyButtonStyle: ButtonStyle {
    private let _makeBody: (Configuration) -> AnyView
    
    init<Style: ButtonStyle>(_ style: Style) {
        self._makeBody = { style.makeBody(configuration: $0).eraseToAnyView() }
    }
    
    func makeBody(configuration: Configuration) -> AnyView {
        return _makeBody(configuration)
    }
}
