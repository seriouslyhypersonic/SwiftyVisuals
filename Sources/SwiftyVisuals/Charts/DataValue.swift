//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 05/03/2021.
//

import SwiftUI

/// A `LineChart` data element that holds a single y-value and an optional label
public struct DataValue {
    var y: CGFloat
    var label: AnyView?
}

public extension DataValue {
    init<Label: View>(y: CGFloat, label: Label) {
        self.y = y
        self.label = label.eraseToAnyView()
    }
}
