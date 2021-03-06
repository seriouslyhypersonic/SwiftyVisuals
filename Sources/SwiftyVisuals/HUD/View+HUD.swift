//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 04/03/2021.
//

import SwiftUI

public struct HUDLabelStyle: LabelStyle {
    public init() { }
    
    public func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .center) {
            configuration.icon
                .foregroundColor(.gray)
            configuration.title
                .font(Font.caption.bold()).foregroundColor(.secondary)
        }
    }
}

public extension View {
    func hud<Content: View>(
        isPresented: Binding<Bool>,
        duration: Double? = nil,
        content: @escaping () -> Content) -> some View
    {
        ZStack {
            self
            VStack {
                HUD(isPresented: isPresented, duration: duration, content: content)
                Spacer()
            }
        }
    }
    
    func hud<Icon: View, Title: View>(
        isPresented: Binding<Bool>,
        duration: Double? = nil,
        label: Label<Icon, Title>) -> some View
    {
        ZStack {
            self
            VStack {
                HUD(isPresented: isPresented, duration: duration) {
                    label.labelStyle(HUDLabelStyle())
                }
                Spacer()
            }
        }
    }
}
