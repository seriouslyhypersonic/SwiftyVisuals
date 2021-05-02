//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 02/05/2021.
//

import Foundation

public extension TimeInterval {
    /// Convert a second-based time interval to an hour, minute and second basis
    func toHoursMinutesSeconds() -> (h: Int, m: Int, s: Int) {
        let seconds = Int(self)
        return (Int(seconds / 3600), Int((seconds  % 3600) / 60), Int( (seconds % 3600) % 60) )
    }
}
