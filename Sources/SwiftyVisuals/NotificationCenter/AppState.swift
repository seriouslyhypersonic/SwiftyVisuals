//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 15/03/2021.
//

import SwiftUI

/// The current application state reported by the `NotificationCenter`
public class AppState: ObservableObject {
    /// A publisher that reflect whether the application is currently active or in a background state
    @Published public var isActive = true
    
    public init() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(willEnterForeground),
            name: UIApplication.willEnterForegroundNotification,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didEnterBackground),
            name: UIApplication.didEnterBackgroundNotification,
            object: nil)
    }
    
    @objc func willEnterForeground() {
        isActive = true
    }
    
    @objc func didEnterBackground() {
        isActive = false
    }
}

