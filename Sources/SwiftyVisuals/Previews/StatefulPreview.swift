//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 26/02/2021.
//

import SwiftUI

// Thanks to Jim Dovey
// https://developer.apple.com/forums/thread/118589?answerId=398579022#398579022

/// A wrapper view that enables proper binding support for SwiftUI previews
struct StatefulPreview<Value, Content: View>: View {
    @State var value: Value
    var content: (Binding<Value>) -> Content

    var body: some View {
        content($value)
    }

    init(_ value: Value, content: @escaping (Binding<Value>) -> Content) {
        self._value = State(wrappedValue: value)
        self.content = content
    }
}
