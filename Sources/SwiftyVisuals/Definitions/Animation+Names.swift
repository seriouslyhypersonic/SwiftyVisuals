//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 20/02/2021.
//

import SwiftUI

public extension Animation {
    static var springy: Self {
        interpolatingSpring(
            mass: 0.75,
            stiffness: 150.0,
            damping: 12,
            initialVelocity: 10
        )
    }
    
    static var bouncySpring: Self {
        interpolatingSpring(
            mass: 0.6,
            stiffness: 150,
            damping: 8,
            initialVelocity: 15
        )
    }
    
    static var springyContraction: Self {
        .interpolatingSpring(stiffness: 50, damping: 9, initialVelocity: -100)
    }
    
    static var fastInout: Self { .easeInOut(duration: 0.15) }
    static var mediumInOut: Self { .easeInOut(duration: 0.25) }
    static var slowInOut: Self { .easeInOut(duration: 0.5) }
}
