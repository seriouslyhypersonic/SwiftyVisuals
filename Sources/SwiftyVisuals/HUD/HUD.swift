//
//  SwiftUIView.swift
//  
//
//  Created by Nuno Alves de Sousa on 04/03/2021.
//

import SwiftUI

public struct HUD<Content: View>: View {
    @Binding var isPresented: Bool
    @State private var id = UUID()
    
    let duration: Double?
    let content: () -> Content
    
    
    public init(
        isPresented: Binding<Bool>,
        duration: Double? = nil,
        content: @escaping () -> Content)
    {
        self._isPresented = isPresented
        self.duration = duration
        self.content = content
    }
    
    public var body: some View {
        ZStack {
            if isPresented {
                content()
//                    .foregroundColor(.gray)
                    .padding()
                    .background(
                        Blur(style: .systemThickMaterial)
                            .clipShape(Capsule())
                            .shadow(color: Color(.black).opacity(0.22), radius: 12, x: 0, y: 5)
                    )
                    .align(.top)
                    .zIndex(1.0)
                    .transition(AnyTransition.move(edge: .top))//.combined(with: .opacity))
                    .onAppear {
                        id = UUID()
                        dismissWithDelay(idOnAppear: id)
                    }
                    .gesture(swipeUpToDismiss)
            }
        }
        .animation(.mediumInOut, value: isPresented)
        .fixedSize()
    }
    
    var swipeUpToDismiss: some Gesture {
        DragGesture(minimumDistance: 0, coordinateSpace: .local)
            .onEnded { drag in
                if drag.translation.height < 0 { // Swipped up
                    id = UUID()
                    isPresented = false
                }
            }
    }
    
    func dismissWithDelay(idOnAppear: UUID) {
        if let duration = duration {
            withDelay(duration) {
                if id == idOnAppear { // Still the same view - can dismiss
                    id = UUID()
                    isPresented = false
                }
            }
        }
    }
}

fileprivate struct HUDPreviewContainer: View {
    @State private var isPresented = true
    
    var body: some View {
//        Background {
            VStack {
                HStack {
                    hud
                    hud.colorScheme(.dark)
                }
                Spacer()
                Button("Toggle HUD") { isPresented.toggle() }
            }
//        }
    }
    
    var hud: some View {
        HUD(isPresented: $isPresented, duration: 3) {
            Label {
                Text("Message")
            } icon: {
                Image(systemName: "info.circle.fill")
            }
        }
        .labelStyle(HUDLabelStyle())
    }
}

struct HUD_Previews: PreviewProvider {
    static var previews: some View {
        HUDPreviewContainer()
    }
}
