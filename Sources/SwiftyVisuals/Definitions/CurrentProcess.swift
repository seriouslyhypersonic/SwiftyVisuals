//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 09/05/2021.
//

import Foundation

/// Information about the current process
public enum CurrentProcess {
    /// Check weather Xcode is running for previews
    public static var isPreview: Bool {
        ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
}
 
