//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 24/02/2021.
//

import Foundation

public extension Date {
    /// Create a new date by adding date components
    /// - Parameters:
    ///   - days: the number of days to add
    ///   - months: the number of days to add
    ///   - years: the number of days to add
    ///   - calendar: the calendar according to which the new date is computed
    func newByAdding(
        days: Int = 0,
        months: Int = 0,
        years: Int = 0,
        calendar: Calendar = .current) -> Date?
    {
        var components = DateComponents()
        components.day = days
        components.month = months
        components.year = years
        
        return calendar.date(byAdding: components, to: self)
    }
    
    /// Create a new date by setting the time component
    /// - Parameters:
    ///   - hour: hours of new date
    ///   - minute: minutes of new date
    ///   - second: seconds of new date
    ///   - calendar: the calendar according to which the new date is computed
    func newBySetting(
        hour: Int = 0,
        minute: Int = 0,
        second: Int = 0,
        calendar: Calendar = .current) -> Date?
    {
        calendar.date(bySettingHour: hour, minute: minute, second: second, of: self)
    }
}
