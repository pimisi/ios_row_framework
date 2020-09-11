//
//  String+Extension.swift
//  ios-row
//
//  Created by Paul Imisi on 2020/09/09.
//  Copyright © 2020 Betway. All rights reserved.
//

import Foundation

extension String {
    var trimmed: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func replaceOccurrencies(of searches: [String], with replacements: [String]) -> String {
        guard searches.count == replacements.count else {
            debugLog("The searches collection must be equal to the replacements collection")
            return self
        }
        
        guard !searches.isEmpty else {
            debugLog("The searches collection is empty")
            return self
        }
        
        var `self` = self
        
        searches.enumerated().forEach({ index, search in
            `self` = replacingOccurrences(of: search, with: replacements[index])
        })
        
        return `self`
    }
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
}
