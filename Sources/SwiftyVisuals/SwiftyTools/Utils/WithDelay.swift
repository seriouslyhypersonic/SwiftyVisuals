//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 20/02/2021.
//

import Foundation

/// Perform an asynchronous action on the main thread after a prescribed  time interval
/// - Parameters:
///   - delay: the time interval tha occurs (in miliseconds?)  before the action is performed
///   - execute: the action to perform
public func withDelay(_ delay: Double, execute: @escaping () -> Void ) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: execute)
}
