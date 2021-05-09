//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 03/05/2021.
//

import Foundation

public extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
