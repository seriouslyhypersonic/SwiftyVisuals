//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 24/02/2021.
//

import Foundation

public extension Date {
    /// The current date and time
    static var now: Self { Date() }
    /// The date for tomorrow at midnight
    static var tomorrow: Self {
        now
            .newByAdding(days: 1)!
            .newBySetting(hour: 0, minute: 0, second: 0)!
    }
}
