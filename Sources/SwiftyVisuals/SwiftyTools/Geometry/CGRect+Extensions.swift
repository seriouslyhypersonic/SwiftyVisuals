//
//  CGRect+Extensions.swift
//  ListViewApp
//
//  Created by Nuno Alves de Sousa on 15/02/2021.
//

import SwiftUI

extension CGRect {
    func isAbove(_ rect: CGRect) -> Bool {
        self.midY.isAbove(y: rect.midY)
    }
    
    func isBelow(_ rect: CGRect) -> Bool {
        self.midY.isBelow(y: rect.midY)
    }
    
    func isAbove(_ point: CGPoint) -> Bool {
        self.midY.isAbove(y: point.y)
    }
    
    func isBelow(_ point: CGPoint) -> Bool {
        self.midY.isBelow(y: point.y)
    }
}
