//
//  File.swift
//  
//
//  Created by Nuno Alves de Sousa on 04/03/2021.
//

import SwiftUI
import Combine

private var cancellableSet: Set<AnyCancellable> = []

public extension Published where Value: Codable {
    init(wrappedValue defaultValue: Value, _ key: String, store: UserDefaults? = nil) {
        let _store: UserDefaults = store ?? .standard
        
        if
            let data = _store.data(forKey: key),
            let value = try? JSONDecoder().decode(Value.self, from: data)
        {
            self.init(initialValue: value)
        } else {
            self.init(initialValue: defaultValue)
        }
        
        projectedValue
            .sink { newValue in
                let data = try? JSONEncoder().encode(newValue)
                _store.set(data, forKey: key)
            }
            .store(in: &cancellableSet)
    }
}
