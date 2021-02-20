//
//  EditModeDismissButton.swift
//  ListViewApp
//
//  Created by Nuno Alves de Sousa on 25/01/2021.
//

import SwiftUI

struct EditModeDismissButton: View {
    @EnvironmentObject var editMode: ListEditMode
    
    let configuration: Configuration
    
    @ViewBuilder var body: some View {
        Group {
            if editMode.isActive {
                editButton
                    .transition(configuration.transition)
                    .zIndex(1)
            }
        }
        .offset(x: configuration.xOffset, y: configuration.yOffset)
        .align(configuration.alignmentGuide)
    }
    
    var editButton: some View {
        Button {
            let dismiss = configuration.onDismiss ?? { editState in editState.dismiss() }
            dismiss(editMode)
        } label: {
            configuration.label
        }
        .if(configuration.style.get(AnyPrimitiveButtonStyle.self) != nil,
            if: { button in
                button.buttonStyle(configuration.style.get(AnyPrimitiveButtonStyle.self)!)
            },
            else: { button in
                button.ifLet(configuration.style.get(AnyButtonStyle.self)) { button, style in
                    button.buttonStyle(style)
                }
            }
        )
    }
}

// Mark: - EditModeDismissButton.Configuration
extension EditModeDismissButton {
    struct Configuration {
        var onDismiss: ((ListEditMode) -> Void)? = nil
        var label: AnyView = Text("Ok").eraseToAnyView()
        var style: Either<AnyPrimitiveButtonStyle, AnyButtonStyle> =
            .init(AnyPrimitiveButtonStyle(DefaultButtonStyle()))
        var transition: AnyTransition = AnyTransition.scale.combined(with: AnyTransition.opacity)
        var xOffset: CGFloat = 0
        var yOffset: CGFloat = 0
        var alignmentGuide: AlignmentGuide = .topLeading
    }
}

struct EditModeDismissButton_Previews: PreviewProvider {
    
    static var previews: some View {
        EditModeDismissButton(configuration: .init())
            .environmentObject(ListEditMode(true))
    }
}
