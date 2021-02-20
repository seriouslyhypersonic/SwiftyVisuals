//
//  View+ToCell.swift
//  ListViewApp
//
//  Created by Nuno Alves de Sousa on 15/02/2021.
//

import SwiftUI

extension View {
    /// Embbed the current view in a Cell
    /// - Parameter id: the cell id
    /// - Returns: the current view embbeded in a Cell or a `self` if the view is already a Cell
    func toCell(id: AnyHashable = UUID()) -> Cell {
        if let cell = self as? Cell {
            return cell
        } else {
            return Cell(id: id) { self }
        }
    }
    
    /// Embbed the current view in a Cell
    /// - Parameter id: the cell id
    /// - Returns: the current view embbeded in a Cell or a `self` if the view is already a Cell
    func toCell(id: AnyHashable = UUID()) -> Cell where Self: View & ContextMenuProvider {
        if let cell = self as? Cell {
            return cell
        } else {
            return Cell(id: id) { self }
        }
    }
}
