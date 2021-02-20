//
//  BlurredCapsuleButtonStyle.swift
//
//  Created by Nuno Alves de Sousa on 10/10/2020.
//
import SwiftUI

public extension Padding {
    static var buttonDefault: Padding { .init(horizontal: 10, vertical: 5) }
}

// MARK: - BlurredClipShapeButtonStyleProtocol
protocol BlurredClipShapeButtonStyleProtocol: ButtonStyle {
    associatedtype ClipShape: Shape
    var clipShape: ClipShape { get }
    var style: UIBlurEffect.Style { get }
    var padding: Padding { get }
}

// The implementation for the button styling
fileprivate func clipAndBlur<Label: View, ClipShape: Shape>(
    configuration: ButtonStyleConfiguration,
    label: Label,
    padding: Padding,
    style: UIBlurEffect.Style,
    clipShape: ClipShape) -> some View
{
    label
        .foregroundColor(.primary)
        .padding(padding)
        .background(BlurView(style: style))
        .overlay(Color.primary.opacity(configuration.isPressed ? 0.5 : 0))
        .clipShape(clipShape)
}

extension BlurredClipShapeButtonStyleProtocol {
    public func makeBody(configuration: ButtonStyleConfiguration) -> some View {
        clipAndBlur(
            configuration: configuration,
            label: configuration.label,
            padding: padding,
            style: style,
            clipShape: clipShape)
    }
}

// MARK: - BlurredClipShapeButtonStyle

/// Styles a button with a blurred background and applies a clip shape
public struct BlurredClipShapeButtonStyle<ClipShape: Shape>: BlurredClipShapeButtonStyleProtocol {
    let clipShape: ClipShape
    let style: UIBlurEffect.Style
    let padding: Padding
    
    init(clipShape: ClipShape,
         style: UIBlurEffect.Style = .systemMaterial,
         padding: Padding = .buttonDefault)
    {
        self.clipShape = clipShape
        self.style = style
        self.padding = padding
    }
}

// MARK: - BlurredCapsuleButtonStyle

/// A capsule shaped button with a blurred background
public typealias BlurredCapsuleButtonStyle = BlurredClipShapeButtonStyle<Capsule>

public extension BlurredCapsuleButtonStyle {
    init(style: UIBlurEffect.Style = .systemMaterial,
         padding: Padding = .buttonDefault)
    {
        self.init(clipShape: ClipShape(), style: style, padding: padding)
    }
}

// MARK: - BluredRoundedRectanleButtonStyle

/// A button with a blurred background and a `RoundedRactangle` clip shape
public typealias BlurredRoundedRectangleButtonStyle = BlurredClipShapeButtonStyle<RoundedRectangle>

public extension BlurredRoundedRectangleButtonStyle {
    init(cornerRadius: CGFloat,
         style: UIBlurEffect.Style = .systemMaterial,
         padding: Padding = .buttonDefault)
    {
        self.init(clipShape: ClipShape(cornerRadius: cornerRadius), style: style, padding: padding)
    }
}

// MARK: - BlurredCircleButtonStyle
// Blurred circular buttons get TwistableButtonStyle conformance for free

/// A circular, twistable, button with a blurred background
public struct BlurredCircleButtonStyle: BlurredClipShapeButtonStyleProtocol, TwistableButtonStyle {
    public let rotation: Angle
    public let scale: CGFloat
    public let shadowRadius: CGFloat
    
    let clipShape = Circle()
    let style: UIBlurEffect.Style
    let padding: Padding
    
    public init(
        style: UIBlurEffect.Style = .systemMaterial,
        padding: Padding = .init(horizontal: 7, vertical: 7),
        rotation: Angle = .degrees(90),
        scale: CGFloat = 1.5,
        shadowRadius: CGFloat = 10)
    {
        self.rotation = rotation
        self.scale = scale
        self.shadowRadius = shadowRadius
        
        self.style = style
        self.padding = padding
    }
    
    public func makeBody(configuration: Configuration) -> some View {
        twist(
            label: clipAndBlur(
                configuration: configuration,
                label: configuration.label,
                padding: padding,
                style: style,
                clipShape: clipShape),
            with: configuration)
    }
}

struct BlurredCapsuleButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        
        Background {
            VStack(spacing: 50) {
                Button("Capsule") { }
                    .buttonStyle(BlurredCapsuleButtonStyle())
                
                Button("Rounded Rectangle") { }
                    .buttonStyle(BlurredRoundedRectangleButtonStyle(cornerRadius: 10))
                
                Button("Rectangle") { }
                    .buttonStyle(BlurredClipShapeButtonStyle(clipShape: Rectangle()))
                
                Button { } label : { Image(systemName: "plus") }
                    .buttonStyle(BlurredCircleButtonStyle())
                
                Button { } label : { Image(systemName: "minus") }
                    .buttonStyle(BlurredCircleButtonStyle(padding: .init(equal: 13)))
            }
        }
    }
}




