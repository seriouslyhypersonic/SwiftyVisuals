//
//  Date+Components.swift
//  MeteoApp
//
//  Created by Nuno Alves de Sousa on 22/02/2021.
//

import Foundation

public extension Date {
    // MARK: Time components
    /// The minutes of the date
    var minute: Int { Calendar.current.component(.minute, from: self) }
    /// The hour of the date
    var hour: Int { Calendar.current.component(.hour, from: self) }
    
    // MARK: Date components
    /// The day of the month
    var day: Int { Calendar.current.component(.day, from: self) }
    /// The number of the month
    var month: Int { Calendar.current.component(.month, from: self) }
    /// The year
    var year: Int { Calendar.current.component(.year, from: self) }
    
    // MARK: Weekday
    /// The weekday units are the numbers 1 through N (where for the Gregorian calendar N=7 and 1 is Sunday)
    ///
    /// The weekday units are the numbers 1 through N (where for the Gregorian calendar N=7 and 1 is Sunday)
    var weeekdayNumber: Int { Calendar.current.component(.weekday, from: self) }
    
    /// A formated string with the weekday
    var weekday: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: self).capitalized
    }
    
    // MARK: isSameDay
    /// Check if two dates have the same day
    /// - Parameter date: the date against which to compare
    func isSameDay(_ date: Date) -> Bool {
        day == date.day && month == date.month && year == date.year
    }
}
