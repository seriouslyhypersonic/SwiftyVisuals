//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 20/02/2021.
//

import SwiftUI

/// The device's screen
///
/// Dimensions are given in the current coordinate space, which takes into account any interface rotations in effect for the device.
/// Therefore, the value of the properties may change when the device rotates between portrait and landscape orientations.
public struct Screen {
    /// The bounding rectangle of the screen, measured in points.
    ///
    /// This rectangle is specified in the current coordinate space, which takes into account any interface rotations in effect for the
    ///  device. Therefore, the value of this property may change when the device rotates between portrait and landscape orientations.
    public static let bounds = UIScreen.main.bounds
    
    /// The width of the device's screen
    public static var width: CGFloat { bounds.width }
    
    /// The height of the device's screen
    public static var heigth: CGFloat { bounds.height }
    
    /// The insets that you use to determine the safe area for this view.
    ///
    /// The safe area of a view reflects the area not covered by navigation bars, tab bars, toolbars, and other ancestors that obscure a
    /// view controller's view. (In tvOS, the safe area reflects the area not covered by the screen's bezel.) You obtain the safe area for a
    /// view by applying the insets in this property to the view's bounds rectangle. If the view is not currently installed in a view
    /// hierarchy, or is not yet visible onscreen, the edge insets in this property are 0. For the view controller's root view, the insets
    /// account for the status bar, other visible bars, and any additional insets that you specified using the additionalSafeAreaInsets
    /// property of your view controller. For other views in the view hierarchy, the insets reflect only the portion of the view that is
    /// covered. For example, if a view is entirely within the safe area of its superview, the edge insets in this property are 0. You might
    /// use this property at runtime to adjust the position of your view's content programmatically.
    struct SafeAreaInsets {
        private static var Window: UIWindow? { UIApplication.shared.windows.first }
        
        /// The top edge inset value.
        static var top: CGFloat {  Window?.safeAreaInsets.top ?? 0 }
        
        /// The bottom edge inset value
        static var bottom: CGFloat { Window?.safeAreaInsets.bottom ?? 0 }
        
        /// The left edge inset value.
        static var left: CGFloat { Window?.safeAreaInsets.left ?? 0 }
        
        /// The right edge inset value.
        static var right: CGFloat { Window?.safeAreaInsets.right ?? 0 }
    }
}
