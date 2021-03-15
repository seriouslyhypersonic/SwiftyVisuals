//
//  SwiftUIView.swift
//  
//
//  Created by Nuno Alves de Sousa on 27/02/2021.
//

import SwiftUI

public struct MenuDrawer<Content: View>: View {
    let content: () -> Content
    let contextualMenu: ContextualMenu?
    
    public init(contextualMenu: ContextualMenu?, content: @escaping () -> Content) {
        self.contextualMenu = contextualMenu
        self.content = content
    }
    
    @GestureState private var isPressing = false
    @StateObject var presentationMode = ContextualMenu.PresentationMode()
    @State private var menuFrame: CGRect = .zero
    @State private var contentFrame: CGRect = .zero
    
    public var body: some View {
        VStack(alignment: .center) {
            content()
                .zIndex(isMenuActive ? 3 : 2)
                .disabled(isMenuActive)
                .scaleEffect(isMenuActive ? 1.005 : 1)
                .animation(.springyContraction, value: isPressing)
//                .shadow(color: Color.black.opacity(0.5), radius: isMenuActive ? /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/ : 0)
                .animation(.fastInout, value: isPressing)
                .contentShape(Rectangle())
                .onTapGesture(perform: dismissMenuDrawer)
                .gesture(isGestureActive ? longPress : nil)
            
            if let contextualMenu = contextualMenu, presentationMode.isPresented {
                contextualMenu
                    .transition(Configuration.transition)
                    .fixedSize(horizontal: false, vertical: true)
                    .clipped()
                    .zIndex(isMenuActive ? 1 : 0)
            }
        }
        .environmentObject(presentationMode)
        .zIndex(isMenuActive ? 1 : 0)
        .background(dismisserView)
    }
    
    var isMenuActive: Bool { isPressing || presentationMode.isPresented }
    var isGestureActive: Bool { contextualMenu != nil && !presentationMode.isPresented }
    
    @ViewBuilder var dismisserView: some View {
        if presentationMode.isPresented {
            Color.clear
//            BlurView(style: .systemUltraThinMaterialDark)
                .frame(height: presentationMode.isPresented ? Screen.heigth * 3 : 0)
                .ignoresSafeArea()
                .contentShape(Rectangle())
                .onTapGesture(perform: dismissMenuDrawer)
                .transition(.opacity)
        }
    }
    
    var longPress: some Gesture {
        LongPressGesture(minimumDuration: 1.5, maximumDistance: 50)
            .updating($isPressing) { currentState, isShowing, transaction in
                isShowing = currentState
            }
            .onChanged { if $0 { Haptics.impact() }  }
            .onEnded { hasCompleted in
                if hasCompleted {
                    withAnimation(.springy) { presentationMode.isPresented = true }
                    Haptics.impact(style: .light)
                }
            }
    }
    
    func dismissMenuDrawer() {
        if presentationMode.isPresented {
            withAnimation(.mediumInOut) { presentationMode.isPresented = false }
        }
    }
}

extension MenuDrawer {
    struct Configuration {
        static var transition: AnyTransition {
            AnyTransition.opacity.combined(with: .move(edge: .top)).combined(with: .scale)
        }
    }
}

struct MenuDrawer_Previews: PreviewProvider {
    @State static private var isLarge = false
    
    static var previews: some View {
//        Background {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 25) {
                    widget
                    widget
                    widget
                    widget
                    widget
                }
            }
//        }
    }
    
    static var widget: some View {
        Text("Hello, World")
            .font(isLarge ? .title : .body)
            .frame(maxWidth: .infinity)
            .frame(height: 150)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .padding(.horizontal)
            .shadow(radius: 5)
            .menuDrawer {
                MenuButton(
                    text: "Share",
                    symbol: Image(systemName: "square.and.arrow.up"))
                MenuGroup(label: "Create") {
                    MenuButton(
                        text: "New Folder",
                        symbol: Image(systemName: "folder.fill.badge.plus").renderingMode(.original))
                    MenuButton(
                        text: "New Message",
                        symbol: Image(systemName: "square.and.pencil"))
                }
            }
    }
}
