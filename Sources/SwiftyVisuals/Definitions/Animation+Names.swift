//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 20/02/2021.
//

import SwiftUI

public extension Animation {
    static var springyAnimation: Self {
        interpolatingSpring(
            mass: 0.75,
            stiffness: 150.0,
            damping: 12,
            initialVelocity: 10
        )
    }
    
    static var snappyAnimation: Self { .easeInOut(duration: 0.15) }
}
