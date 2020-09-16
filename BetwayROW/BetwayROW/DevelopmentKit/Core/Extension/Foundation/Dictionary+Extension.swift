//
//  Dictionary+Extension.swift
//  ios-row
//
//  Created by Paul Imisi on 2020/09/09.
//  Copyright © 2020 Betway. All rights reserved.
//

import Foundation

extension Dictionary {
    var data: Data? {
        do {
            return try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
        } catch let error {
            print("Exception while serializing json data: \(error.description)")
            return nil
        }
    }
    
    mutating func set(value: Value?, for key: Key) {
       self[key] = value
   }
}

extension Dictionary where Key == String {
    
    // MARK: - Getters
    
    func object(forKey key: String) -> Any? {
        if key.contains("|") {
            let parts = key.split(separator: "|").map { String($0).trimmed }
            
            for part in parts {
                if let value = object(forKey: part) {
                    return value
                }
            }
        }
        return self[key]
    }
    
    func int(forKey key: String, `default`: Int? = nil) -> Int? {
        if let string = object(forKey: key) as? String {
            return Int(string) ?? `default`
        }
        
        return object(forKey: key) as? Int ?? `default`
    }
    
    func string(forKey key: String, `default`: String = "") -> String {
        return stringOrNil(forKey: key) ?? `default`
    }
    
    func stringOrNil(forKey key: String) -> String? {
        return object(forKey: key) as? String
    }
}
