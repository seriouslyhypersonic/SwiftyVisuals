//
//  View+AfterTapGesture.swift
//  ListViewApp
//
//  Created by Nuno Alves de Sousa on 15/02/2021.
//

import SwiftUI

extension View {
    /// Add a gesture after ignoring a tap gesture
    func afterTapGesture<G>(add gesture: G) -> some View where G: Gesture {
        self
            .onTapGesture { }
            .gesture(gesture)
    }
}
