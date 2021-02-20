//
//  CGPoint+Extension.swift
//  ListViewApp
//
//  Created by Nuno Alves de Sousa on 15/02/2021.
//

import SwiftUI

extension CGPoint {
    func isAbove(_ point: CGPoint) -> Bool {
        self.y.isAbove(y: point.y)
    }
    
    func isBelow(_ point: CGPoint) -> Bool {
        self.y.isBelow(y: point.y)
    }
    
    func isAbove(y: CGFloat) -> Bool {
        self.y.isAbove(y: y)
    }
    
    func isBelow(y: CGFloat) -> Bool {
        self.y.isBelow(y: y)
    }
}
