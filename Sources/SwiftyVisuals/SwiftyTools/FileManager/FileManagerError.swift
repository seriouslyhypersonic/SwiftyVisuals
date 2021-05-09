//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 09/05/2021.
//

import Foundation

public enum FileManagerError: LocalizedError {
    case url(filename: String)
    
    public var errorDescription: String? {
        switch self {
        case .url(let filename): return "cannot generate URL for filename '\(filename)'"
        }
    }
}
