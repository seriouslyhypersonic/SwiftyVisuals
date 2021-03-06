//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 24/02/2021.
//

import Foundation

public extension Date {
    /// Generate a textual representation of the date using a specified formatter
    /// - Parameter formatter: the date formatter used for textual conversion
    func toString(format formatter: DateFormatter) -> String {
        formatter.string(from: self)
    }
    
    /// Generate a textual representation of the date using  built-in date a time styles
    /// - Parameters:
    ///   - dateStyle: the date display style
    ///   - timeStyle: the time display style
    func toString(
        dateStyle: DateFormatter.Style = .full,
        timeStyle: DateFormatter.Style = .none) -> String
    {
        let formatter = DateFormatter()
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        
        return formatter.string(from: self)
    }
}
