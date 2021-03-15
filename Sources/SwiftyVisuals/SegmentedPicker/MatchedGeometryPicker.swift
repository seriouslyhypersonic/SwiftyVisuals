//
//  SwiftUIView.swift
//  
//
//  Created by Nuno Alves de Sousa on 10/03/2021.
//

import SwiftUI

struct MatchedGeometryPicker: View {
    @Namespace private var animation
    @Binding var selection: Int
    let items: [String]
    
    var body: some View {
        HStack {
            ForEach(items.indices) { index in
                ZStack {
                    if isSelected(index) {
                        Color.gray.clipShape(Capsule())
                            .matchedGeometryEffect(id: "selector", in: animation)
                            .animation(.easeInOut)
                            .zIndex(0)
                    }
                    
                    itemView(for: index)
                        .padding(7)
                        .zIndex(1)
                }
                .fixedSize()
            }
        }
        .padding(7)
    }
    
    func itemView(for index: Int) -> some View {
        Text(items[index])
            .frame(minWidth: 0, maxWidth: .infinity)
            .foregroundColor(isSelected(index) ? .black : .gray)
            .font(.caption)
            .onTapGesture { selection = index }
    }
    
    func isSelected(_ index: Int) -> Bool { selection == index }
}

struct MatchedGeometryPickerPreview: View {
    @State private var selection = 0
    
    let pickerItems = [ "Item 1", "Long item 2", "Item 3", "Item 4", "Long item 5"]
    
    var body: some View {
        MatchedGeometryPicker(selection: $selection, items: pickerItems)
            .background(Color.gray.opacity(0.10).clipShape(Capsule()))
            .padding(.horizontal, 5)
        
    }
}

struct MatchedGeometryPicker_Previews: PreviewProvider {
    static var previews: some View {
        MatchedGeometryPickerPreview()
    }
}
