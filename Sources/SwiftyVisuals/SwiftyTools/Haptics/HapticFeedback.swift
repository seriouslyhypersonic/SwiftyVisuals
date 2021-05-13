//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 02/03/2021.
//

import Foundation
import UIKit

public enum Haptics {
    
    /// Triggers notification feedback using haptics to communicate successes, failures, and warnings
    /// - Parameter type: The type of notification generated
    public static func notification(type: UINotificationFeedbackGenerator.FeedbackType = .success) {
        UINotificationFeedbackGenerator().notificationOccurred(type)
    }
    
    /// Creates haptics to simulate physical impacts.
    /// - Parameter style: The mass of the objects in the simulated collision
    public static func impact(style: UIImpactFeedbackGenerator.FeedbackStyle = .medium) {
        UIImpactFeedbackGenerator(style: style).impactOccurred()
    }
}
