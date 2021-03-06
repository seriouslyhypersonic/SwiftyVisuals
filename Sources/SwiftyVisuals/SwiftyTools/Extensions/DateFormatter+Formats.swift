//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 24/02/2021.
//

import Foundation

public extension DateFormatter {
    /// No time date formatter: `yyyy-MM-dd`
    static let fullDateWithouYear: DateFormatter = {
        let template = "EEEEdMMMM"
        let format = DateFormatter.dateFormat(fromTemplate: template, options: 0, locale: .current)
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter
    }()
    
    /// A date formatter that uses relative date formatting 
    static var relativeDay: DateFormatter = {
        let formater = DateFormatter()
        formater.timeStyle = .none
        formater.dateStyle = .medium
        formater.doesRelativeDateFormatting = true
        
        return formater
    }()
}
