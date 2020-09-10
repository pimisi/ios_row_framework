//
//  Data+Extension.swift
//  ios-row
//
//  Created by Paul Imisi on 2020/09/09.
//  Copyright © 2020 Betway. All rights reserved.
//

import Foundation

extension Data {
    private func object(with data: Data, options opt: JSONSerialization.ReadingOptions = []) -> Any? {
        do {
            return try JSONSerialization.jsonObject(with: self, options: JSONSerialization.ReadingOptions())
        } catch {
            debugLog("Could not serialize data. \(error): \(#function)")
            return nil
        }
    }
    
    var dictionary: GenericDictionary? {
        return object(with: self) as? GenericDictionary
    }
}
