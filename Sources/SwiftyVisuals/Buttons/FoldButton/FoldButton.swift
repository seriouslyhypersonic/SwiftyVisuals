//
//  FoldButton.swift
//  TempoDemo
//
//  Created by Nuno Alves de Sousa on 05/12/2020.
//

import SwiftUI

/// A button that can be used to toggle between two folding states
public struct FoldButton: View {
    @Binding var isFolded: Bool
    let action: (() -> Void)?
    let label: AnyFoldLabel
    
    public init(isFolded: Binding<Bool>, action: (() -> Void)? = nil) {
        self._isFolded = isFolded
        self.action = action
        self.label = AnyFoldLabel(TransitionFoldLabel())
    }
    
    public init<Label: FoldLabel>(isFolded: Binding<Bool>, label: Label, action: (() -> Void)? = nil) {
        self._isFolded = isFolded
        self.action = action
        self.label = AnyFoldLabel(label)
    }
    
    public var body: some View {
        Button {
            isFolded.toggle()
            action?()
        } label : {
            label.makeLabel(isFolded: isFolded)
        }
    }
}

struct FoldButton_Previews: PreviewProvider {
    static var previews: some View {
        Background {
            VStack(spacing: 25) {
                StatefulPreview(false) { FoldButton(isFolded: $0) }
                
                StatefulPreview(false) { FoldButton(isFolded: $0, label: RotationFoldLabel()) }
            }
            .animation(.slowInOut)
            .foregroundColor(.white)
        }
    }
}
