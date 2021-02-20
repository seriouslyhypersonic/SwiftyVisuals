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
    public static let width: CGFloat { bounds.width }
    
    /// The height of the device's screen
    public static let heigth: CGFloat { bounds.height }
}
