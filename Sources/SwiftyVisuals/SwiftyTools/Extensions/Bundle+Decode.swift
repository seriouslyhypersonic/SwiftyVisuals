//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 12/05/2021.
//

import Foundation

// TODO: make throwing function
public extension Bundle {
    func decode<T: Decodable>(
        _ type: T.Type,
        filename: String,
        decoder: JSONDecoder = JSONDecoder()
    ) throws -> T
    {
        guard let url = self.url(forResource: filename, withExtension: nil) else {
            fatalError("Could not locate '\(filename)' in bundle")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Could not load data from '\(filename)'")
        }
        
        return try decoder.decode(T.self, from: data)
    }
}
