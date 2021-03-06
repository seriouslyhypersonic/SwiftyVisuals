//
//  List+Modifiers.swift
//  ListViewApp
//
//  Created by Nuno Alves de Sousa on 20/01/2021.
//

import SwiftUI

public extension ListView {
    /// Set the deletion action for the `ListView`
    /// - Parameters:
    ///   - action: the action that you want `ListView` to perform when elements in the view are deleted. The `ListView`
    ///     passes a set of indices to the closure that’s relative to the underlying collection of data.
    ///   - offsets: the `IndexSet` of the elements marked for deletion
    func onDelete(perform action: @escaping (_ offsets: IndexSet) -> Void) -> Self {
        modify(\.onDelete, value: action)
    }
    
    /// Set the move action for the `ListView`
    /// - Parameter action: a closure that `ListView` invokes when elements in the view are moved. The closure takes two
    /// arguments that represent the offset relative to the view’s underlying collection of data.
    /// - Parameter source:  the `IndexSet` of the items to be moved.
    /// - Parameter destination: the destination offset for the items to be moved
    func onMove(perform action: @escaping (_ source: IndexSet, _ destination: Int) -> Void) -> Self {
        modify(\.onMove, value: action)
    }
    
    // TODO: ADD DOCUMENTATION
    
    // MARK: - ListView appearance
    
    func showIndicators(_ showIndicators: Bool) -> Self {
        modify(\.configuration.showIndicators, value: showIndicators)
    }
    
    func cellTransition(_ transition: AnyTransition) -> Self {
        modify(\.configuration.cellTransition, value: transition)
    }
    
    func alignment(_ alignment: HorizontalAlignment) -> Self {
        modify(\.configuration.alignment, value: alignment)
    }
    
    func spacing(_ spacing: CGFloat?) -> Self {
        modify(\.configuration.spacing, value: spacing)
    }
    
    func fixedHeader(_ hasFixedHeader: Bool = true) -> Self {
        modify(\.configuration.hasFixedHeader, value: hasFixedHeader)
    }
    
    // MARK: - Edit Mode
    
    func editMode(
        onActivate: @escaping (ListEditMode) -> Void,
        onDismiss: @escaping (ListEditMode) -> Void) -> Self
    {
        self.modify(\.editModeOnActivate, value: onActivate)
            .modify(\.editButtonConfiguration.onDismiss, value: onDismiss)
    }
    
    func editMode(padding: CGFloat) -> Self {
        modify(\.configuration.editModePadding, value: padding)
    }
    
    func editMode(spacing: CGFloat) -> Self {
        modify(\.configuration.editModeSpacing, value: spacing)
    }
    
    func editMode<ClipShape: Shape>(clipShape:ClipShape) -> Self {
        modify(\.cellDisplayerConfiguration.editingClipShape, value: clipShape.eraseToAnyShape())
    }
    
    func editButton<Label: View, Style: ButtonStyle>(
        alignment: AlignmentGuide = .topLeading,
        style: Style? = nil,
        transition: AnyTransition? = nil,
        @ViewBuilder label: @escaping () -> Label ) -> Self
    {
        var list = self
            .modify(\.editButtonConfiguration.label, value: label().eraseToAnyView())
            .modify(\.editButtonConfiguration.alignmentGuide, value: alignment)
        
        if let style = style {
            list = list.editButton(style: style)
        }
        
        if let transition = transition {
            list = list.modify(\.editButtonConfiguration.transition, value: transition)
        }
        
        return list
    }
    
    func editButtonOffset(x: CGFloat, y: CGFloat) -> Self {
        self.modify(\.editButtonConfiguration.xOffset, value: x)
            .modify(\.editButtonConfiguration.yOffset, value: y)
    }
    
    func editButton(alignment: AlignmentGuide) -> Self {
        modify(\.editButtonConfiguration.alignmentGuide, value: alignment)
    }
    
    func editButton<Style: ButtonStyle>(style: Style) -> Self {
        modify(\.editButtonConfiguration.style, value: .init(AnyButtonStyle(style)))
    }
    
    func editButton<Style: PrimitiveButtonStyle>(style: Style) -> Self {
        modify(\.editButtonConfiguration.style, value: .init(AnyPrimitiveButtonStyle(style)))
    }
    
    func editMode(jiggleEffect: Bool, amplitude: Angle = .degrees(2), duration: Double = 0.35) -> Self {
        self.modify(\.cellDisplayerConfiguration.jiggleAmplitude, value: jiggleEffect ? amplitude : .zero)
            .modify(\.cellDisplayerConfiguration.jiggleAnimation.duration, value: duration)
    }
    
    // MARK: - Delete Button
    
    func deleteButton<Label: View, S: ButtonStyle>(
        alignment: AlignmentGuide = .topLeading,
        style: S? = nil,
        transition: AnyTransition? = nil,
        @ViewBuilder label: @escaping () -> Label) -> Self
    {
        var list = self
            .modify(\.cellDisplayerConfiguration.deleteButtonConfiguration.label, value: label().eraseToAnyView())
            .modify(\.cellDisplayerConfiguration.deleteButtonConfiguration.alignmentGuide, value: alignment)
            
        if let style = style {
            list = list.deleteButton(style: style)
        }
        
        if let transition = transition {
            list = list.deleteButton(transition: transition)
        }
        
        return list
    }
    
    func deleteButton<Style: ButtonStyle>(
        symbol: DeleteButtonLabel.DeleteSymbol,
        font: Font = .title2,
        alignment: AlignmentGuide = .topLeading,
        style: Style? = nil,
        transition: AnyTransition? = nil) -> Self
    {
        deleteButton(alignment: alignment, style: style, transition: transition) {
            DeleteButtonLabel(symbol: symbol, font: font)
        }
    }
    
    func deleteButtonOffset(x: CGFloat, y: CGFloat) -> Self {
        self.modify(\.cellDisplayerConfiguration.deleteButtonConfiguration.xOffset, value: x)
            .modify(\.cellDisplayerConfiguration.deleteButtonConfiguration.yOffset, value: y)
    }
    
    func deleteButton(alignment: AlignmentGuide) -> Self {
        modify(\.cellDisplayerConfiguration.deleteButtonConfiguration.alignmentGuide, value: alignment)
    }
    
    func deleteButton<Style: ButtonStyle>(style: Style) -> Self {
        modify(\.cellDisplayerConfiguration.deleteButtonConfiguration.style, value: .init(AnyButtonStyle(style)))
    }
    
    func deleteButton<Style: PrimitiveButtonStyle>(style: Style) -> Self {
        modify(\.cellDisplayerConfiguration.deleteButtonConfiguration.style, value: .init(AnyPrimitiveButtonStyle(style)))
    }
    
    func deleteButton(transition: AnyTransition) -> Self {
        modify(\.cellDisplayerConfiguration.deleteButtonConfiguration.transition, value: transition)
    }
}
