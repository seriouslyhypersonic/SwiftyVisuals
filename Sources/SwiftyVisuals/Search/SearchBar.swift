//
//  SwiftUIView.swift
//  
//
//  Created by Nuno Alves de Sousa on 10/05/2021.
//

import SwiftUI


/// A field for text-based searches
public struct SearchBar: View {
    let label: Image?
    let placeholder: String
    @Binding var text: String
    
    /// - Parameters:
    ///   - label: an image used as label for the text field
    ///   - placeholder: the text field placeholder
    ///   - text: a binding to the string value of the text field
    public init(label: Image? = Image(systemName: "magnifyingglass"),
                placeholder: String = "Search...",
                text: Binding<String>)
    {
        self.label = label
        self.placeholder = placeholder
        self._text = text
    }
    
    public var body: some View {
        HStack {
            HStack {
                label?
                    .foregroundColor(.secondary)
                TextField(placeholder, text: $text)
                    .accentColor(.primary)
                
                if !text.isEmpty {
                    Button {
                        withAnimation(.mediumInOut) {
                            text = ""
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .font(Font.body.bold())
                    }
                    .buttonStyle(CircleButtonStyle(background: fillColor, scale: 1.2))
                    .transition(.opacity)
                    .scaleEffect(0.85)
                    .zIndex(2.0)
                }
            }
            .frame(height: 20)
            .padding(10)
            .background(fillColor)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
    
    let fillColor = Color.secondary.opacity(0.2)
}

struct SearchBar_Previews: PreviewProvider {
    static var text: String = ""
    
    static var previews: some View {
            VStack(spacing: 150) {
                StatefulPreview(text) {
                    SearchBar(text: $0)
                }
                .padding()
                .background(Blur())
                
                StatefulPreview(text) {
                    SearchBar(text: $0)
                }
                .padding()
                .background(Blur())
                .colorScheme(.dark)
            }
    }
}
