//
//  String+ForSorting.swift
//  
//
//  Created by Nuno Alves de Sousa on 11/05/2021.
//

import Foundation

public extension String {
    /// Returns a version of the current string suitable for sorting
    /// - Note: the resulting string is diacritic, width and case insensitive using user's region settings
    var forSorting: String {
        let simple = folding(options: [.diacriticInsensitive, .widthInsensitive, .caseInsensitive], locale: .current)
        let nonAlphaNumeric = CharacterSet.alphanumerics.inverted
        return simple.components(separatedBy: nonAlphaNumeric).joined(separator: "")
    }
}
