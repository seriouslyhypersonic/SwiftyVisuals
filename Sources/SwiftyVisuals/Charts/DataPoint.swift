//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 05/03/2021.
//

import SwiftUI

public struct DataPoint {
    public var x: CGFloat
    public var y: CGFloat
    public var label: AnyView?
}

public extension DataPoint {
    init(x: CGFloat, y: CGFloat) {
        self.x = x
        self.y = y
        self.label = nil
    }
    
    init<Label: View>(x: CGFloat, y: CGFloat, label: Label) {
        self.x = x
        self.y = y
        self.label = label.eraseToAnyView()
    }
}
