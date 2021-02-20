//
//  CGFloat+Extension.swift
//  ListViewApp
//
//  Created by Nuno Alves de Sousa on 15/02/2021.
//

import SwiftUI

extension CGFloat {
    func isAbove(y: CGFloat) -> Bool {
        self < y
    }
    
    func isBelow(y: CGFloat) -> Bool {
        self > y
    }
}
