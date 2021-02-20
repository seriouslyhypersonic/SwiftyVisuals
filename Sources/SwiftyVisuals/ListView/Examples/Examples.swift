//
//  Examples.swift
//  ListViewApp
//
//  Created by Nuno Alves de Sousa on 20/01/2021.
//

import SwiftUI

// MARK: - TextCell
public struct Examples {
    public struct TextCell: View, ContextMenuProvider {
        @ObservedObject var viewModel: ViewModel
        
        public init(viewModel: ViewModel) { self.viewModel = viewModel }
        
        public var body: some View {
            ZStack {
                switch viewModel.isLarge {
                case true: Color.blue.opacity(0.2)
                case false: Color.gray.opacity(0.2)
                }
                
                Text(viewModel.string)
                    .font(viewModel.isLarge ? .title : .body)
            }
            .frame(height: viewModel.isLarge ? 200 : 75)
            .onAppear {
                print("Appeared: " + viewModel.string)
            }
        }
        
        public var menuItems: some View {
            MenuItems(viewModel: viewModel)
        }
    }
}

// MARK: - TextCell+ViewModel
public extension Examples.TextCell {
    final class ViewModel: ObservableObject {
        @Published var isLarge = false
        @Published var string: String
        
        public init(_ string: String) { self.string = string }
    }
}

// MARK: - TextCell+MenuItems
public extension Examples.TextCell {
    struct MenuItems: View {
        @ObservedObject var viewModel: ViewModel
        
        public var body: some View {
            Button(viewModel.isLarge ? "Shrink" : "Expand") {
                withDelay(0.75) { withAnimation(.easeInOut) { viewModel.isLarge.toggle() } }
            }
        }
    }
}

public extension Examples {
    struct PulsatingCircle: View {
        @State private var scale: CGFloat = 1
        
        public init() { }
        
        public var body: some View {
            ZStack {
                Color.clear
                Circle()
                    .foregroundColor(.blue)
                    .frame(width: 100, height: 100)
                    .scaleEffect(scale)
                    .onAppear {
                        withAnimation(Animation.easeInOut(duration: 1).repeatForever()) {
                            self.scale = 1.25
                        }
                    }
            }
            .frame(height: 250)
            .contentShape(Rectangle())
        }
    }
}
