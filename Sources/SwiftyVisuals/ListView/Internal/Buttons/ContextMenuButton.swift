//
//  SwiftUIView.swift
//  
//
//  Created by Nuno Alves de Sousa on 23/02/2021.
//

import SwiftUI

/// A button with an optional `Image` that can  be used in a `ContextMenu`
/// Note: button actions are only called after the context menu dismiss animation
public struct ContextMenuButton: View {
    let label: Text
    let image: Image?
    let action: () -> Void
    
    public init(label: Text, image: Image? = nil, action: @escaping () -> Void) {
        self.label = label
        self.image = image
        self.action = action
    }
    
    public var body: some View {
        Button {
            afterContextMenuDismissed(execute: action)
        } label: {
            label
            image
        }
    }
        
    /// Perform an action after context menu dismiss animation (workarround)
    func afterContextMenuDismissed(execute: @escaping () -> Void ) {
        withDelay(ContextMenuButton.dismissInterval, execute: execute)
    }
    
    /// An approximation for the duration of the context menu dismiss animation
    private static let dismissInterval = 0.75
}
//
//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContextMenuButton()
//    }
//}
