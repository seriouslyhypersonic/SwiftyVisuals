//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 09/05/2021.
//

import Foundation

public extension FileManager {
    /// Generate an URL for the resource refered to by the provided filename in the document directory using the user domain mask
    /// - Parameter filename: the filename of the resource
    func url(filename: String) -> URL? {
        urls(for: .documentDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(filename)
    }
    
    
    /// Decode object refered to by `filename` from the document directory
    /// - Parameters:
    ///   - type: the type of the decoded object
    ///   - filename: the filename of the resource
    ///   - decoder: the JSONDecoder used for decoding
    func decode<T: Decodable>(
        _ type: T.Type,
        filename: String,
        decoder: JSONDecoder = .init()
    ) throws -> T {
        guard let url = url(filename: filename) else {
            throw FileManagerError.url(filename: filename)
        }
        
        let data = try Data(contentsOf: url)
        return try decoder.decode(T.self, from: data)
    }
    
    /// Encode object with the provided `filename` and write it to the document directory
    /// - Parameters:
    ///   - value: the object to encode
    ///   - filename: the filename used for writing to the document directory
    ///   - encoder: the JSONEncoder used for encoding
    ///   - withProtection: an option to make the file accessible only while the device is unlocked
    func encode<T: Encodable>(
        _ value: T,
        filename: String,
        encoder: JSONEncoder = .init(),
        withProtection: Bool = false) throws
    {
        let data = try encoder.encode(value)
        
        var options = Data.WritingOptions.atomicWrite
        if withProtection {
            options.insert(.completeFileProtection)
        }
        
        guard let url = url(filename: filename) else {
            throw FileManagerError.url(filename: filename)
        }
        
        try data.write(to: url, options: options)
    }
}
