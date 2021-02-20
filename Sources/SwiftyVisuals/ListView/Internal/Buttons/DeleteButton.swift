//
//  DeleteButton.swift
//  ListViewApp
//
//  Created by Nuno Alves de Sousa on 26/01/2021.
//

import SwiftUI

// MARK: - DeleteButton
struct DeleteButton: View {
    @EnvironmentObject var editState: ListEditMode
    let configuration: Configuration
    
    var body: some View {
        Group {
            if editState.isActive {
                deleteButton
                    .transition(configuration.transition)
                    .zIndex(1)
            }
        }
        .align(configuration.alignmentGuide)
        .offset(x: configuration.xOffset, y: configuration.yOffset)
    }
    
    var deleteButton: some View {
        Button {
            configuration.onDelete?()
        } label: {
            configuration.label
        }
        .if(configuration.style.get(AnyPrimitiveButtonStyle.self) != nil,
            if: { button in
                button.buttonStyle(configuration.style.get(AnyPrimitiveButtonStyle.self)!)
            },
            else: { button in
                button.ifLet(configuration.style.get(AnyButtonStyle.self)) { button, style in
                    return button.buttonStyle(style)
                }
            }
        )
        
    }
}

// MARK: - DeleteButton.Configuration
extension DeleteButton {
    struct Configuration {
        var onDelete: (() -> Void)? = nil
        var label: AnyView = Image(systemName: "xmark.circle.fill").eraseToAnyView()
        var style: Either<AnyPrimitiveButtonStyle, AnyButtonStyle> =
            .init(AnyPrimitiveButtonStyle(DefaultButtonStyle()))
        var transition: AnyTransition = AnyTransition.scale.combined(with: AnyTransition.opacity)
        var xOffset: CGFloat = 0
        var yOffset: CGFloat = 0
        var alignmentGuide: AlignmentGuide = .topLeading
    }
}

struct DeleteButton_Previews: PreviewProvider {
    static var previews: some View {
        DeleteButton(configuration: .init())
            .environmentObject(ListEditMode(true))
    }
}
