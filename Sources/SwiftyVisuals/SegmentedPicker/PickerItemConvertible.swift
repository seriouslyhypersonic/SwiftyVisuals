//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 09/03/2021.
//

import SwiftUI

/// A type that can be converted to a `Pickeritem
public protocol PickerItemConvertible {
    func asPickerItems() -> [PickerItem]
}
