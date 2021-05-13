//
//  SwiftUIView.swift
//  
//
//  Created by Nuno Alves de Sousa on 10/05/2021.
//

import SwiftUI

public struct SearchField: View {
    let placeholder: String
    let text: Binding<String>
    let results: Array<IdentifiableView>?
    
//    @State private var contentOffset: CGFloat = 0
    let isPresented: Binding<Bool>
    
    public init(placeholder: String = "Search...",
                text: Binding<String>,
                results: Array<AnyView>?,
                isPresented: Binding<Bool>)
    {
        self.placeholder = placeholder
        self.text = text
        self.results = results?.map { $0.toIdentifiableView() }
        self.isPresented = isPresented
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            HStack {
                SearchBar(placeholder: placeholder, text: text)
                Button {
                    isPresented.wrappedValue.toggle()
                } label: {
                    Text("Cancel")
                        .foregroundColor(.secondary)
                }
            }
            .padding(.horizontal.union(.bottom))
            
            if let results = results {
                if !results.isEmpty {
                    Divider()
                        .transition(.opacity)
                    
                    ScrollView {
                        LazyVStack(spacing: 0) {
                            ForEach(results) { result in
                                result
                                Divider()
                            }
                        }
                        .clipped()
                    }
                    .padding(.bottom, 5)
                }
//                else {
//                    if isDebounced && !text.wrappedValue.isEmpty {
//                        Divider()
//                            .transition(.opacity)
//                        Text("No results")
//                            .foregroundColor(.secondary)
//                            .padding()
//                    }
//                }
            } else {
                Divider()
                    .transition(.opacity)
                ProgressView()
                    .scaleEffect(1.25)
                    .transition(.opacity)
                    .padding()
            }
            
        }
        .transition(.opacity)
        .clipped()
    }
}

struct SearchFieldPreview: View {
    @Binding var isPresented: Bool
    
    var results: [AnyView]? {
        if text.forSorting.contains("nil".forSorting) {
            return nil
        } else {
            return data
                .filter { $0.forSorting.contains(text.forSorting) }
                .map { data in
                    Text(data)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .eraseToAnyView()
                }
        }
    }
        
    let data = Array(1..<101).map { "Search result \($0)" }
    
    @State private var text = ""
    
    var body: some View {
        SearchField(text: $text.animation(.mediumInOut), results: results, isPresented: _isPresented)
            .padding(.top)
            .background(Blur(style: .systemUltraThinMaterial).clipShape(RoundedRectangle(cornerRadius: 15)))
            .padding()
            .animation(.mediumInOut, value: results?.count)
    }
}


struct SearchField_Previews: PreviewProvider {
    static var previews: some View {
        Background {
            VStack {
                Spacer()
                
                SearchFieldPreview(isPresented: .constant(true))
                
                Spacer()
                
                SearchFieldPreview(isPresented: .constant(true))
                    .colorScheme(.dark)
                
                Spacer()
            }
        }
    }
}
